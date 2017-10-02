#!/usr/bin/perl
use warnings;
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Seq::Quality;
use Getopt::Long;
use Pod::Usage;

#GLOBALS
my $left = '';
my $right = '';
my $interleaved = '';
my $qual = 0;
my $usage = "\n$0 [options] \n
Options:
    -left Left reads
    -right Right reads
    -qual Quality score minimum
    -interleaved Filname for interleaved output
    -help Show this message
\n";
GetOptions(
    'left=s'    => \$left,
    'right=s'   => \$right,
    'interleaved=s' => \$interleaved,
    'qual=i'    => \$qual,
    'help'      => sub{ pd2usage($usage); },
) or pod2usage($usage);
unless (-e $left and -e $right and $qual and $interleaved) {
	unless (-e $left){
		print "Specify file for left reads\n;"
	}
	unless (-e $right) {
		print "Specify file for right reads\n";
	}
	unless ($interleaved) {
		print "Specify file for interleaved output\n;"
	}
	unless ($qual) {
		print "Specify quality score cutoff\n", $usage;
	}
	die "Missing required options\n";
	
}


    
#create two objects to read the fastq sequences
my $r1_obj = Bio::SeqIO->new(
	-file   => $left,
	-format => 'fastq'
);
my $r2_obj = Bio::SeqIO->new(
	-file   => $right,
	-format => 'fastq'
);

#create a object for output file
my $out_obj = Bio::SeqIO->new(
	-file   => ">$interleaved",
	-format => 'fastq'
);

#read the fastq file
while ( my $left = $r1_obj->next_seq ) {

	#get the longest subsequence that has quality values above 20
	my $leftTrimmed = $left->get_clear_range($qual);

	#copy the descrition from the orignal file
	$leftTrimmed->desc( $left->desc() );

	#write into the output file
	$out_obj->write_seq($leftTrimmed);

	#read the mated sequence
	my $right = $r2_obj->next_seq;

	#get the longest subsequence that has quality values above 20
	my $rightTrimmed = $right->get_clear_range($qual);

	#copy the descrition from the orignal file
	$rightTrimmed->desc( $right->desc() );

	#write into the output file
	$out_obj->write_seq($rightTrimmed);
}
