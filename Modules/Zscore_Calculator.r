args = commandArgs(trailingOnly=TRUE)
path <- args[1]
filenameR <- args[2]
setwd(path)
file <- filenameR
data <- as.matrix(read.table(file,sep="\t",header=T,row.names=1, check.names=F))
print ("This is how input file looks")
head(data)
data1 <- scale(data, center = TRUE, scale = TRUE)
zscore_data <- as.matrix((data1-mean(data1))/sd(data1))
col <- cbind(row.names(data),zscore_data)
write.table(col,"temporaryfile.txt",sep="\t",row.names=F,quote=F)
