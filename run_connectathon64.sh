#!/bin/bash -x
##
## run_connectathon64.sh
## 
## Made by Sean Dague
## Login   <sdague@orac>
## 
## Started on  Fri Nov 19 11:12:16 2010 Sean Dague
##

source ./CONFIG

# get rid of the test files
rm -f $WORKSPACE/*.xml
sudo rm -rf /tmp/root /tmp/jenkins

SERVER=$1
HOSTFS=$2

echo "Building connectathon"
if [[ ! -d /home/hudson/cthon04 ]]; then
    git clone $CTHON04_LOC /home/hudson/cthon04
fi

sh ./build_dirs.sh $SERVER $HOSTFS
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
ssh -tt root@$SERVER service nfs-ganesha-gpfs restart || exit 1
sudo ./runcthon --server $SERVER --serverdir $HOSTFS/hudson64/root/$NODE_NAME --onlyv3 --noudp
sudo ./runcthon --unmountall

echo "Unmounting everything"
sudo killall runcthon
sudo killall tlocklfs
sudo ./runcthon --unmountall
ssh -tt root@$SERVER service nfs-ganesha-gpfs restart || exit 1
./runcthon --server $SERVER --serverdir $HOSTFS/hudson64/jenkins/$NODE_NAME --onlyv3 --noudp
sudo ./runcthon --unmountall


echo "Running the parser"
# get the parse
if [[ ! -d /home/hudson/cthon2junit ]]; then
    git clone $CTHON2JUNIT_LOC /home/hudson/cthon2junit
else
    cd /home/hudson/cthon2junit
    git fetch $CTHON2JUNIT_LOC master
    git reset --hard FETCH_HEAD
fi

cd /home/hudson/cthon2junit
git pull
./cthon2junit.rb $WORKSPACE /tmp/root "root-" noudp nokrb v3
./cthon2junit.rb $WORKSPACE /tmp/jenkins "jenkins-" noudp nokrb v3
