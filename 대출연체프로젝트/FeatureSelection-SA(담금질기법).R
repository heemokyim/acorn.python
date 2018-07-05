setwd("C:\\Users\\acorn\\Downloads\\select")



df<-read.csv("train_1.csv", header = T)

na.omit(df)

summary(df)

sum(is.na(df))

df <- df[complete.cases(df[ , c(22,53)]), ]

library(dplyr)

library(caret)


#Simulated Annealing (담금질기법)을 활용한 변수선택
sa_ctrl<-safsControl(functions = rfSA,
                     method = "repeatedcv",
                     repeats = 5)

install.packages("randomForest")
library(randomForest)

lev<-c(0,1)
set.seed(1234)
model_l<-safs(x= df[-c(1,2)], y= df$TARGET,
              iter=2,levels = lev,
              safsControl = sa_ctrl)
model_l
