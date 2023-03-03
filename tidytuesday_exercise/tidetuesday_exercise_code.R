# Install from CRAN via: 
install.packages("tidytuesdayR")
install.packages("janitor")
#library 
library(tidytuesdayR)
library(tidyverse)
library(here)
library(Hmisc)
library(ggplot2)
library(plotly)
# Get the Data
# Either ISO-8601 date or year/week works!
age_gaps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv')

#looking at data 
glimpse(age_gaps)

########################################### 
#changing the variable names for the older and younger characters just so it's easy to remember which is which

#changing actor gender
age_gaps <- age_gaps %>% 
  rename(older_actor_gender = character_1_gender)

age_gaps <- age_gaps %>% 
  rename(younger_actor_gender = character_2_gender)


#changing actor name variable name 
age_gaps <- age_gaps %>% 
  rename(older_actor_name = actor_1_name)
age_gaps <- age_gaps %>% 
  rename(younger_actor_name = actor_2_name)
#changing birthday actor name 
age_gaps <- age_gaps %>% 
  rename(older_actor_birthdate = actor_1_birthdate)
age_gaps <- age_gaps %>% 
  rename(younger_actor_birthdate = actor_2_birthdate)
#changing actor age
age_gaps <- age_gaps %>% 
  rename(older_actor_age = actor_1_age)
age_gaps <- age_gaps %>% 
  rename(younger_actor_age = actor_2_age)

#using the describe function from the Hmisc package to see how many of the observations in the character_1_gender variable are man and woman 
describe(age_gaps$older_actor_gender)

#producing tibble with older actor variable 
freq_older_char <- age_gaps %>%
  group_by(older_actor_gender) %>%
  summarise(counts = n())
freq_older_char

#producing plot for man vs woman that play the older character 
older_plot = ggplot(freq_older_char, aes(x = older_actor_gender, y = counts)) +
  geom_bar(fill = "#0073C2FF", stat = "identity") +
  geom_text(aes(label = counts), vjust = -0.3) + ggtitle("Count of older men characters vs older women characters")
older_plot

#describing the younger_actor_gender variable: count of man and woman characters who are younger 
#producing tibble with frequencies of younger actor variable 
describe(age_gaps$younger_actor_gender)

freq_younger_char <- age_gaps %>%
  group_by(younger_actor_gender) %>%
  summarise(counts = n())
freq_younger_char

#producing plot for man vs woman that play the younger character 
younger_plot = ggplot(freq_younger_char, aes(x = younger_actor_gender, y = counts)) +
  geom_bar(fill = "red", stat = "identity") +
  geom_text(aes(label = counts), vjust = -0.3) + ggtitle("Count of younger men characters vs younger women characters")
younger_plot

#in the movies included in the data it is a more common for a male actor to play the older character when compared to women playing the older character 

#with that in mind, I am curious if there is any relationship between movies with an older man character and the release date of the movie 

#creating data set with just men who are the older character
year_vs_oldergender <- age_gaps %>% group_by(release_year, older_actor_gender)
year_vs_oldergender <-year_vs_oldergender %>% summarise(n = n())

#comparing the numbers of older men characters by year 
year_vs_oldermen = filter(year_vs_oldergender, older_actor_gender == "man")

#removing the gender column because they are all male 
year_vs_oldermen <- year_vs_oldermen[,-2]

plot_oldermen_byyear = ggplot(year_vs_oldermen, aes(x=release_year, y=n)) + 
  geom_bar(stat = "identity") + ggtitle("Count of older men characters by year")
plot_oldermen_byyear

#creating an interactive bar plot using ggplotly
interactive_plot = ggplotly(plot_oldermen_byyear)
interactive_plot

#cool, the trend of older men playing the lover in movies really started to pick up in the early to mid 90's
