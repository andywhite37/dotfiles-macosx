#!/usr/bin/perl -w
use strict;
use warnings;
use Getopt::Long;
use Term::ANSIColor qw(:constants);

################################################################################
# Subroutine pre-declarations
################################################################################

sub usage;

################################################################################
# Pre-conditions
################################################################################

if (!(-f "cleanEverything.sh") || !(-f ".sbtrc")) {
    die "Error: file must be run from cdp root directory";
}

################################################################################
# Gather files to process
################################################################################

my @desktopFiles = `find modules/webApp/desktop -print | sort`;
chomp @desktopFiles;

my @mobileFiles = `find modules/webApp/mobile -print | sort`;
chomp @mobileFiles;

print "Desktop:\n";
foreach my $desktopFile (@desktopFiles) {
    print "$desktopFile\n";
}

print "\nMobile\n";
foreach my $mobileFile (@mobileFiles) {
    print "$mobileFile\n";
}

# Find files that only exist in desktop
foreach my $desktopFile (@desktopFiles) {
    my $mobileFile = $desktopFile =~ s/modules\/webApp\/desktop/modules\/webApp\/mobile/;

    if (-e $mobileFile) {
    }
}

