#!/usr/bin/perl -w


my $ioption = 0;     #run the script in inverted order
my $regex;          #regular expression to find in file names and contents
my @files;          #fileList passed to the script

die "Usage: find.pl [-i] pattern fileList" if($#ARGV < 1);

# determine of the -i option is given
if($ARGV[0] eq "-i" ){
    $ioption = 1;
    $regex = $ARGV[1];
}

else{
    $regex = $ARGV[0];
}

#retreive the files
@files = grep( -f, @ARGV);

#run the script in inverted mode

if($ioption){

      foreach (@files){
        
        #extract the file name from the file path
        ($file) = $_ =~ /.*\/(.*)/g;

        #if the file name does not match the pattern, open it and ensure that it's
        #contents do not also match the pattern
        if($file !~ m/$regex/){

            $match = 0;

            open(IN, "<", $_);

            while($line = <IN>){

                if($line =~ m/$regex/){
                    $match =1;
                }
            }

            if(not $match){
                push(@invertedFiles, $file);
            }

            close(IN);
        }       
    }

    print (join("\n", @invertedFiles), "\n");
}


else{

    foreach (@files){

        ($file) = $_ =~ /.*\/(.*)/g;

        #Print the name of the file if it matches the pattern,
        #else check if the file contents match a pattern.
        if($file =~ m/$regex/){
            print "$file\n";
        }

        else{

            open(IN, "<", $_) or die("Failed to open $_");

            while( $line = <IN>){

                if($line =~ /$regex/){

                    print "$file: $line";
                    last;
                }
            }
            close(IN);
        }
    }
}





