#!/bin/bash
bam="$(ls -q noDup/*.bam)"
inPath="noDup/"
replacement="-I noDup/"
bamParam="${bam//$inPath/$replacement}"
#echo $bamParam
knownVcf="filteredSnps.vcf"
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar \
-T BaseRecalibrator \
-R vShiloni.fasta \
$bamParam \
-knownSites $knownVcf -o recal_data.table 1>rec.err 2>rec.log &  

