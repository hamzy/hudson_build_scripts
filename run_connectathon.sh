#!/bin/bash -x
##
## run_connectathon.sh
## 
## Made by Sean Dague
## Login   <sdague@orac>
## 
## Started on  Fri Nov 19 11:12:16 2010 Sean Dague
## Last update Fri Nov 19 11:12:16 2010 Sean Dague
##

# get rid of the test files
rm -f $WORKSPACE/*.xml
sudo rm -rf /tmp/root /tmp/jenkins

echo "Building connectathon"
if [[ ! -d /home/hudson/cthon04 ]]; then
    git clone git://morbo.linux.ibm.com/~sdague/cthon04 /home/hudson/cthon04
fi
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
ssh -tt root@sonas13 service rpcbind restart || exit 1
ssh -tt root@sonas13 service nfs-ganesha-gpfs restart || exit 1

# we need a loop to figure out if NFS is ready, as apparently it can
# take a little bit to come up, and that little bit is really non
# deterministic.
NFSNOTREADY=1
while [ $NFSNOTREADY -ne 0 ]
do
    sudo mount sonas13:/ibm/fs0 /mnt
    NFSNOTREADY=$?
    sleep 5
    echo "sleeping 5 seconds to ensure NFS is ready"
done
sudo umount /mnt

sudo ./runcthon --server sonas13 --serverdir /ibm/fs0/hudson/root/$NODE_NAME --onlyv3
sudo ./runcthon --unmountall

echo "Unmounting everything"
sudo killall runcthon
sudo killall tlocklfs
sudo ./runcthon --unmountall
ssh -tt root@sonas13 service nfs-ganesha-gpfs restart || exit 1
./runcthon --server sonas13 --serverdir /ibm/fs0/hudson/jenkins/$NODE_NAME --onlyv3
sudo ./runcthon --unmountall


echo "Running the parser"
# get the parse
if [[ ! -d /home/hudson/cthon2junit ]]; then
    git clone git://morbo.linux.ibm.com/~sdague/cthon2junit /home/hudson/cthon2junit
fi

cd /home/hudson/cthon2junit
git pull
./cthon2junit.rb $WORKSPACE /tmp/root "root-"
./cthon2junit.rb $WORKSPACE /tmp/jenkins "jenkins-"
