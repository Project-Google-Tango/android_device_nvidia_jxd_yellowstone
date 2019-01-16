# NVIDIA Tegra4 "Dalmore" development system
#
# Copyright (c) 2012-2013 NVIDIA Corporation.  All rights reserved.

$(call inherit-product-if-exists, vendor/nvidia/tegra/core/nvidia-tegra-vendor.mk)
$(call inherit-product-if-exists, frameworks/base/data/videos/VideoPackage2.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage3.mk)
$(call inherit-product, build/target/product/languages_full.mk)

PRODUCT_LOCALES += mdpi hdpi xhdpi

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/bootloader/nvbootloader/odm-partner/dalmore
else
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/odm/dalmore
endif

PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/E1613_Hynix_2GB_H9CCNNN8JTMLAR-NTM_408MHz_121007_fixed.cfg:bct.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1613_Hynix_2GB_H9CCNNN8JTMLAR-NTM_408MHz_121007_fixed.bct:flash_dalmore_e1613.bct \
    $(NVFLASH_FILES_PATH)/nvflash/E1613_Hynix_2GB_H9CCNNN8JTMLAR-NTM_408MHz_121007_fixed.cfg:flash_dalmore_e1613.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1611_Hynix_DDR3_2GB_H5TC4G63MFR-PBA_480MHz.bct:flash.bct \
    $(NVFLASH_FILES_PATH)/nvflash/E1611_Hynix_DDR3_2GB_H5TC4G63MFR-PBA_480MHz.bct:flash_dalmore_e1611.bct \
    $(NVFLASH_FILES_PATH)/nvflash/E1611_Hynix_DDR3_2GB_H5TC4G63MFR-PBA_480MHz.cfg:flash_dalmore_e1611.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1611_Hynix_DDR3_2GB_H5TC4G63MFR-PBA_480MHz_spif.bct:flash_dalmore_e1611_spif.bct \
    $(NVFLASH_FILES_PATH)/nvflash/E1611_Hynix_DDR3_2GB_H5TC4G63MFR-PBA_480MHz_spif.cfg:flash_dalmore_e1611_spif.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1611_Hynix_2GB_H5TC4G63AFR-RDA_792MHz_r403_v03.cfg:flash_dalmore_e1611_t40t_792_1866.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1611_Hynix_2GB_H5TC4G63AFR-RDA_792Mhz_r403_v2.cfg:flash_dalmore_e1611_t40s_792_1866.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1611_Hynix_2GB_H5TC4G63MFR-PBA_792Mhz_r403_v2.cfg:flash_dalmore_e1611_t40s_792_1600.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/eks_nokey.dat:eks.dat \
    $(NVFLASH_FILES_PATH)/nvflash/charging.bmp:charging.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/lowbat.bmp:lowbat.bmp \
    $(NVFLASH_FILES_PATH)/partition_data/config/nvcamera.conf:system/etc/nvcamera.conf \
    $(NVFLASH_FILES_PATH)/nvflash/common_bct.cfg:common_bct.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/fuse_write.txt:fuse_write.txt

ifeq ($(APPEND_DTB_TO_KERNEL), true)
ifeq ($(BUILD_NV_CRASHCOUNTER),true)
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_cc_fastboot_emmc_full.cfg:flash.cfg
else
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_emmc_full.cfg:flash.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_emmc_full_spif.cfg:flash_spif.cfg
endif
else
ifeq ($(BUILD_NV_CRASHCOUNTER),true)
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_cc_fastboot_dtb_emmc_full.cfg:flash.cfg
else
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_dtb_emmc_full.cfg:flash.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_dtb_emmc_full_spif.cfg:flash_spif.cfg
endif
endif

NVFLASH_FILES_PATH :=

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

ifneq (,$(filter $(BOARD_INCLUDES_TEGRA_JNI),display))
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/hal/frameworks/Display/com.nvidia.display.xml:system/etc/permissions/com.nvidia.display.xml
endif

ifneq (,$(filter $(BOARD_INCLUDES_TEGRA_JNI),cursor))
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/hal/frameworks/Graphics/com.nvidia.graphics.xml:system/etc/permissions/com.nvidia.graphics.xml
endif

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/ueventd.dalmore.rc:root/ueventd.dalmore.rc \
  $(LOCAL_PATH)/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
  $(LOCAL_PATH)/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
  $(LOCAL_PATH)/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
  $(LOCAL_PATH)/raydium_ts.idc:system/usr/idc/raydium_ts.idc \
  $(LOCAL_PATH)/sensor00fn11.idc:system/usr/idc/sensor00fn11.idc \
  $(LOCAL_PATH)/../common/wifi_loader.sh:system/bin/wifi_loader.sh \
  $(LOCAL_PATH)/../common/ussr_setup.sh:system/bin/ussr_setup.sh \
  $(LOCAL_PATH)/../common/input_cfboost_init.sh:system/bin/input_cfboost_init.sh \
  $(LOCAL_PATH)/../common/set_hwui_params.sh:system/bin/set_hwui_params.sh \
  $(LOCAL_PATH)/../common/set_light_sensor_perm.sh:system/bin/set_light_sensor_perm.sh

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
  $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
  $(LOCAL_PATH)/audio_policy.conf:system/etc/audio_policy.conf
