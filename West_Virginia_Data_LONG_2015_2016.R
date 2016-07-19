#################################################################################
###
### Script for preparation of 2015_2016 LONG data for SGP analysis
###
#################################################################################

### Load packages

require(data.table)
require(SGP)


### Load Data

West_Virginia_Data_LONG_2015_2016 <- fread("Data/Base_Files/2015_growth_wv.txt", colClasses=rep("character", 29))
setnames(West_Virginia_Data_LONG_2015_2016, toupper(names(West_Virginia_Data_LONG_2015_2016)))

### Tidy up data

West_Virginia_Data_LONG_2015_2016[,SYEAR:="2015"]
West_Virginia_Data_LONG_2015_2016[STYP=="C", STYP:="A"]
West_Virginia_Data_LONG_2015_2016[,STYP:=factor(STYP, labels=c("Not Applicable", "Elementary", "Middle", "Secondary"))]
West_Virginia_Data_LONG_2015_2016[,SCLS:=as.character(as.numeric(SCLS))]
West_Virginia_Data_LONG_2015_2016[,SRACE:=factor(SRACE, labels=c("Asian", "Black", "Hispanic", "American Indian", "Multi-Racial", "Pacific Islander", "White"))]
West_Virginia_Data_LONG_2015_2016[,SLEP1:=factor(SLEP1, labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2015_2016[,SSPED:=factor(SSPED, labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2015_2016[,SDISA:=NULL] ### Doesn't contain many students as identified with a disability with completely different labels as previously so eliminating since not critical
West_Virginia_Data_LONG_2015_2016[,SLSES1:=factor(SLSES1, labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2015_2016[,SSEX:=factor(NA, levels=1:2, labels=c("Female", "Male"))]
#West_Virginia_Data_LONG_2015_2016[,SSEX:=factor(SSEX, labels=c("Female", "Male"))]
West_Virginia_Data_LONG_2015_2016[,SMIG:=NULL] ### Doesn't contain any info
West_Virginia_Data_LONG_2015_2016[,SSCHA:=factor('Y', levels=c('N', 'Y'), labels=c("Enrolled School: No", "Enrolled School: Yes"))]
West_Virginia_Data_LONG_2015_2016[,SCTYA:=factor('Y', levels=c('N', 'Y'), labels=c("Enrolled District: No", "Enrolled District: Yes"))]
West_Virginia_Data_LONG_2015_2016[,SSTAA:=factor('Y', levels=c('N', 'Y'), labels=c("Enrolled State: No", "Enrolled State: Yes"))]
West_Virginia_Data_LONG_2015_2016[,FORM_TYPE:=factor(FORM_TYPE)]
West_Virginia_Data_LONG_2015_2016[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
West_Virginia_Data_LONG_2015_2016[SCALE_SCORE==0,SCALE_SCORE:=as.numeric(NA)]
West_Virginia_Data_LONG_2015_2016[PLEVEL=="",PLEVEL:=as.character(NA)]
West_Virginia_Data_LONG_2015_2016[!is.na(PLEVEL), PLEVEL:=paste("Level", PLEVEL)]
West_Virginia_Data_LONG_2015_2016[,NAME:=factor(NAME)]
levels(West_Virginia_Data_LONG_2015_2016$NAME) <- sapply(levels(West_Virginia_Data_LONG_2015_2016$NAME), capwords)
West_Virginia_Data_LONG_2015_2016[,COUNTYNAME:=factor(COUNTYNAME)]
levels(West_Virginia_Data_LONG_2015_2016$COUNTYNAME) <- sapply(levels(West_Virginia_Data_LONG_2015_2016$COUNTYNAME), capwords)
West_Virginia_Data_LONG_2015_2016[,WSFNAM:=factor(WSFNAM)]
levels(West_Virginia_Data_LONG_2015_2016$WSFNAM) <- sapply(levels(West_Virginia_Data_LONG_2015_2016$WSFNAM), capwords)
West_Virginia_Data_LONG_2015_2016[WSLNAM=="",WSLNAM:=as.character(NA)]
West_Virginia_Data_LONG_2015_2016[,WSLNAM:=factor(WSLNAM)]
levels(West_Virginia_Data_LONG_2015_2016$WSLNAM) <- sapply(levels(West_Virginia_Data_LONG_2015_2016$WSLNAM), capwords)
West_Virginia_Data_LONG_2015_2016[,MREC:=NULL]
West_Virginia_Data_LONG_2015_2016[,YEAR_LONG:="2015_2016"]
West_Virginia_Data_LONG_2015_2016[,VREC:=as.integer(VREC)]
West_Virginia_Data_LONG_2015_2016[,VALID_CASE:="VALID_CASE"]
West_Virginia_Data_LONG_2015_2016[,GIFTED:=NULL]
West_Virginia_Data_LONG_2015_2016[,SSEX:=NULL]
West_Virginia_Data_LONG_2015_2016[,IRECORD:=NULL]

West_Virginia_Data_LONG_2015_2016[,SCHOOL_NUMBER:=paste(SDIS, SSCH, sep="")]

setkeyv(West_Virginia_Data_LONG_2015_2016, c("VALID_CASE", "SUBJECT", "SYEAR", "SSTU", "SCLS", "SCALE_SCORE"))
setkeyv(West_Virginia_Data_LONG_2015_2016, c("VALID_CASE", "SUBJECT", "SYEAR", "SSTU"))
West_Virginia_Data_LONG_2015_2016[["VALID_CASE"]][which(duplicated(West_Virginia_Data_LONG_2015_2016))-1] <- "INVALID_CASE"
West_Virginia_Data_LONG_2015_2016 <- West_Virginia_Data_LONG_2015_2016[VALID_CASE!="INVALID_CASE"]


### Save results

save(West_Virginia_Data_LONG_2015_2016, file="Data/West_Virginia_Data_LONG_2015_2016.Rdata")
