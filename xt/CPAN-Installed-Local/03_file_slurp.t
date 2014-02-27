use strict;
use warnings;
use utf8;
use Test::More;
use File::Temp;
use xt::Util;

my $dir = File::Temp::tempdir(CLEANUP => $ENV{DEBUG} ? 0 : 1);
install($dir, 'File::Slurp@9999.19');

my $local = CPAN::Installed::Local->new(directory => $dir);
my ($installed, $uninstalled) = $local->aggregate();
is 0+@$uninstalled, 0;

my ($ffr_meta) = grep { $_->{dist} eq 'File-Slurp-9999.19' } @$installed;
ok $ffr_meta;

done_testing;

