#####################################################################################
###
### West Virginia analyses for 2013
###
#####################################################################################

### Load SGP Package

require(SGP)


### Load data

load("Data/West_Virginia_SGP.Rdata")
load("Data/West_Virginia_Data_LONG_2013.Rdata")


### updateSGP

West_Virginia_SGP <- updateSGP(
	West_Virginia_SGP, 
	West_Virginia_Data_LONG_2013,
	sgPlot.demo.report=TRUE,
	save.intermediate.results=TRUE,
	parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=8, PROJECTIONS=8, BASELINE_PERCENTILES=8, LAGGED_PROJECTIONS=8, SUMMARY=24, GA_PLOTS=2)))


### Save results

save(West_Virginia_SGP, file="Data/West_Virginia_SGP.Rdata")
