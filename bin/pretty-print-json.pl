#! /usr/bin/env perl -w
use strict;
use warnings;

my @files = @ARGV;
chomp @files;

foreach my $file (@files)
{
    print "$file\n";

    print("cat $file | python -mjson.tool > $file.p.json\n");
    system("cat $file | python -mjson.tool > $file.p.json");
}
