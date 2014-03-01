#!/bin/bash

export BUILD_WITH_COLORS=0
export PATH=$PWD/bin:$PATH

eval `ssh-agent`
trap "kill $SSH_AGENT_PID" EXIT

ssh-add $PWD/jenkins_key

cp -fv local_manifest.xml .repo/local_manifests/

repo sync -c
. build/envsetup.sh

breakfast yuga

cd vendor/cm
./get-prebuilts
cd -

mka clean
mka bacon