else
PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/media_profiles_noenhance.xml:system/etc/media_profiles.xml \
  $(LOCAL_PATH)/media_codecs_noenhance.xml:system/etc/media_codecs.xml \
  $(LOCAL_PATH)/audio_policy_noenhance.conf:system/etc/audio_policy.conf
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power.dalmore.rc:system/etc/power.dalmore.rc \
    $(LOCAL_PATH)/init.dalmore.rc:root/init.dalmore.rc \
    $(LOCAL_PATH)/init.icera.rc:root/init.icera.rc \
    $(LOCAL_PATH)/fstab.dalmore:root/fstab.dalmore \
    $(LOCAL_PATH)/../common/init.nv_dev_board.usb.rc:root/init.nv_dev_board.usb.rc

ifeq ($(NO_ROOT_DEVICE),1)
  PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init_no_root_device.rc:root/init.rc
endif

# Face detection model
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/core/include/ft/model_frontalface.xml:system/etc/model_frontal.xml

# Icera modem integration
NVIDIA_ICERA_VARIANT=nvidia-e1729-android
$(call inherit-product-if-exists, $(LOCAL_PATH)/../common/icera/icera-modules.mk)

# Test files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../common/cluster:system/bin/cluster \
    $(LOCAL_PATH)/../common/cluster_get.sh:system/bin/cluster_get.sh \
    $(LOCAL_PATH)/../common/cluster_set.sh:system/bin/cluster_set.sh \
    $(LOCAL_PATH)/../common/dcc:system/bin/dcc \
    $(LOCAL_PATH)/../common/hotplug:system/bin/hotplug \
    $(LOCAL_PATH)/../common/mount_debugfs.sh:system/bin/mount_debugfs.sh

PRODUCT_COPY_FILES += \
    device/nvidia/dalmore/nvcms/device.cfg:system/lib/nvcms/device.cfg

PRODUCT_COPY_FILES += \
	external/alsa-lib/src/conf/alsa.conf:system/usr/share/alsa/alsa.conf \
	external/alsa-lib/src/conf/pcm/dsnoop.conf:system/usr/share/alsa/pcm/dsnoop.conf \
	external/alsa-lib/src/conf/pcm/modem.conf:system/usr/share/alsa/pcm/modem.conf \
	external/alsa-lib/src/conf/pcm/dpl.conf:system/usr/share/alsa/pcm/dpl.conf \
	external/alsa-lib/src/conf/pcm/default.conf:system/usr/share/alsa/pcm/default.conf \
	external/alsa-lib/src/conf/pcm/surround51.conf:system/usr/share/alsa/pcm/surround51.conf \
	external/alsa-lib/src/conf/pcm/surround41.conf:system/usr/share/alsa/pcm/surround41.conf \
	external/alsa-lib/src/conf/pcm/surround50.conf:system/usr/share/alsa/pcm/surround50.conf \
	external/alsa-lib/src/conf/pcm/dmix.conf:system/usr/share/alsa/pcm/dmix.conf \
	external/alsa-lib/src/conf/pcm/center_lfe.conf:system/usr/share/alsa/pcm/center_lfe.conf \
	external/alsa-lib/src/conf/pcm/surround40.conf:system/usr/share/alsa/pcm/surround40.conf \
	external/alsa-lib/src/conf/pcm/side.conf:system/usr/share/alsa/pcm/side.conf \
	external/alsa-lib/src/conf/pcm/iec958.conf:system/usr/share/alsa/pcm/iec958.conf \
	external/alsa-lib/src/conf/pcm/rear.conf:system/usr/share/alsa/pcm/rear.conf \
	external/alsa-lib/src/conf/pcm/surround71.conf:system/usr/share/alsa/pcm/surround71.conf \
	external/alsa-lib/src/conf/pcm/front.conf:system/usr/share/alsa/pcm/front.conf \
	external/alsa-lib/src/conf/cards/aliases.conf:system/usr/share/alsa/cards/aliases.conf \
	device/nvidia/common/bdaddr:system/etc/bluetooth/bdaddr \
	device/nvidia/dalmore/asound.conf:system/etc/asound.conf \
	device/nvidia/dalmore/nvaudio_conf.xml:system/etc/nvaudio_conf.xml \
        device/nvidia/dalmore/audioConfig_qvoice_icera_pc400.xml:system/etc/audioConfig_qvoice_icera_pc400.xml \
	hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/fw_bcm4330_abg.bin:system/vendor/firmware/bcm4330/fw_bcmdhd.bin \
	hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/fw_bcm4330_apsta_bg.bin:system/vendor/firmware/bcm4330/fw_bcmdhd_apsta.bin \
	hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/fw_bcm4329_abg.bin:system/vendor/firmware/bcm4329/fw_bcmdhd.bin \
	hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/fw_bcm4329_apsta.bin:system/vendor/firmware/bcm4329/fw_bcmdhd_apsta.bin

