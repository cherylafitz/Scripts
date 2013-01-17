use warnings;
use strict;
use 5.010;

my $inputfile = "labels.txt";
my @RefLabels;
my @Standardized;
my @Processed;
my @words;
my $DesiredLength = '25';

#Hash for standard abbreviations

my %standard = (
#	'Ability' => 'Abil',
#	'Abroad' => 'Abr',
#	'Account' => 'Acc',
#	'Activities' => 'Activs',
#	'Activity' => 'Activ',
#	'Adaptability' => 'Adapt',
#	'Additional' => 'Addi',
	'Address' => 'Addr',
	'Admin' => 'Admin',
	'Administrator' => 'Admin',
	'Affirmation' => 'Affrim',
	'Agreement' => 'Agree',
	'Allergies' => 'Allerg',
	'Alumnus' => 'Alum',
	'American' => 'Amer',
	'Applicant' => 'App',
	'Approval' => 'Approv',
	'Asmyle' => 'ASMYLE',
	'Assessment' => 'Assess',
	'Awarded' => 'Award',
	'Bank' => 'Bank',
	'Biography' => 'Bio',
	'Budget' => 'Budg',
	'Choice' => 'Choice',
	'Cived' => 'CivEd',
	'Cls' => 'CLS',
	'Community' => 'Comm',
	'Composite' => 'Comp',
	'Conference' => 'Conf',
	'Conferences' => 'Confs',
	'Contact' => 'Cont',
	'Councils' => 'Coun',
#	'Country' => 'Country',
	'Current' => 'Curr',
	'Custodial' => 'Cust',
	'Date' => 'Date',
	'Degree' => 'Deg',
#	'Description' => 'Descript',
	'Dietary' => 'Diet',
	'Director' => 'Dir',
	'District' => 'Dist',
	'Dc' => 'DC',
#	'Domestic' => 'Dom',
#	'Duration' => 'Dur',
	'Eca' => 'ECA',
	'Eligibility' => 'Elig',
	'Email' => 'Email',
	'Emergency' => 'Emerg',
	'Employment' => 'Emp',
	'English' => 'Eng',
	'Essay' => 'Ess',
	'Eval' => 'EVAL',
	'EVAL' => 'EVAL',
	'Evaluation' => 'Eval',
	'Exchange' => 'Exch',
	'Experience' => 'Exper',
	'Explain' => 'Expl',
	'Family' => 'Fam',
	'Fathers' => 'Father',
	'Field' => 'Field',
	'First' => '1st',
	'Flagship' => 'Flag',
	'Flex' => 'FLEX',
	'Funding' => 'Fund',
	'Generic' => 'Gen',
	'Guardian' => 'Guard',
	'Grade' => 'Grade',
	'Home' => 'Home',
	'Honorific' => 'Hon',
	'Host' => 'Host',
	'Hours' => 'Hours',
	'Immersion' => 'Imm',
	'Independent' => 'Ind',
	'Institution' => 'Inst',
	'Intermediary' => 'Intermed',
	'International' => 'Int',
	'Language' => 'Lang',
	'Last' => 'Last',
	'Leadership' => 'Lead',
	'Letter' => 'Lett',
	'Level' => 'Lev',
	'Liaison' => 'Lia',
	'Listening' => 'List',
	'Mail' => 'Mail',
	'Mailing' => 'Mail',
	'Medical' => 'Med',
	'Mentor' => 'Ment',
	'Middle' => 'Mid',
	'Mobile' => 'Mob',
	'Month' => 'Mon',
	'Mothers' => 'Mother',
#	'Motivation' => 'Motiv',
	'Name' => 'Name',
	'Nsliy' => 'NSLIY',
	'Number' => 'Num',
	'Ngo' => 'NGO',
	'Noneca' => 'NonECA',
	'Organization' => 'Org',
	'Other' => 'Oth',
	'Outside' => 'Out',
	'Pak' => 'PAK',
#	'Parent' => 'Par',
	'Participated' => 'Part',
	'Participation' => 'Part',
	'Passport' => 'Pass',
	'Permanent' => 'Perm',
	'Personality' => 'Pers',
	'Phone' => 'Phone',
	'Physical' => 'Phys',
#	'Placement' => 'Plac',
	'Plan' => 'Plan',
#	'Position' => 'Pos',
	'Postal' => 'Post',
	'PreCapstone' => 'PreCap',
	'Preference' => 'Pref',
	'Previous' => 'Prev',
	'Previously' => 'Prev',
	'Priority' => 'Pri',
#	'Program' => 'Prog',
	'Project' => 'Proj',
	'Purpose' => 'Purp',
	'Reading' => 'Read',
	'Recommendation' => 'Rec',
	'Recommender' => 'Rec',
	'Reference' => 'Ref',
	'Referral' => 'Ref',
	'Relationship' => 'Rela',
#	'Religion' => 'Reli',
	'Report' => 'Rep',
	'Responsibilities' => 'Resp',
	'Restrictions' => 'Rest',
	'Russia' => 'Rus',
	'Russian' => 'Rus',
#	'School' => 'Sch',
	'Score' => 'Score',
	'Screening' => 'Screen',
	'See' => 'SEE',
	'Self' => 'Self',
	'Sibling' => 'Sib',
	'Signature' => 'Sig',
	'Speaking' => 'Speak',
	'Start' => 'Start',
	'STARTALK' => 'STAR',
	'State' => 'State',
	'Statement' => 'Statem',
	'Street' => 'St',
	'Student' => 'Stud',
	'Students' => 'Stud',
	'Study' => 'Study',
	'Superintendent' => 'Super',
	'Supervisor' => 'Superv',
	'Teacher' => 'Teach',
	'Teaching' => 'Teach',
	'Telephone' => 'Phone',
	'Test' => 'Test',
	'Title' => 'Title',
	'Training' => 'Train',
	'Trait' => 'Trait',
	'Transcript' => 'Transc',
	'Translator' => 'Transl',
	'Travel' => 'Trav',
	'Type' => 'Type',
	'University' => 'Uni',
	'Upload' => 'Up',
	'Us' => 'US',
	'Usa' => 'USA',
	'Vegetarian' => 'Veg',
	'Volunteer' => 'Vol',
	'Writing' => 'Writ',
	'Year' => 'Year',
	'Years' => 'Years' ,
	'Zip' => 'ZIP' ,
	);

