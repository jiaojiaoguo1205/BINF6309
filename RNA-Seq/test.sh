#!/bin/bash
#Get the list of left reads and store as $leftReads
leftReads="$(ls -q Paired/*.R1.fastq)"
#Store echo of $leftReads as $leftReads to get rid of line breaks
leftReads=$(echo $leftReads)
#Replace spaces in list of reads with comma
leftRead="${leftReads// /,}"
echo $leftReads
