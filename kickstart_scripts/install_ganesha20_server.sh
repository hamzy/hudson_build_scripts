#!/usr/bin/perl

sub pre() {
    #after networking is setup but before OS is installed
}

sub post() {
    #after OS is installed and networking is still setup

    #setup EPEL repos for rhel 6
    `wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm`;
    `wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm`;
    `sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm`;

    #install packages
    `yum install git nfs-utils nfs4-acl-tools nfs-utils-lib nfs-utils-lib-devel \
     nfs-utils krb5-devel krb5-workstation krb5-libs python rpm-build gcc git cmake`;

    #configure KDC if you want
    
    #generate ssh keys

    #etc.
}

if (@ARGV[0] eq "pre") { pre() }
elsif (@ARGV[0] eq "post") { post() }




