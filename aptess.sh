#!/bin/bash

# Android Prebuilt Toolchains External Script Set - APTESS
# For build ARM64 and ARM Linux Kernels

clear
echo
echo "-APTESS - Toolchain Choice-"
echo
echo "${bldgrn}-GCC Linaro-${txtrst}"
echo
echo "0) GCC 7.5.0 toolchain from Linaro"
echo
echo "${bldred}-GCC Google-${txtrst}"
echo
echo "1) GCC 4.9.0 toolchain from Google"
echo
echo "${bldcya}-GCC arter97-${txtrst}"
echo
echo "2) GCC 9.2.0 toolchain from arter97"
echo
echo "${bldblu}-Clang Google-${txtrst}"
echo
echo "3) Clang 9.0.8 with GCC 4.9.0 both from Google"
echo
echo "*) Any other key to Exit"
echo
DIR_KERNEL="$(pwd)"
if [ "${ORIGINAL_PATH}" == "" ]
then
	ORIGINAL_PATH=${PATH}
fi
cd ..
DIR_TOOLCHAIN="$(pwd)/Toolchain"
cd /
cd $DIR_KERNEL
unset errortoolchain
read -p "Choice: " -n 1 -s x
_CROSS_COMPILE=$CROSS_COMPILE
unset CROSS_COMPILE
case "$x" in

 #################### LINARO ####################

	0 ) export CROSS_COMPILE="${DIR_TOOLCHAIN}/linaro_gcc/aarch64-linux-gnu-7.5.0-2019.12/bin/aarch64-linux-gnu-";
	    export CROSS_COMPILE_ARM32="${DIR_TOOLCHAIN}/linaro_gcc/arm-eabi-7.5.0-2019.12/bin/arm-eabi-";
        export TARGET_CC="gcc";
        ToolchainName="Linaro";
        ToolchainCompile="Linaro GCC 7.5.0";;

 #################### GOOGLE ####################

	1 ) export CROSS_COMPILE="${DIR_TOOLCHAIN}/google_gcc/aarch64-linux-android-4.9/bin/aarch64-linux-android-";
	    export CROSS_COMPILE_ARM32="${DIR_TOOLCHAIN}/google_gcc/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-";
        export TARGET_CC="gcc";
        ToolchainName="Google";
        ToolchainCompile="Google GCC 4.9.0";;

 #################### arter97 ####################

	2 ) export CROSS_COMPILE="${DIR_TOOLCHAIN}/arter97_gcc/arm64-gcc-master/bin/aarch64-elf-";
	    export CROSS_COMPILE_ARM32="${DIR_TOOLCHAIN}/arter97_gcc/arm32-gcc-master/bin/arm-eabi-";
        export TARGET_CC="gcc";
        ToolchainName="arter97";
        ToolchainCompile="arter97 GCC 9.2.0";;

 #################### CLANG ####################

	3 ) export CROSS_COMPILE="${DIR_TOOLCHAIN}/google_gcc/aarch64-linux-android-4.9";
	    export CROSS_COMPILE_ARM32="${DIR_TOOLCHAIN}/google_gcc/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-";
        export KERNEL_CLANG_PATH="${DIR_TOOLCHAIN}/google_clang/clang-r365631c-9.0.8";
        export TARGET_CLANG_TRIPLE="aarch64-linux-gnu-"
        export TARGET_CROSS_COMPILE="aarch64-linux-android-"
        export PATH=${ORIGINAL_PATH}
        export PATH="${KERNEL_CLANG_PATH}/bin:${CROSS_COMPILE}/bin:${PATH}"
        export TARGET_CC="clang";
        ToolchainName="Clang"; 
        ToolchainCompile="Clang Google 9.0.8";;

	* ) ;;

esac
if [ "$CROSS_COMPILE" == "" ]
then
	CROSS_COMPILE=$_CROSS_COMPILE
	unset _CROSS_COMPILE
else
	echo $ToolchainCompile
fi
