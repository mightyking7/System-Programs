#!/usr/bin/perl -w


my $option = 0;     #run the script in inverted order
my $regex;          #regular expression to find in file names and contents
my @files;          #fileList passed to the script

die "Usage: find.pl [-i] pattern fileList" if($#ARGV < 1);

#initialize variables and determine the program state

# determine of the -i option is given
if($ARGV[0] eq "-i" ){
    $option = 1;
    $regex = $ARGV[1];
}

else{
    $regex = $ARGV[0];
}

#retreive the files
@files = grep( -f, @ARGV);

#run the script in inverted mode
=pod
if($option){

      foreach my $file(@files){

        if($file !~ m/$regex/){
            print "$file\n";
        }

        else{

            open(IN, "<", $file);

            while( ($line = <IN>) && ($line !~ /$regex/);

            $? !=
            }
            close(IN);
        }
    }
}
=cut

    foreach my $file(@files){

        if($file =~ m/$regex/){
            #match the '/' to print only the file name
            print "$file";
        }

        else{

            open(IN, "<", $file);

            while( $line = <IN>){

                if($line =~ /$regex/){

                    print "$file: $line\n";
                    last;
                }
            }
            close(IN);
        }
    }



