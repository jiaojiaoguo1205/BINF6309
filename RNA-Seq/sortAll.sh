#!/bin/sh
samPath="Sam/"
suffix=".sam"
outPath="Bam/"
for file in $samPath*$suffix
do
    pathRemoved="${file/$samPath}"
    sampleName="${pathRemoved/$suffix}"
    echo samtools sort \
    $sampleName$suffix \
    -o $sampleName.sorted.bam \
#1>Aip02.sort.log 2>Aip02.sort.err &
done
