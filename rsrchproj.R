#Imports general libraries necessary to Exploratory Data Analysis
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
# reads the dataset and puts it in an R dataframe
dataset <- read.csv("data_merged.csv")
#gives the first lines of the dataset
head(dataset)
#describes general statistical information about the dataset
describe(dataset)

dt = sort(sample(nrow(dataset), nrow(dataset)*.5))

train<-dataset[dt,]
test<-dataset[-dt,]


# X_test <- data.matrix(test[, c('pm2.5', 'T2M', 'ALLSKY_SFC_LW_DWN', 'QV2M', 
#                                'CLRSKY_SFC_LW_DWN')])
X_test <- data.matrix(test[, !names(test) %in% c("AOD_55")])
y_test <- test$AOD_55

# X <- data.matrix(train[, c('pm2.5', 'T2M', 'ALLSKY_SFC_LW_DWN', 'QV2M', 
#                            'CLRSKY_SFC_LW_DWN')])
X <- data.matrix(train[, !names(test) %in% c("AOD_55")])
y <- train$AOD_55


#Lasso Regression: 
cv_model <- cv.glmnet(X, y, alpha = 1)
#find optimal lambda value that minimizes test MSE
optimal_lambda <- cv_model$lambda.min
optimal_lambda
#produce plot of test MSE by lambda value
plot(cv_model)

model <- glmnet(X, y, alpha = 1, lambda = optimal_lambda)
coef(model)

y_predicted <- predict(model, s = optimal_lambda, newx = X_test)
# R-squared value
sst <- sum((y_test - mean(y_test))^2)
sse <- sum((y_predicted - y_test)^2)
rsq <- 1 - sse/sst
rsq
# 0.4284794


# Ridge regression
cv_model <- cv.glmnet(X, y, alpha = 0)
plot(cv_model)
optimal_lambda <- cv_model$lambda.min
optimal_lambda
ridge_model <- glmnet(X, y, alpha = 0, lambda = optimal_lambda)
plot(ridge_model,xvar="lambda",label=TRUE)
coef(ridge_model)

y_predicted <- predict(ridge_model, s = optimal_lambda, newx = X_test)
# R-squared value
sst <- sum((y_test - mean(y_test))^2)
sse <- sum((y_predicted - y_test)^2)
rsq <- 1 - sse/sst
rsq
# 0.3367526

