# NVIDIA Tegra4 "Dalmore" development system
#
# Copyright (c) 2012 NVIDIA Corporation.  All rights reserved.

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

ifeq ($(wildcard 3rdparty/google/gms-apps/products/gms.mk),3rdparty/google/gms-apps/products/gms.mk)
$(call inherit-product, 3rdparty/google/gms-apps/products/gms.mk)
endif

PRODUCT_NAME := dalmore_hr
PRODUCT_DEVICE := dalmore
PRODUCT_MODEL := Dalmore
PRODUCT_MANUFACTURER := NVIDIA

PRODUCT_LOCALES += en_US

$(call inherit-product, device/nvidia/dalmore/device.mk)
$(call inherit-product-if-exists, vendor/nvidia/tegra/secureos/nvsi/nvsi.mk)

include frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk
