#!/bin/bash -x
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
export CONFIG_FLAGS="--with-fsal=GPFS --enable-snmp-adm --enable-nlm --enable-stat-exporter --with-rpcal=TIRPC"
export PATH="/bin:/usr/bin:/usr/local/bin"
export CC=/usr/local/bin/beam-cc
autoreconf -i
./configure $CONFIG_FLAGS
make clean
make