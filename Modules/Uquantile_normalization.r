options(warn=-1)
##############################  UpperQuantile  Normalization ##############################

##### Installing Package EDASeq ############
if (!require("devtools")) install.packages("devtools",repos="http://cran.us.r-project.org")
print ("Loading required dependencies for devtools")
library(withr)
library(httr)
library(curl)
library(devtools)
source("https://bioconductor.org/biocLite.R")
if (!require("EDASeq")) biocLite("EDASeq")
library(EDASeq)
############################################


####### Reading Command Line Arguments ########
args = commandArgs(trailingOnly=TRUE)
path <- args[1]
filenameR <- args[2]
setwd(path)
file <- filenameR
Data <- as.matrix(read.table(file,sep="\t",header=TRUE,row.names=1, check.names=F))
print ("This how your input data looks")
head(Data)
print ("Performing Upper Quantile Normalization")
UData <- betweenLaneNormalization(Data, which="upper", round=FALSE)
write.table(UData,"temporaryfile.txt",sep="\t",quote=F)