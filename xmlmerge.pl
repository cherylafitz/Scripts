#this program looks in the directory it's in, takes all xml documents it sees, and pastes them together into one long one.  It's designed to work with 'flattened' xml files from AIS Forms.
#Note: a blank file passed as xml to the program will cause fatal errors

use warnings;
use strict;
use 5.010;

#define header and top-level element tag opener and closer
my $header = '<?xml version="1.0" encoding="UTF-8"?>';
my $rowsopener = '<rows>';
my $rowscloser = '</rows>';
my @problemfiles;
my @files = glob '*.xml'; # assign all xml files to an array, arranged alphabetically

unless (@files) {
	die "no xml files found!"; #die if no xml files are found to be put into @files
}

#Check @files array for improperly-headed xml files, push all found bad files into @problemfiles
foreach my $inputfile ( @files ) {
	open my $inputfilehandle,'<:encoding(UTF-8)',"$inputfile" or die "cannot open input file $inputfile: $!";
	my $firstline = <$inputfilehandle>;
	chomp $firstline;
	unless ( $firstline eq $header ) {
		push @problemfiles, $inputfile;
		# die "first line of $inputfile is $firstline";
	}
}

#If @problemfiles array is not empty, throw fatal error containing names of all bad xml files
if (@problemfiles) {
	die "The following files look like improperly formatted xml:\n @problemfiles\n";
}

mkdir 'output'; # create directory for output

# put header and top-level tag opener into output document
my $outputfile;
open $outputfile,'>:encoding(UTF-8)','output/master.xml' or die "can't open output file $outputfile: $!";
select $outputfile;
say $header;
say $rowsopener;
close $outputfile;
select STDOUT;

#loop over array of xml file inputs, print each line of each file into output document unless it matches header or top-level tag opener/closer
 foreach my $inputfile ( @files ) {
	open my $inputfile,'<:encoding(UTF-8)',"$inputfile" or die "cannot open input file $inputfile: $!";
	open $outputfile,'>>:encoding(UTF-8)','output/master.xml';
	select $outputfile;
	while ( defined ( $_ = <$inputfile> )) {
		chomp $_;
		unless ( ($_ eq $rowsopener) || ($_ eq $rowscloser) || ($_ eq $header) ) {
			say "$_" or die "cannot print: $!";
		}
	}
}

print $rowscloser; #put top-level tag closer at end of document

#Last updated by Chris MacDonald on June 7, 2012 (cmac1000@gmail.com)
