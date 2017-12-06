#!/bin/bash
spades.py --pe1-1 SRR6293333.R1.paired.fastq \
--pe1-2 SRR6293333.R2.paired.fastq -o vibrioAssembly -t 8 -m 50 \
1>spades.err 2>spades.err &
