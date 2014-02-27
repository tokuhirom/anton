use strict;
use warnings;
use utf8;
use Test::More;
use File::Temp;
use xt::Util;

my $dir = File::Temp::tempdir(CLEANUP => $ENV{DEBUG} ? 0 : 1);
install($dir, 'common::sense@3.72');
install($dir, 'JSON::PP@2.27203');
install($dir, 'Types::Serialiser@1.0');

my $local = CPAN::Installed::Local->new(directory => $dir);
my ($installed, $uninstalled) = $local->aggregate();
is 0+@$uninstalled, 0;
like join(' ', map { $_->{dist} } @$installed), qr(Types-Serialiser-1.0);
like join(' ', map { $_->{dist} } @$installed), qr(common-sense);
like join(' ', map { $_->{dist} } @$installed), qr(JSON-PP);

note 'Installed: ' . join(' ', map { $_->{dist} } @$installed);
note 'Uninstalled: ' . join(' ', map { $_->{dist} } @$uninstalled);

done_testing;

