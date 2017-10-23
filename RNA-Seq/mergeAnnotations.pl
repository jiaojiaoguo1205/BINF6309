#!/bin/perl
use Bio::SearchIO;
use Bio::Search::Result::GenericResult;


my $blastXml = Bio::SearchIO->new(
    -file    => 'Trinity-GG.blastp.xml',
    -format  => 'blastxml'
    );
my $out = Bio::SearchIO->new(
    -file => '>aipSwissProt.tsv'
);
open(FH, ">","aipSwissProt.tsv") or die $!;
print FH "Trinity\tSwissProt\tSwissProtDesc\teValue\n";
while (my $result =$blastXml->next_result()) {
	my $queryDesc = $result->query_description;
	if ($queryDesc =~ /::(.*?)::/) {
		my $queryDescShort =$1;
		my $hit            = $result->next_hit;
		if ($hit) {
			print FH $queryDescShort, "\t";
			print FH $hit->accession, "\t";
			my $subjectDescription=$hit->description;
			if ($subjectDescription =~ /Full=(.*?);/){
				$subjectDescription = $1;
			}
			if ($subjectDescription =~ /Full=(.*?)\[/){
				$subjectDescription = $1;
			}
			print FH $subjectDescription, "\t";
			print FH $hit->significance, "\n";
			
			
		}
	}
}
