#!/bin/bash
#location of LOCAL-YUM
#This script is made for establish a local yum-source
#by Laurenfrost
usr=`whoami`

YUM_PATH=/home/${usr}/yumsoftware
ISO_PATH=${YUM_PATH}/CentOS-7-x86_64-Everything-1810.iso
#cp -r yumsoftware /home/${usr}/

#Create the mount point
#And mount the ISO
sudo df -h | grep loop0
sudo mkdir -p /media/CentOS
sudo mount -o loop ${ISO_PATH} /media/CentOS
df -h | grep loop0

#add automatical mount option
# sudo chmod 666 /etc/fstab
# echo ${ISO_PATH}  /media/CentOS/ iso9660 loop 0 0>>/etc/fstab
# grep iso /etc/fstab
# sudo chmod 644 /etc/fstab

#change the repo souce as local iso
sudo cat << EOF > /etc/yum.repos.d/CentOS-Media.repo
# CentOS-Media.repo
#
#  This repo can be used with mounted DVD media, verify the mount point for
#  CentOS-7.  You can use this repo and yum to install items directly off the
#  DVD ISO that we release.
#
# To use this repo, put in your DVD and use it with the other repos too:
#  yum --enablerepo=c7-media [command]
#  
# or for ONLY the media repo, do this:
#
#  yum --disablerepo=\* --enablerepo=c7-media [command]

[c7-media]
name=CentOS-$releasever - Media
baseurl=file:///media/CentOS/
gpgcheck=0
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#[laurenfrost-yum]
#name=local-yum
#baseurl=file:///home/${user}/yumsoftware
#enabled=0
#gpgcheck=0
EOF


sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
sudo mv /etc/yum.repos.d/CentOS-Debuginfo.repo  /etc/yum.repos.d/CentOS-Debuginfo.repo.backup
sudo mv /etc/yum.repos.d/CentOS-Sources.repo /etc/yum.repos.d/CentOS-Sources.repo.backup

#add local repo storage
# sudo yum install createrepo
# sudo createrepo $YUM_PATH

echo "$YUM_PATH" 

sudo yum clean all 
sudo yum makecache
