#!/bin/sh
ls Bam/*.sorted.bam > bamIn.txt
samtools merge -b bamIn.txt AipAll.bam \
1>merge.log 2>merge.err &
