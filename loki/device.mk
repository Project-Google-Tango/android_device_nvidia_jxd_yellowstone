# NVIDIA Tegra5 "loki" development system
#
# Copyright (c) 2013 NVIDIA Corporation.  All rights reserved.

#$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

ifeq ($(wildcard 3rdparty/google/gms-apps/products/gms.mk),3rdparty/google/gms-apps/products/gms.mk)
$(call inherit-product, 3rdparty/google/gms-apps/products/gms.mk)
endif

PRODUCT_LOCALES += en_US
PRODUCT_PROPERTY_OVERRIDES += \
ro.com.google.clientidbase=android-nvidia

$(call inherit-product-if-exists, vendor/nvidia/tegra/core/nvidia-tegra-vendor.mk)
$(call inherit-product-if-exists, frameworks/base/data/videos/VideoPackage2.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage3.mk)
$(call inherit-product-if-exists, vendor/nvidia/tegra/secureos/nvsi/nvsi.mk)
$(call inherit-product, build/target/product/languages_full.mk)

include frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk

PRODUCT_LOCALES += mdpi hdpi xhdpi

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/bootloader/nvbootloader/odm-partner/loki
else
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/odm/loki
endif

PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/E2548_B00_Hynix_4GB_H5TQ4G83AFR_TEC_792Mhz_r506_v2.cfg:bct_loki_b00.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E2548_B00_Hynix_4GB_H5TQ4G83AFR_TEC_1056Mhz_r506_v7.cfg:bct_1056.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E2548_Hynix_2GB_H5TC4G63AFR_RDA_792Mhz.cfg:bct.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E2548_Hynix_2GB_H5TC4G63AFR_RDA_792Mhz.cfg:bct_loki.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E2548_B00_SKU1_Hynix_4GB_H5TQ4G83AFR_TEC_204Mhz_r506_v1.cfg:bct_loki_b00_sku100.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E2548_Hynix_4GB_H5TQ4G83AFR_TEC_204Mhz_r503_2gb_mode_v1_spi.cfg:bct_spi.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E2549_Hynix_2GB_H5TC4G63AFR_RDA_792Mhz.cfg:bct_thor1_9.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E2549_B00_Hynix_4GB_H5TQ4G83AFR_TEC_1056Mhz_r506_v7.cfg:bct_thor1_95.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E2530_A00_Hynix_4GB_H5TQ4G83AFR_TEC_1056Mhz_r509_v6.cfg:bct_loki_ffd_sku0.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E2530_A00_Hynix_4GB_H5TQ4G83AFR_TEC_1200Mhz_r509_v6.cfg:bct_loki_ffd_sku0_1200.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P2530_A00_SKU100_Hynix_2GB_H5TQ2G83FFR_RDC_1056Mhz_r509_v3.cfg:bct_loki_ffd_sku100.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_foster.txt:NCT_foster.txt \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_loki.txt:NCT_loki.txt \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_loki_b00.txt:NCT_loki_b00.txt \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_loki_b00_sku100.txt:NCT_loki_b00_sku100.txt \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_thor1_9.txt:NCT_thor1_9.txt \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_thor1_95.txt:NCT_thor1_95.txt \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_loki_ffd_sku0.txt:NCT_loki_ffd_sku0.txt \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_loki_ffd_sku0_a1.txt:NCT_loki_ffd_sku0_a1.txt \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_loki_ffd_sku0_a3.txt:NCT_loki_ffd_sku0_a3.txt \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_loki_ffd_sku100.txt:NCT_loki_ffd_sku100.txt \
    $(NVFLASH_FILES_PATH)/nvflash/eks_nokey.dat:eks.dat \
    $(NVFLASH_FILES_PATH)/partition_data/config/nvcamera.conf:system/etc/nvcamera.conf \
    $(NVFLASH_FILES_PATH)/nvflash/common_bct.cfg:common_bct.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/fuse_write.txt:fuse_write.txt \
    $(NVFLASH_FILES_PATH)/nvflash/nvidia.bmp:nvidia.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/lowbat.bmp:lowbat.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charging.bmp:charging.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charged.bmp:charged.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/fullycharged.bmp:fullycharged.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/fuse_write.txt:fuse_write.txt

