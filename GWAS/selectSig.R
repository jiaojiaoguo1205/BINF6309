file <- read.table("epilepsy.txt.assoc.adjusted", header=T)
select <- file[file$BONF<=0.05,]
write.csv(select,file="selectSig.csv")
