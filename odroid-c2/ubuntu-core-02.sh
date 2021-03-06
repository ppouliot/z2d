#!/bin/sh
set -ex
. ./common-functions.sh

export DEBIAN_FRONTEND=noninteractive

c_locale "en_GB.UTF-8" "de_DE.UTF-8"
c_tzone "Europe/Berlin"
c_hostname "c2"
c_apt_list "xenial"
c_nameserver "8.8.8.8"

dpkg-divert --local --rename --add /sbin/initctl; ln -s /bin/true /sbin/initctl

r_pkg_upgrade
i_base
i_extra
i_kernel_odroid_c2_415
c_if_lo
c_if_dhcp "eth0"
c_ttyS "ttyAML0"
c_fw_utils "/dev/mmcblk0 0xB4000 0x8000 0x200"
c_user "ubuntu"

apt-get clean

rm /sbin/initctl; dpkg-divert --local --rename --remove /sbin/initctl
