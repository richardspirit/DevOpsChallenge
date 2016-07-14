#!/usr/bin/env bash
###############################################################################
#Script to install Apache to VM create by Vagrant
#Auther: Kenneth Lynch
#Date: 7-13-16
###############################################################################

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

