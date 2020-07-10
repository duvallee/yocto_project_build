#!/bin/bash
#
#
# ------------------------------------------------------------------
export START_TIME=""
export END_TIME=""

export TOP_DIR=`pwd`
export DEPLOY_DIR=${TOP_DIR}/tmp-glibc/deploy/images/stm32mp1
export SDCARD_SHELL_SCRIPT=${DEPLOY_DIR}/scripts/create_sdcard_from_flashlayout.sh
export FLASHLAYOUT_FILE=${DEPLOY_DIR}/flashlayout_st-example-image-qt-custom/FlashLayout_sdcard_stm32mp157c-dk2-basic.tsv

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

   echo "================================================================================="
   echo "Build time : $((($END_TIME-$START_TIME)/60)) minutes $((($END_TIME-$START_TIME)%60)) seconds"
   echo "================================================================================="
}

# ------------------------------------------------------------------
# MAIN LOOP
{
   if [ ! -e ../../downloads ]
   then
      mkdir -p ../../downloads
      ln -s ../../downloads downloads
   fi

   if [ ! -e downloads ]
   then
      ln -s ../../downloads downloads
   fi

   build_start_time
#    bitbake st-example-image-qt -c cleanall
#    bitbake st-example-image-qt

   bitbake st-image-weston -c cleanall
   bitbake st-image-weston

   build_end_time

   exit 0
   if [ ! -e ../release ]
   then
      mkdir -p ../release
   else
      rm -f ../release/st32mp157c-dk2-qt-basic.img
   fi

   if [ ! -e ${SDCARD_SHELL_SCRIPT} ]
   then
      echo "Not found script : ${SDCARD_SHELL_SCRIPT} "
      exit 0
   fi
   ${SDCARD_SHELL_SCRIPT} ${FLASHLAYOUT_FILE}
   mv ${DEPLOY_DIR}/flashlayout_st-example-image-qt-custom_FlashLayout_sdcard_stm32mp157c-dk2-basic.raw ../release/st32mp157c-dk2-qt-basic-custom.img 
}

