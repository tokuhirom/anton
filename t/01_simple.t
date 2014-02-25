use strict;
use warnings;
use utf8;
use Test::More;
use File::pushd;
use File::Temp;
use FindBin;

my $anton = "$FindBin::Bin/../anton";

my $dir = File::Temp::tempdir(CLEANUP => 1);
   $dir = pushd($dir);

open my $fh, '>', 'cpanfile';
print {$fh} "requires 'Scalar::DDie';\n";
close $fh;

is system($^X, $anton, 'install'), 0;
ok -f 'local/lib/perl5/Scalar/DDie.pm';

done_testing;

