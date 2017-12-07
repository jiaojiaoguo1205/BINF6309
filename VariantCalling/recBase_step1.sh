#!/bin/bash
bam="$(ls -q noDup/*.bam)"
inPath="noDup/"
replacement="-I noDup/"
bamParam="${bam//$inPath/$replacement}"
#echo $bamParam
knownVcf="filteredSnps.vcf"
recBase_step1(){
for bam in $bamPath*.bam
do
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar \
-T BaseRecalibrator \
-R vShiloni.fasta \
$bamParam \
-knownSites $knownVcf \
-o recal_data.table 
done
}
recBase_step1 1>rec.err 2>rec.log & 

