use strict;
use warnings;
use utf8;
use Test::More;
use File::pushd;
use File::Temp;
use FindBin;
use File::Path;

my $anton = "$FindBin::Bin/../anton";

my $dir = File::Temp::tempdir(CLEANUP => $ENV{DEBUG} ? 0 : 1);
   $dir = pushd($dir);

mkpath('anton/');

{
    open my $fh, '>', 'anton/darkpan.txt';
    print {$fh} "https://github.com/tokuhirom/Acme-Kensiro.git\@0.13\n";
    close $fh;
}

{
    open my $fh, '>', 'cpanfile' or die $!;
    print {$fh} "requires 'Acme::Foo', '0.01',
        git => 'git://github.com/tokuhirom/Acme-Foo.git', ref => 'master';\n";
    close $fh;
}

is system($^X, $anton, 'install'), 0;
ok -f 'local/lib/perl5/Acme/Foo.pm';
ok -f 'anton/darkpan.json', 'darkpan.json was generated';
ok -f 'anton/index.txt', 'index.txt was generated';
do 'local/lib/perl5/Acme/Foo.pm';
is $Acme::Foo::VERSION, '0.01';

done_testing;

