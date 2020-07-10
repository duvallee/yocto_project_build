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

   echo "================================================================================="
   echo "Build time : $((($END_TIME-$START_TIME)/60)) minutes $((($END_TIME-$START_TIME)%60)) seconds"
   echo "================================================================================="
}

# ------------------------------------------------------------------
# MAIN LOOP
{
    build_start_time
    rm -rf buildhistory
    rm -rf cache
    rm -rf sstate-cache
    rm -rf tmp-glibc
    rm -f bitbake-cookerdaemon.log
    build_end_time
}

