#!/bin/bash
#
#

# ------------------------------------------------------------------
# base
export BUILD_ROOT=`pwd`
export BUILD_DIR="build-jetson-nano-qspi-sd"
export BUILD_TMP="tmp"
export BUILD_BOARD="jetson-nano-qspi-sd"
export BUILD_IMAGES="core-image-minimal-jetson-nano-qspi-sd.tegraflash.tar.gz"

# ------------------------------------------------------------------
export DEPLOY_PATH=${BUILD_ROOT}/${BUILD_TMP}/deploy/images/${BUILD_BOARD}
export RELEASE_PATH=${BUILD_ROOT}/../release

# ------------------------------------------------------------------
export START_TIME=""
export END_TIME=""

# ------------------------------------------------------------------
# build_start_time
# ------------------------------------------------------------------
function build_start_time()
{
   START_TIME=`date +%s`
}

# ------------------------------------------------------------------
# build_end_time
# ------------------------------------------------------------------
function build_end_time()
{
   END_TIME=`date +%s`

   echo ""
   echo "================================================================================="
   echo "${0} Build time : $((($END_TIME-$START_TIME)/60)) minutes $((($END_TIME-$START_TIME)%60)) seconds"
   echo "================================================================================="
   echo ""
}

# ------------------------------------------------------------------
# MAIN LOOP
{
   # check download directory
   if [ ! -e ../../downloads ]
   then
     mkdir -p ../../downloads
     ln -s ../../downloads downloads
   fi

   # check download directory
   if [ ! -e downloads ]
   then
     ln -s ../../downloads downloads
   fi

   # ------------------------------------------------------------------
   # build
   build_start_time

  if [ "${1}" != "-u" ]
   then
     bitbake core-image-minimal -c clean
   fi

   bitbake core-image-minimal
   build_end_time
   # ------------------------------------------------------------------


   # ------------------------------------------------------------------
   # build
   build_start_time

   # check release directory
      echo " ${RELEASE_PATH} "
   if [ ! -e ${RELEASE_PATH} ]
   then
      mkdir -p ${RELEASE_PATH}
      echo " ${RELEASE_PATH} "
   fi

   pushd .
   cd ${RELEASE_PATH}

   if [ ! -e tmp ]
   then
     rm -rf tmp
   fi

   mkdir -p tmp
   cp ${DEPLOY_PATH}/${BUILD_IMAGES} ./tmp/.

   cd tmp
   tar -zxvf ${BUILD_IMAGES}
   ./dosdcard.sh

   cd ../
   mv ./tmp/core-image-minimal.sdcard core-image-minimal.sdcard.img
   rm -rf ./tmp

   popd

   build_end_time
   # ------------------------------------------------------------------
}


