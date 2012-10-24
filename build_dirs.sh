#!/bin/bash -x

source ./CONFIG

SERVER=$1
HOSTFS=$2

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/rhel60/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/rhel60/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/rhel60/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/rhel55/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/rhel55/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/rhel55/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/rhel55_32/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/rhel55_32/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/rhel55_32/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/ubuntu32/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/ubuntu32/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/root/ubuntu32/nfsv4tcp

ssh -tt root@$HOST chown root $HOSTFS/hudson64/root -R
ssh -tt root@$HOST chgrp root $HOSTFS/hudson64/root -R

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/rhel60/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/rhel60/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/rhel60/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/rhel55/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/rhel55/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/rhel55/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/rhel55_32/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/rhel55_32/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/rhel55_32/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/ubuntu32/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/ubuntu32/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson64/jenkins/ubuntu32/nfsv4tcp

ssh -tt root@$HOST chown jenkins $HOSTFS/hudson64/jenkins -R
ssh -tt root@$HOST chgrp jenkins $HOSTFS/hudson64/jenkins -R




ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/rhel60/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/rhel60/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/rhel60/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/rhel55/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/rhel55/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/rhel55/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/rhel55_32/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/rhel55_32/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/rhel55_32/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/ubuntu32/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/ubuntu32/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/root/ubuntu32/nfsv4tcp

ssh -tt root@$HOST chown root $HOSTFS/hudson/root -R
ssh -tt root@$HOST chgrp root $HOSTFS/hudson/root -R

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/rhel60/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/rhel60/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/rhel60/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/rhel55/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/rhel55/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/rhel55/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/rhel55_32/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/rhel55_32/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/rhel55_32/nfsv4tcp

ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/ubuntu32/nfsv3tcp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/ubuntu32/nfsv3udp
ssh -tt root@$HOST mkdir -p $HOSTFS/hudson/jenkins/ubuntu32/nfsv4tcp

ssh -tt root@$HOST chown jenkins $HOSTFS/hudson/jenkins -R
ssh -tt root@$HOST chgrp jenkins $HOSTFS/hudson/jenkins -R
