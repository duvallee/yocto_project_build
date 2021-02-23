#!/bin/bash
#
#
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
   # ===============================================================
   if [ ! -e ../../downloads ]
   then
      mkdir -p ../../downloads
      ln -s ../../downloads downloads
   fi
 
   if [ ! -e downloads ]
   then
      ln -s ../../downloads downloads
   fi

   # ===============================================================
   build_start_time

   bitbake raspberry-core-image -c populate_sdk

   build_end_time
}



