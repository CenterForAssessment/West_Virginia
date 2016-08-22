#################################################################################
###
### Script for preparation of 2015_2016 LONG data for SGP analysis
###
#################################################################################

### Load packages

require(data.table)
require(SGP)


### Load Data

West_Virginia_Data_LONG_2015_2016 <- fread("Data/Base_Files/2016_growth_wv.txt", colClasses=rep("character", 29))
setnames(West_Virginia_Data_LONG_2015_2016, toupper(names(West_Virginia_Data_LONG_2015_2016)))

### Tidy up data

West_Virginia_Data_LONG_2015_2016[,SYEAR:="2016"]
West_Virginia_Data_LONG_2015_2016[,STYP:=factor(STYP, labels=c("Not Applicable", "Elementary", "Middle", "Secondary"))]
West_Virginia_Data_LONG_2015_2016[,SCLS:=as.character(as.numeric(SCLS))]
West_Virginia_Data_LONG_2015_2016[SRACE=="",SRACE:=as.character(NA)]
West_Virginia_Data_LONG_2015_2016[,SRACE:=factor(SRACE, labels=c("Asian", "Black", "Hispanic", "American Indian", "Multi-Racial", "Pacific Islander", "White"))]
West_Virginia_Data_LONG_2015_2016[,SLEP1:=factor(SLEP1, labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2015_2016[,SSPED:=factor(SSPED, labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2015_2016[,SDISA:=NULL] ### Doesn't contain many students as identified with a disability with completely different labels as previously so eliminating since not critical
West_Virginia_Data_LONG_2015_2016[,SLSES1:=factor(SLSES1, labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2015_2016[,SSEX:=factor(SSEX, labels=c("Female", "Male"))]
West_Virginia_Data_LONG_2015_2016[,SMIG:=factor(SMIG, levels=c('N', 'Y'), labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2015_2016[,SSCHA:=factor(SSCHA, levels=c('N', 'Y'), labels=c("Enrolled School: No", "Enrolled School: Yes"))]
West_Virginia_Data_LONG_2015_2016[,SCTYA:=factor(SCTYA, levels=c('N', 'Y'), labels=c("Enrolled District: No", "Enrolled District: Yes"))]
West_Virginia_Data_LONG_2015_2016[,SSTAA:=factor(SSTAA, levels=c('N', 'Y'), labels=c("Enrolled State: No", "Enrolled State: Yes"))]
West_Virginia_Data_LONG_2015_2016[,FORM_TYPE:=factor(FORM_TYPE)]
West_Virginia_Data_LONG_2015_2016[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
West_Virginia_Data_LONG_2015_2016[SCALE_SCORE==0,SCALE_SCORE:=as.numeric(NA)]
West_Virginia_Data_LONG_2015_2016[PLEVEL=="",PLEVEL:=as.character(NA)]
West_Virginia_Data_LONG_2015_2016[!is.na(PLEVEL), PLEVEL:=paste("Level", PLEVEL)]
West_Virginia_Data_LONG_2015_2016[NAME=="",NAME:=as.character(NA)]
West_Virginia_Data_LONG_2015_2016[,NAME:=factor(NAME)]
West_Virginia_Data_LONG_2015_2016[COUNTYNAME=="",COUNTYNAME:=as.character(NA)]
West_Virginia_Data_LONG_2015_2016[,COUNTYNAME:=factor(COUNTYNAME)]
West_Virginia_Data_LONG_2015_2016[WSFNAME=="",WSFNAME:=as.character(NA)]
West_Virginia_Data_LONG_2015_2016[,WSFNAME:=factor(WSFNAME)]
levels(West_Virginia_Data_LONG_2015_2016$WSFNAME) <- sapply(levels(West_Virginia_Data_LONG_2015_2016$WSFNAME), capwords)
West_Virginia_Data_LONG_2015_2016[WSLNAME=="",WSLNAME:=as.character(NA)]
West_Virginia_Data_LONG_2015_2016[,WSLNAME:=factor(WSLNAME)]
levels(West_Virginia_Data_LONG_2015_2016$WSLNAME) <- sapply(levels(West_Virginia_Data_LONG_2015_2016$WSLNAME), capwords)
West_Virginia_Data_LONG_2015_2016[,MREC:=NULL]
West_Virginia_Data_LONG_2015_2016[,YEAR_LONG:="2015_2016"]
West_Virginia_Data_LONG_2015_2016[,VREC:=as.integer(VREC)]
West_Virginia_Data_LONG_2015_2016[,VALID_CASE:="VALID_CASE"]
West_Virginia_Data_LONG_2015_2016[,GIFTED:=NULL]
West_Virginia_Data_LONG_2015_2016[,IRECORD:=NULL]

West_Virginia_Data_LONG_2015_2016[,SCHOOL_NUMBER:=paste(SDIS, SSCH, sep="")]


### INVALIDATE 12th GRADE scores

West_Virginia_Data_LONG_2015_2016[SCLS=="12", VALID_CASE:="INVALID_CASE"]


### Save results

setkey(West_Virginia_Data_LONG_2015_2016, VALID_CASE, SUBJECT, SYEAR, SSTU)
save(West_Virginia_Data_LONG_2015_2016, file="Data/West_Virginia_Data_LONG_2015_2016.Rdata")
