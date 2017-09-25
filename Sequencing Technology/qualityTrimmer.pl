#!/usr/bin/perl
use warnings;
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Seq::Quality;

#create two objects to read the fastq sequences
my $r1_obj = Bio::SeqIO->new(
	-file   => 'Sample.R1.fastq',
	-format => 'fastq'
);
my $r2_obj = Bio::SeqIO->new(
	-file   => 'Sample.R2.fastq',
	-format => 'fastq'
);

#create a object for output file
my $out_obj = Bio::SeqIO->new(
	-file   => '>interleaved.fastq',
	-format => 'fastq'
);

#read the fastq file
while ( my $left = $r1_obj->next_seq ) {

	#get the longest subsequence that has quality values above 20
	my $leftTrimmed = $left->get_clear_range(20);

	#copy the descrition from the orignal file
	$leftTrimmed->desc( $left->desc() );

	#write into the output file
	$out_obj->write_seq($leftTrimmed);

	#read the mated sequence
	my $right = $r2_obj->next_seq;

	#get the longest subsequence that has quality values above 20
	my $rightTrimmed = $right->get_clear_range(20);

	#copy the descrition from the orignal file
	$rightTrimmed->desc( $right->desc() );

	#write into the output file
	$out_obj->write_seq($rightTrimmed);
}
