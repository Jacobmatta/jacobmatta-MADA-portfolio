#library
library(tidyr)
library(tidyselect)
library(dplyr)
library(here)

#reading in the RDS file 
datalocation = here("Fluanalysis_exercise","data", "rawdata", "SympAct_Any_Pos.Rda")
rawdata = readRDS(datalocation)

#Remove all variables that have Score or Total or FluA or FluB or Dxname or Activity in their name
rawdata2 = rawdata %>% select(-contains("Score")) %>% 
  select(-contains("Total")) %>% 
  select(-contains("FluA")) %>% 
  select(-contains("FluB")) %>%
  select(-contains("Dxname")) %>%
  select(-contains("Activity")) %>%
  select(-contains("Unique.Visit"))

# Removing an NA values
rawdata3 = na.omit(rawdata2)

### Saving data as an RDS file
#saving data as an RDS file in the cleandata folder as "cleandata.RDS"
#used the here function to set the location to where I want to save the file 
location = here("Fluanalysis_exercise", "data", "cleandata", "cleandata.RDS")

#see if it worked
readRDS(location)