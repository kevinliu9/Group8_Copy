rm(list=ls())   
library(tidyverse)
library(dplyr)
library(readxl)
library(glmnet)
library(reshape2)
library(ggplot2)
library(rpart)
library(Hmisc)
library(plotmo)
library("readxl")
library(reshape)
library(caret)
library(corrplot)
library(readr)

# Cluster analysis code written with assistance from Kevin Liu and Ajeet Parmar

earn <- read.csv("data_merged.csv")

df_init <- earn %>%
  select_if(is.numeric)

lat = list()
for (x in 1:1000)
{
  y <- sample(1:length(earn$Latitude), 1)
  lat <- append(lat, earn$Latitude[y])
}

barplot(table(unlist(lat)), las=2, cex.names=.5, 
        ylab ="Frequency", xlab ="Latitude Values",
        main = "Frequency of Randomly Selected 1000 Latitude Values")

long = list()
for (x in 1:1000)
{
  y <- sample(1:length(earn$Longitude), 1)
  long <- append(long, earn$Longitude[y])
}

barplot(table(unlist(long)), las=2, cex.names=.5, 
        ylab ="Frequency", xlab ="Longitude Values",
        main = "Frequency of Randomly Selected 1000 Longitude Values")

cor(earn$pm2.5, earn$AOD_55)

# select variables v1, v2, v3
myvarsabc <- c("Latitude", "Longitude", "ALLSKY_SFC_SW_DWN")
newdataabc <- df_init[myvarsabc]

long = list()
for (x in 1:1000)
{
  y <- sample(1:length(newdataabc$Longitude), 1)
  long <- append(long, newdataabc$Longitude[y])
}
long <- unlist(long)

lat = list()
for (x in 1:1000)
{
  y <- sample(1:length(newdataabc$Latitude), 1)
  lat <- append(lat, newdataabc$Latitude[y])
}
lat <- unlist(lat)

sun = list()
for (x in 1:1000)
{
  y <- sample(1:length(newdataabc$ALLSKY_SFC_SW_DWN), 1)
  sun <- append(sun, newdataabc$ALLSKY_SFC_SW_DWN[y])
}
summary(sun)
sun <- unlist(sun)

subsetdata = data.frame(sun, long, lat)

# All data applies to Continental United States
# We used 1000 samples from the dataset.

# Northeast data
subsetdata1 <- subsetdata[subsetdata$lat >= 37.816667 & subsetdata$long >= -80.5 & subsetdata$lat < 47.533333 & subsetdata$long < -66.666667,]
boxplot(subsetdata1$sun, main = "Boxplot of All Sky Surface Shortwave Downward Irradiance", ylab = "Irradiance (Wh/m^2)", xlab = "Northeast Region")
print("Northeast")
summary(subsetdata1$sun)
sd(subsetdata1$sun)
d <- density(subsetdata1$sun)
plot(d, main="Distribution of AOD Values")
shapiro.test(subsetdata1$sun)
corrplot(cor(subsetdata1),        # Correlation matrix
         method = "shade", # Correlation plot method
         mar=c(0,0,2,0),
         tl.cex=0.5,
         type = "lower",    # Correlation plot style (also "upper" and "lower")
         diag = TRUE,      # If TRUE (default), adds the diagonal
         tl.col = "black", # Labels color
         bg = "white",     # Background color
         title = "Data Variables Correlation Plot",       # Main title
         col = NULL)       # Color palette

# Southeast data
subsetdata2 <- subsetdata[subsetdata$lat >= 24.333333 & subsetdata$long >= -94.583333 & subsetdata$lat < 37.816667 & subsetdata$long < -75.466667,]
boxplot(subsetdata2$sun, main = "Boxplot of All Sky Surface Shortwave Downward Irradiance", ylab = "Irradiance (Wh/m^2)", xlab = "Southeast Region")
print("Southeast")
summary(subsetdata2$sun)
sd(subsetdata2$sun)
d <- density(subsetdata2$sun)
plot(d, main="Distribution of AOD Values")
shapiro.test(subsetdata2$sun)
corrplot(cor(subsetdata2),        # Correlation matrix
         method = "shade", # Correlation plot method
         mar=c(0,0,2,0),
         tl.cex=0.5,
         type = "lower",    # Correlation plot style (also "upper" and "lower")
         diag = TRUE,      # If TRUE (default), adds the diagonal
         tl.col = "black", # Labels color
         bg = "white",     # Background color
         title = "Data Variables Correlation Plot",       # Main title
         col = NULL)       # Color palette

