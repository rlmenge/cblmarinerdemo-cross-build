#!/bin/bash
set -e

# This script expects no other folders for CBLMariner or CBL-MarinerDemo
# The script results in a configured CBL-MarinerDemo repo ready to perform builds 

# Install prereqs - done in docker file
# apt-get update
# apt-get install -y git sudo software-properties-common
# sudo add-apt-repository ppa:longsleep/golang-backports
# apt-get update
# apt -y install make tar wget curl rpm qemu-utils golang-1.13-go genisoimage pigz cpio python2 python3-distutils
# sudo ln -vs /usr/lib/go-1.13/bin/go /usr/bin/go

# grab toolkit from base repo

TOOLKIT_REPO="CBLMariner"
git clone https://github.com/microsoft/CBL-Mariner.git $TOOLKIT_REPO


# Create the CBL-Mariner 1.0 toolkit
pushd "$TOOLKIT_REPO/toolkit"
git checkout 1.0-stable
mv /.dockerenv /.dockerenv.old 

# Install image utilities
apt-get install -y udev parted dosfstools
sudo make package-toolkit REBUILD_TOOLS=y
popd

# Checkout Demo Derivative repo
git clone https://github.com/microsoft/CBL-MarinerDemo.git

# Expand the toolkit into the demo derivative
cp $TOOLKIT_REPO/out/toolkit-1.0* CBL-MarinerDemo/
sudo rm -r $TOOLKIT_REPO
cd CBL-MarinerDemo
tar xzvf toolkit-1.0*
cd toolkit
# Populate toolchain 
sudo make toolchain REBUILD_TOOLCHAIN=n REBUILD_TOOLS=y -j$(nproc)
sudo make copy-toolchain-rpms
# Build packages
sudo make build-packages -j$(nproc) CONFIG_FILE=
