#loading packages 
library(here) #to set paths
library(readr) #for loading csv files
library(ggplot2)
library(plotly)

#uploading data 
data_location <- here::here("data","raptor_by_nba_player.csv")
rawdata <- readr::read_csv(data_location)

#examining data
head(rawdata)
str(rawdata) #used to see how data is structured 

#extracting only players in the 2022 season 
rawdata_2022 <- rawdata[rawdata$season == '2022', ]

#the fivethirtyeight scatter plot is only keeping players who have played 1042 minutes or more
#removing players who have played less than 1042 minutes 
clean_data <- rawdata_2022[rawdata_2022$mp > 1042,]

#making ggplot scatterplot to match professional scatterplot 
#shape controls dot shape
#fill adds white filling to dot 
#size controls the size of the dot 
#the stroke controls the stroke of the black outline 
g1 <- ggplot(clean_data, aes(x=raptor_offense, y=raptor_defense)) +
  geom_rect(aes(xmin=-10,xmax=0,ymin=-10,ymax=0),fill="pink",alpha=0.01) +
  geom_rect(aes(xmin=0,xmax=10,ymin=0,ymax=10),fill='turquoise',alpha=0.01) +
  labs(x = "Offensive RAPTOR rating", y = "Defensive RAPTOR rating")

g2 <- g1 + geom_point(shape = 21, colour = "black", fill = "white", size = 4, stroke = 1 ) + xlim(-10,10) + ylim(-10,10)

g3 <- g2 + theme(panel.grid.minor = element_blank()) +  annotate(geom="label", x=-9,y=10,label="- offensive", fill="pink") +
  annotate(geom="label", x=-9,y=8,label="+ defensive", fill='turquoise') +
  annotate(geom="label", x=-9,y=-10,label="- defensive", fill='pink') +
  annotate(geom="label", x=-9,y=-8,label="- offensive", fill='pink') + 
  annotate(geom="label", x=9,y=10,label="+ offensive", fill='turquoise') +
  annotate(geom="label", x=9,y=8,label="+ defensive", fill='turquoise') +
  annotate(geom="label", x=9,y=-8,label="+ offensive", fill='turquoise') +
  annotate(geom="label", x=9,y=-10,label="- defensive", fill='pink')
g3

#with changes 
g3 <- g2 + theme(panel.background=element_rect(fill="#FFFFFF"),  
                 panel.grid.major=element_line(color="lightgrey"),
                 axis.ticks=element_blank ( ), panel.grid.minor = element_blank()) +
  
  annotate(geom="label", x=-7.5,y=9,label="- offensive", fill="pink", size = 3) +
  annotate(geom="label", x=-7.5,y=7.5,label="+ defensive", fill='turquoise', size = 3) +
  annotate(geom="label", x=-7.5,y=-9,label="- defensive", fill='pink', size = 3) +
  annotate(geom="label", x=-7.5,y=-7.5,label="- offensive", fill='pink', size = 3) + 
  annotate(geom="label", x=7.5,y=9,label="+ offensive", fill='turquoise', size = 3) +
  annotate(geom="label", x=7.5,y=7.5,label="+ defensive", fill='turquoise', size = 3) +
  annotate(geom="label", x=9,y=-8,label="+ offensive", fill='turquoise', size = 3) +
  annotate(geom="label", x=9,y=-10,label="- defensive", fill='pink', size = 3)

g3



