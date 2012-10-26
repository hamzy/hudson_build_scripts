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
## enhanced_build_test.sh
## 
## Made by Sean Dague
## Login   <sdague@orac>
##
## This does a build with and without memcorrupt and runs unit tests
## and packaging tests.  Used for a standard build of Ganesha, takes
## about 12 minutes.
## 
## Started on  Fri Nov 19 09:35:17 2010 Sean Dague
## Last update Fri Nov 19 09:35:17 2010 Sean Dague
##

cd src

# export CONFIG_FLAGS="--with-fsal=GPFS --enable-snmp-adm --enable-nlm --enable-stat-exporter --enable-strict-compile"
# autoreconf -i
# ./configure $CONFIG_FLAGS
# make clean
# make || exit 1

export CONFIG_FLAGS="--enable-strict-compile --with-fsal=VFS --enable-snmp-adm --enable-nlm --enable-stat-exporter"
sh ./tirpc.sh
autoreconf -i
./configure $CONFIG_FLAGS
make clean
make || exit 1
make check || exit 1
make rpm || exit 1 

# export CONFIG_FLAGS="--with-fsal=GPFS --enable-snmp-adm --enable-nlm --enable-stat-exporter --enable-strict-compile --with-rpcal=TIRPC"
# autoreconf -i
# ./configure $CONFIG_FLAGS
# make clean
# make || exit 1

#export CONFIG_FLAGS="--enable-strict-compile --with-fsal=GPFS --enable-snmp-adm --enable-nlm --enable-stat-exporter --with-rpcal=TIRPC"
#sh ./tirpc.sh
#autoreconf -i
#./configure $CONFIG_FLAGS
#make clean
#make || exit 1
#make check  || exit 1
#make rpm  || exit 1

