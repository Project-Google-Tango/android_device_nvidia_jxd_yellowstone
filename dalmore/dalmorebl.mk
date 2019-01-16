# NVIDIA Tegra4 "loki" development system
#
# Copyright (c) 2013 NVIDIA Corporation.  All rights reserved.
# Product to build bootloader

PRODUCT_NAME := dalmorebl
PRODUCT_DEVICE := dalmore
PRODUCT_MODEL := Dalmore
PRODUCT_MANUFACTURER := NVIDIA
PRODUCT_BRAND := nvidia

# Disable dependency from libcompiler rt and kernel
WITHOUT_LIBCOMPILER_RT := 1
TARGET_NO_KERNEL := true