ifeq ($(TARGET_PRODUCT),loki)
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_nvtboot_dtb_emmc_full.cfg:flash.cfg
else ifeq ($(TARGET_PRODUCT),lokidiag)
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_nvtboot_dtb_emmc_full_mfgtest.cfg:flash.cfg
endif

PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_dtb_spi_sata_full.cfg:flash_spi_sata.cfg \

NVFLASH_CFG_BASE_FILE := $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_nvtboot_dtb_emmc_full.cfg

NVFLASH_FILES_PATH :=

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
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
  $(LOCAL_PATH)/ueventd.loki.rc:root/ueventd.loki.rc \
  $(LOCAL_PATH)/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
  $(LOCAL_PATH)/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
  $(LOCAL_PATH)/Vendor_0955_Product_7205.kl:system/usr/keylayout/Vendor_0955_Product_7205.kl \
  $(LOCAL_PATH)/Vendor_0955_Product_7210.kl:system/usr/keylayout/Vendor_0955_Product_7210.kl \
  $(LOCAL_PATH)/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
  $(LOCAL_PATH)/raydium_ts.idc:system/usr/idc/raydium_ts.idc \
  $(LOCAL_PATH)/sensor00fn11.idc:system/usr/idc/sensor00fn11.idc \
  $(LOCAL_PATH)/../common/ussr_setup.sh:system/bin/ussr_setup.sh \
  $(LOCAL_PATH)/ussrd.conf:system/etc/ussrd.conf \
  $(LOCAL_PATH)/../common/input_cfboost_init.sh:system/bin/input_cfboost_init.sh \
  $(LOCAL_PATH)/../common/set_hwui_params.sh:system/bin/set_hwui_params.sh \
  $(LOCAL_PATH)/../common/set_light_sensor_perm.sh:system/bin/set_light_sensor_perm.sh \
  $(LOCAL_PATH)/js_firmware.bin:system/etc/firmware/js_firmware.bin

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/../common/init_lbh.sh:system/bin/init_lbh.sh

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
  $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
  $(LOCAL_PATH)/audio_policy.conf:system/etc/audio_policy.conf \
  $(LOCAL_PATH)/legal/legal.html:system/etc/legal.html \
  $(LOCAL_PATH)/legal/legal_zh_tw.html:system/etc/legal_zh_tw.html \
  $(LOCAL_PATH)/legal/legal_zh_cn.html:system/etc/legal_zh_cn.html \
  $(LOCAL_PATH)/legal/tos.html:system/etc/tos.html \
  $(LOCAL_PATH)/legal/tos_zh_tw.html:system/etc/tos_zh_tw.html \
  $(LOCAL_PATH)/legal/tos_zh_cn.html:system/etc/tos_zh_cn.html \
  $(LOCAL_PATH)/legal/priv.html:system/etc/priv.html \
  $(LOCAL_PATH)/legal/priv_zh_tw.html:system/etc/priv_zh_tw.html \
  $(LOCAL_PATH)/legal/priv_zh_cn.html:system/etc/priv_zh_cn.html
else
PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/media_profiles_noenhance.xml:system/etc/media_profiles.xml \
  $(LOCAL_PATH)/media_codecs_noenhance.xml:system/etc/media_codecs.xml \
  $(LOCAL_PATH)/audio_policy_noenhance.conf:system/etc/audio_policy.conf
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power.loki.rc:system/etc/power.loki.rc \
    $(LOCAL_PATH)/init.loki.rc:root/init.loki.rc \
    $(LOCAL_PATH)/init.icera.rc:root/init.icera.rc \
    $(LOCAL_PATH)/init.none.rc:root/init.none.rc \
    $(LOCAL_PATH)/fstab.loki:root/fstab.loki \
    $(LOCAL_PATH)/../common/init.nv_dev_board.usb.rc:root/init.nv_dev_board.usb.rc

ifeq ($(NO_ROOT_DEVICE),1)
  PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init_no_root_device.rc:root/init.rc
endif

