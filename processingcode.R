###############################
# processing script
#
#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed_data folder
#
# Note the ## ---- name ---- notation
# This is done so one can pull in the chunks of code into the Quarto document

## ---- packages --------
#load needed packages. make sure they are installed.
library(readr) #for loading csv files
library(dplyr) #for data processing/cleaning
library(tidyr) #for data processing/cleaning
library(stats) #used for cleaning 
library(here) #to set paths

## ---- loaddata --------
#path to data
#note the use of the here() package and not absolute paths
#notice here::here is to indicate package::function()
data_location <- here::here("dataanalysis-exercise", "data","raw data",
                            "CDC_COVID_State_Funding.csv")

#loading data 
rawdata <- readr::read_csv(data_location)

## ---- exploredata --------
#take a look at the data
dplyr::glimpse(rawdata)
summary(rawdata)
head(rawdata)
skimr::skim(rawdata)

## ---- cleandata1 --------
#the only variable that appears to have a lot of missing values is Sub-jurisdiction.
#I am going to extract the observations that have a sub-jurisdiction. 
df1 <- stats::na.omit(rawdata)

## ---- cleandata2 --------
#there are some funding amounts that are $0.
#I am only interested in funding that is over $0.
#to clean this up I will remove all the rows containing $0.
df2 <- 
