#! /usr/bin/perl -w

use strict;
use warnings;

my @files = `find . -print`;
chomp @files;

foreach my $file (@files)
{
    print "$file";

    if (-T $file)
    {
        print " IS TEXT!\n";
    }
}