# Face detection model
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/core/include/ft/model_frontalface.xml:system/etc/model_frontal.xml

# Icera modem integration
$(call inherit-product-if-exists, $(LOCAL_PATH)/../common/icera/icera-modules.mk)
SYSTEM_ICERA_FW_PATH=system/vendor/firmware/icera
LOCAL_ICERA_FW_PATH=vendor/nvidia/tegra/icera/firmware/binaries/binaries_nvidia-e1729-loki
PRODUCT_COPY_FILES += \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/secondary_boot.wrapped:$(SYSTEM_ICERA_FW_PATH)/secondary_boot.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/loader.wrapped:$(SYSTEM_ICERA_FW_PATH)/loader.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/modem.wrapped:$(SYSTEM_ICERA_FW_PATH)/modem.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/audioConfig.bin:$(SYSTEM_ICERA_FW_PATH)/audioConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/productConfigXml_icera_e1729_loki_voice_nala.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice-nala/productConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/productConfigXml_icera_e1729_loki_voice.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice/productConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_PATH)/init.icera.rc:root/init.icera.rc)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../common/cluster:system/bin/cluster \
    $(LOCAL_PATH)/../common/cluster_get.sh:system/bin/cluster_get.sh \
    $(LOCAL_PATH)/../common/cluster_set.sh:system/bin/cluster_set.sh \
    $(LOCAL_PATH)/../common/dcc:system/bin/dcc \
    $(LOCAL_PATH)/../common/hotplug:system/bin/hotplug \
    $(LOCAL_PATH)/../common/mount_debugfs.sh:system/bin/mount_debugfs.sh

PRODUCT_COPY_FILES += \
    device/nvidia/loki/nvcms/device.cfg:system/lib/nvcms/device.cfg

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
	device/nvidia/loki/asound.conf:system/etc/asound.conf \
	device/nvidia/loki/nvaudio_conf.xml:system/etc/nvaudio_conf.xml \
    device/nvidia/loki/audioConfig_qvoice_icera_pc400.xml:system/etc/audioConfig_qvoice_icera_pc400.xml \
	device/nvidia/loki/nvaudio_fx.xml:system/etc/nvaudio_fx.xml \
	hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/fw_bcm4330_abg.bin:system/vendor/firmware/bcm4330/fw_bcmdhd.bin \
	hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/fw_bcm4330_apsta_bg.bin:system/vendor/firmware/bcm4330/fw_bcmdhd_apsta.bin \
	hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/fw_bcm4329_abg.bin:system/vendor/firmware/bcm4329/fw_bcmdhd.bin \
	hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/fw_bcm4329_apsta.bin:system/vendor/firmware/bcm4329/fw_bcmdhd_apsta.bin

PRODUCT_COPY_FILES += \
	device/nvidia/loki/enctune.conf:system/etc/enctune.conf

# nvcpud specific cpu frequencies config
PRODUCT_COPY_FILES += \
        device/nvidia/loki/nvcpud.conf:system/etc/nvcpud.conf

