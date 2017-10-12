#!/bin/sh
fastqPath="Paired/"
leftSuffix=".R1.fastq"
rightSuffix=".R2.fastq"
outPath="Sam/"
for file in $fastqPath*$leftSuffix
do
    pathRemoved="${file/$fastqPath/}"
    sampleName="${pathRemoved/$leftSuffix/}"
    echo nice -n 19 gsnap \
    -A sam \
    -s AiptasiaGmapIIT.iit \
    -D . \
    -d AiptasiaGmapDb \
    $sampleName$leftSuffix \
    $sampleName$rightSuffix \
    #1>$outPath$sampleName.sam 
done
