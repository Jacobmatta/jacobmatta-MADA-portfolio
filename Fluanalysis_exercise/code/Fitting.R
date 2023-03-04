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
  set_engine("lm") #setting the engine to "lm" for linear regression 

lm_mod = linear_reg()

lm_fit = lm_mod %>% 
  fit(BodyTemp ~ RunnyNose, data = clean_data ) #here bodytemp is the continuous outcome while RunnyNose is the binary predictor variable 
lm_fit = tidy(lm_fit) #using tidy to produce a tibble for the results of the model fitting 


#Fitting bodytemp with all predictors of interest 
linear_reg() %>% 
  set_engine("lm")

lm_mod2 = linear_reg()

lm_fit2 = lm_mod %>% 
  fit(formula = BodyTemp ~ RunnyNose + Insomnia + Nausea + SwollenLymphNodes, data = clean_data) #Setting body temp as the continuous outcome with multiple predictors

lm_fit2= tidy(lm_fit2)

#comparing the results from simple linear regression between body weight and swollen lymph nodes 
#to multiple linear regression between body weight and Swollen Lymph Nodes + Insomnia + Nausea
lm_fit 
lm_fit2

#fit logistic regression Nausea(outcome) vs Swollen Lymph Nodes
logistic_reg() %>% 
  set_engine("glm") #setting the engine to "glm" for "general linear model"
glm_mod = logistic_reg() #
glm_fit = glm_mod %>% 
  fit(formula = Nausea ~ RunnyNose, data = clean_data) 
glm_fit = tidy(glm_fit)

# multiple log regression for all predictors of interest 
logistic_reg() %>% 
  set_engine("glm")
glm_mod = logistic_reg()
glm_fit2 = glm_mod %>% 
  fit(formula = Nausea ~ RunnyNose + SwollenLymphNodes + Insomnia, data = clean_data, family = binomial)
glm_fit2 = tidy(glm_fit2)

#comparing the two logistic models 
glm_fit
glm_fit2





