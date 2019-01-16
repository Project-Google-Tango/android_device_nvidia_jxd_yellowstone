#!/system/bin/sh

# Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

# input_cfboost_init.sh -- initialize CPU boost parameters
#
# This script reads max cpu lp frequency and programs it as default
# boost frequency for input cfboost kernel module. In case max lp
# frequency can't be read using sysfs some sane value is set. Default
# boost time is set to 160ms with 2 minimum online CPUs.
#
# Defaults can be override by passing -f, -t, -e and -n options.
# cfboost: CPU Frequency Booster

WRITE_CPU_BOOST_FREQ="/sys/module/input_cfboost/parameters/boost_freq"
WRITE_EMC_BOOST_FREQ="/sys/module/input_cfboost/parameters/boost_emc"
WRITE_BOOST_TIME="/sys/module/input_cfboost/parameters/boost_time"
WRITE_BOOST_CPUS="/sys/module/input_cfboost/parameters/boost_cpus"

# defaults
CPU_FREQ_KHZ=600000
EMC_FREQ_KHZ=300000
TIME_MS=160
NUM_CPUS=2

# scan override options
while getopts f:t:n:e: OPT; do
    case "$OPT" in
        f)
            CPU_FREQ_KHZ=$OPTARG
            ;;
        e)
            EMC_FREQ_KHZ=$OPTARG
            ;;
        t)
            TIME_MS=$OPTARG
            ;;
        n)
            NUM_CPUS=$OPTARG
            ;;
    esac
done

if [ -f $WRITE_CPU_BOOST_FREQ ];
then
    echo $CPU_FREQ_KHZ > $WRITE_CPU_BOOST_FREQ
fi

if [ -f $WRITE_EMC_BOOST_FREQ ];
then
    echo $EMC_FREQ_KHZ > $WRITE_EMC_BOOST_FREQ
fi

if [ -f $WRITE_BOOST_TIME ];
then
    echo $TIME_MS > $WRITE_BOOST_TIME
fi

if [ -f $WRITE_BOOST_CPUS ];
then
    echo $NUM_CPUS > $WRITE_BOOST_CPUS
fi
