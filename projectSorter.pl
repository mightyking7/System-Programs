#!/usr/bin/perl -w

my $DIR;        #Directory to search for project files
my $fileStruct; #The assigment directory to create
my @files;      #Files in DIR

die "Usage: projectSorter.pl directory" if(not @ARGV or $#ARGV > 0);

$DIR = $ARGV[0];

@files = glob("$DIR/*");


foreach $file (@files)
{
    #remove all directories and path seperators from the qualified path
    ($file) = $file =~ /.*\/(.*)/i;

    #if the file is a project file, the destination dir starts with assignment
    if($file =~ /^proj([^.]*)/i)
    {   
        $fileStruct = "$DIR/assingment$1";
    }

    #The file is not a project file and the destination dir starts with misc
    else
    {
        $fileStruct = "$DIR/misc";
    }

    #Destination directory does not exists, so create it 
    if(not -d $fileStruct)
    {
        `mkdir $fileStruct`;
    }

    `mv $DIR/$file $fileStruct`;
}