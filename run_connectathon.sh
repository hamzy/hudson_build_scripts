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

SERVER=$1
HOSTFS=$2

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
sleep 1
sudo umount -l /mnt

ssh -tt root@${SERVER} service nfs-ganesha-gpfs restart || exit 1
sleep 5

NFSNOTREADY=1
while [ $NFSNOTREADY -ne 0 ]
do
    sudo mount ${SERVER}:$HOSTFS /mnt
    NFSNOTREADY=$?
    sleep 5
    echo "sleeping 5 seconds to ensure NFS is ready"
done
sudo umount -l /mnt
sleep 1

sudo ./runcthon --server ${SERVER} --serverdir $HOSTFS/hudson/root/$NODE_NAME --onlyv3 --noudp

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
    sudo mount ${SERVER}:$HOSTFS /mnt
    NFSNOTREADY=$?
    sleep 5
    echo "sleeping 5 seconds to ensure NFS is ready"
done
sudo umount -l /mnt
sleep 1

./runcthon --server ${SERVER} --serverdir $HOSTFS/hudson/jenkins/$NODE_NAME --onlyv3 --noudp
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
