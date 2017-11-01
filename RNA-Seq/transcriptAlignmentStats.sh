#!/bin/bash
#get the xprs path as the first argument
xprsPath=$1
#set a variable with xprs output file extension
xprsExt='.err'
#set a variabe with the output file name
outFile='tranAlignStats.csv'
#set a variable with the search text around the desired data
searchText='overall alignment rate'
#write a header line in csv format
echo 'Sample,TranAlignPct' > $xprsPath$outFile
#grep the search text and pipe to a while loop to process line by line
grep "$searchText" $xprsPath*$xprsExt | while read -r line 
do
    #remove search text from the output
    line="${line/$searchText/}"
    #remove file path from the output
    line="${line/$xprsPath/}"
    #remove file extension from the output
    line="${line/$xprsExt/}"
    #replace colon with comma
    line="${line/:/,}"
    #remove %sign
    line="${line/\%/}"
    #Append output in csv format
    echo $line >> $xprsPath$outFile
done
