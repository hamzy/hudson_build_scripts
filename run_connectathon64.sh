#!/bin/bash -x
##
## run_connectathon64.sh
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

HOST=sonas13_gpfs35

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
ssh -tt root@$HOST service nfs-ganesha-gpfs restart || exit 1
sudo ./runcthon --server $HOST --serverdir /ibm/fs0/hudson64/root/$NODE_NAME --onlyv3
sudo ./runcthon --unmountall

echo "Unmounting everything"
sudo killall runcthon
sudo killall tlocklfs
sudo ./runcthon --unmountall
ssh -tt root@$HOST service nfs-ganesha-gpfs restart || exit 1
./runcthon --server $HOST --serverdir /ibm/fs0/hudson64/jenkins/$NODE_NAME --onlyv3
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
