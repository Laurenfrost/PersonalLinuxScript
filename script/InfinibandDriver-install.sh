#!/bin/sh

## check the firmware version and downlowd the right version of drivers
## get Mellanox IB driver on https://www.mellanox.com/products/infiniband-drivers/linux/mlnx_ofed
ethtool -i ib0

## unzip the driver
PACKAGE=MLNX_OFED_LINUX-5.0-2.1.8.0-rhel7.7-x86_64
tar zxvf ${package}.tgz
cd ${package}

## in CentOS 7.7 computer node installation,  
## there are two packages depends on the common version driver  
## which has been installed during OS installation.
## opa-address-resolution & opa-libopamgt
sudo yum remove opa-address-resolution opa-libopamgt

## install the driver
sudo ./mlnxofedinstall

## restart the service  
## there are some module depends on rdma_cm
## remove them first
sudo modprobe -r rpcrdma ib_srpt ib_isert
## check the issue in https://www.mellanox.com/related-docs/prod_software/Mellanox_OFED_Linux_Release_Notes_3_1-1_0_0.pdf
sudo /etc/init.d/openibd restart

## Configure the IPoIB then
## check the HCA stat
ibstat

## configure the IP on m1501
## change the following configs before you use them
cat << EOF > /etc/sysconfig/network-scripts/ifcfg-ib0
CONNECTED_MODE=no
TYPE=InfiniBand
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=static
DEFROUTE=yes
IPADDR=10.1.24.7
NETMASK=255.255.0.0
BROADCAST=10.1.255.255
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=ib0
UUID=e1b33c52-48c3-44a6-a991-97377ced43e6
DEVICE=ib0
ONBOOT=yes
EOF

## restart
sudo ifdown ib0
sudo ifup ib0

## check 
ifconfig ib0
