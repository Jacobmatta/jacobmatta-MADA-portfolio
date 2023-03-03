install.packages(dplyr)
#library
library(tidyr)
library(tidyselect)
library(dplyr)
library(here)

#reading in the RDS file 
setwd("~/Documents/R/jacobmatta-MADA-portfolio")
list.files()
rawdata = readRDS("~/Documents/R/jacobmatta-MADA-portfolio/Fluanalysis_exercise/data/rawdata/SympAct_Any_Pos.Rda") 

#Remove all variables that have Score or Total or FluA or FluB or Dxname or Activity in their name
#the pipe operator (%>%) allows us to do this in neat fashion while using the contains function
#the negatice sign (-) in front of contains indicates the name inside the parenthesis will be dropped 
#from any variable that has that name 
rawdata2 = rawdata %>% select(-contains("Score")) %>% 
            select(-contains("Total")) %>% 
            select(-contains("FluA")) %>% 
            select(-contains("FluB")) %>%
            select(-contains("Dxname")) %>%
            select(-contains("Activity")) %>%
            select(-contains("Unique.Visit"))

#removing an NA values 
rawdata3 = na.omit(rawdata2)

#saving data as an RDS file in the cleandata folder as "cleandata.RDS"
#used the here function to set the location to where I want to save the file 
location = here("Fluanalysis_exercise", "data", "cleandata", "cleandata.RDS")
saveRDS(rawdata3, file = location)






