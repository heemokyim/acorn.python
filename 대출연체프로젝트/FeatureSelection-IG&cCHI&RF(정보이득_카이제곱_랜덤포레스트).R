install.packages("FSelector")
library(FSelector)
install.packages("Boruta")
library(Boruta)
setwd("C:\\Users\\acorn\\Downloads\\select")



df<-read.csv("train_1.csv", header = T)

na.omit(df)

summary(df)

sum(is.na(df))

df <- df[complete.cases(df[ , c(22,53)]), ]
df<-df[,-1]
df$TARGET<-as.factor(df$TARGET)



# FSelector가 제공하는 각종 function을 사용하여 각 feature의 가중치를 구한다.
#정보이득을 활용한 변수선택
weights <- information.gain(TARGET~., df)
print(weights)

# highest rank weight를 갖는 feature 5개로 subset 구성
subset <- cutoff.k(weights, 10)

# subset의 feature들과 예측변수 Class로 구성된 formula로 최종 모델을 출력한다.
f <- as.simple.formula(subset, "df$TARGET")
print(f)




#카이제곱을 활용한 변수선택
weights1 <- chi.squared(TARGET~., df)
print(weights1)

# highest rank weight를 갖는 feature 5개로 subset 구성
subset1 <- cutoff.k(weights1, 10)

# subset의 feature들과 예측변수 Class로 구성된 formula로 최종 모델을 출력한다.
f1 <- as.simple.formula(subset1, "df$TARGET")
print(f1)





weights2 <- random.forest.importance(TARGET~., df,importance.type = 1)
print(weights2)

# highest rank weight를 갖는 feature 5개로 subset 구성
subset2 <- cutoff.k(weights, 10)

# subset의 feature들과 예측변수 Class로 구성된 formula로 최종 모델을 출력한다.
f2 <- as.simple.formula(subset2, "df$TARGET")
print(f2)








