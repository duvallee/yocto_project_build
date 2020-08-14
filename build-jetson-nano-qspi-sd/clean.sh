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
   # ------------------------------------------------------------------
   # build
   build_start_time

   rm -rf bitbake-cookerdaemon.log
   rm -rf bitbake.lock
   rm -rf bitbake.sock
   rm -rf cache
   rm -rf sstate-cache
   rm -rf tmp

   build_end_time
   # ------------------------------------------------------------------
}

