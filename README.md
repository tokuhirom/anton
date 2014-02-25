# NAME

anton - Yet another CPAN module manager for web applications.

# SYNOPSIS

    > anton install

    > anton uninstall Acme::YakiniQ

# DESCRIPTION

Yet another CPAN module manager for web applications.

# USAGE

## At first time.

You need to write the cpanfile, first.

Then, you run following command:

    > echo '/anton/authors/' >> .gitignore
    > anton install

cpanm installs all dependent modules.

Anton generates anton/modules/02.packages.details.txt from local/lib/perl5/\*/.meta/\*/install.json.
It contains installed module's version information.

You can restore local/ from anton.cpanfile.

## Restore local/ from anton.cpanfile

You can generate original environment's local/ from anton.cpanfile.

    > anton install --deployment

This command install all modules described in anton.cpanfile.

If all restoration is succeeded, exit status is 0.
If anton gets an error, exit status is non-zero value.

# FAQ

## Is there an \`carton exec\` equivalent command?

There is no \`carton exec\` equivalent subcommand.
But you can do \`perl -Mlib::core::only -Mlib=lib/perl5/ foo.pl\`.
