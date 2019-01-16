
/*
 * Copyright (C) 2008 The Android Open Source Project
 * Copyright (c) 2011-2012, NVIDIA CORPORATION.  All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <fcntl.h>

#include "isl29028.h"
#include "ltr558als.h"
#include "MPLSensor.h"
#include "MPLSensorDefs.h"
#include "MPLSensorSysApi.h"

#define LIGHT_SENSOR_NAME_SYSFS_PATH  "/sys/bus/iio/devices/device0/name"
#define LUX_SYSFS_PATH  "/sys/bus/iio/devices/device0/als_value"
#define LUX_ENABLE_SYSFS_PATH  "/sys/bus/iio/devices/device0/als_enable"
#define LUX_MODE_SYSFS_PATH  "/sys/bus/iio/devices/device0/als_ir_mode"
#define PROX_SYSFS_PATH  "/sys/bus/iio/devices/device0/proximity_value"
#define PROX_ENABLE_SYSFS_PATH  "/sys/bus/iio/devices/device0/proximity_enable"

static const struct sensor_t sSensorList[] = {
      MPLROTATIONVECTOR_DEF,
      MPLLINEARACCEL_DEF,
      MPLGRAVITY_DEF,
      MPLGYRO_DEF,
      MPLACCEL_DEF,
      MPLMAGNETICFIELD_DEF,
      MPLORIENTATION_DEF,
      ISL29028LIGHT_DEF(ID_L),
      ISL29028PROX_DEF(ID_P),
      LTR_558ALS_DEF(ID_L),
      LTR_558PS_DEF(ID_P),
};

/*****************************************************************************/

static int open_sensors(const struct hw_module_t* module, const char* id,
                        struct hw_device_t** device);


static int initFailed = 0;
static int sensors__get_sensors_list(struct sensors_module_t* module,
                                     struct sensor_t const** list)
{
    if (initFailed) return 0;

    *list = sSensorList;
    return ARRAY_SIZE(sSensorList);
}

static struct hw_module_methods_t sensors_module_methods = {
        open: open_sensors
};

struct sensors_module_t HAL_MODULE_INFO_SYM = {
        common: {
                tag: HARDWARE_MODULE_TAG,
                version_major: 1,
                version_minor: 0,
                id: SENSORS_HARDWARE_MODULE_ID,
                name: "P1852 sensors module",
                author: "nvidia",
                methods: &sensors_module_methods,
                dso: NULL,
                reserved: {0}
        },
        get_sensors_list: sensors__get_sensors_list,
};

struct sensors_poll_context_t {
    struct sensors_poll_device_t device; // must be first

        sensors_poll_context_t();
        ~sensors_poll_context_t();
    int activate(int handle, int enabled);
    int setDelay(int handle, int64_t ns);
    int pollEvents(sensors_event_t* data, int count);

private:
    enum {
        light             = 0,
        proximity         = 1,
        mpl               = 2,
        mpl_accel,
        mpl_timer,
        numSensorDrivers,       // wake pipe goes here
        mpl_power,              //special handle for MPL pm interaction
        numFds,
    };

    static const size_t wake = numFds - 1;
    static const char WAKE_MESSAGE = 'W';
    struct pollfd mPollFds[numFds];
    int mWritePipeFd;
    SensorBase* mSensors[numSensorDrivers];

    int handleToDriver(int handle) const {
        switch (handle) {
            case ID_RV:
            case ID_LA:
            case ID_GR:
            case ID_GY:
            case ID_A:
            case ID_M:
            case ID_O:
                return mpl;
            case ID_L:
                return light;

            case ID_P:
                return proximity;
        }
        return -EINVAL;
    }
};

/*****************************************************************************/

