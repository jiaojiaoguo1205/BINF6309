#!/bin/bash
# set a variable with the file containing SRA accesstions
filename="SRR_Acc_List.txt"
# create a funtion to read the file line-by-line
getAll(){
        while read -r line
        do
               #get the FASTQ
               fastq-dump $line --split-3 --gzip
        done < "$filename"
}
#cal the function in the background
getAll 1>get.log 2>get.err &
