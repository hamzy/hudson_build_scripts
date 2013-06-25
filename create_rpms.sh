#!/bin/bash -x
#
# Copyright IBM  (2012)
# Author(s): Sean Dague      sdague@us.ibm.com
#            Jeremy Bongio   jbongio@us.ibm.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#
# ---------------------------------------
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
#export CONFIG_FLAGS="--enable-strict-compile --with-fsal=GPFS --enable-snmp-adm --enable-nlm --enable-stat-exporter --enable-nfs4-locks --with-rpcal=TIRPC"
#export CONFIG_FLAGS=" --with-fsal=GPFS --enable-snmp-adm --enable-nlm --enable-stat-exporter --enable-nfs4-locks  --with-rpcal=TIRPC"
if [[ $STRICT  ]]; then
    export CONFIG_FLAGS="--enable-strict-compile --enable-debug-symbols --with-fsal=GPFS --with-rpcal=TIRPC --enable-nlm --enable-nfs4-locks --enable-stat-exporter --enable-fsal-up --enable-nfs4-acl"
else
    export CONFIG_FLAGS="--enable-debug-symbols --with-fsal=GPFS --with-rpcal=TIRPC --enable-nlm --enable-nfs4-locks --enable-stat-exporter --enable-fsal-up --enable-nfs4-acl"
fi

sh ./tirpc.sh
aclocal
autoreconf -i
./configure $CONFIG_FLAGS
perl -pi -e "s/Release: .*/Release: $DATE.$GITVER/" nfs-ganesha.spec
make clean
make rpm
DIR=`pwd`
cp $DIR/rpm/RPMS/x86_64/nfs-ganesha-gpfs* $DIR/rpm/RPMS/x86_64/nfs-ganesha-common* /tmp/
sudo rpm -Uhv --force /tmp/nfs-ganesha-*.rpm
