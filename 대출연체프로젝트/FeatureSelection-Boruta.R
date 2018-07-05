install.packages("Boruta")
library(Boruta)
setwd("C:\\Users\\acorn\\Downloads\\select")



df<-read.csv("train_1.csv", header = T)

na.omit(df)

summary(df)

sum(is.na(df))

df <- df[complete.cases(df[ , c(22,53)]), ]
df<-df[,-1]
str(df)


#알고리즘 실행
set.seed(27)
bor_1 <- Boruta(TARGET ~ ., data = df)
bor_1
