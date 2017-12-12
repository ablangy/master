#!/bin/bash
KNL_ARCH=arm64
KNL_CROSS_COMPILE=aarch64-linux-gnu-
# KNL_PATH=/opt/toolchains/gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu/bin
KNL_PATH=/opt/toolchains/gcc-linaro-7.1.1-2017.08-x86_64_aarch64-linux-gnu/bin

# Pour preciser la racine d'installation des modules
# INSTALL_MOD_PATH=

KNL_DIR=$1
KNL_TARGET=$2

do_compile()
{
  local src_dir=$1
  local target=$2
  local rc=0
  
  pushd $src_dir
  export ARCH=${KNL_ARCH}
  export CROSS_COMPILE=${KNL_CROSS_COMPILE}
  export PATH=${KNL_PATH}:${PATH}
  # make ${target} ARCH=${KNL_ARCH} CROSS_COMPILE=${KNL_CROSS_COMPILE} PATH=${KNL_PATH}:${PATH}
  make ${target}
  rc=$?
  popd
  
  return $rc
}

if [ z"${KNL_DIR}" == z"" ]; then
  echo "Specify the source directory"
  exit 1;
fi

if [ ! -d ${KNL_DIR} ]; then
  echo "${KNL_DIR} directory doesn't exist";
  exit 1;
fi

if [ z"${KNL_TARGET}" == z"" ]; then
  
  # Generation d'une image U-BOOT complete
  echo "Create a complete kernel image";
  do_compile ${KNL_DIR} odroidc2_defconfig
  if [ $? -ne 0 ]; then
    echo "odroidc2_config compilation error !";
    exit 1;
  fi
  do_compile ${KNL_DIR} "-j4 Image" 
  if [ $? -ne 0 ]; then
    echo "Image compilation error !";
    exit 1;
  fi
  do_compile ${KNL_DIR} dtbs
  if [ $? -ne 0 ]; then
    echo "dtbs compilation error !";
    exit 1;
  fi
  
  echo "Complete kernel compilation done !"
  ls -la ${KNL_DIR}/arch/arm64/boot/Image
  ls -la ${KNL_DIR}/arch/arm64/boot/dts/meson64_odroidc2.dtb
  echo "To compile modules execute # $0 ${KNL_DIR} modules";
  
else

  # Execution de la cible fournit
  do_compile ${KNL_DIR} ${KNL_TARGET}
  if [ $? -ne 0 ]; then
    echo "Compilation error !";
    exit 1;
  fi
  
fi

exit 0;
