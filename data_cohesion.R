library(tidyverse)
library(dplyr)
library(readxl)
library(glmnet)
library(reshape2)
library(ggplot2)
library(rpart)

# reads in dataset pertaining to Californian power plants
power_plant_dataset <- read.csv("California_Power_Plants.csv", header = TRUE, row.names=NULL)
#check if we read in the data properly
head(power_plant_dataset)
#check the class of the dataset columns
sapply(power_plant_dataset, class)
#changing column names from X and Y to Longitude and Latitude respectively
colnames(power_plant_dataset)[1] <- "Longitude"
colnames(power_plant_dataset)[2] <- "Latitude"



#reads in power monthly
power_dataset <- read.csv("POWER_Regional_Monthly_2000_2020.csv", header = TRUE, row.names=NULL, skip = 10)
#check if we read in the data properly
head(power_dataset)
#changing column names from LAT and LONG to Latitude and Longitude  respectively
colnames(power_dataset)[4] <- "Longitude"
colnames(power_dataset)[3] <- "Latitude"


# reads in solar radiation data
solar_radiation_dataset <- read.csv("Solar_Radiation_Data.csv", header = TRUE, row.names=NULL)
#check if we read in the data properly
head(solar_radiation_dataset)
#changing column names from lat and lon to Latitude and Longitude respectively
colnames(solar_radiation_dataset)[3] <- "Longitude"
colnames(solar_radiation_dataset)[2] <- "Latitude"

#binding power plant dataset and monthly power dataset by longitude and latitude

df2 <- power_plant_dataset %>% merge( power_dataset,
                                           by=c('Longitude','Latitude'))
