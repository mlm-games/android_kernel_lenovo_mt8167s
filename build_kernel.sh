#!/bin/bash
set -e
rm -rf out
make clean && make mrproper
mkdir out

export CROSS_COMPILE="$(pwd)/../aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export ARCH=arm64
export O=out

make aud8516p1_64_basic_debug_defconfig

status=${PIPESTATUS[0]}
if [ "$status" != "0" ]; then 
     echo "ERROR:  make defconfig  error:"
     exit
else
     echo "#### make defconfig successfully ####"
fi
make -j$(nproc)

re=${PIPESTATUS[0]}
if [ "$re" != "0" ];then 
     echo "ERROR:  build kernel error:"
     exit
else
    echo "#### build kernel completed successfully ####"
fi