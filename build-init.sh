#!/bin/bash

export PATH=$PWD/bin:$PATH

usage() {
cat << EOF
usage: $0 [<OPTIONS>]

Build script for prepping a "clean" build of CyanogenMod.

OPTIONS:
   -p   Pretend, don't actually do anything, just print.
   -h   Show this message.
EOF
}

PRETEND=

while getopts "ph" options; do
    case $options in
        p) PRETEND=echo;;
        h) usage; exit 0;;
        *) usage; exit 1;;
    esac
done

find . -maxdepth 1 -not \( \
  -name '.' -or \
  -name 'build*.sh' -or \
  -name '.repo' -or \
  -name 'jenkins_*' -or \
  -name 'bin' -or \
  -name '.git' -or \
  -name 'local_manifest.xml' -or \
  -name 'envsetup.sh' -or \
  -name 'repo_sync' -or \
  -name '.gitignore' \) \
  -exec $PRETEND rm -rf {} \;

$PRETEND repo init -u /cyanogenmod/cm/cozybit/android.git -b cm-10.2
