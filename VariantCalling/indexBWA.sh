#!/bin/bash
# build BWA index use the vShiloni.fasta file  and the linear-time algorithm for constructing suffix array, the output is vShiloni-prefixed database
nice -n19 bwa index -p vShiloni -a is vShiloni.fasta \
1>bwaIndex.log 2>bwaIndex.err &
