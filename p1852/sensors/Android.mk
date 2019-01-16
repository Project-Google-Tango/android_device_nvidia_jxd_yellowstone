# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


LOCAL_PATH:= $(call my-dir)

ifneq ($(TARGET_SIMULATOR),true)

# HAL module implemenation, not prelinked and stored in
# hw/<COPYPIX_HARDWARE_MODULE_ID>.<ro.board.platform>.so
include $(NVIDIA_DEFAULTS)

LOCAL_CFLAGS := -DLOG_TAG=\"Sensors\"
LOCAL_SRC_FILES := sensors.cpp

LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_C_INCLUDES += device/nvidia/drivers/sensors
LOCAL_C_INCLUDES += device/nvidia/drivers/sensors/mlsdk/mllite
LOCAL_C_INCLUDES += device/nvidia/drivers/sensors/mlsdk/platform/linux
LOCAL_C_INCLUDES += device/nvidia/drivers/sensors/mlsdk/platform/include
LOCAL_C_INCLUDES += device/nvidia/drivers/sensors/mlsdk/platform/include/linux
LOCAL_SHARED_LIBRARIES := liblog libcutils libutils libdl libsensors.base \
                          libinvensense_hal libsensors.mpl \
                          libsensors.isl29028 libsensors.ltr558als

LOCAL_CPPFLAGS+=-DLINUX=1

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE := sensors.p1852

include $(NVIDIA_SHARED_LIBRARY)

endif # !TARGET_SIMULATOR
