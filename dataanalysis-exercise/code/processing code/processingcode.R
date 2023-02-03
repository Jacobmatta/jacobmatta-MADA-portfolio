###############################
# processing script for dataanalysis-excercise
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
library(ggplot2) #for advanced plotting

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
df2 <- df1 %>% dplyr::filter(Amount != 0)

## ---- cleandata3 --------
#I am only interested in the supplemental act name.
#the following code will remove the topical area column and the award name column.
df3 <- dplyr::select(df2,-c("Topical Area", "Award Name"))

#------------------------------------Aidan Troha's Edit--------------------------------------------
## ---- selectingdata1 ----
# First, we summarise the data based on location
# (Jurisdiction). Also, we wish to convert the "Amount"
# column to one that can be easily readable by viewers.
# We can achieve this by using the "group-by","summarise",
# and "mutate" functions.
test1 <- df3 %>%
      group_by(Jurisdiction) %>%
      summarise(Funding = sum(Amount)) %>%
      mutate(`Funding (in Millions)` = Funding/1000000)

## ---- plotting1 ---------
# We want to show the relationships between the state and
# the amount of funding received. Since there is such a disparity
# between the states with the most funding and the states with the
# least funding, I will only show the states with the highest level
# of funding.
ggplot(mapping=aes(x=Jurisdiction,y=`Funding (in Millions)`)) +
       geom_col(data=slice_max(test1,order_by=`Funding (in Millions)`,n=5),
                aes(fill=c("red","yellow","green","blue","purple"))) +
       ylim(0,max(test1$`Funding (in Millions)`)) +
       theme(legend.position="none") +
       labs(title="States with the Highest Level of Funding")

## ---- selectingdata2 ----
# As before, we summarise the data, but this time, we group
# by "Supplemental Act Name". 
test2 <- df3 %>%
  group_by(`Supplemental Act Name`) %>%
  summarise(Funding = sum(Amount)) %>%
  mutate(`Funding (in Millions)` = Funding/1000000)

## ---- plotting2 ---------
# We want to show the relationships between the cumulative amount 
# of funding donated by Supplemental Act.
ggplot(data=test2,mapping=aes(x=`Supplemental Act Name`,
                              y=`Funding (in Millions)`)) +
  geom_col(aes(fill=c("red","orange","yellow","green","blue","purple","black"))) +
  theme(legend.position="none") +
  scale_x_discrete(labels=scales::label_wrap(12)) +
  labs(title="Total Funding Awarded by Supplemental Act")
