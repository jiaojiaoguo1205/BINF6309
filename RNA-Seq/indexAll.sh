!/bin/bash
bamPath="Bam/"
suffix=".sorted.bam"
for file in $bamPath*$suffix
do
    pathRemoved="${file/$bamPath/}"
    sampleName="${pathRemoved/$suffix/}"
    samtools index $bamPath$sampleName$suffix \
    1>$bamPath$sampleName.index.log 2>$bamPath$sampleName.index.err 
done