PRODUCT_COPY_FILES += \
	device/nvidia/dalmore/enctune.conf:system/etc/enctune.conf

PRODUCT_COPY_FILES += \
   vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/glgps_nvidiaTegra2android:system/bin/glgps_nvidiaTegra2android \
   vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/gpslogd_nvidiaTegra2android:system/bin/gpslogd \
   vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/gpsconfig-dalmore.xml:system/etc/gps/gpsconfig.xml \
   vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/gps.tegra.so:system/lib/hw/gps.tegra.so

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
PRODUCT_COPY_FILES += \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4329/bluetooth/bcmpatchram.hcd:system/etc/firmware/bcm4329.hcd \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4330/bluetooth/BCM4330B1_002.001.003.0379.0390.hcd:system/etc/firmware/bcm4330.hcd \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4329/wlan/nh930_nvram.txt:system/etc/nvram_4329.txt \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4330/wlan/NB099H.nvram_20110708.txt:system/etc/nvram_4330.txt \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:system/vendor/firmware/bcm43241/fw_bcmdhd.bin \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/wlan/bcm943241ipaagb_p100_hwoob.txt:system/etc/nvram_43241.txt \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/bluetooth/AB113_BCM43241B0_0012_Azurewave_AW-AH691_TEST.HCD:system/etc/firmware/bcm43241.hcd \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4335/bluetooth/BCM4335B0_002.001.006.0037.0046_ORC.hcd:system/etc/firmware/bcm4335.hcd \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4335/wlan/bcm94335wbfgn3_r04_hwoob.txt:system/etc/nvram_4335.txt \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4335/wlan/sdio-ag-pool-p2p-pno-pktfilter-keepalive-aoe-ccx-sr-vsdb-proptxstatus-lpc-wl11u-autoabn.bin:system/vendor/firmware/bcm4335/fw_bcmdhd.bin
else
PRODUCT_COPY_FILES += \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm4329/bluetooth/bcmpatchram.hcd:system/etc/firmware/bcm4329.hcd \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm4330/bluetooth/BCM4330B1_002.001.003.0379.0390.hcd:system/etc/firmware/bcm4330.hcd \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm4329/wlan/nh930_nvram.txt:system/etc/nvram_4329.txt \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm4330/wlan/NB099H.nvram_20110708.txt:system/etc/nvram_4330.txt \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:system/vendor/firmware/bcm43241/fw_bcmdhd.bin \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm43241/wlan/bcm943241ipaagb_p100_hwoob.txt:system/etc/nvram_43241.txt \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm43241/bluetooth/AB113_BCM43241B0_0012_Azurewave_AW-AH691_TEST.HCD:system/etc/firmware/bcm43241.hcd \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm4335/bluetooth/BCM4335B0_002.001.006.0037.0046_ORC.hcd:system/etc/firmware/bcm4335.hcd \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm4335/wlan/bcm94335wbfgn3_r04_hwoob.txt:system/etc/nvram_4335.txt \
   vendor/nvidia/tegra/prebuilt/dalmore/3rdparty/bcmbinaries/bcm4335/wlan/sdio-ag-pool-p2p-pno-pktfilter-keepalive-aoe-ccx-sr-vsdb-proptxstatus-lpc-wl11u-autoabn.bin:system/vendor/firmware/bcm4335/fw_bcmdhd.bin
endif

# Nvidia Miracast
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../common/miracast/com.nvidia.miracast.xml:system/etc/permissions/com.nvidia.miracast.xml

# NvBlit JNI library
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/graphics-partner/android/frameworks/Graphics/com.nvidia.graphics.xml:system/etc/permissions/com.nvidia.graphics.xml

#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
PRODUCT_PACKAGES += \
    com.google.widevine.software.drm.xml \
    com.google.widevine.software.drm \
    libdrmwvmplugin \
    libwvm \
    libWVStreamControlAPI_L1 \
    libwvdrm_L1 \
    libdrmdecrypt

#SD8897 firmware package
PRODUCT_PACKAGES += sd8897_uapsta.bin

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    VisualizationWallpapers \
    PhaseBeam \
    librs_jni

PRODUCT_PACKAGES += \
	sensors.dalmore \
	lights.dalmore \
	audio.primary.tegra \
	audio.a2dp.default \
	audio.usb.default \
	audio_policy.tegra \
	power.dalmore \
	setup_fs \
	drmserver \
	Gallery2 \
	libdrmframework_jni \
	e2fsck

#ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
#PRODUCT_PACKAGES += Nscopic
#endif

PRODUCT_PACKAGES += nvaudio_test

# NFC packages
PRODUCT_PACKAGES += \
		libnfc \
		libnfc_jni \
		Nfc \
		Tag

# HDCP SRM Support
PRODUCT_PACKAGES += \
		hdcp1x.srm \
		hdcp2x.srm \
		hdcp2xtest.srm

PRODUCT_PACKAGES += \
	tos.img

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := tablet

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

ifeq ($(wildcard vendor/nvidia/roth/rothui.mk),vendor/nvidia/roth/rothui.mk)
$(call inherit-product, vendor/nvidia/roth/rothui.mk)
else
DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay
endif

