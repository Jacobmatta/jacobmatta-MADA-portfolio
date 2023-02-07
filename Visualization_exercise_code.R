#loading packages 
library(here) #to set paths
library(readr) #for loading csv files
library(ggplot2)

#uploading data 
data_location <- here::here("data","raptor_by_nba_player.csv")
rawdata <- readr::read_csv(data_location)

#examining data
head(rawdata)
str(rawdata) #used to see how data is structured 

#extracting only players in the 2022 season 
rawdata_2022 <- rawdata[rawdata$season == '2022', ]

#removing all columns but defensive RAPTOR and offensive RAPTOR
#keeping column numbers 1,3,12,13 = player name, year, defensive raptor and offensive raptor
clean_data <- rawdata_2022[ -c(2,4:11, 14:21) ]

#making ggplot scatterplot to match professional scatterplot 
ggplot(rawdata_2022, aes(x=clean_data$raptor_offense, y=clean_data$raptor_defense)) +
  geom_point() + xlim(-10,10) + ylim(-10,10)

