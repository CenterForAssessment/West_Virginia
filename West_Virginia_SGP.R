#####################################################################################
###
### Code to update West Virginia SGP object
###
#####################################################################################

### Load SGP package

require(SGP)


### Load Data

load("Data/West_Virginia_SGP.Rdata")
load("Data/West_Virginia_Data_LONG.Rdata")


### prepareSGP

West_Virginia_SGP <- prepareSGP(West_Virginia_Data_LONG)


### analyzeSGP

West_Virginia_SGP <- analyzeSGP(
        West_Virginia_SGP,
	years="2011_2012",
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE,
        sgp.projections.lagged.baseline = TRUE,
        simulate.sgps=FALSE)


### combineSGP

West_Virginia_SGP <- combineSGP(West_Virginia_SGP, years="2011_2012")


### summarizeSGP

West_Virginia_SGP <- summarizeSGP(West_Virginia_SGP)
