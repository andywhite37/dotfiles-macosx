#!/usr/bin/perl -w
use strict;
use warnings;
use Getopt::Long;
use Term::ANSIColor qw(:constants);

################################################################################
# Subroutine pre-declarations
################################################################################

sub diffFiles;
sub usage;

################################################################################
# Pre-conditions
################################################################################

if (!(-f "cleanEverything.sh") || !(-f ".sbtrc")) {
    die "Error: file must be run from cdp root directory";
}

################################################################################
# Options
################################################################################

my $diffToolCommand = "~/bin/diffmerge.sh";

GetOptions(
    "diff=s" => \$diffToolCommand
);

print "using diff tool: $diffToolCommand\n";

################################################################################
# Gather files to process
################################################################################

my $gitDiffCommand = "git diff --name-only master..HEAD";

my @files = `$gitDiffCommand | sort`;
chomp @files;
foreach my $file (@files) {
    print "$file\n";
}

my $desktopPathPrefix = "modules/webApp/desktop";
my $mobilePathPrefix = "modules/webApp/mobile";

my @desktopFiles = `$gitDiffCommand | grep 'modules/webApp/desktop' | sed 's/modules\\/webApp\\/desktop\\///' | sort`;
chomp @desktopFiles;

my @mobileFiles = `$gitDiffCommand | grep 'modules/webApp/mobile' | sed 's/modules\\/webApp\\/mobile\\///' | sort`;
chomp @mobileFiles;

################################################################################
# Process the files
################################################################################

diffFiles(\@desktopFiles, \@mobileFiles, $desktopPathPrefix, $mobilePathPrefix, "desktop", "mobile");
diffFiles(\@mobileFiles, \@desktopFiles, $mobilePathPrefix, $desktopPathPrefix, "mobile", "desktop");

################################################################################
# Subroutine definitions
################################################################################

sub diffFiles {

    my @sourceFiles = @{$_[0]};
    my @destinationFiles = @{$_[1]};
    my $sourcePathPrefix = $_[2];
    my $destinationPathPrefix = $_[3];
    my $sourceName = $_[4];
    my $destinationName = $_[5];

    print BLUE;
    print "--------------------------------------------------------------------------------\n";
    print "$sourceName files:\n";
    print "--------------------------------------------------------------------------------\n";
    print RESET;

    foreach my $sourceFile (@sourceFiles) {
        my $sourceFileFullPath = "$sourcePathPrefix/$sourceFile";
        my $destinationFileFullPath = "$destinationPathPrefix/$sourceFile";

        print BOLD, BLUE, "$sourceFileFullPath\n", RESET;

        while (1) {

            # Check if the destination file exists for this source file
            if (-e "$destinationFileFullPath") {
                print GREEN, "corresponding $destinationName file exists: ", BOLD, "$destinationFileFullPath\n", RESET;
            } else {
                print RED, "corresponding $destinationName file does not exist: ", BOLD, "$destinationFileFullPath\n", RESET;
            }

            # Check if the destination file has also been changed in this branch (compared to master)
            if ($sourceFile ~~ @destinationFiles) {
                print RED, "corresponding $destinationName file is also changed (differs from master)\n", RESET;
            } else {
                print GREEN, "corresponding $destinationName file is not changed (does not differ from master)\n", RESET;
            }

            # See if the source file and destination file currently differ
            my $diffCommand = "diff -q $sourceFileFullPath $destinationFileFullPath &> /dev/null";
            my $diffStatus = system "$diffCommand";
            if ($diffStatus != 0) {
                print RED, "$sourceName and $destinationName files differ in this working directory\n", RESET;
            } else {
                print GREEN, "$sourceName and $destinationName files do not differ in this working directory\n", RESET;
            }

            # See if the source file and destination file differ in the master branch
            my $masterGitDiffCommand = "git diff --quiet master:$sourceFileFullPath master:$destinationFileFullPath &> /dev/null";
            my $masterGitDiffStatus = system "$masterGitDiffCommand";
            if ($masterGitDiffStatus != 0) {
                print RED, "$sourceName and $destinationName files differ in master branch\n", RESET;
            } else {
                print GREEN, "$sourceName and $destinationName files do not differ in master branch\n", RESET;
            }

            print YELLOW, "skip (s), copy (c), diff working desktop/mobile (d), diff master desktop/mobile (m), quit (q)? ", RESET;

            my $answer = <STDIN>;
            chomp $answer;

            if ($answer eq "s") {

                # Skip the file
                print "skipping\n";
                last;

            } elsif ($answer eq "c") {

                # Copy the file
                my $copyCommand = "cp $sourceFileFullPath $destinationFileFullPath";
                print "$copyCommand\n";
                system("$copyCommand");
                last;

            } elsif ($answer eq "d") {

                # Diff the file using diff tool
                my $diffCommand = "$diffToolCommand $sourceFileFullPath $destinationFileFullPath &> /dev/null";
                print "$diffCommand\n";
                system "$diffCommand";

            } elsif ($answer eq "m") {

                # Diff the file using diff tool
                my $diffCommand = "git diff master:$sourceFileFullPath master:$destinationFileFullPath &> /dev/null";
                #my $editCommand = "$ENV{'EDITOR'} $destinationFileFullPath";
                #my $command = "$diffCommand; $editCommand";
                my $command = "$diffCommand";
                print "$command\n";
                system "$command";

            } elsif ($answer eq "q") {

                # Exit the program
                print "exiting\n";
                exit;

            } elsif ($answer eq "") {

                # No-op

            } else {

                # Unknown response
                print "invalid response: $answer\n";

            }
        }

        print "\n";
    }
}

sub usage {
}
