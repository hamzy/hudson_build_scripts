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

CONFDIR=`dirname ${0}`
source $CONFDIR/CONFIG

GITVER=`git log -1 | head -1 | cut -b 8-15`
DATE=`date +%Y%m%d%H%M`
STRICT=$1
CODE_DIR=`pwd`


rm -f /tmp/*.rpm
git submodule update --init
#cd src
#git remote add jer-github https://github.com/bongiojp/nfs-ganesha.git
#git fetch jer-github
#git cherry-pick 1cf58ba157a3e4392d2a7e06ad45d9db62e838ff
mkdir -p $BUILDDIR
cd $BUILDDIR
cmake $CODE_DIR/src/ -DCMAKE_BUILD_TYPE=Maintainer -DBUILD_CONFIG=gpfs -DDEBUG_SYMS=ON
make rpm
sudo rpm -Uvh --force RPM/RPMS/x86_64/*.rpm
sudo ldconfig

