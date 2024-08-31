#!/bin/bash

# Signed Kernele installer script
# Made by RDProject Development Team
# For personal use

# Start script
root=http://ru.archive.ubuntu.com/ubuntu/pool/main/
major=6.2.0 # put version of kernel you want to install
patch=21 # follow kernel version description
rev=21 # follow kernel version description

wget \
$root/l/linux-signed/linux-image-$major-${patch}-generic_$major-${patch}.${rev}_amd64.deb \
$root/l/linux/linux-headers-$major-${patch}-generic_$major-${patch}.${rev}_amd64.deb \
$root/l/linux/linux-headers-$major-${patch}_$major-${patch}.${rev}_all.deb \
$root/l/linux/linux-modules-$major-${patch}-generic_$major-${patch}.${rev}_amd64.deb \
$root/l/linux/linux-modules-extra-$major-${patch}-generic_$major-${patch}.${rev}_amd64.deb \
$root/l/linux/linux-modules-iwlwifi-$major-${patch}-generic_$major-${patch}.${rev}_amd64.deb

sudo dpkg -i *.deb

# Fixes "Possible missing firmware /lib/firmware/i915/skl_guc_70.1.1.bin for module i915" etc
wget \
$root/a/amd64-microcode/amd64-microcode_3.20220411.1ubuntu3_amd64.deb \
$root/l/linux-firmware/linux-firmware_20220923.gitf09bebf3-0ubuntu1_all.deb
sudo dpkg -i --auto-deconfigure linux-firmware_*.deb amd64-microcode_*.deb
