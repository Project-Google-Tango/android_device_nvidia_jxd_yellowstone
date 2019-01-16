# NVIDIA Tegra5 "Ardbeg" development system
#
# Copyright (c) 2013, NVIDIA Corporation.  All rights reserved.
#
# AndroidProducts.mk is included before BoardConfig.mk, variable essential at
# start of build and used in here should always be intialized in this file

## All essential packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/nvidia/ardbeg/device.mk)

## including rild here to create modem for data only skus without dialer and
## mms apps , not including generic.mk
PRODUCT_PACKAGES += rild

## NV_TN_SKU
NV_TN_SKU := wx_na_do

## REFERENCE_DEVICE
REFERENCE_DEVICE := ardbeg

## NV_TN_PLATFORM
NV_TN_PLATFORM := premium

## NV_TN_WITH_GMS - allowed values true, false
NV_TN_WITH_GMS := true

## Thse are default settings, it gets changed as per sku manifest properties
PRODUCT_NAME := wx_na_do
PRODUCT_DEVICE := ardbeg
PRODUCT_MODEL := wx_na_do
PRODUCT_MANUFACTURER := NVIDIA
PRODUCT_BRAND := nvidia

## The base dtb file name used for this product
TARGET_KERNEL_DT_NAME := tegra124-tn8

PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/gpsconfig-ardbeg.xml:system/etc/gps/gpsconfig.xml

## Icera modem integration
$(call inherit-product-if-exists, $(LOCAL_PATH)/../common/icera/icera-modules.mk)
SYSTEM_ICERA_FW_PATH=system/vendor/firmware/icera
LOCAL_ICERA_FW_PATH=vendor/nvidia/tegra/icera/firmware/binaries/binaries_nvidia-e1729-tn8l
PRODUCT_COPY_FILES += \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/secondary_boot.wrapped:$(SYSTEM_ICERA_FW_PATH)/secondary_boot.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/loader.wrapped:$(SYSTEM_ICERA_FW_PATH)/loader.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/modem.wrapped:$(SYSTEM_ICERA_FW_PATH)/modem.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/productConfigXml_icera_e1729_tn8l_nala.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-nala/productConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/productConfigXml_icera_e1729_tn8l.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729/productConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_PATH)/../t124/init.icera.rc:root/init.icera.rc)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modem.do=1

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-tablet-do

## GMS apps
$(call inherit-product-if-exists, 3rdparty/google/gms-apps/products/gms.mk)

## GMS 3rd-party preinstalled apk
$(call inherit-product-if-exists, 3rdparty/applications/prebuilt/common/wx_na_do.mk)

## SKU specific apps
$(call inherit-product-if-exists, vendor/nvidia/ardbeg/wx_na_do.mk)
