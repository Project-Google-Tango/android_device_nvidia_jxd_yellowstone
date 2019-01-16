#!/system/bin/sh

# Copyright (c) 2013-2014, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

# create a folder for phs to store various files
mkdir -p /data/misc/phs
chown system /data/misc/phs
chmod 0775 /data/misc/phs

# set up power management nodes for user space control
chown system /sys/kernel/cluster/active
chmod 0640 /sys/kernel/cluster/active

# loop through all cpu cores
for ci in /sys/devices/system/cpu/cpu[0-3]*
do
    chown system ${ci}/cpuquiet/active
    chmod 0664 ${ci}/cpuquiet/active

    chown system ${ci}/cpufreq/scaling_governor
    chmod 0664 ${ci}/cpufreq/scaling_governor

    chown system ${ci}/cpufreq/scaling_setspeed
    chmod 0664 ${ci}/cpufreq/scaling_setspeed
done

chown root:system /dev/constraint_cpu_freq
chmod 0660 /dev/constraint_cpu_freq
chown root:system /dev/constraint_gpu_freq
chmod 0660 /dev/constraint_gpu_freq
chown root:system /dev/constraint_online_cpus
chmod 0660 /dev/constraint_online_cpus

chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
chmod 0444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
chown system /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
chmod 0444 /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
chown system /sys/devices/system/cpu/cpufreq/cpuload/cpu_load
chmod 0444 /sys/devices/system/cpu/cpufreq/cpuload/cpu_load
chown system /sys/devices/system/cpu/cpufreq/cpuload/cpu_usage
chmod 0444 /sys/devices/system/cpu/cpufreq/cpuload/cpu_usage
chown system /sys/devices/system/cpu/cpufreq/cpuload/enable
chmod 0664 /sys/devices/system/cpu/cpufreq/cpuload/enable
chown system /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/no_lp
chmod 0664 /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/no_lp
chown system /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/enable
chmod 0664 /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/enable
chown system /sys/devices/system/cpu/cpuquiet/current_governor
chmod 0664 /sys/devices/system/cpu/cpuquiet/current_governor
chown system /sys/devices/system/cpu/present
chmod 0444 /sys/devices/system/cpu/present
chown system /d/clock/cpu_g/min
chmod 0444 /d/clock/cpu_g/min
chown system /sys/kernel/debug/clock/c2bus/possible_rates
chmod 0444 /sys/kernel/debug/clock/c2bus/possible_rates
chown system /d/clock/cpu_lp/max
chmod 0664 /d/clock/cpu_lp/max
chown system /sys/class/graphics/fb0/device/enable
chmod 0644 /sys/class/graphics/fb0/device/enable

# FPS nodes
chown system /sys/kernel/debug/fps
chmod 0444 /sys/kernel/debug/fps
chown system /sys/devices/virtual/misc/tegra-throughput/fps
chmod 0444 /sys/devices/virtual/misc/tegra-throughput/fps
chown system /sys/devices/virtual/misc/tegra-throughput/framecount
chmod 0444 /sys/devices/virtual/misc/tegra-throughput/framecount

# gr3d nodes
chown system /sys/devices/platform/host1x/gr3d/freq_request
chmod 0664 /sys/devices/platform/host1x/gr3d/freq_request
chown system /sys/devices/platform/host1x/gr3d/user
chmod 0664 /sys/devices/platform/host1x/gr3d/user
chown system /sys/devices/platform/host1x/gr3d/devfreq/gr3d/cur_freq
chmod 0444 /sys/devices/platform/host1x/gr3d/devfreq/gr3d/cur_freq
chown system /sys/devices/platform/host1x/gr3d/load
chmod 0444 /sys/devices/platform/host1x/gr3d/load

# gk20a nodes
chown system /sys/devices/platform/host1x/gk20a.0/freq_request
chmod 0664 /sys/devices/platform/host1x/gk20a.0/freq_request
chown system /sys/devices/platform/host1x/gk20a.0/user
chmod 0664 /sys/devices/platform/host1x/gk20a.0/user
chown system /sys/devices/platform/host1x/gk20a.0/devfreq/gk20a.0/cur_freq
chmod 0444 /sys/devices/platform/host1x/gk20a.0/devfreq/gk20a.0/cur_freq
chown system /sys/devices/platform/host1x/gk20a.0/load
chmod 0444 /sys/devices/platform/host1x/gk20a.0/load
chown system /sys/devices/platform/host1x/gk20a.0/counters_reset
chmod 0444 /sys/devices/platform/host1x/gk20a.0/counters_reset

chown system /sys/devices/platform/host1x/gk20a.0/slcg_enable
chmod 0664 /sys/devices/platform/host1x/gk20a.0/slcg_enable
chown system /sys/devices/platform/host1x/gk20a.0/elcg_enable
chmod 0664 /sys/devices/platform/host1x/gk20a.0/elcg_enable
chown system /sys/devices/platform/host1x/gk20a.0/elpg_enable
chmod 0664 /sys/devices/platform/host1x/gk20a.0/elpg_enable
chown system /sys/devices/platform/host1x/gk20a.0/blcg_enable
chmod 0664 /sys/devices/platform/host1x/gk20a.0/blcg_enable


# loop through thermal zones
for tz in /sys/class/thermal/thermal_zone*
do
    chown system ${tz}/type
    chmod 0444 ${tz}/type
    chown system ${tz}/temp
    chmod 0444 ${tz}/temp

    # loop through trip points
    for tp in $tz/trip_point_[0-9]*temp
    do
        if [ -e $tp ]
        then
            chown system $tp
            chmod 0664 $tp
        fi
    done

    for tp in $tz/trip_point_[0-9]*hyst
    do
        if [ -e $tp ]
        then
            chown system $tp
            chmod 0664 $tp
        fi
    done
done
