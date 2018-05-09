####### Installing libraries for generating Interactive Scatter Plot
print ("Checking and installing required packages")
if (!require("devtools")) install.packages("devtools",repos="http://cran.us.r-project.org")
print ("Loading required dependencies for devtools")
library(withr)
library(httr)
library(curl)
library(devtools)
print ("Loading required dependencies for devtools")
if (!require("plotly")) install.packages("plotly",repos="http://cran.us.r-project.org")
if (!require("ggplot2")) install.packages("ggplot2",repos="http://cran.us.r-project.org")
if (!require("gplots")) install.packages("gplots",repos="http://cran.us.r-project.org")
if (!require("R2HTML")) install.packages("R2HTML",repos="http://cran.us.r-project.org")
if (!require("RColorBrewer")) install.packages("RColorBrewer",repos="http://cran.us.r-project.org")
if (!require("htmlwidgets")) install.packages("htmlwidgets",repos="http://cran.us.r-project.org")
if (!require("reshape2")) install.packages("reshape2",repos="http://cran.us.r-project.org")

#####load Libraries
print ("Loading required libraries")
library(plotly)
library(ggplot2)
library(R2HTML)
library(htmlwidgets)
library(RColorBrewer)
library(gplots)
library(reshape2)

##### Taking Command Line Arguments 
args = commandArgs(trailingOnly=TRUE)
path <- args[1]
filenameR <- args[2]
col1 <- as.numeric(args[3])
col2 <- as.numeric(args[4])
col3 <- args[5]

setwd(path)
file <- filenameR
data <- read.table(file,sep="\t",header=T,row.names=1,check.names=F)
print ("This is how your input data looks")
head(data)
headervalues <- names(data)
newcol1 <- col1-1
headervaluesx <- (headervalues[newcol1])
newcol2 <- col2-1
headervaluesy <- headervalues[newcol2]
xvalue <- as.numeric(data[,newcol1])
yvalue <- as.numeric(data[,newcol2])
Name <- row.names(data)
print ("Generating Scatter plot based on user preference")
if(identical(col3,"No")){
header <- toString(file)
file <- strsplit(file,".txt")
outfile1 <- paste0(file, "_static", "_scatterplot", ".png")
p <- ggplot(data, aes(xvalue,yvalue,label=Name))
p +theme(axis.text = element_text(size = 14),axis.line.x = element_line(colour = "black"),axis.line.y = element_line(colour = "black"),legend.key = element_rect(fill = "white"),legend.background = element_rect(fill = "white"),panel.grid.major = element_line(),panel.grid.minor = element_blank(),panel.background = element_rect(fill = "white"))+geom_point(shape=1)+xlab(headervaluesx)+ylab(headervaluesy)+ggtitle(header)
ggsave(outfile1)
outfile <- paste0(file, "_interactive", "_scatterplot", ".html")
htmlwidgets::saveWidget(as.widget(ggplotly()), outfile)} else{
newcol3 <- as.numeric(col3)-1
enrichment <- data[,newcol3]
Color_Legend <- factor(enrichment)
file <- strsplit(file,".txt")
outfile1 <- paste0(file, "_static", "_scatterplot", ".png")
header <- toString(file)
p <- ggplot(data, aes(xvalue,yvalue,label=Name))
p +theme(axis.text = element_text(size = 14),axis.line.x = element_line(colour = "black"),axis.line.y = element_line(colour = "black"),legend.key = element_rect(fill = "white"),legend.background = element_rect(fill = "white"),panel.grid.major = element_line(),panel.grid.minor = element_blank(),panel.background = element_rect(fill = "white"))+geom_point(aes(color=Color_Legend),shape=1,size=3)+xlab(headervaluesx)+ylab(headervaluesy)+ggtitle(header)+scale_size_area()
ggsave(outfile1)
outfile <- paste0(file, "_interactive", "_scatterplot", ".html")
htmlwidgets::saveWidget(as.widget(ggplotly()), outfile)}

###END