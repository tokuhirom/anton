# NAME

anton - Yet another CPAN module manager for web applications.

# SYNOPSIS

    > anton install

    > anton uninstall Acme::YakiniQ

# DEVELOPMENT STATUS

Unstable.

# DESCRIPTION

Yet another CPAN module manager for web applications.

# USAGE

## At first time.

You need to write the cpanfile, first.

Then, you run following command:

    > anton install

cpanm installs all dependent modules.

Anton generates anton/modules/02.packages.details.txt from local/lib/perl5/\*/.meta/\*/install.json.
It contains installed module's version information.

You can restore local/ from anton/index.txt.

## Restore local/ from anton/index.txt

You can generate original environment's local/ from anton/index.txt.

    > anton install --deployment

This command install all modules described in anton/index.txt.

If all restoration is succeeded, exit status is 0.
If anton gets an error, exit status is non-zero value.

# Directory structure

    - cpanfile
    + anton
        - darkpan.txt
        + darkpan
            + authors
            + dists
        + dists
            - 02.packages.details.txt
        + authors

# FAQ

## Is there an \`carton exec\` equivalent command?

There is no \`carton exec\` equivalent subcommand.
But you can do \`perl -Mlib::core::only -Mlib=lib/perl5/ foo.pl\`.
