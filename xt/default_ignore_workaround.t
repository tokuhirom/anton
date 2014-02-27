use strict;
use warnings;
use utf8;
use Test::More;
use File::pushd;
use File::Temp;
use FindBin;
use Config;

my $anton = "$FindBin::Bin/../anton";

my $dir = File::Temp::tempdir(CLEANUP => $ENV{DEBUG} ? 0 : 1);
   $dir = pushd($dir);

# You can remove this workaround after 2020.

# multidimensional contains package declaration in t/
open my $fh, '>', 'cpanfile';
print {$fh} "requires 'multidimensional', '==0.011';\n";
close $fh;

is system($^X, $anton, 'install'), 0;
ok -f "local/lib/perl5/$Config{archname}/multidimensional.pm";
my $index = slurp('anton/index.txt');
note $index;
unlike $index, qr/MyTest/, "Don't index package in t/";
like $index, qr/multidimensional\s+0\.011/, "multidimensional is indexed";

done_testing;

sub slurp {
    my $fname = shift;
    open my $fh, '<', $fname
        or Carp::croak("Can't open '$fname' for reading: '$!'");
    scalar(do { local $/; <$fh> })
}
