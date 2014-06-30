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

        while (1) {
            print BOLD, BLUE, "$sourceFileFullPath\n>>>\n$destinationFileFullPath\n", RESET;

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

            my $instructions = <<"END_DOCUMENT";
n - next
c - copy source file to destination file
d - difftool working directory source file and destination file
m - difftool master source file and destination file
es - edit source file
ed - edit destination file
q - quit
END_DOCUMENT
            print YELLOW, "${instructions}> ", RESET;

            my $answer = <STDIN>;
            chomp $answer;

            if ($answer eq "n") {

                # Skip the file (go to next)
                print "next\n";
                last;

            } elsif ($answer eq "c") {

                # Copy the file
                my $command = "cp $sourceFileFullPath $destinationFileFullPath";
                print "$command\n";
                system("$command");

            } elsif ($answer eq "d") {

                # Diff the desktop/mobile files in this current working directory
                my $command = "$diffToolCommand $sourceFileFullPath $destinationFileFullPath";
                print "$command\n";
                system "$command";

            } elsif ($answer eq "m") {

                # Diff the desktop/mobile files in the master branch
                my $command = "git difftool master:$sourceFileFullPath master:$destinationFileFullPath";
                print "$command\n";
                system "$command";

            } elsif ($answer eq "es") {

                # Edit the source file in $EDITOR
                my $command = "$ENV{'EDITOR'} $sourceFileFullPath";
                print "$command\n";
                system "$command";

            } elsif ($answer eq "ed") {

                # Edit the destination file in $EDITOR
                my $command = "$ENV{'EDITOR'} $destinationFileFullPath";
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
