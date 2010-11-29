#!/bin/bash -x
##
## run_dupreq_check.sh
## 
## Made by Jeremy Bongio
##
## Creation: Nov 22 2010
##

echo "Building duplicate request check"
if [[ -d /home/hudson/dupreq_check ]]; then
    rm -rf /home/hudson/dupreq_check
fi
git clone git://morbo.linux.ibm.com/~jbongio0/dupreq_check /home/hudson/dupreq_check
cd /home/hudson/dupreq_check
make

echo "Preparing for test"
sudo killall dupreq_check
ssh -tt root@sonas12 service nfs-ganesha-gpfs restart

echo "Running tests"
sudo ./dupreq_check -h sonas12 -d /ibm/fs0/hudson/$NODE_NAME -C > /tmp/dupreq_check-C
sudo ./dupreq_check -h sonas12 -d /ibm/fs0/hudson/$NODE_NAME -D > /tmp/dupreq_check-D

echo "Running the parser"
cd /home/hudson/dupreq_check
sudo ./c-toxml.rb $WORKSPACE/ /tmp/
sudo ./d-toxml.rb $WORKSPACE/ /tmp/
