#!/bin/bash -x
##
## run_dupreq_check.sh
## 
## Made by Jeremy Bongio
##
## Creation: Nov 22 2010
##

echo "Running collection of regression tests ..."
if [[ -d /home/hudson/dupreq_check ]]; then
    rm -rf /home/hudson/regression_tests
fi
git clone git://morbo.linux.ibm.com/~jbongio0/regression_tests /home/hudson/regression_tests
cd /home/hudson/regression_tests
sudo ./run_tests.sh $WORKSPACE sonas12  /ibm/fs0/hudson/$NODE_NAME
