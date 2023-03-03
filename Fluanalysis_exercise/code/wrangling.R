#library
library(tidyr)
library(tidyselect)
library(dplyr)

#reading in the RDS file 
setwd("~/Documents/R/jacobmatta-MADA-portfolio")
list.files()
rawdata = readRDS("~/Documents/R/jacobmatta-MADA-portfolio/Fluanalysis_exercise/rawdata/SympAct_Any_Pos.Rda") 

#Remove all variables that have Score or Total or FluA or FluB or Dxname or Activity in their name
rawdata2 = rawdata[,!names(rawdata) %in% -c("Score", "Total", "FluA", "FluB", "Dxname", "Activity")]
rawdata2 = subset(rawdata, select = -c("Score", "Total", "FluA", "FluB", "Dxname", "Activity"))
rawdata2 = select(rawdata, - c("Score", "Total", "FluA", "FluB", "Dxname", "Activity"))