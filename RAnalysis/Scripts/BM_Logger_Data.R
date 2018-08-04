#Senior Thesis
#Title: 
#Contact: vjs2@Princeton.edu
#R Version: R version 3.3.1
#RStudio Version: 1.0.44

rm(list=ls()) # removes all prior objects

######Read in required libraries#####
library(reshape)
library(reshape2)
library(stringr)
library(ggplot2)
library(scales)
library(anytime)

#############Required Data files#############################
#From Calib folder: "Carboy1.csv" "Carboy2.csv" "Tank5.csv"   "Tank6.csv"   "Tank7.csv"  "Tank8.csv"

##############################################################LOGGER CALIBRATION###############################################################
####################################ADULT EXPOSURE TANKS#####################################################
setwd("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/Calibration_20180719")
mypath <-("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/Calibration_20180719")
filenames<-list.files(path = mypath, pattern = "csv$")

for (i in 1:length(filenames)) assign(filenames[i], read.csv(filenames[i]))

list.logger = list(Carboy1.csv, Carboy2.csv, Tank5.csv, Tank6.csv, Tank7.csv, Tank8.csv)

master.function <- function(dfNames) {
  do.call(rbind, lapply(dfNames, function(x) {
    cbind(get(x), source = x)
  }))
}

#Rename logger.d columns
plot.logger = master.function(c(filenames)) ; colnames(plot.logger) = c("Point", "Date_Time","Temperature", "Data.Frame") 

#Order and cut ot the same length
plot.logger = plot.logger[order(plot.logger$Point),]
plot.logger = subset(plot.logger, Point < 95)


#Fixing Time Zone (TZ) issues!!!
plot.logger$Date_Time = as.POSIXct(plot.logger$Date_Time,format="%m/%d/%y %H:%M")
class(plot.logger$Date_Time)

#Plot with date and time
{loggerplot = ggplot(plot.logger, aes(x = Date_Time, y = Temperature, group = Data.Frame, colour= Data.Frame))
loggerplot + 
  geom_line() + 
  theme(axis.text = element_text(size =8, angle = 90, hjust = 1), plot.title = element_text(size = 16, hjust = 0.1,face = 'bold')) +
  ggtitle(    '            Logger Calibration') + theme(plot.title = element_text(size = 16)) + 
  ylab('Temperature°C') + 
  xlab('Time') + 
  theme (plot.margin = grid::unit(c(0,0, 0,0), "null")) + 
  theme(axis.title.y = element_text(size = rel(1.2), angle = 90, face = 'bold')) + 
  theme(axis.title.x = element_text(size = rel(1.2), angle = 0, face = 'bold')) + 
  labs(colour='Logger Location') + theme(legend.text = element_text(size = 12)) + 
  scale_y_continuous(name="Temperature°C", limits = c(20,28), breaks=seq(20,30, by=1))
ggsave("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Output/BM_Logger_Calibration_Adult.pdf", plot = last_plot(), device = NULL, path = NULL,
       scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
       dpi = 300, limitsize = TRUE)}

#############################################EXPOSURE TANKS#########################################################
rm(list=ls()) # removes all prior objects
setwd("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/Calibration_20180803")
mypath <-("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/Calibration_20180803")
filenames<-list.files(path = mypath, pattern = "csv$")

for (i in 1:length(filenames)) assign(filenames[i], read.csv(filenames[i]))

list.logger = list(Common.garden.csv, Tank1.csv, Tank2.csv, Tank3.csv, Tank4.csv)

master.function <- function(dfNames) {
  do.call(rbind, lapply(dfNames, function(x) {
    cbind(get(x), source = x)
  }))
}

#Rename logger.d columns
plot.logger = master.function(c(filenames)) ;colnames(plot.logger) = c("Point", "Date_Time","Temperature", "Data.Frame") 

#Order and cut ot the same length (right before any NAs)
plot.logger = plot.logger[order(plot.logger$Point),]
plot.logger = subset(plot.logger, Point < 215)