sensors_poll_context_t::sensors_poll_context_t()
{
    char name[32] = {0};
    int data_fd = 0;

    FUNC_LOG;
    MPLSensor *p_mplsen = new MPLSensorSysApi();
    if (p_mplsen->initFailed) {
        initFailed = 1;
        return;
    }

    // setup the callback object for handing mpl callbacks
    setCallbackObject(p_mplsen);

    mSensors[mpl] = p_mplsen;
    mPollFds[mpl].fd = mSensors[mpl]->getFd();
    mPollFds[mpl].events = POLLIN;
    mPollFds[mpl].revents = 0;

    mSensors[mpl_accel] = mSensors[mpl];
    mPollFds[mpl_accel].fd = ((MPLSensor*)mSensors[mpl])->getAccelFd();
    mPollFds[mpl_accel].events = POLLIN;
    mPollFds[mpl_accel].revents = 0;

    mSensors[mpl_timer] = mSensors[mpl];
    mPollFds[mpl_timer].fd = ((MPLSensor*)mSensors[mpl])->getTimerFd();
    mPollFds[mpl_timer].events = POLLIN;
    mPollFds[mpl_timer].revents = 0;

    mPollFds[proximity].fd = -1;
    mPollFds[light].fd = -1;
    mSensors[light] = NULL;
    mSensors[proximity] = NULL;

    data_fd = open(LIGHT_SENSOR_NAME_SYSFS_PATH, O_RDONLY);
    if (data_fd >= 0) {
        read(data_fd, name, sizeof(name));
        close(data_fd);

       if (!strncmp(name, "isl29028", strlen("isl29028"))) {
            mSensors[light] = new Isl29028Light(LUX_SYSFS_PATH, LUX_MODE_SYSFS_PATH, ID_L);
            mSensors[proximity] = new Isl29028Prox(PROX_SYSFS_PATH, PROX_ENABLE_SYSFS_PATH, ID_P);
       }
       else if (!strncmp(name, "LTR_558ALS", strlen("LTR_558ALS"))) {
           mSensors[light] = new ltr558Light(LUX_SYSFS_PATH, LUX_ENABLE_SYSFS_PATH, ID_L);
           mSensors[proximity] = new ltr558Prox(PROX_SYSFS_PATH, PROX_ENABLE_SYSFS_PATH, ID_P);
       }
       else {
            LOGE("sensors_poll_context_t: Unsupported Light Sensor %s\n", name);
       }
    }
    else {
        LOGE("sensors_poll_context_t:data_fd for als/proximity is invalid = %d\n", data_fd);
    }

    int wakeFds[2];
    int result = pipe(wakeFds);
    LOGE_IF(result<0, "error creating wake pipe (%s)", strerror(errno));
    fcntl(wakeFds[0], F_SETFL, O_NONBLOCK);
    fcntl(wakeFds[1], F_SETFL, O_NONBLOCK);
    mWritePipeFd = wakeFds[1];

    mPollFds[wake].fd = wakeFds[0];
    mPollFds[wake].events = POLLIN;
    mPollFds[wake].revents = 0;

    //setup MPL pm interaction handle
    mPollFds[mpl_power].fd = ((MPLSensor*)mSensors[mpl])->getPowerFd();
    mPollFds[mpl_power].events = POLLIN;
    mPollFds[mpl_power].revents = 0;
}

sensors_poll_context_t::~sensors_poll_context_t()
{
    FUNC_LOG;
    for (int i=0 ; i<numSensorDrivers ; i++) {
        if (mSensors[i] != NULL) delete mSensors[i];
    }
    close(mPollFds[wake].fd);
    close(mWritePipeFd);
}

int sensors_poll_context_t::activate(int handle, int enabled)
{
    FUNC_LOG;
    int index = handleToDriver(handle);
    if (index < 0) return index;
    if (mSensors[index] == NULL) return 0;
    int err =  mSensors[index]->enable(handle, enabled);
    if (!err) {
        const char wakeMessage(WAKE_MESSAGE);
        int result = write(mWritePipeFd, &wakeMessage, 1);
        LOGE_IF(result<0, "error sending wake message (%s)", strerror(errno));
    }
    return err;
}

int sensors_poll_context_t::setDelay(int handle, int64_t ns)
{
    FUNC_LOG;
    int index = handleToDriver(handle);
    if (index < 0) return index;
    if (mSensors[index] == NULL) return 0;
    return mSensors[index]->setDelay(handle, ns);
}

