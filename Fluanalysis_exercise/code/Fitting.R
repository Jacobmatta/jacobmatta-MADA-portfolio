#library 
library(dplyr)
library(here)

#loading clean data
location = here("Fluanalysis_exercise", "data", "cleandata", "cleandata.RDS")
clean_data = readRDS(location)

#Fitting main predictor of interest to outcome to simple linear regression model
lm1 = lm(formula = BodyTemp ~ SwollenLymphNodes, data = clean_data)

#Fitting bodytemp with all predictors of interest 
lm2 = lm(formula = BodyTemp ~ SwollenLymphNodes + Insomnia + Nausea, data = clean_data)

#comparing the results from simple linear regression between body weight and swollen lymph nodes 
#to multiple linear regression between body weight and Swollen Lymph Nodes + Insomnia + Nausea
coef(lm1)
coef(lm2)
#It appears that the coefficent for the slope between body weight and Swollen Lymph Nodes becomes 
#more negative when going from the linear regression model to the multiple linear regression model 

#fit log regression Nausea(outcome) vs Swollen Lymph Nodes

#fit multile log regression for all redictors of interst 
