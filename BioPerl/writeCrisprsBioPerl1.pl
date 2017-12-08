#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
use Bio::Seq;
use Bio::SeqIO;
#use Getopt::Long;
#use Pod::Usage;

#username: croesel

# Load into a hash all 21-mers ending in GG from dmel-all-chromosome.r6.02.fasta
# where the key is the last 12 positions of the k-mer, and the value is the k-mer.
# Create a second hash to count how many times each 12-mer occurs in the genome.
# For each 12-mer that only occurs ONCE, the corresponding 21-mer is a potential CRISPR.
# Print the crisprs.fasta
#GLOBALS
#my $fasta = '';

#my $usage = "\n$0 [options] \n
#Options:
#    -fastaIn input file
#\n";
#GetOptions(
#	'fastaIn=s' => \$fasta,
#	'help'      => sub { pd2usage($usage); },
# or pod2usage($usage);
#
#unless ( -e $fasta ) {
#	unless ( -e $fasta ) {
#		print "Specify the input file\n;";
#	}

#	die "Missing required options\n";
#}

#create an output file
my $seqiowrite_obj = Bio::SeqIO->new(
	-file   => '>crisprs2.fasta',
	-format => 'fasta'
);

#read the fasta file
my $seqioread_obj = Bio::SeqIO->new(
	-file   => '/scratch/Drosophila/dmel-all-chromosome-r6.17.fasta',
	-format => 'fasta'
);

#create the DNA sequence
my $seq;
while ( my $seq_obj = $seqioread_obj->next_seq ) {
	$seq .= $seq_obj->seq;
}

#hash to store kmers
my %kMerHash = ();

#hash to store occurrences of last 12 positions
my %last12Counts = ();

#declare scalars to characterize sliding window
#Set the size of the sliding window
my $windowSize = 21;

#Set the step size
my $stepSize  = 1;
my $seqLength = length($seq);

#for loop to increment the starting position of the sliding window
#starts at position zero; doesn't move past end of file; advance the window by step size
for (
	my $windowStart = 0 ;
	$windowStart <= ( $seqLength - $windowSize ) ;
	$windowStart += $stepSize
  )
{

	#Get a 21-mer substring from sequenceRef (two $ to deference reference to
	#sequence string) starting at the window start for length $windowStart
	my $crisprSeq = substr( $seq, $windowStart, $windowSize );

#if the 21-mer ends in GG, create a hash with key=last 12 of k-mer and value is 21-mer
#Regex where $1 is the crispr, and $2 contains the last 12 of crispr.
	if ( $crisprSeq =~ /([ATGC]{9}([ATGC]{10}GG))$/ ) {

		#Put the crispr in the hash with last 12 as key, full 21 as value.
		$kMerHash{$2} = $1;
		$last12Counts{$2}++;

	}

}

#Initialize the CRISPR count to zero
my $crisprCount = 0;

#Loop through the hash of last 12 counts
for my $last12Seq ( sort ( keys %last12Counts ) ) {

	#Check if count == 1 for this sequence
	if ( $last12Counts{$last12Seq} == 1 ) {

		#The last 12 seq of this CRISPR is unique in the genome.
		#Increment the CRISPR count.
		$crisprCount++;

		#Print the CRISPR in FASTA format.
		my $seq1_obj = Bio::Seq->new(
			-seq      => $kMerHash{$last12Seq},
			-alphabet => 'dna',
			-desc     => ">crispr_$crisprCount CRISPR"
		);
		$seqiowrite_obj->write_seq($seq1_obj);
	}
}