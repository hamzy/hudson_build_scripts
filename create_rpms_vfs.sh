#!/bin/bash -x
##
## create_rpms.sh
## 
## Made by Sean Dague
## Login   <sdague@orac>
## 
## Started on  Fri Nov 19 09:37:38 2010 Sean Dague
## Last update Fri Nov 19 09:37:38 2010 Sean Dague
##

GITVER=`git log -1 | head -1 | cut -b 8-15`
DATE=`date +%Y%m%d%H%M`
STRICT=$1

rm -f /tmp/*.rpm
cd src
#export CONFIG_FLAGS="--enable-strict-compile --with-fsal=VFS --enable-snmp-adm --enable-nlm --enable-stat-exporter --with-rpcal=TIRPC"
#export CONFIG_FLAGS="--with-fsal=VFS --enable-snmp-adm --enable-nlm --enable-stat-exporter --with-rpcal=TIRPC"
if [[ $STRICT  ]]; then
    export CONFIG_FLAGS="--enable-strict-compile --enable-debug-symbols --with-fsal=GPFS --with-rpcal=TIRPC --enable-nlm --enable-nfs4-locks --enable-stat-exporter --enable-snmp-adm --enable-fsal-up --enable-nfs4-acl"
else
    export CONFIG_FLAGS="--enable-debug-symbols --with-fsal=GPFS --with-rpcal=TIRPC --enable-nlm --enable-nfs4-locks --enable-stat-exporter --enable-snmp-adm --enable-fsal-up --enable-nfs4-acl"
fi

autoreconf -i
./configure $CONFIG_FLAGS
perl -pi -e "s/Release: .*/Release: $DATE.$GITVER/" nfs-ganesha.spec
make clean
make rpm
DIR=`pwd`
cp $DIR/rpm/RPMS/x86_64/nfs-ganesha-vfs* $DIR/rpm/RPMS/x86_64/nfs-ganesha-common* /tmp/
sudo rpm -Uhv --force /tmp/nfs-ganesha-*.rpm