#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  source ./common_linux.sh

 ./install_ubuntu.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
 ./install_macos.sh
fi
