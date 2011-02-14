#!/bin/bash
##
## sync_data.sh
## 
## Made by Sean Dague
## Login   <sdague@orac>
## 
## Started on  Mon Feb 14 10:05:04 2011 Sean Dague
## Last update Mon Feb 14 10:05:04 2011 Sean Dague
##

# pull in the hosts file

if [[ $HOSTNAME -ne "herbert" ]]; then
    scp herbert.pok.ibm.com:/etc/hosts /tmp/hosts && sudo cp /tmp/hosts /etc/hosts
fi


