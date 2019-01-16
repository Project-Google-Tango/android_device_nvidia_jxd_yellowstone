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

## NV_TN_SKU
NV_TN_SKU := wx_na_wf

## REFERENCE_DEVICE
REFERENCE_DEVICE := ardbeg

## NV_TN_PLATFORM
NV_TN_PLATFORM := basic

## NV_TN_WITH_GMS - allowed values true, false
NV_TN_WITH_GMS := true

## Thse are default settings, it gets changed as per sku manifest properties
PRODUCT_NAME := wx_na_wf
PRODUCT_DEVICE := ardbeg
PRODUCT_MODEL := wx_na_wf
PRODUCT_MANUFACTURER := NVIDIA
PRODUCT_BRAND := nvidia

## The base dtb file name used for this product
TARGET_KERNEL_DT_NAME := tegra124-tn8

## SKU specific overrides
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.none.rc:root/init.none.rc \
    vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/gpsconfig-wf-ardbeg.xml:system/etc/gps/gpsconfig.xml

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-tablet

PRODUCT_PROPERTY_OVERRIDES += ro.radio.noril=true

## GMS apps
$(call inherit-product-if-exists, 3rdparty/google/gms-apps/products/gms.mk)

## GMS 3rd-party preinstalled apk
$(call inherit-product-if-exists, 3rdparty/applications/prebuilt/common/wx_na_wf.mk)

## SKU specific apps
$(call inherit-product-if-exists, vendor/nvidia/ardbeg/wx_na_wf.mk)
