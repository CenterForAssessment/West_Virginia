#####################################################################################
###
### West Virginia analyses for 2018
###
#####################################################################################

### Load SGP Package

require(SGP)


### Load data

load("West_Virginia_Data_LONG.Rdata")


### prepareSGP

West_Virginia_SGP <- prepareSGP(West_Virginia_Data_LONG)


### analyzeSGP

West_Virginia_SGP <- analyzeSGP(
	West_Virginia_SGP,
	sgp.percentiles=TRUE,
	sgp.projections=FALSE,
	sgp.projections.lagged=FALSE,
	sgp.percentiles.baseline=FALSE,
	sgp.projections.baseline=FALSE,
	sgp.projections.lagged.baseline=FALSE)


### combineSGP

West_Virginia_SGP <- combineSGP(West_Virginia_SGP)


### outputSGP

outputSGP(West_Virginia_SGP)


### Save SGP object

save(West_Virginia_SGP, file="West_Virginia_SGP.Rdata")
