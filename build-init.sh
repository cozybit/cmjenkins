#!/bin/bash

export PATH=$PWD/bin:$PATH

find . -maxdepth 1 -not \( \
  -name '.' -or \
  -name 'build*.sh' -or \
  -name '.repo' -or \
  -name 'jenkins_*' -or \
  -name 'bin' \) \
  -exec rm -rf {} \;

repo init -u /cyanogenmod/cm/cozybit/android.git -b cm-10.2
