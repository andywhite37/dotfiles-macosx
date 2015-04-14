#! /usr/bin/env perl
use strict;
use warnings;

my $haxeLibRoot = "$ENV{HOME}/.haxe/lib";

my @haxeLibs = `ls $haxeLibRoot | sort`;
chomp @haxeLibs;

for my $haxeLib (@haxeLibs) {
  print "$haxeLib\n";

  my $dir = "$haxeLibRoot/$haxeLib";
  my $gitDir = "$haxeLibRoot/$haxeLib/git";

  my $currentFile = "$dir/.current";
  my $current = `cat $currentFile`;
  chomp $current;
  print "  current: $current\n";

  my @versionDirs = `ls -a $dir | grep -v '^\\.'`;
  chomp @versionDirs;

  print "  versions:\n";
  for my $versionDir (@versionDirs) {
    print "    $versionDir\n";
  }

  if (-d $gitDir) {
    print "  git dir: $gitDir\n";

    if ($current ne "dev") {
      print "  changing current to dev\n";
      system("echo dev > $currentFile");
    }

    if (scalar(@versionDirs) > 1) {
      print "  more than one version!\n";
    }
  }
}
