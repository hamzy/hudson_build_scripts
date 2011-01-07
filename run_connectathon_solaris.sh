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

echo "Building connectathon"
if [[ ! -d /home/hudson/cthon04_solaris ]]; then
    git clone git://morbo.linux.ibm.com/~jbongio0/cthon04_solaris /home/hudson/cthon04_solaris
fi
cd /home/hudson/cthon04_solaris
git pull
sudo rm -f domount
make
sudo chown root domount
sudo chmod u+s domount

echo "Unmounting everything"
sudo killall runcthon
sudo killall tlocklfs
sudo ./runcthon --unmountall
ssh -tt root@sonas12 service nfs-ganesha-gpfs restart || exit 1
sudo ./runcthon --server sonas12 --serverdir /ibm/fs0/hudson/root/$NODE_NAME --onlyv3
sudo ./runcthon --unmountall

echo "Unmounting everything"
sudo killall runcthon
sudo killall tlocklfs
sudo ./runcthon --unmountall
ssh -tt root@sonas12 service nfs-ganesha-gpfs restart || exit 1
./runcthon --server sonas12 --serverdir /ibm/fs0/hudson/hudson/$NODE_NAME --onlyv3
sudo ./runcthon --unmountall


echo "Running the parser"
# get the parse
if [[ ! -d /home/hudson/cthon2junit ]]; then
    git clone git://morbo.linux.ibm.com/~sdague/cthon2junit /home/hudson/cthon2junit
fi

cd /home/hudson/cthon2junit
git pull
./cthon2junit.rb $WORKSPACE /tmp/root "root-"
./cthon2junit.rb $WORKSPACE /tmp/hudson "hudson-"
