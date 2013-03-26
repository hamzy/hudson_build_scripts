#!/usr/bin/perl -w
#
# Copyright IBM  (2013)
# Author(s): Jeremy Bongio   jbongio@us.ibm.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#
# ---------------------------------------
use strict;
use DBI;

# created from instructions on http://www.dba-oracle.com/t_dbi_interface1.htm

#### CONFIGURATION #############

my $username = "oracle";
my $passwd = "Passw0rd";
my $db = "local";

################################

if($DBI::VERSION < 1.5) {
    print "Perl module DBI must be > 1.5\n";
}

my $dbh = DBI->connect( "dbi:Oracle:$db", $username, $passwd ) ||
    die( $DBI::errstr . "\n" );

# $dbh->{AutoCommit}    = 0;
# $dbh->{RaiseError}    = 1;
# $dbh->{ora_check_sql} = 0;
# $dbh->{RowCacheSize}  = 16;

my $SEL = "invalid SQL statement";
my $sth = $db->prepare($SEL);

$sth->execute();
while ( my @row = $sth->fetchrow_array() ) {
    foreach (@row) {
        $_ = "\t" if !defined($_);
        print "$_\t";
    }
    print "\n";
}



END {
    $dbh->disconnect if defined($dbh);
}


