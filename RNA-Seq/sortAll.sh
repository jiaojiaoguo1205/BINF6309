#!/bin/sh
samPath="Sam/"
suffix=".sam"
outPath="Bam/"
for file in $samPath*$suffix
do
    pathRemoved="${file/$samPath/}"
    sampleName="${pathRemoved/$suffix/}"
    samtools sort \
    $samPath$sampleName$suffix \
    -o $outPath$sampleName.sorted.bam \
    1>$outPath$sampleName.sort.log 2>$outPath$sampleName.sort.err 
done
