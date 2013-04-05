#!/usr/bin/perl

my %functionmap;
my $logfile = "/root/ks_prepost.out";

sub pre() {
    #after networking is setup but before OS is installed
}
$functionmap{"preinstall"} = \&preinstall;

sub post() {
    #after OS is installed and networking is still setup
}
$functionmap{"postinstall"} = \&postinstall;

sub installepel() {
    #setup EPEL repos for rhel 6
    `wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm &>> ${logfile}`;
    `wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm &>> ${logfile}`;
    `sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm &>> ${logfile}`;
}
$functionmap{"installepel"} = \&installepel;

sub ganesha20rpms() {
    #install packages
    `yum install -y git nfs-utils nfs4-acl-tools nfs-utils-lib nfs-utils-lib-devel nfs-utils krb5-devel krb5-workstation krb5-libs python rpm-build gcc git cmake &>> ${logfile}`;
}
$functionmap{"ganesha20rpms"} = \&ganesha20rpms;

sub build_ganesha20() {
    `git clone https://github.com/nfs-ganesha/nfs-ganesha.git &>> ${logfile}`;
    `cd nfs-ganesha/src &>> ${logfile}`;
    `cmake ./ -DDEBUG_SYMS=ON -DCMAKE_PREFIX_PATH=/usr/ -DCMAKE_INSTALL_PREFIX=/usr/ &>> ${logfile}`;
    `gmake &>> ${logfile}`;
    `gmake install &>> ${logfile}`;
}
$functionmap{"build_ganesha20"} = \&build_ganesha20;

sub test() {
    print "TEST!!\n";
}
$functionmap{"test"} = \&test;

open(LOG, ">>${logfile}");
foreach(@ARGV) {
    if ($functionmap{$_}) {
	print LOG "-----------------------------------------------------\n";
	print LOG "-- Executing ${_}\n";
	print LOG "-----------------------------------------------------\n";
	close(LOG);
	$functionmap{$_}->();
	open(LOG, ">>${logfile}");
	}
    else {
	print LOG "-----------------------------------------------------\n";
	print LOG "-- Failed to execute ${_}, there is no such function.\n"; 
	print LOG "-----------------------------------------------------\n";
    }
}
close(LOG);
