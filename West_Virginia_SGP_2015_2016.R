#####################################################################################
###
### West Virginia analyses for 2015-2016
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
	sgp.percentiles=TRUE,
	sgp.projections=TRUE,
	sgp.projections.lagged=TRUE,
	sgp.percentiles.baseline=FALSE,
	sgp.projections.baseline=FALSE,
	sgp.projections.lagged.baseline=FALSE,
	sgp.target.scale.scores=TRUE,
	sgPlot.demo.report=TRUE,
	parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2, PROJECTIONS=2, BASELINE_PERCENTILES=2, LAGGED_PROJECTIONS=2, SGP_SCALE_SCORE_TARGETS=2, SUMMARY=2, GA_PLOTS=2, SG_PLOTS=1)))


### Save results

#save(West_Virginia_SGP, file="Data/West_Virginia_SGP.Rdata")
