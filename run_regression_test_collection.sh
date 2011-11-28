#!/bin/bash -x
##
## run_dupreq_check.sh
##
## Made by Jeremy Bongio
##
## Creation: Nov 22 2010
##

echo "Running collection of regression tests ..."
if [[ -d /home/hudson/regression_tests ]]; then
    sudo rm -rf /home/hudson/regression_tests
fi
git clone git://morbo.stglabs.ibm.com/~jbongio0/regression_tests /home/hudson/regression_tests
cd /home/hudson/regression_tests
sudo SERVER=sonas13_gpfs35 EXPORTDIR=/ibm/fs0/hudson/jenkins/$NODE_NAME XMLDEST=$WORKSPACE TMPDIR=/tmp make
