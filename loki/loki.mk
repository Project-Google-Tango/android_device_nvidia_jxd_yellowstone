# NVIDIA Tegra4 "loki" development system
#
# Copyright (c) 2013 NVIDIA Corporation.  All rights reserved.

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

PRODUCT_NAME := loki
PRODUCT_DEVICE := loki
PRODUCT_MODEL := loki
PRODUCT_MANUFACTURER := NVIDIA

$(call inherit-product, device/nvidia/loki/device.mk)
