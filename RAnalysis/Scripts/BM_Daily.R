#Senior Thesis
#Title: 
#Contact: vjs2@Princeton.edu
#R Version: R version 3.3.1
#RStudio Version: 1.0.44

rm(list=ls()) # removes all prior objects


#####Required Data files#####
#BM_daily_measurements.csv
#Logger calibration files

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
plot(daily2$Treatment, daily2$Light, xlab="Treatment", ylab="Light(PAR)", main="Light for parental\n exposure period")
plot(daily3$Treatment, daily3$Light, xlab="Treatment", ylab="Light(PAR)", main="Light for planulation period")
plot(daily1$Sample.ID, daily1$Light, xlab="Treatment", ylab="Light(PAR)", main="Light per tank for test period")
plot(daily2$Sample.ID, daily2$Light, xlab="Treatment", ylab="Light(PAR)",main="Light per tank for\n parental exposure period")
plot(daily3$Sample.ID, daily3$Light, xlab="Treatment", ylab="Light(PAR)", main="Light per jug for\n planulation period")
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

