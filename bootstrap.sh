#!/usr/bin/env bash
###############################################################################
#Script to install Apache to VM create by Vagrant
#Auther: Kenneth Lynch
#Date: 7-13-16
###############################################################################

#Arguments
while getopts p: option
do
case "${option}"
in
p) password=${OPTARG};;
esac
done


export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

debconf-set-selections <<< 'mysql-server mysql-server/root_password password $password'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password $password'

apt-get update
apt-get install -y mysql-server

sudo sed -i 's/key_buffer/key_buffer_size/' /etc/mysql/my.cnf

