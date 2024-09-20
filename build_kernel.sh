#!/bin/bash

set -e

if [ -z "$1" ]; then
echo "Error: Enter the defconfig"
exit
fi

# if [ -z "$2" == --clang ]; then
# echo "Using clang"
# export LLVM=1
# fi

if [ ! -d "../aarch64-linux-android-4.9" ]; then
echo "GCC toolchain not avaliable at $../aarch64-linux-android-4.9"
exit
fi

make clean && make mrproper

rm -rf out && mkdir out

export CROSS_COMPILE="$(pwd)/../aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export ARCH=arm64
export O=out

make $1 O=out

make -j$(nproc) O=out -Wno-error