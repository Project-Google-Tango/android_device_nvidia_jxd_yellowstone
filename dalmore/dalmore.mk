# NVIDIA Tegra4 "Dalmore" development system
#
# Copyright (c) 2012 NVIDIA Corporation.  All rights reserved.

ifeq ($(BUILD_HAS_VENDOR_TV),true)
$(call inherit-product, vendor/tv/nvidia/dalmore.mk)
else
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)
endif

ifeq ($(wildcard 3rdparty/google/gms-apps/products/gms.mk),3rdparty/google/gms-apps/products/gms.mk)
$(call inherit-product, 3rdparty/google/gms-apps/products/gms.mk)
endif

PRODUCT_NAME := dalmore
PRODUCT_DEVICE := dalmore
PRODUCT_MODEL := Dalmore
PRODUCT_MANUFACTURER := NVIDIA

PRODUCT_LOCALES += en_US
PRODUCT_PROPERTY_OVERRIDES += \
ro.com.google.clientidbase=android-nvidia

$(call inherit-product, device/nvidia/dalmore/device.mk)
$(call inherit-product-if-exists, vendor/nvidia/tegra/secureos/nvsi/nvsi.mk)

ifeq ($(BUILD_HAS_VENDOR_TV),true)
include vendor/tv/products/tv-dalvik-heap.mk
else
include frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk
endif
