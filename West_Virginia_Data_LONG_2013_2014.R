#################################################################################
###
### Script for preparation of 2013_2014 LONG data for SGP analysis
###
#################################################################################

### Load packages

require(data.table)
require(SGP)


### Load Data

West_Virginia_Data_LONG_2013_2014 <- fread("Data/Base_Files/2014_growth_wv.txt", colClasses=rep("character", 27))
setnames(West_Virginia_Data_LONG_2013_2014, toupper(names(West_Virginia_Data_LONG_2013_2014)))

### Tidy up data

West_Virginia_Data_LONG_2013_2014[,SYEAR:="2014"]
West_Virginia_Data_LONG_2013_2014[,STYP:=factor(STYP, labels=c("Not Applicable", "Elementary", "Middle", "Secondary"))]
West_Virginia_Data_LONG_2013_2014[,SCLS:=as.character(as.numeric(SCLS))]
West_Virginia_Data_LONG_2013_2014[,SRACE:=factor(SRACE, labels=c("Asian", "Black", "Hispanic", "American Indian", "Multi-Racial", "Pacific Islander", "White"))]
West_Virginia_Data_LONG_2013_2014[,SLEP1:=factor(SLEP1, labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2013_2014[,SSPED:=factor(SSPED, labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2013_2014[,SDISA:=NULL] ### Doesn't contain many students as identified with a disability with completely different labels as previously so eliminating since not critical
West_Virginia_Data_LONG_2013_2014[,SLSES1:=factor(SLSES1, labels=c("No", "Yes"))]
West_Virginia_Data_LONG_2013_2014[,SSEX:=factor(SSEX, labels=c("Female", "Male"))]
West_Virginia_Data_LONG_2013_2014[,SMIG:=NULL] ### Doesn't contain any info
West_Virginia_Data_LONG_2013_2014[,SSCHA:=factor(SSCHA, labels=c("Enrolled School: No", "Enrolled School: Yes"))]
West_Virginia_Data_LONG_2013_2014[,SCTYA:=factor(SCTYA, labels=c("Enrolled District: No", "Enrolled District: Yes"))]
West_Virginia_Data_LONG_2013_2014[,SSTAA:=factor(SSTAA, labels=c("Enrolled State: No", "Enrolled State: Yes"))]
West_Virginia_Data_LONG_2013_2014[,FORM_TYPE:=factor(FORM_TYPE)]
West_Virginia_Data_LONG_2013_2014[FORM_TYPE=="",FORM_TYPE:=as.character(NA)]
West_Virginia_Data_LONG_2013_2014[,FORM_TYPE:=droplevels(FORM_TYPE)]
West_Virginia_Data_LONG_2013_2014[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
West_Virginia_Data_LONG_2013_2014[SCALE_SCORE==0,SCALE_SCORE:=as.numeric(NA)]
West_Virginia_Data_LONG_2013_2014[PLEVEL=="",PLEVEL:=as.character(NA)]
West_Virginia_Data_LONG_2013_2014[,PLEVEL:=factor(PLEVEL, labels=c("Novice", "Partial Mastery", "Mastery", "Above Mastery", "Distinguished"), ordered=TRUE)]
West_Virginia_Data_LONG_2013_2014[,NAME:=factor(NAME)]
West_Virginia_Data_LONG_2013_2014[,COUNTYNAME:=factor(COUNTYNAME)]
West_Virginia_Data_LONG_2013_2014[WSFNAM=="",WSFNAM:=as.character(NA)]
West_Virginia_Data_LONG_2013_2014[,WSFNAM:=factor(WSFNAM)]
levels(West_Virginia_Data_LONG_2013_2014$WSFNAM) <- sapply(levels(West_Virginia_Data_LONG_2013_2014$WSFNAM), capwords)
West_Virginia_Data_LONG_2013_2014[WSLNAM=="",WSLNAM:=as.character(NA)]
West_Virginia_Data_LONG_2013_2014[,WSLNAM:=factor(WSLNAM)]
levels(West_Virginia_Data_LONG_2013_2014$WSLNAM) <- sapply(levels(West_Virginia_Data_LONG_2013_2014$WSLNAM), capwords)
West_Virginia_Data_LONG_2013_2014[SUBJECT=="",SUBJECT:=as.character(NA)]
West_Virginia_Data_LONG_2013_2014[SUBJECT=="Reading",SUBJECT:="READING"]
West_Virginia_Data_LONG_2013_2014[,MREC:=NULL] 
West_Virginia_Data_LONG_2013_2014[,YEAR_LONG:="2013_2014"]
West_Virginia_Data_LONG_2013_2014[VREC=="2013-2014",VREC:=as.character(NA)] 
West_Virginia_Data_LONG_2013_2014[,VREC:=as.integer(VREC)] 
West_Virginia_Data_LONG_2013_2014[,VALID_CASE:="VALID_CASE"]
West_Virginia_Data_LONG_2013_2014[is.na(SUBJECT), VALID_CASE:="INVALID_CASE"]


### Save results

save(West_Virginia_Data_LONG_2013_2014, file="Data/West_Virginia_Data_LONG_2013_2014.Rdata")
