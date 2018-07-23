#Finding best temperature

rm(list=ls()) # removes all prior objects

#2012
setwd("/Users/valerieschmidt/Desktop/Fall 2017 Semester/Spring 2018 Semester/Hawaii 2018:BIOS 2018/RAnalysis/DataRAnalysis/Data")
getwd()
oahu2012 = read.table("2012oahu.txt")
colnames(oahu2012) = c('yr', 'mo', 'dy', 'hr', 'mn', 'degT', 'm/s',  'm/s', 'm', 'sec', 'sec', 'degT', 'hPa', 'degC', 'SST', 'degC', 'mi', 'ft')
min(oahu2012$SST)
max(oahu2012$SST)
oahu2012.high = subset(oahu2012, SST>28, select = c(mo, dy, SST))
oahu2012.high

#2013
setwd("/Users/valerieschmidt/Desktop/Fall 2017 Semester/Spring 2018 Semester/Hawaii 2018:BIOS 2018/RAnalysis/DataRAnalysis/Data")
getwd()
oahu2013 = read.table("2013oahu.txt")
colnames(oahu2013) = c('yr', 'mo', 'dy', 'hr', 'mn', 'degT', 'm/s',  'm/s', 'm', 'sec', 'sec', 'degT', 'hPa', 'degC', 'SST', 'degC', 'mi', 'ft')
min(oahu2013$SST)
max(oahu2013$SST)
oahu2015.high = subset(oahu2013, SST>28, select = c(mo, dy, SST))
oahu2015.high

#2014
setwd("/Users/valerieschmidt/Desktop/Fall 2017 Semester/Spring 2018 Semester/Hawaii 2018:BIOS 2018/RAnalysis/Data")
getwd()
oahu2014 = read.table("2014oahu.txt")
colnames(oahu2014) = c('yr', 'mo', 'dy', 'hr', 'mn', 'degT', 'm/s',  'm/s', 'm', 'sec', 'sec', 'degT', 'hPa', 'degC', 'SST', 'degC', 'mi', 'ft')
min(oahu2014$SST)
max(oahu2014$SST)
oahu2015.high = subset(oahu2015, SST>28, select = c(mo, dy, SST))
oahu2015.high

#2015
setwd("/Users/valerieschmidt/Desktop/Fall 2017 Semester/Spring 2018 Semester/Hawaii 2018:BIOS 2018/RAnalysis/Data")
getwd()
oahu2015 = read.table("2015oahu.txt")
colnames(oahu2015) = c('yr', 'mo', 'dy', 'hr', 'mn', 'degT', 'm/s',  'm/s', 'm', 'sec', 'sec', 'degT', 'hPa', 'degC', 'SST', 'degC', 'mi', 'ft')
min(oahu2015$SST)
max(oahu2015$SST)
oahu2015.high = subset(oahu2015, SST>28, select = c(mo, dy, SST))
oahu2015.high

#2016
setwd("/Users/valerieschmidt/Desktop/Fall 2017 Semester/Spring 2018 Semester/Hawaii 2018:BIOS 2018/RAnalysis/Data")
getwd()
oahu2016 = read.table("2016oahu.txt")
colnames(oahu2016) = c('yr', 'mo', 'dy', 'hr', 'mn', 'degT', 'm/s',  'm/s', 'm', 'sec', 'sec', 'degT', 'hPa', 'degC', 'SST', 'degC', 'mi', 'ft')
min(oahu2016$SST)
max(oahu2016$SST)
oahu2016.high = subset(oahu2016, SST>28, select = c(mo, dy, SST))
oahu2016.high

#2017
setwd("/Users/valerieschmidt/Desktop/Fall 2017 Semester/Spring 2018 Semester/Hawaii 2018:BIOS 2018/RAnalysis/Data")
getwd()
oahu2017 = read.table("2017oahu.txt")
colnames(oahu2017) = c('yr', 'mo', 'dy', 'hr', 'mn', 'degT', 'm/s',  'm/s', 'm', 'sec', 'sec', 'degT', 'hPa', 'degC', 'SST', 'degC', 'mi', 'ft')
min(oahu2017$SST)
max(oahu2017$SST)
oahu2017.high = subset(oahu2017, SST>28, select = c(mo, dy, SST))
oahu2017.high

###
oahu2012v = merge(min(oahu2012$SST),max(oahu2012$SST))
oahu2013v = merge(min(oahu2013$SST),max(oahu2013$SST))
oahu2014v = merge(min(oahu2014$SST),max(oahu2014$SST))
oahu2015v = merge(min(oahu2015$SST),max(oahu2015$SST))
oahu2016v = merge(min(oahu2016$SST),max(oahu2016$SST))
oahu2017v = merge(min(oahu2017$SST),max(oahu2017$SST))

temp.data = Reduce(function(x, y) merge(x, y, all=TRUE), list(oahu2012v, oahu2013v, oahu2014v,oahu2015v,oahu2016v,oahu2017v))
colnames(temp.data) = c('min', 'max')
rownames(temp.data) = c('2012','2013','2014','2015','2016','2017')
temp.data

#Loop version
path <- ('/Users/valerieschmidt/Desktop/Fall 2017 Semester/Spring 2018 Semester/Hawaii 2018:BIOS 2018/RAnalysis/Data')
file.n<-list.files(path = path, pattern= "*.txt") #list all the file names in the folder to get only get the csv files
file.n

for(i in 1:length(file.n)) { # for every file in list start at the first and run this following function
  Temp.Data <-read.table(file.path(path,file.n[i]), header=TRUE, sep=",", na.string="NA", as.is=TRUE) #reads in the data files
}
