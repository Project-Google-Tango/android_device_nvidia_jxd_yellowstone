# NVIDIA Tegra5 "Ardbeg" development system
#
# Copyright (c) 2013, NVIDIA Corporation.  All rights reserved.
#
# AndroidProducts.mk is included before BoardConfig.mk, variable essential at
# start of build and used in here should always be intialized in this file

## All essential packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/nvidia/ardbeg/device.mk)

## NV_TN_SKU
NV_TN_SKU := wx_diag

## REFERENCE_DEVICE
REFERENCE_DEVICE := ardbeg

## NV_TN_PLATFORM
NV_TN_PLATFORM := premium

## NV_TN_WITH_GMS - allowed values true, false
NV_TN_WITH_GMS := true

## Thse are default settings, it gets changed as per sku manifest properties
PRODUCT_NAME := wx_diag
PRODUCT_DEVICE := ardbeg
PRODUCT_MODEL := wx_diag
PRODUCT_MANUFACTURER := NVIDIA
PRODUCT_BRAND := nvidia

## The base dtb file name used for this product
TARGET_KERNEL_DT_NAME := tegra124-tn8

## Icera modem integration
$(call inherit-product-if-exists, $(LOCAL_PATH)/../common/icera/icera-modules.mk)
SYSTEM_ICERA_FW_PATH=system/vendor/firmware/icera
LOCAL_ICERA_FW_PATH=vendor/nvidia/tegra/icera/firmware/binaries/binaries_nvidia-e1729-tn8l
PRODUCT_COPY_FILES += \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/secondary_boot.wrapped:$(SYSTEM_ICERA_FW_PATH)/secondary_boot.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/loader.wrapped:$(SYSTEM_ICERA_FW_PATH)/loader.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/modem.wrapped:$(SYSTEM_ICERA_FW_PATH)/modem.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/audioConfig.bin:$(SYSTEM_ICERA_FW_PATH)/audioConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/productConfigXml_icera_e1729_tn8l_voice_nala.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice-nala/productConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/productConfigXml_icera_e1729_tn8l_voice.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice/productConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_PATH)/../t124/init.icera.rc:root/init.icera.rc)

## SKU specific overrides
include frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-phone

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.tn8diag.rc:root/init.tn8diag.rc \
    vendor/nvidia/tegranote/apps/diagsuite/bin/stress_test.sh:root/bin/stress_test.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/CPU/power_utils.sh:data/mfgtest/CPU/power_utils.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/CPU/roth_dvfs.sh:data/mfgtest/CPU/roth_dvfs.sh \
    vendor/nvidia/tegranote/apps/diagsuite/src/Tn8Diag/external/CPU/game_testing.sh:data/mfgtest/CPU/game_testing.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/thermal/burnCortexA15_linux:data/mfgtest/thermal/burnCortexA15_linux \
    vendor/nvidia/tegranote/apps/diagsuite/bin/thermal/EDPVirus_linux:data/mfgtest/thermal/EDPVirus_linux \
    vendor/nvidia/tegranote/apps/diagsuite/bin/thermal/run.sh:data/mfgtest/thermal/run.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/thermal/thermal_test.py:data/mfgtest/thermal/thermal_test.py \
    vendor/nvidia/tegranote/apps/diagsuite/bin/GPU/gl30.xml:data/media/Android/data/com.glbenchmark.glbenchmark30/cache/selected_tests.xml \
    vendor/nvidia/tegranote/apps/diagsuite/src/Tn8Diag/external/GPU/game_testing.sh:data/mfgtest/GPU/game_testing.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/GPU/busybox:root/bin/busybox \
    vendor/nvidia/tegranote/apps/diagsuite/bin/thorMon/thorMon.py:root/bin/thorMon.py \
    vendor/nvidia/tegranote/apps/diagsuite/bin/thorMon/runThorMon.sh:root/bin/runThorMon.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/flash/loki_mac_writer.sh:loki_mac_writer.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/flash/main.sh:main.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/flash/pullLogFiles.sh:pullLogFiles.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/flash/flash.sh:flash.sh \
    vendor/nvidia/tegranote/apps/diagsuite/bin/modem/atcmd-itf-arm:data/bin/atcmd-itf-arm

## GMS apps
$(call inherit-product-if-exists, 3rdparty/google/gms-apps/products/gms.mk)

## GMS 3rd-party preinstalled apk
$(call inherit-product-if-exists, 3rdparty/applications/prebuilt/common/wx_diag.mk)

## SKU specific apps
$(call inherit-product-if-exists, vendor/nvidia/ardbeg/wx_diag.mk)
