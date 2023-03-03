#library 
library(tidyverse)
library(ggplot2)
library(Hmisc) #needed for the describe() function
library(dplyr)


#Start with summary statistics for the body temperature because it is the only 
#continuous variable 
bodytemp_summary = summary(rawdata3$BodyTemp)


#getting a visual of the distribution of body temp
Bodytemp_plot = ggplot(rawdata3,aes(x=BodyTemp)) +
  geom_density(color="darkblue", fill="lightblue")
Bodytemp_plot
bodytemp_summary
#there is a skew to the right with a mean at 98.94 

#summary statistics for binary (yes or no) predictor variables: Nausea, Swollen lymph nodes and insomia 
#I chose to use the describe function because it provides count (n), and the frequency and proportion of response
nausea_summary = describe(rawdata3$Nausea)
lymph_summary = describe(rawdata3$SwollenLymphNodes)
insomnia_summary = describe(rawdata3$Insomnia)

#checking out the summaries of the binary predictor variables 
nausea_summary
lymph_summary
insomnia_summary

#All three binary variables appear to be pretty split, with no overwhelming majority 
#It is important to note that the majority of responses to the nausea question were no (65.1%)
#Also, the majority of the responses to the swollen lymph nodes question was no (57.3%)
#It was interesting to see that the majority of response to the insomnia question was yes (56.8%)

