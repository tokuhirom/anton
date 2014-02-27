use strict;
use warnings;
use utf8;
use Test::More;
use File::pushd;
use File::Temp;
use FindBin;
use Config;


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

my $anton = "$FindBin::Bin/../anton";

my $dir = File::Temp::tempdir(CLEANUP => $ENV{DEBUG} ? 0 : 1);
   $dir = pushd($dir);

open my $fh, '>', 'cpanfile';
print {$fh} "requires 'File::Find::Rule', '==0.33';\n";
close $fh;

is system($^X, $anton, 'install'), 0;
ok -f "local/lib/perl5/File/Find/Rule.pm";
my $index = slurp('anton/index.txt');
note $index;
like $index, qr/File::Find::Rule\s+0\.33\s+/, "File::Find::Rule is indexed";

done_testing;

sub slurp {
    my $fname = shift;
    open my $fh, '<', $fname
        or Carp::croak("Can't open '$fname' for reading: '$!'");
    scalar(do { local $/; <$fh> })
}
