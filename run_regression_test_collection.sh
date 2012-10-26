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
## run_dupreq_check.sh
##
## Made by Jeremy Bongio
##
## Creation: Nov 22 2010
##

source ./CONFIG

SERVER=$1
HOSTFS=$2

echo "Running collection of regression tests ..."
if [[ -d /home/hudson/regression_tests ]]; then
    sudo rm -rf /home/hudson/regression_tests
fi
git clone $REGRESSIONTEST_LOC /home/hudson/regression_tests
cd /home/hudson/regression_tests
sudo SERVER=$SERVER EXPORTDIR=$HOSTFS/hudson/jenkins/$NODE_NAME XMLDEST=$WORKSPACE TMPDIR=/tmp make