# pbc config
PRODUCT_COPY_FILES += \
        device/nvidia/loki/pbc.conf:system/etc/pbc.conf

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
PRODUCT_COPY_FILES += \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4329/bluetooth/bcmpatchram.hcd:system/etc/firmware/bcm4329.hcd \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4330/bluetooth/BCM4330B1_002.001.003.0379.0390.hcd:system/etc/firmware/bcm4330.hcd \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4329/wlan/nh930_nvram.txt:system/etc/nvram_4329.txt \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4330/wlan/NB099H.nvram_20110708.txt:system/etc/nvram_4330.txt \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:system/vendor/firmware/bcm43241/fw_bcmdhd.bin \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:system/vendor/firmware/bcm43241/fw_bcmdhd_apsta.bin \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/wlan/bcm943241ipaagb_p100_hwoob.txt:system/etc/nvram_43241.txt \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/bluetooth/AB113_BCM43241B0_0012_Azurewave_AW-AH691_TEST.HCD:system/etc/firmware/bcm43241.hcd \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4335/bluetooth/BCM4335B0_002.001.006.0037.0046_ORC.hcd:system/etc/firmware/bcm4335.hcd \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4335/wlan/bcm94335wbfgn3_r04_hwoob.txt:system/etc/nvram_4335.txt \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm4335/wlan/sdio-ag-pool-p2p-pno-pktfilter-keepalive-aoe-ccx-sr-vsdb-proptxstatus-lpc-wl11u-autoabn.bin:system/vendor/firmware/bcm4335/fw_bcmdhd.bin
else
PRODUCT_COPY_FILES += \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm4329/bluetooth/bcmpatchram.hcd:system/etc/firmware/bcm4329.hcd \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm4330/bluetooth/BCM4330B1_002.001.003.0379.0390.hcd:system/etc/firmware/bcm4330.hcd \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm4329/wlan/nh930_nvram.txt:system/etc/nvram_4329.txt \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm4330/wlan/NB099H.nvram_20110708.txt:system/etc/nvram_4330.txt \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:system/vendor/firmware/bcm43241/fw_bcmdhd.bin \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm43241/wlan/bcm943241ipaagb_p100_hwoob.txt:system/etc/nvram_43241.txt \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm43241/bluetooth/AB113_BCM43241B0_0012_Azurewave_AW-AH691_TEST.HCD:system/etc/firmware/bcm43241.hcd \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm4335/bluetooth/BCM4335B0_002.001.006.0037.0046_ORC.hcd:system/etc/firmware/bcm4335.hcd \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm4335/wlan/bcm94335wbfgn3_r04_hwoob.txt:system/etc/nvram_4335.txt \
   vendor/nvidia/tegra/prebuilt/loki/3rdparty/bcmbinaries/bcm4335/wlan/sdio-ag-pool-p2p-pno-pktfilter-keepalive-aoe-ccx-sr-vsdb-proptxstatus-lpc-wl11u-autoabn.bin:system/vendor/firmware/bcm4335/fw_bcmdhd.bin
endif

# Enable following APKs only for internal engineering build
ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
PRODUCT_PACKAGES += \
    NvwfdServiceTest
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
    libwvdrm_L1

#needed by google GMS lib:libpatts_engine_jni_api.so
PRODUCT_PACKAGES += \
    libwebrtc_audio_coding

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
	sensors.loki \
	lights.loki \
	audio.primary.tegra \
	audio.a2dp.default \
	audio.usb.default \
	audio_policy.tegra \
	power.loki \
	pbc.loki \
	setup_fs \
	drmserver \
	Gallery2 \
	gpload \
	c2debugger \
	libdrmframework_jni \
	e2fsck \
	NvShieldService \
	InputViewer \
	NVSS \
	charger \
	charger_res_images

PRODUCT_PACKAGES += \
	tos.img

#MTK GPS
PRODUCT_PACKAGES += \
	gps.conf \
	libssladp \
	mtk_agpsd

#Application for collection of end user feedback
PRODUCT_PACKAGES += \
    nvidiafeedback

# SHIELD Boot Animation
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip

# SHIELD sleep menu option
PRODUCT_PROPERTY_OVERRIDES += fw.sleep_in_power_menu=true

# HDCP SRM Support
PRODUCT_PACKAGES += \
		hdcp1x.srm \
		hdcp2x.srm \
		hdcp2xtest.srm

PRODUCT_PACKAGES += ControllerMapper

# camera2 sanity tests for HAL V3; Only for T124+ products
PRODUCT_PACKAGES += camera2_test

PRODUCT_PACKAGE_OVERLAYS := $(LOCAL_PATH)/shield_strings/overlay $(LOCAL_PATH)/overlay

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := shield

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Enable secure USB debugging in user release build
ifeq ($(TARGET_BUILD_TYPE),release)
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.adb.secure=1
endif
endif

# Add SHIELD apps
PRODUCT_PACKAGES += \
    Welcome

# Add TZ3
PRODUCT_PACKAGES += \
    TegraZone

# Include ShieldTech
ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
SHIELDTECH_FEATURE_NVGALLERY := false
$(call inherit-product-if-exists, vendor/nvidia/shieldtech/common/shieldtech.mk)
endif

