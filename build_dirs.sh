#!/bin/bash -x

HOST=sonas13_gpfs35

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/rhel60/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/rhel60/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/rhel60/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/rhel55/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/rhel55/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/rhel55/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/rhel55_32/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/rhel55_32/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/rhel55_32/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/ubuntu32/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/ubuntu32/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/root/ubuntu32/nfsv4tcp

ssh -tt root@$HOST chown root /ibm/gpfs0/hudson64/root -R
ssh -tt root@$HOST chgrp root /ibm/gpfs0/hudson64/root -R

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/rhel60/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/rhel60/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/rhel60/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/rhel55/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/rhel55/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/rhel55/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/rhel55_32/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/rhel55_32/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/rhel55_32/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/ubuntu32/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/ubuntu32/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson64/jenkins/ubuntu32/nfsv4tcp

ssh -tt root@$HOST chown jenkins /ibm/gpfs0/hudson64/jenkins -R
ssh -tt root@$HOST chgrp jenkins /ibm/gpfs0/hudson64/jenkins -R




ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/rhel60/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/rhel60/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/rhel60/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/rhel55/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/rhel55/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/rhel55/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/rhel55_32/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/rhel55_32/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/rhel55_32/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/ubuntu32/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/ubuntu32/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/root/ubuntu32/nfsv4tcp

ssh -tt root@$HOST chown root /ibm/gpfs0/hudson/root -R
ssh -tt root@$HOST chgrp root /ibm/gpfs0/hudson/root -R

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/rhel60/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/rhel60/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/rhel60/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/rhel55/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/rhel55/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/rhel55/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/rhel55_32/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/rhel55_32/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/rhel55_32/nfsv4tcp

ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/ubuntu32/nfsv3tcp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/ubuntu32/nfsv3udp
ssh -tt root@$HOST mkdir -p /ibm/gpfs0/hudson/jenkins/ubuntu32/nfsv4tcp

ssh -tt root@$HOST chown jenkins /ibm/gpfs0/hudson/jenkins -R
ssh -tt root@$HOST chgrp jenkins /ibm/gpfs0/hudson/jenkins -R
