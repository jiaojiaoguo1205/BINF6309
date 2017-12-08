#!/bin/sh
nice -n 19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
-threads 1 -phred33 \
SRR6293333_1.fastq \
SRR6293333_2.fastq \
SRR6293333.R1.paired.fastq \
SRR6293333.R1.unpaired.fastq \
SRR6293333.R2.paired.fastq \
SRR6293333.R2.unpaired.fastq \
HEADCROP:0 \
ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/NexteraPE-PE.fa:2:30:10 \
LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36 \
1>SRR6293333.trim.log 2>SRR6293333.trim.err &