#Subroutine to find length of longest string in array
sub LengthFinder {
	my $LongestYet = length(shift @_);
	foreach (@_) {
		if (length($_) > $LongestYet) {
			$LongestYet = length ($_);
		}
	}
	return $LongestYet;
}

#Read labels.txt into program, strip out punctuation, capitalize initial letters, pass each line into @RefLabels
open "inputfilehandle",'<:encoding(UTF-8)',"$inputfile" or die "cannot open input file $inputfile: $!";
while ( defined ( $_ = <inputfilehandle> )) {	#Strip out punctuation
	s/-/ /g;
	s/,//g;
	s/\// /g;
	s/\.//g;
	s/'//g;
	s/\?//g;
	s/\)//g;
	s/\(//g;
	s/\b(\w)(\w*)/uc($1).lc($2)/ge; #and capitalize
	push @RefLabels, $_;	
}


#Standard abbreviations
foreach my $line (@RefLabels) {
		$_ = $line;
		my $StandardLine;
		my @words = split(/\s/, $_);
		foreach (@words) {
			if (exists $standard{$_}) {
				$_ = $standard{$_};
			}
		}
		$StandardLine = join (' ',@words);
		say "standardized is $StandardLine";
		push @Standardized, $StandardLine;
	}

#Process each line in @Standardized
 foreach my $line (@Standardized) {
 chomp $line;
 	if (length($line) < $DesiredLength) { #If length less than desired, string is fine to use unaltered, strip out white space and pass to @Processed
 		$_ = $line;
 		s/\s//g;
 		push @Processed, $_;
 		my $l = length($_);
 	}	
 	else { #Otherwise, split line into array of words, and iterate through chopping the last character off of the longest word(s) every time until the length is under desired
 		$_ = $line;
 		my $ChoppedLine;
 		$ChoppedLine = 'InitialValueforChoppedLineIsPrettyLongAndThisFeelsLikeABitOfAHack';
 		my $l = length($_);
 		my @words = split(/\s/, $_);
 		my $i =1;
 		while (length($ChoppedLine) > $DesiredLength){
 			my $Longest = &LengthFinder (@words);
 			foreach my $word (@words) {
 				unless (length($word) < $Longest) {
 					chop $word;
 				}
 			}
 			$ChoppedLine = join ('',@words);
 			$i++;
 		}
 	#Once chopped down to size, send concatenated line to @Processed
 	push @Processed, $ChoppedLine; 
 	}
 }
 
 #Give readout of processed lines
  print "Processed is:\n";
 foreach (@Processed) {
   print "$_\n";
 }
 
 #Write processed lines into output.txt
 my $outputfile;
 open $outputfile,'>:encoding(UTF-8)','output.txt' or die "can't open output file $outputfile: $!";
 select $outputfile;
 foreach (@Processed) {
   say "$_";
 }
 select STDOUT;
 say "Chopped to limit of $DesiredLength";
 #Done