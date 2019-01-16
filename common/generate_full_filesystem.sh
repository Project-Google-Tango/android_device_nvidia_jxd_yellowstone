#!/bin/bash
#
# Usage: generate_full_filesystem.sh
#        generate_full_filesystem.sh --help
#
# Description: Generate a complete Android root file system, both in a ramdisk
#              and in a folder that can be mounted through NFS.
#-------------------------------------------------------------------------------

# Help target
if [ "$1" == "--help" ]; then
    this_script=`basename $0`
    echo " "
    echo "Generate a complete Android root file system, both in a ramdisk"
    echo "and in a folder that can be mounted through NFS."
    echo " "
    echo "Usage:"
    echo " "
    echo "  $this_script"
    echo "  $this_script --help"
    echo " "
    echo "where:"
    echo " "
    echo "  --help: produces this description"
    echo " "
    exit 0
fi

nfs_out=$OUT/full_filesystem
ramdisk_out=$OUT/full_filesystem.img

android_host_bin=$ANDROID_HOST_OUT/bin

# Sanity checks
if [ "$OUT" == "" ]; then
    echo "ERROR: Environment variable OUT is not set. You must initialize an Android build shell."
    exit 2
fi

if [ "$ANDROID_HOST_OUT" == "" ]; then
    echo "ERROR: Environment variable ANDROID_HOST_OUT is not set. You must initialize an Android build shell."
    exit 2
fi

if [ ! -d "$OUT" ]; then
    echo "ERROR: Product output directory $OUT does not exist."
    exit 2
fi

if [ ! -d "$android_host_bin" ]; then
    echo "ERROR: Host tools directory $android_host_bin does not exist."
    exit 2
fi

# Output directory preparation
echo "Generating NFS-friendly root file system under $nfs_out."
rm -rf $nfs_out
mkdir -p $nfs_out

# File copy
cp -ra $OUT/root/* $nfs_out
cp -ra $OUT/system $nfs_out
cp -ra $OUT/data $nfs_out

# Ensure that group and world do not have write permissions for certain files in
# $nfs_out. If the following files have group/world write permissions, the init
# executable complains about "skipping insecure files" and simulator does not
# boot up.
chmod 644 $nfs_out/*.rc
chmod 644 $nfs_out/default.prop
chmod 644 $nfs_out/system/build.prop

# Package into a ramdisk
echo "Packaging ramdisk as $ramdisk_out."
$android_host_bin/mkbootfs $nfs_out | gzip -9 > $ramdisk_out

echo "Done"
exit 0

