#!/bin/bash
#
#
# ------------------------------------------------------------------

pushd .
cd dunfell
repo start spotmicro-raspberry-pi 
popd

pushd .
cd dunfell/bsp/u-boot 
repo start raspberrypi_4  
popd

pushd .
cd dunfell/bsp/kernel
repo start raspberrypi_4  
popd

pushd .
cd dunfell/source/poky 
repo start dunfell  
popd

pushd .
cd dunfell/source/meta-openembedded  
repo start dunfell  
popd

pushd .
cd dunfell/source/meta-qt5  
repo start dunfell  
popd

pushd .
cd dunfell/source/meta-raspberrypi  
repo start dunfell  
popd

pushd .
cd dunfell/source/meta-ros  
repo start dunfell  
popd

pushd .
cd dunfell/source/meta-raspberrypi-custom  
repo start raspberrypi_4
popd

pushd .
cd 3d-cad-files  
repo start spotmicro-raspberry-pi 
popd

pushd .
cd old-mcu  
repo start spotmicro-raspberry-pi 
popd

pushd .
cd micro-ros-mcu 
repo start spotmicro-raspberry-pi-micro-ros 
popd

pushd .
cd app/spotmicro  
repo start spotmicro-raspberry-pi 
popd

pushd .
cd app/test  
repo start spotmicro-raspberry-pi-test  
popd

