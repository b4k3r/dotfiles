#!/bin/bash

source ./common.sh

if [[ "$OSTYPE" == "linux-gnu" ]]; then
 ./install_linux.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
 ./install_macos.sh
fi
