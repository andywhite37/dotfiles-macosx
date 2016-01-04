#! /usr/bin/perl
use strict;
use warnings;

my @sizes = (50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600);

for my $size (@sizes) {
  print "convert testPNG.png -resize ${size}x${size} temp/test${size}.png\n";
  system "convert testPNG.png -resize ${size}x${size} temp/test${size}.png";
}

