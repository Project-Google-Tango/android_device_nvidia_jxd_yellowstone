# NVIDIA Tegra4 "loki" development system
#
# Copyright (c) 2013 NVIDIA Corporation.  All rights reserved.
# Product to build bootloader

PRODUCT_NAME := lokibl
PRODUCT_DEVICE := loki
PRODUCT_MODEL := loki
PRODUCT_MANUFACTURER := NVIDIA
PRODUCT_BRAND := nvidia

# Disable dependency from libcompiler rt and kernel
WITHOUT_LIBCOMPILER_RT := 1
TARGET_NO_KERNEL := true
