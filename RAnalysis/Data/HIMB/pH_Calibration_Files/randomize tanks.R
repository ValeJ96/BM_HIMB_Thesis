#Coral Larval Biomineralization
#Code used to randomize the large tank treatments on 20180604
rm(list=ls())
generate.random = rep(10:15, each =1)
ambient = sample(generate.random,2)
generate.random = setdiff(generate.random, ambient)
low = sample(generate.random,2)
generate.random = setdiff(generate.random, low)
extra.low = sample(generate.random,2)

### Vale's project rand.
#tubs
rm(list=ls())
generate.random = rep(1:24, each =1)
treat.1 = sample(generate.random,8)
treat.1
#treat.1 = c(22,10,13,3,16,12,14,2)
generate.random = setdiff(generate.random, treat.1)
treat.2 = sample(generate.random,8)
#treat.2 = c(1,11,9,7,8,19,15,17)
treat.3 = setdiff(generate.random, treat.2)
#treat.3 = c(4,5,6,18,20,21,23,24)

###JKJK

treat.1.day = rep(1:8, each=1)
#ambient = sample(treat.1.day,4)
ambient = c(5,7,8,2)
#hot = setdiff(treat.1.day,ambient)
hot = c(1,3,4,6)

treat.3.day = rep(9:16, each=1)
#ambient = sample(treat.3.day,4)
ambient = c(9,15,10,13)
#hot = setdiff(treat.3.day,ambient)
hot = c(11,12,14,16)

treat.5.day = rep(17:24, each=1)
#ambient = sample(treat.5.day,4)
ambient = c(20,19,23,18)
#hot = setdiff(treat.3.day,ambient)
hot = c(17,21,22,24)

#tanks
ambient
tank1 = sample(ambient,2)
#24hr exposure tank1 = c(5,8)
#3rd day exposure tank1 = c(5,8)
#5th day exposure tank1 = c(5,8)
tank2 = setdiff(ambient, tank1)
tank2

hot
tank3 = sample(hot,2)
#24hr exposure tank3 = c(6,1)
#3rd day exposure tank3 = c(5,8)
#5th day exposure tank3 = c(5,8)
tank4 = setdiff(hot, tank3)
tank4
