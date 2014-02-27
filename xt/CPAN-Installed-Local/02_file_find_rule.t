use strict;
use warnings;
use utf8;
use Test::More;
use File::pushd;
use File::Temp;
use FindBin;
use Config;
use xt::Util;

# File::Find::Rule::Test::ATeam is indexed. But it's not installed.

#   {
#   "version" : "0.33",
#   "pathname" : "R/RC/RCLAMP/File-Find-Rule-0.33.tar.gz",
#   "name" : "File::Find::Rule",
#   "provides" : {
#       "File::Find::Rule::Test::ATeam" : {
#           "file" : "testdir/lib/File/Find/Rule/Test/ATeam.pm"
#       },
#       "File::Find::Rule" : {
#           "file" : "lib/File/Find/Rule.pm",
#           "version" : "0.33"
#       }
#   },
#   "target" : "File::Find::Rule",
#   "dist" : "File-Find-Rule-0.33"
#   }

my $dir = File::Temp::tempdir(CLEANUP => $ENV{DEBUG} ? 0 : 1);

install($dir, "File::Find::Rule");

my $local = CPAN::Installed::Local->new(directory => $dir);
my ($installed, $uninstalled) = $local->aggregate();
is 0+@$uninstalled, 0;

my ($ffr_meta) = grep { $_->{dist} eq 'File-Find-Rule-0.33' } @$installed;
ok $ffr_meta;

done_testing;

