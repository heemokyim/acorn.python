install.packages("Boruta")
library(Boruta)
setwd("C:\\Users\\acorn\\Downloads\\select")



df<-read.csv("train_1.csv", header = T)

na.omit(df)

summary(df)

sum(is.na(df))

df <- df[complete.cases(df[ , c(22,53)]), ]
df<-df[,-1]



#랜덤포레스트 패키지를 활용한 변수선택
library(randomForest)
str(df)
df$TARGET<-as.factor(df$TARGET)
result<-randomForest(TARGET~., importance=TRUE,data=df)
install.packages("varlmpPlot")
varImpPlot(result)
