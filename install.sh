#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
 ./install_fedora.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
 ./install_macos.sh
fi