# Midwest data
subsetdata3 <- subsetdata[subsetdata$lat >= 37.816667 & subsetdata$long >= -103.933333 & subsetdata$lat < 48.966667 & subsetdata$long < -80.5,]
boxplot(subsetdata3$sun, main = "Boxplot of All Sky Surface Shortwave Downward Irradiance", ylab = "Irradiance (Wh/m^2)", xlab = "Midwest Region")
print("Midwest")
summary(subsetdata3$sun)
sd(subsetdata3$sun)
d <- density(subsetdata3$sun)
plot(d, main="Distribution of AOD Values")
shapiro.test(subsetdata3$sun)
corrplot(cor(subsetdata3),        # Correlation matrix
         method = "shade", # Correlation plot method
         mar=c(0,0,2,0),
         tl.cex=0.5,
         type = "lower",    # Correlation plot style (also "upper" and "lower")
         diag = TRUE,      # If TRUE (default), adds the diagonal
         tl.col = "black", # Labels color
         bg = "white",     # Background color
         title = "Data Variables Correlation Plot",       # Main title
         col = NULL)       # Color palette

# Southwest data
subsetdata4 <- subsetdata[subsetdata$lat >= 25.7 & subsetdata$long >= -114.816667 & subsetdata$lat < 37.816667 & subsetdata$long < -94.583333,]
boxplot(subsetdata4$sun, main = "Boxplot of All Sky Surface Shortwave Downward Irradiance", ylab = "Irradiance (Wh/m^2)", xlab = "Southwest Region")
print("Southwest")
summary(subsetdata4$sun)
sd(subsetdata4$sun)
d <- density(subsetdata4$sun)
plot(d, main="Distribution of AOD Values")
shapiro.test(subsetdata4$sun)
corrplot(cor(subsetdata4),        # Correlation matrix
         method = "shade", # Correlation plot method
         mar=c(0,0,2,0),
         tl.cex=0.5,
         type = "lower",    # Correlation plot style (also "upper" and "lower")
         diag = TRUE,      # If TRUE (default), adds the diagonal
         tl.col = "black", # Labels color
         bg = "white",     # Background color
         title = "Data Variables Correlation Plot",       # Main title
         col = NULL)       # Color palette

# West 1 data
subsetdata5 <- subsetdata[subsetdata$lat >= 37.816667 & subsetdata$long >= -114.816667 & subsetdata$lat < 49 & subsetdata$long < -103.933333,]
boxplot(subsetdata5$sun, main = "Boxplot of All Sky Surface Shortwave Downward Irradiance", ylab = "Irradiance (Wh/m^2)", xlab = "West 1 Region")
print("West 1")
summary(subsetdata5$sun)
sd(subsetdata5$sun)
d <- density(subsetdata5$sun)
plot(d, main="Distribution of AOD Values")
shapiro.test(subsetdata5$sun)
corrplot(cor(subsetdata5),        # Correlation matrix
         method = "shade", # Correlation plot method
         mar=c(0,0,2,0),
         tl.cex=0.5,
         type = "lower",    # Correlation plot style (also "upper" and "lower")
         diag = TRUE,      # If TRUE (default), adds the diagonal
         tl.col = "black", # Labels color
         bg = "white",     # Background color
         title = "Data Variables Correlation Plot",       # Main title
         col = NULL)       # Color palette

# West 2 data
subsetdata6 <- subsetdata[subsetdata$lat >= 25.7 & subsetdata$long >= -124.816667 & subsetdata$lat < 49 & subsetdata$long < -114.816667,]
boxplot(subsetdata6$sun, main = "Boxplot of All Sky Surface Shortwave Downward Irradiance", ylab = "Irradiance (Wh/m^2)", xlab = "West 2 Region")
print("West 2")
summary(subsetdata6$sun)
sd(subsetdata6$sun)
d <- density(subsetdata6$sun)
plot(d, main="Distribution of AOD Values")
shapiro.test(subsetdata6$sun)
corrplot(cor(subsetdata6),        # Correlation matrix
         method = "shade", # Correlation plot method
         mar=c(0,0,2,0),
         tl.cex=0.5,
         type = "lower",    # Correlation plot style (also "upper" and "lower")
         diag = TRUE,      # If TRUE (default), adds the diagonal
         tl.col = "black", # Labels color
         bg = "white",     # Background color
         title = "Data Variables Correlation Plot",       # Main title
         col = NULL)       # Color palette