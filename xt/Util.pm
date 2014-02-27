package xt::Util;
use strict;
use warnings;
use utf8;
use parent qw(Exporter);
use Carp;
use File::Basename;
use File::Spec;
use File::Which;

our @EXPORT = qw(install);

my $cpanm = which('cpanm') or die "Missing cpanm";

&load_cpan_installed_local;

sub install {
    my ($dir, $module) = @_;
    system($^X, $cpanm, '--notest', '--no-man-pages', '-L', $dir, $module)==0 or Carp::croak("Cannot install $module to $dir\n");
}

# Load CPAN::Installed::Local
sub load_cpan_installed_local {
    ::note 'load_cpan_installed_local';

    open my $fh, '<', 'anton'
        or die $!;
    my $content = do { local $/; <$fh> };
    $content =~ m{(package CPAN::Installed::Local.*# /CPAN::Installed::Local)}s
        or die "Cannot find CPAN::Installed::Local in the anton";
    $content = $1;
    eval $content;
    die $@ if $@;
}

1;

