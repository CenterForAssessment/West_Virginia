#####################################################################################
###
### West Virginia analyses for 2014-2015
###
#####################################################################################

### Load SGP Package

require(SGP)
options(error=recover)


### Load data

load("Data/West_Virginia_SGP.Rdata")
load("Data/West_Virginia_Data_LONG_2015_2016.Rdata")


### updateSGP

West_Virginia_SGP <- updateSGP(
	West_Virginia_SGP, 
	West_Virginia_Data_LONG_2015_2016,
	sgp.target.scale.scores=TRUE,
	sgPlot.demo.report=TRUE,
	fix.duplicates="KEEP.ALL",
	parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=8, PROJECTIONS=8, BASELINE_PERCENTILES=8, LAGGED_PROJECTIONS=8, SGP_SCALE_SCORE_TARGETS=4, SUMMARY=24, GA_PLOTS=2, SG_PLOTS=1)))


### Save results

save(West_Virginia_SGP, file="Data/West_Virginia_SGP.Rdata")
