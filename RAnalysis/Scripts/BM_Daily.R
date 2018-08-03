#Coral Larval Biomineralization
#Data published in X
#Title: 
#Contact: Hollie Putnam hollieputnam@gmail.com
#Supported by: BSF
#See Readme file for details on data files and metadata

rm(list=ls()) # removes all prior objects

#R Version: R version 3.3.1
#RStudio Version: 1.0.44
######Read in required libraries#####
library(car) #version 2.1-4 Date: 2016-11-30 Depends: R (>= 3.2.0) Imports:MASS, mgcv, nnet, pbkrtest (>= 0.3-2), quantreg, grDevices, utils, stats, graphics, Rcpp
library(ggplot2) #version 2.2.1 Date/Publication: 2016-12-30 Depends: R (>= 3.1) Imports: digest, grid, gtable (>= 0.1.1), MASS, plyr (>= 1.7.1),reshape2, scales (>= 0.4.1), stats, tibble, lazyeval
library(gridExtra) #version: 2.2.1 Date/Publication: 2016-02-29 Depends: R(>= 2.5.0) Imports: gtable, grid, grDevices, graphics, utils
library(lsmeans)  #version: 2.26-3 Date: 2017-05-09 Depends: estimability, methods, R (>= 3.0) Imports: graphics, stats, utils, nlme, coda (>= 0.17), multcomp, plyr,mvtnorm, xtable (>= 1.8-2)
library(multcomp) #version: 1.4-6 Date: 2016-07-14 Depends: stats, graphics, mvtnorm (>= 1.0-3), survival (>= 2.39-4), TH.data (>= 1.0-2)
library(nlme) #version: 3.1-131 Date: 2017-02-06 Depends: R (>= 3.0.2) Imports: graphics, stats, utils, lattice
library(plotrix) #version: 3.6-5 Date: 2017-05-09 Depends: NA Imports: grDevices, graphics, stats, utils
library(plyr) #version: 1.8.4 Date/Publication: 2016-06-08 Depends: R (>= 3.1.0) Imports: Rcpp (>= 0.11.0)
library(reshape) #version: 3.3.1 Date/Publication: 2016-06-24  Depends: R (>= 3.3.1)
library(seacarb) #version: 3.2 Date/Publication: 2017-06-19 Depends: R (>= 2.10), oce, gsw Imports: NA
library(grid) #version: 3.3.1 Date/Publication: 2016-06-24  Depends: R (>= 3.3.1)
library(xtable) #version 1.8-2 Date/Publication: 2016-01-08 Depends: R (>= 2.10.0)
library(lme4) #version: 1.1-13 Date/Publication: 2017-04-19 Depends: R (>= 3.0.2), Matrix (>= 1.1.1), methods, stats Imports: graphics, grid, splines, utils, parallel, MASS, lattice, nlme(>= 3.1-123), minqa (>= 1.1.15), nloptr (>= 1.0.4)
library(blmeco) #version: 1.1 Date/Publication: 2015-08-22 Depends: R (>= 3.0.0), stats, MASS Imports: MuMIn, arm, lme4
library(MuMIn) #version: 1.15.6 Date/Publication: 2016-01-07 Depends: R (>= 3.0.0) Imports: graphics, methods, Matrix, stats, stats4

#####Required Data files#####

#BM_daily_measurements.csv

#############################################################PARENTAL EXPOSURE##################################################
setwd("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Data/BM") #set working directory
mainDir<-'/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis' #set main directory
#############################################################

#Read in probe measurements of pH, temperature, and salinity from tanks
daily <- read.csv("BM_daily_measurements.csv", header=TRUE, sep=",", na.strings="NA") #load data with a header, separated by commas, with NA as NA

daily1 <- subset(daily, Experimental.Stage == "test")
#daily1 <- subset(daily, Type == "Tank")
daily1$Sample.ID <- factor(daily1$Sample.ID)

daily2 <- subset(daily, Experimental.Stage == "parental.exposure")
#daily1 <- subset(daily, Type == "Tank")
daily2$Sample.ID <- factor(daily2$Sample.ID)

daily3 <- subset(daily, Experimental.Stage == "planulation.period")
#daily1 <- subset(daily, Type == "Tank")
daily3$Sample.ID <- factor(daily3$Sample.ID)

pdf("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Output/BM_Parental_Exposure_Daily.pdf")
par(mfrow=c(3,3))
plot(daily1$Treatment, daily1$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main="Temperature for test period")
plot(daily2$Treatment, daily2$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main="Temperature for\n parental exposure period")
plot(daily3$Treatment, daily3$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main="Temperature for\n planulation period")
plot(daily1$Treatment, daily1$Light, xlab="Treatment", ylab="Light(PAR)", main="Light for test period")
plot(daily2$Treatment, daily2$Light, xlab="Treatment", ylab="Light(PAR)", main="Light for parental exposure period")
plot(daily3$Treatment, daily3$Light, xlab="Treatment", ylab="Light(PAR)", main="Light for planulation period")
plot(daily1$Sample.ID, daily1$Light, xlab="Treatment", ylab="Light(PAR)", main="Light per tank for test period")
plot(daily2$Sample.ID, daily2$Light, xlab="Treatment", ylab="Light(PAR)",main="Light per tank for\n parental exposure period")
plot(daily3$Sample.ID, daily3$Light, xlab="Treatment", ylab="Light(PAR)", main="Light per tank for\n planulation period")
dev.off()

