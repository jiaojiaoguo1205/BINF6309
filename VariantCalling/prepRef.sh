#!/bin/bash
# index the reference genome vshiloni
samtools faidx vShiloni.fasta
# create the sequence dictionary for the reference sequence and output to the vShiloni.dict
java -jar /usr/local/bin/picard.jar CreateSequenceDictionary \
R=vShiloni.fasta O=vShiloni.dict \
1>perpRef.log 2>prepRef.err
