####Taking command line options
args = commandArgs(trailingOnly=TRUE)
path <- args[1]
filenameR <- args[2]
typeOfCorr <- args[3]
####supress warnings
options(warn=-1)
####setting path
setwd(path)
file <- filenameR
#### reading data
data <- as.matrix(read.table(file,sep="\t",header=TRUE,row.names=1,check.names=F))
print ("This is how input data looks like")
head(data)
datat <- t(data)
CORR <- cor(datat,method = typeOfCorr)
write.table(CORR,"temporaryfile.txt",sep="\t",quote=F)