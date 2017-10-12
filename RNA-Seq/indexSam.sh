#!/bin/bash
samtools index Aip02.sorted.bam
1>Aip02.index.log 2>Aip02.index.err &