int sensors_poll_context_t::pollEvents(sensors_event_t* data, int count)
{
    //FUNC_LOG;
    int nbEvents = 0;
    int n = 0;
    int polltime = -1;

    do {
        // see if we have some leftover from the last poll()
        for (int i=0 ; count && i<numSensorDrivers ; i++) {
            if (mSensors[i] == NULL) continue;
            SensorBase* const sensor(mSensors[i]);
            if ((mPollFds[i].revents & POLLIN) || (sensor->hasPendingEvents())) {
                int nb = sensor->readEvents(data, count);
                if (nb < count) {
                    // no more data for this sensor
                    mPollFds[i].revents = 0;
                }
                count -= nb;
                nbEvents += nb;
                data += nb;

                //special handling for the mpl, which has multiple handles
                if(i==mpl) {
                    i+=2; //skip accel and timer
                    mPollFds[mpl_accel].revents = 0;
                    mPollFds[mpl_timer].revents = 0;
                }
                if(i==mpl_accel) {
                    i+=1; //skip timer
                    mPollFds[mpl_timer].revents = 0;
                }
            }
        }

        if (count) {
            // we still have some room, so try to see if we can get
            // some events immediately or just wait if we don't have
            // anything to return
            int i;

            n = poll(mPollFds, numFds, nbEvents ? 0 : polltime);
            if (n<0) {
                LOGE("poll() failed (%s)", strerror(errno));
                return -errno;
            }
            if (mPollFds[wake].revents & POLLIN) {
                char msg;
                int result = read(mPollFds[wake].fd, &msg, 1);
                LOGE_IF(result<0, "error reading from wake pipe (%s)", strerror(errno));
                LOGE_IF(msg != WAKE_MESSAGE, "unknown message on wake queue (0x%02x)", int(msg));
                mPollFds[wake].revents = 0;
            }
            if(mPollFds[mpl_power].revents & POLLIN) {
                ((MPLSensor*)mSensors[mpl])->handlePowerEvent();
                mPollFds[mpl_power].revents = 0;
            }
        }
        // if we have events and space, go read them
    } while (n && count);

    return nbEvents;
}

/*****************************************************************************/

static int poll__close(struct hw_device_t *dev)
{
    FUNC_LOG;
    sensors_poll_context_t *ctx = (sensors_poll_context_t *)dev;
    if (ctx) {
        delete ctx;
    }
    return 0;
}

static int poll__activate(struct sensors_poll_device_t *dev,
                          int handle, int enabled)
{
    FUNC_LOG;
    sensors_poll_context_t *ctx = (sensors_poll_context_t *)dev;
    return ctx->activate(handle, enabled);
}

static int poll__setDelay(struct sensors_poll_device_t *dev,
                          int handle, int64_t ns)
{
    FUNC_LOG;
    sensors_poll_context_t *ctx = (sensors_poll_context_t *)dev;
    return ctx->setDelay(handle, ns);
}

static int poll__poll(struct sensors_poll_device_t *dev,
                      sensors_event_t* data, int count)
{
    //FUNC_LOG;
    sensors_poll_context_t *ctx = (sensors_poll_context_t *)dev;
    return ctx->pollEvents(data, count);
}

/*****************************************************************************/

/** Open a new instance of a sensor device using name */
static int open_sensors(const struct hw_module_t* module, const char* id,
                        struct hw_device_t** device)
{
    FUNC_LOG;
    int status = -EINVAL;
    sensors_poll_context_t *dev = new sensors_poll_context_t();

    memset(&dev->device, 0, sizeof(sensors_poll_device_t));

    dev->device.common.tag = HARDWARE_DEVICE_TAG;
    dev->device.common.version  = 0;
    dev->device.common.module   = const_cast<hw_module_t*>(module);
    dev->device.common.close    = poll__close;
    dev->device.activate        = poll__activate;
    dev->device.setDelay        = poll__setDelay;
    dev->device.poll            = poll__poll;

    *device = &dev->device.common;
    status = 0;

    return status;
}
