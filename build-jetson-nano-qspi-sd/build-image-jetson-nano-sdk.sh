#!/bin/bash
#
#

# ------------------------------------------------------------------
# base

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
     bitbake image-jetson-nano-sdk -c clean
   fi

   bitbake image-jetson-nano-sdk
   build_end_time
   # ------------------------------------------------------------------
}


