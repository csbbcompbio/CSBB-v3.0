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
setwd(path)
file <- filenameR

data <- as.matrix(read.table(file,sep="\t",header=T,row.names=1,check.names=F))
data.t <- t(data)
data.t <- melt(data.t, id.vars="Samples", value.name="Expression", variable.name="Genes")
Genes <- factor(data.t$Var2)
Samples <- data.t$Var1
file <- strsplit(file,".txt")
header <- toString(file)
outfile1 <- paste0(file, "_static", "_ExpressionPlot", ".png")
print ("Generating Expression Plot both in interactive and static mode")
p <- ggplot(data.t, aes(x=Samples, y=Expression, group = Var2)) + geom_line(aes(color=Genes)) + geom_point(aes(color=Genes),shape=1,size=3) + xlab("Samples")+ ylab("Expression")+ggtitle(header)
ggsave(outfile1,width=30,height=30,limitsize = FALSE)
outfile <- paste0(file, "_interactive", "_ExpressionPlot", ".html")
htmlwidgets::saveWidget(as.widget(ggplotly(),p), outfile)
dev.off()