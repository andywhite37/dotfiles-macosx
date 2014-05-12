#! /usr/bin/env perl -w
use strict;
use warnings;

my @files = `ls *.png`;
chomp @files;

for my $file (@files) {
    #print "$file\n";

    my $origFile = $file;

    $file =~ s/Icon//;
    $file =~ s/Launch//;
    $file =~ s/\d-/-/;
    $file =~ s/\d\w-/-/;

    print "mv $origFile $file\n";
    system "mv $origFile $file";
}