#Fixing Time Zone (TZ) issues!!!
plot.logger$Date_Time = as.POSIXct(plot.logger$Date_Time,format="%m/%d/%y %H:%M")
class(plot.logger$Date_Time)

#Plot with date and time
{loggerplot = ggplot(plot.logger, aes(x = Date_Time, y = Temperature, group = Data.Frame, colour= Data.Frame))
  loggerplot + 
    geom_line() + 
    theme(axis.text = element_text(size =8, angle = 90, hjust = 1), plot.title = element_text(size = 16, hjust = 0.1,face = 'bold')) +
    ggtitle(    '            Logger Calibration') + theme(plot.title = element_text(size = 16)) + 
    ylab('Temperature°C') + 
    xlab('Time') + 
    theme (plot.margin = grid::unit(c(0,0, 0,0), "null")) + 
    theme(axis.title.y = element_text(size = rel(1.2), angle = 90, face = 'bold')) + 
    theme(axis.title.x = element_text(size = rel(1.2), angle = 0, face = 'bold')) + 
    labs(colour='Logger Location') + theme(legend.text = element_text(size = 12)) + 
    scale_y_continuous(name="Temperature°C", limits = c(20,28), breaks=seq(20,30, by=1))
  ggsave("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Output/BM_Logger_Calibration_Exposure_Tanks.pdf", plot = last_plot(), device = NULL, path = NULL,
         scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
         dpi = 300, limitsize = TRUE)}

#############################################EXTRA STUFF############################################################
#Split date and time and bind date and time back to plot.logger dataframe
split.date = do.call(rbind, str_split(plot.logger$Date_Time, " "))
master.logger =cbind(plot.logger[,c(3,4)],split.date)

#Reorganize and rename columns.
master.logger = as.data.frame(master.logger[,c(3,4,1,2)]) 
colnames(master.logger) = c("Date", "Time", "Temperature", "Data.Frame")


#############################################################EVERYDAY LOGGERS EXPOSURE TANKS##################################################################
rm(list=ls())
setwd("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/logger_data/Readout_20180718")
mypath=("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/logger_data/Readout_20180718")
filenames=list.files(path = mypath, pattern = "csv$")
for (i in 1:length(filenames)) assign(filenames[i], read.csv(filenames[i])) #Load csv files

##Check length of data frames.
list.logger = list(Common_Garden.csv,Tank1.csv,Tank2.csv,Tank4.csv)
#str(list.logger)
length.info <- lapply(list.logger,function(x)nrow(x))
length.info

#Make a function to stack multiple dataframes
master.function <- function(dfNames) {
  do.call(rbind, lapply(dfNames, function(x) {
    cbind(get(x), source = x)
  }))
}

#Stack dataframes and rename columns
Readout.20180718 = master.function(c(filenames)) ; colnames(Readout.20180718) = c("Point", "Date_Time","Temperature", "Data.Frame") 

#Order and cut ot the same length
Readout.20180718 = Readout.20180718[order(Readout.20180718$Point),]
tail(Readout.20180718) #Check last value in Point column to double check my reasoning
Cut.Readout.20180718 = subset(Readout.20180718, Point < 3462)
tail(Cut.Readout.20180718)

#Fixing Time Zone (TZ) issues
Cut.Readout.20180718$Date_Time = as.POSIXct(Cut.Readout.20180718$Date_Time,format="%m/%d/%y %H:%M")
class(Cut.Readout.20180718$Date_Time)

