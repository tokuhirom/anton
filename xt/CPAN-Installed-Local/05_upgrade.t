use strict;
use warnings;
use utf8;
use Test::More;
use File::Temp;
use xt::Util;

my $dir = File::Temp::tempdir(CLEANUP => $ENV{DEBUG} ? 0 : 1);
install($dir, 'MIME::Base64@3.11');
install($dir, 'MIME::Base64@3.12');

my $local = CPAN::Installed::Local->new(directory => $dir);
my ($installed, $uninstalled) = $local->aggregate();

is join(' ', map { $_->{dist} } @$installed),   'MIME-Base64-3.12';
is join(' ', map { $_->{dist} } @$uninstalled), 'MIME-Base64-3.11';

done_testing;

