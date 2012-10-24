#!/bin/bash -x
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
