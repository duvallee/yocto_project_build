#!/bin/bash
#
#
# ------------------------------------------------------------------
export START_TIME=""
export END_TIME=""

export TOP_DIR=`pwd`
export DEPLOY_DIR=${TOP_DIR}/tmp-glibc/deploy/images/stm32mp1/
export SDCARD_SHELL_SCRIPT=${DEPLOY_DIR}/scripts/create_sdcard_from_flashlayout.sh
export FLASHLAYOUT_FILE=${DEPLOY_DIR}/flashlayout_st-image-weston/FlashLayout_sdcard_stm32mp157c-dk2-basic.tsv

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
    build_start_time
    bitbake st-image-weston -c cleanall
    bitbake st-image-weston
    build_end_time
    if [ ! -e ../release ]
    then
        mkdir -p ../release
    else
        rm -rf ../release
        mkdir -p ../release
    fi

    if [ ! -e ${SDCARD_SHELL_SCRIPT} ]
    then
        echo "Not found script : ${SDCARD_SHELL_SCRIPT} "
        exit 0
    fi
    ${SDCARD_SHELL_SCRIPT} ${FLASHLAYOUT_FILE}
    mv ${DEPLOY_DIR}/flashlayout_st-image-weston_FlashLayout_sdcard_stm32mp157c-dk2-basic.raw ../release/st32mp157c-dk2-basic.img 
}