###########################################################INCUBATION TANKS###################################################

#####################################TEST PERIOD#####################################################
#read in probe measurements of pH, temperature, and salinity from tanks
daily <- read.csv("BM_daily_measurements.csv", header=TRUE, sep=",", na.strings="NA") #load data with a header, separated by commas, with NA as NA

inc.daily1 <- subset(daily, Experimental.Stage == "inc.test" & Type == "Tank")
inc.daily1$Sample.ID <- factor(inc.daily1$Sample.ID)

c.daily1 <- subset(daily, Experimental.Stage == "inc.test" & Type == "Tray")
c.daily1$Sample.ID <- factor(c.daily1$Sample.ID)

inc.daily2 <- subset(daily, Experimental.Stage == "inc.exposure" & Type == "Tank")
inc.daily2$Sample.ID <- factor(inc.daily2$Sample.ID)

c.daily2 <- subset(daily, Experimental.Stage == "inc.exposure" & Type == "Tray")
c.daily2$Sample.ID <- factor(c.daily2$Sample.ID)


pdf("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Output/BM_Incubation_Exposure_Daily_Test.pdf")
par(mfrow=c(3,2))
plot(inc.daily1$Treatment, inc.daily1$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main="Temperature of incubation tanks\n for test period")
plot(c.daily1$Treatment, c.daily1$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main="Temperature of common garden\n for test period")
plot(inc.daily1$Treatment, inc.daily1$Light, xlab="Treatment", ylab="Light(PAR)", main="Light of incubation tanks\n for test period")
plot(c.daily1$Treatment, c.daily1$Light, xlab="Treatment", ylab="Light(PAR)", main="Light of common garden\n for test period")
plot(inc.daily1$Sample.ID, inc.daily1$Light, xlab="Treatment", ylab="Light(PAR)", main="Light per tank for test period")
plot(c.daily1$Quadrat, c.daily1$Light, xlab="Treatment", ylab="Light(PAR)", main="Light of common garden per quadrat\n for test period")
#plot(inc.daily2$Sample.ID, inc.daily2$Light, xlab="Treatment", ylab="Light(PAR)",main="Light per tank for\n parental exposure")
dev.off()

########################################EXPERIMENTAL PERIOD###############################


inc.daily2 <- subset(daily, Experimental.Stage == "inc.exposure" & Type == "Tank")
inc.daily2$Sample.ID <- factor(inc.daily2$Sample.ID)

c.daily2 <- subset(daily, Experimental.Stage == "inc.exposure" & Type == "Tray")
c.daily2$Sample.ID <- factor(c.daily2$Sample.ID)

#pdf("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Output/BM_Incubation_Exposure_Daily_Exp.pdf")
#par(mfrow=c(3,2))
#plot(inc.daily2$Treatment, inc.daily2$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main='Temperature for\n larval exposure period')
#plot(c.daily2$Treatment, c.daily2$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main="Temperature of common garden\n for larval exposure period")
#plot(inc.daily2$Treatment, inc.daily2$Light, xlab="Treatment", ylab="Light(PAR)", main="Light for larval exposure period")
#plot(c.daily2$Treatment, c.daily2$Light, xlab="Treatment", ylab="Light(PAR)", main="Light of common garden\n for exposure period")
#plot(inc.daily2$Sample.ID, inc.daily2$Light, xlab="Treatment", ylab="Light(PAR)",main="Light per tank for\n larval exposure period")
#plot(c.daily2$Quadrat, c.daily2$Light, xlab="Treatment", ylab="Light(PAR)", main="Light of common garden per quadrat\n for exposure period")
dev.off()

#####JUGS####
jugs.daily <- subset(daily, Experimental.Stage == "planulation.period" & Type == "Jug")
jugs.daily$Sample.ID <- factor(jugs.daily$Sample.ID)


pdf("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Output/BM_Planulation_Jug_Daily.pdf")
par(mfrow=c(2,2))
plot(jugs.daily$Treatment, jugs.daily$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main='Temperature for\n adult planulation period')
plot(jugs.daily$Sample.ID, jugs.daily$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main='Temperature per jug for\n adult planulation period')
plot(jugs.daily$Treatment, jugs.daily$Light, xlab="Treatment", ylab="Light(PAR)", main="Light for adult planulation period")
plot(jugs.daily$Sample.ID, jugs.daily$Light, xlab="Treatment", ylab="Light(PAR)",main="Light per jug for\n adult planulation period")
dev.off()

################PLANULATION PERIOD COMPARED TO PARENTAL EXPOSURE########################
pdf("/Users/valerieschmidt/MyProjects/BM_HIMB_Thesis/RAnalysis/Output/BM_Planulation_Parental_Comparison.pdf")
par(mfrow=c(2,2))
plot(jugs.daily$Treatment, jugs.daily$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main='Temperature for\n adult planulation period')
plot(daily2$Treatment, daily2$Temperature, xlab="Treatment", ylab="Temperature°C", ylim=c(23,35), main="Temperature for\n parental exposure period")
plot(jugs.daily$Treatment, jugs.daily$Light, xlab="Treatment", ylab="Light(PAR)", main="Light for adult planulation period")
plot(daily2$Treatment, daily2$Light, xlab="Treatment", ylab="Light(PAR)", main="Light for parental exposure period")
dev.off()

