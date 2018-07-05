library(caret)
setwd("C:\\Users\\acorn\\Downloads\\select")



df<-read.csv("train_1.csv", header = T)

na.omit(df)

summary(df)

sum(is.na(df))

df <- df[complete.cases(df[ , c(22,53)]), ]
df<-df[,-1]
df$TARGET<-as.factor(df$TARGET)


# gbm알고리즘 실행
control<-trainControl(method="repeatedcv", number=10, repeats=3)
install.packages("e1071")
library(e1071)
model <-train(TARGET~.,data=df,method="gbm",
              preProcess="scale",trControl=control) 
library(gbm)
importance<-varImp(model, scale=FALSE)
print(importance)

#pls알고리즘 실행
install.packages("pls")
library(pls)
control1<-trainControl(method="repeatedcv", number=10, repeats=3)
install.packages("e1071")
library(e1071)
model1 <-train(TARGET~.,data=df,method="pls",
              preProcess="scale",trControl=control1) 
importance1<-varImp(model1, scale=FALSE)
print(importance)


# 랜덤포레스트 -rpart를 이용한 알고리즘 실행 

library(rpart)

m<-rpart(TARGET~.,data=df)
varImp(m)

