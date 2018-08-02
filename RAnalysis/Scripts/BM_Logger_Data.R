#Senior Thesis
#Data published in X
#Title: 
#Contact: vjs2@Princeton.edu
#Supported by: Princeton University
#See Readme file for details on data files and metadata

rm(list=ls()) # removes all prior objects

######Read in required libraries#####
library(reshape)
library(reshape2)
library(stringr)
library(ggplot2)
#####Required Data files#####
setwd("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/logger_calib")
mypath <-("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/logger_calib")
filenames<-list.files(path = mypath, pattern = "csv$")



########
filenames<-list.files(path = mypath, pattern = "csv$")
for (i in 1:length(filenames)) assign(filenames[i], read.csv(filenames[i]))

list.logger = list(Carboy1.csv, Carboy2.csv, Tank5.csv, Tank6.csv, Tank7.csv, Tank8.csv)

master.function <- function(dfNames) {
  do.call(rbind, lapply(dfNames, function(x) {
    cbind(get(x), source = x)
  }))
}
#logger.data = merge_all(list.logger)
logger.d = master.function(c(filenames)) ; colnames(logger.d) = c("Point", "Date_Time","Temperature", "Data.Frame") 
logger.data = logger.d[order(logger.d$Point),]
plot.logger = logger.data[c(1:94),]
plot.logger = subset(logger.data, Point < 95) #; plot.logger = plot.logger[c(2,3,4)]
split.date = do.call(rbind, str_split(plot.logger$Date_Time, " "))
master.logger =cbind(plot.logger[,c(3,4)],split.date)
master.logger = as.data.frame(master.logger[,c(3,4,1,2)]) 
colnames(master.logger) = c("Date", "Time", "Temperature", "Data.Frame")
master.logger

##The values Year, Value, School_ID are
##inherited by the geoms
ggplot(master.logger, aes(x=Date, y=Temperature,colour=Data.Frame)) + 
  geom_line() 
