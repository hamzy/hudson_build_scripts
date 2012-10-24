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

source ./CONFIG

SERVER=$1
HOSTFS=$2
HOSTNAME=`hostname`

# get rid of the test files
export PATH=$PATH:/usr/gnu/bin/:/usr/bin:/sbin:/bin:/usr/sbin

rm -f $WORKSPACE/*.xml
sudo rm -rf /tmp/root /tmp/jenkins

echo "Building connectathon"
if [[ ! -d /home/jenkins/cthon04_solaris ]]; then
    git clone $CTHON04_SOLARIS_LOC /home/jenkins/cthon04_solaris
fi
cd /home/jenkins/cthon04_solaris
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
sudo ./runcthon --server $SERVER --serverdir /ibm/gpfs0/hudson/root/$NODE_NAME --onlyv3 --onlykrb5 --noudp
sudo ./runcthon --unmountall

echo "Unmounting everything"
sudo killall runcthon
sudo killall tlocklfs
sudo ./runcthon --unmountall
ssh -tt root@$SERVER service nfs-ganesha-gpfs restart || exit 1
kinit -k jenkins/$HOSTNAME@SONASDOMAIN.COM 
./runcthon --server $SERVER --serverdir /ibm/gpfs0/hudson/jenkins/$NODE_NAME --onlyv3 --onlykrb5 --noudp
sudo ./runcthon --unmountall


echo "Running the parser"
# get the parse
if [[ ! -d /home/jenkins/cthon2junit ]]; then
    git clone $CTHON2JUNIT_LOC /home/jenkins/cthon2junit
fi

cd /home/jenkins/cthon2junit
git pull
sudo ./cthon2junit.rb $WORKSPACE /tmp/root "root-" noudp krb v3
sudo ./cthon2junit.rb $WORKSPACE /tmp/jenkins "jenkins-" noudp krb v3