#Plot with date and time
{Readout.20180718.plot = ggplot(Cut.Readout.20180718, aes(x = Date_Time, y = Temperature, group = Data.Frame, colour= Data.Frame))
  Readout.20180718.plot + 
    geom_line() + 
    theme(axis.text = element_text(size =8, angle = 90, hjust = 1), plot.title = element_text(size = 16, hjust = 0.1,face = 'bold')) +
    ggtitle(    '                         Test logger temperature data') + theme(plot.title = element_text(size = 20)) + 
    ylab('Temperature°C') + 
    xlab('Date') + 
    theme (plot.margin = grid::unit(c(0,0, 0,0), "null")) + 
    theme(axis.title.y = element_text(size = rel(1.2), angle = 90, face = 'bold')) + 
    theme(axis.title.x = element_text(size = rel(1.2), angle = 0, face = 'bold')) + 
    labs(colour='Logger Location') + theme(legend.text = element_text(size = 12)) + 
    scale_x_datetime(date_breaks = "2 day", labels = date_format("%b %d")) +
    scale_y_continuous(name="Temperature°C", limits = c(25,35), breaks=seq(25,35, by=1))
  ggsave("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Output/BM_Readout_20180718.pdf", plot = last_plot(), device = NULL, path = NULL,
         scale = 1, width = 10, height = 5, units = c("in", "cm", "mm"),
         dpi = 300, limitsize = TRUE)}

######################################################EVERYDAY LOGGERS PARENTAL EXPOSURE PERIOD###############################################
rm(list=ls())
setwd("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/logger_data/Readout_20180801")
mypath=("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM/logger_data/Readout_20180801")
filenames=list.files(path = mypath, pattern = "csv$")
for (i in 1:length(filenames)) assign(filenames[i], read.csv(filenames[i])) #Load csv files
filenames

##Check length of data frames.
list.logger = list(Carboy1.csv,Carboy2.csv, Tank5.csv,Tank6.csv,Tank7.csv,Tank8.csv)
list.logger
#str(list.logger)
length.info <- lapply(list.logger,function(x)nrow(x))
length.info


#Make a function to stack multiple dataframes
master.function <- function(dfNames) {
  do.call(rbind, lapply(dfNames, function(x) {
    cbind(get(x), source = x)
  }))
}

#Stack dataframes and rename columns
Readout.20180801 = master.function(c(filenames)); colnames(Readout.20180801) = c("Point", "Date_Time","Temperature", "Data.Frame") 

#Order and cut ot the same length
Readout.20180801 = Readout.20180801[order(Readout.20180801$Point),]
tail(Readout.20180801) #Check last value in Point column to double check my reasoning
Cut.Readout.20180801 = subset(Readout.20180801, Point < 3642)
tail(Cut.Readout.20180801)

#Fixing Time Zone (TZ) issues
Cut.Readout.20180801$Date_Time = as.POSIXct(Cut.Readout.20180801$Date_Time,format="%m/%d/%y %H:%M")
class(Cut.Readout.20180801$Date_Time)

#Plot with date and time
{Readout.20180801.plot = ggplot(Cut.Readout.20180801, aes(x = Date_Time, y = Temperature, group = Data.Frame, colour= Data.Frame))
Readout.20180801.plot + 
    geom_line() + 
    theme(axis.text = element_text(size =8, angle = 90, hjust = 1), plot.title = element_text(size = 16, hjust = 0.1,face = 'bold')) +
    ggtitle(    '          Logger temperature data for adult exposure period') + theme(plot.title = element_text(size = 20)) + 
    ylab('Temperature°C') + 
    xlab('Date') + 
    theme (plot.margin = grid::unit(c(0,0, 0,0), "null")) + 
    theme(axis.title.y = element_text(size = rel(1.2), angle = 90, face = 'bold')) + 
    theme(axis.title.x = element_text(size = rel(1.2), angle = 0, face = 'bold')) + 
    labs(colour='Logger Location') + theme(legend.text = element_text(size = 12)) + 
    scale_x_datetime(date_breaks = "2 day", labels = date_format("%b %d")) +
    scale_y_continuous(name="Temperature°C", limits = c(25,35), breaks=seq(25,35, by=1))
  ggsave("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Output/BM_Readout_20180801.pdf", plot = last_plot(), device = NULL, path = NULL,
         scale = 1, width = 10, height = 5, units = c("in", "cm", "mm"),
         dpi = 300, limitsize = TRUE)}
