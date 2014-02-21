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

    > anton install

cpanm installs all dependent modules.

anton generates anton.cpanfile from local/lib/perl5/\*/.meta/\*/install.json.
It contains installed module's version information.

You can restore local/ from anton.cpanfile.

## Restore local/ from anton.cpanfile

You can generate original environment's local/ from anton.cpanfile.

    > anton install --deployment

This command install all modules described in anton.cpanfile.

If all restoration is succeeded, exit status is 0.
If anton gets an error, exit status is non-zero value.
