#!/bin/sh
##
## create_rpms.sh
## 
## Made by Sean Dague
## Login   <sdague@orac>
## 
## Started on  Fri Nov 19 09:37:38 2010 Sean Dague
## Last update Fri Nov 19 09:37:38 2010 Sean Dague
##

rm -f /tmp/*.rpm
cd src
export CONFIG_FLAGS="--with-fsal=GPFS --enable-snmp-adm --enable-nlm --enable-stat-exporter"
autoreconf -i
./configure $CONFIG_FLAGS
make clean
make rpm
DIR=`pwd`
cp $DIR/rpm/RPMS/x86_64/nfs-ganesha-gpfs* $DIR/rpm/RPMS/x86_64/nfs-ganesha-common* /tmp/