#!/bin/bash

export BUILD_WITH_COLORS=0
export PATH=$PWD/bin:$PATH

eval `ssh-agent`
ssh-add $PWD/jenkins_key

repo sync -c
. build/envsetup.sh

breakfast yuga

cd vendor/cm
./get-prebuilts
cd -

mka clean
mka bootimage
mka bacon
