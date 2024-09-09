#!/bin/bash

root_dir=$(pwd)
cd ${root_dir} && cd ..
kernel_dir=`pwd` && cd ${root_dir}
echo "kernel_dir=$kernel_dir"
rm -rf out
make clean && make mrproper
mkdir out
# export TARGET_ARCH_VARIANT=armv7-a-neon
export CROSS_COMPILE="$kernel_dir/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export ARCH=arm64

make ARCH=arm64 O=out hq8167_tb_n_defconfig
status=${PIPESTATUS[0]}
if [ "$status" != "0" ]; then 
     echo "ERROR:  make defconfig  error:"
     exit
else
     echo "#### make defconfig successfully ####"
fi
make ARCH=arm64 -j$(nproc) O=out
re=${PIPESTATUS[0]}
if [ "$re" != "0" ];then 
     echo "ERROR:  build kernel error:"
     exit
else
    echo "#### build kernel completed successfully ####"
fi