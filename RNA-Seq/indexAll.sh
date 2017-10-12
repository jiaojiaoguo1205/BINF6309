#!/bin/bash
bamPath="Bam/"
suffix=".sorted.bam"
for file in $bamPath*$suffix
do
    pathRemoved="${file/$bamPath/}"
    sampleName="${pathRemoved/$suffix/}"
    echo samtools index $sampleName$suffix \
    -o $bamPath
#1>Aip02.index.log 2>Aip02.index.err &
done
