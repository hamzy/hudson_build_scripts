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

cd /home/hudson/cthon04
echo "Unmounting everything"
sudo killall runcthon
sudo killall tlocklfs
sudo ./runcthon --unmountall
ssh -tt root@sonas12 service nfs-ganesha-gpfs restart
sudo ./runcthon --server sonas12 --serverdir /ibm/fs0/hudson/$NODE --onlyv3
sudo ./runcthon --unmountall

# get the parse
if [[ ! -d /home/hudson/cthon2junit ]]; then
    git clone git://morbo.linux.ibm.com/~sdague/cthon2junit /home/hudson/cthon2junit
fi

cd /home/hudson/cthon2junit
git pull
./cthon2junit.rb $WORKSPACE
