#!/bin/bash

export PATH=$PWD/bin:$PATH

find . -maxdepth 1 -not \( \
  -name '.' -or \
  -name 'build*.sh' -or \
  -name '.repo' -or \
  -name 'jenkins_*' -or \
  -name 'bin' -or \
  -name '.git' -or \
  -name 'local_manifest.xml' -or \
  -name '.gitignore' \) \
  -exec echo rm -rf {} \;

repo init -u /cyanogenmod/cm/cozybit/android.git -b cm-10.2
