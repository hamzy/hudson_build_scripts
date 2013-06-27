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
## run_connectathon.sh
##
## Made by Sean Dague
## Login   <sdague@orac>
##
## Started on  Fri Nov 19 11:12:16 2010 Sean Dague
##

CONFDIR=`dirname ${0}`
source $CONFDIR/CONFIG

SERVER=$1
HOSTFS=$2

# get rid of the test files
rm -f $WORKSPACE/*.xml
sudo rm -rf /tmp/root /tmp/jenkins

echo "Building connectathon"
if [[ ! -d /home/hudson/tuxera ]]; then
    cd /home/hudson
    wget $TUXERA_LOC
    tar zxf /home/hudson/pjd-fstest-20090130-RC.tgz
fi

# 1038  ~/ibm-yum.sh install perl-Test-Harness
# 1066  ~/ibm-yum.sh install libacl-devel

#make the test and create the test dir
cd /home/hudson/pjd-fstest-20090130-RC
make
ssh -tt $SERVER mkdir -p $HOSTFS/tuxera
sudo mkdir -p /mnt/tuxera

# use cthon04 to unmount all and mount the test dir
cd /home/hudson/cthon04
git pull
sudo rm -f domount
make
sudo chown root domount
sudo chmod u+s domount

echo "Unmounting everything"
sudo killall runcthon
sudo killall tlocklfs

sudo ./runcthon --unmountall
sleep 1
sudo umount -l /mnt

ssh -tt root@${SERVER} service nfs-ganesha-gpfs restart || exit 1
sleep 5

NFSNOTREADY=1
while [ $NFSNOTREADY -ne 0 ]
do
    sudo mount -t nfs -o vers=3 ${SERVER}:$HOSTFS/tuxera /mnt/tuxera
    NFSNOTREADY=$?
    sleep 5
    echo "sleeping 5 seconds to ensure NFS is ready"
done
sleep 1

cd /mnt/tuxera/
mkdir -p /tmp/jenkins
prove -r /home/hudson/pjd-fstest-20090130-RC/nfstest &> /tmp/jenkins/nfstest.results

#mkdir -p /tmp/root
#prove -r /home/hudson/pjd-fstest-20090130-RC/nfstest &> /tmp/

cd /home/hudson/scripts
./nfstestresults2xml $WORKSPACE /tmp/jenkins/nfstest.results
#nfstestresults2xml $WORKSPACE /tmp/root/nfstest.results

