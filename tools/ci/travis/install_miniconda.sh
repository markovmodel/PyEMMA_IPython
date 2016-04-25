#!/bin/bash

TARGET=$HOME/miniconda

function install_miniconda {
	echo "installing miniconda"
	wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O mc.sh -o /dev/null
	bash mc.sh -b -f -p $TARGET
}

export PATH=$TARGET/bin:$PATH

install_miniconda
