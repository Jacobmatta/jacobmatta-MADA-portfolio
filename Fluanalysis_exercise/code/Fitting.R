#install
install.packages("tidymodels")
install.packages("broom.mixed")


#library 
library(dplyr)
library(here)
library(tidymodels)
library(readr)
library(broom.mixed)


#loading clean data
location = here("Fluanalysis_exercise", "data", "cleandata", "cleandata.RDS")
clean_data = readRDS(location)

#Fitting main predictor of interest to outcome to simple linear regression model
#following the tidymodels procedure for linear regression https://www.tidymodels.org/start/models/
linear_reg() %>% 
  set_engine("lm")
lm_mod = linear_reg()

lm_fit = lm_mod %>% 
  fit(BodyTemp ~ RunnyNose, data = clean_data )
lm_fit


#Fitting bodytemp with all predictors of interest 
linear_reg() %>% 
  set_engine("lm")
lm_mod2 = linear_reg()
lm_fit2 = lm_mod %>% 
  fit(formula = BodyTemp ~ RunnyNose + Insomnia + Nausea + SwollenLymphNodes, data = clean_data)
lm_fit2

#comparing the results from simple linear regression between body weight and swollen lymph nodes 
#to multiple linear regression between body weight and Swollen Lymph Nodes + Insomnia + Nausea
tidy(lm_fit)
tidy(lm_fit2)

#fit logistic regression Nausea(outcome) vs Swollen Lymph Nodes
logistic_reg() %>% 
  set_engine("glm")
glm_mod = logistic_reg()
glm_fit = glm_mod %>% 
  fit(formula = Nausea ~ RunnyNose, data = clean_data)
glm_fit

#fit multiple log regression for all predictors of interest 
logistic_reg() %>% 
  set_engine("glm")
glm_mod = logistic_reg()
glm_fit2 = glm_mod %>% 
  fit(formula = Nausea ~ RunnyNose + SwollenLymphNodes + Insomnia, data = clean_data, family = binomial)
glm_fit2
#comparing the two logistic models 
tidy(glm_fit)
tidy(glm_fit2)



