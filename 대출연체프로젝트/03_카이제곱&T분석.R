#-------------------카이제곱&T분석------------------------------------------
#카이제곱
TRAIN$TARGET <- as.factor(TRAIN$TARGET)

library(gmodels)
CrossTable(x=TRAIN$TARGET,y=TRAIN$PAYM_METD,chisq=T)
# Chi^2 =  414.9368     d.f. =  4     p =  1.646885e-88  # 차이 있음

a <- chisq.test(x=TRAIN$TARGET,y=TRAIN$PAYM_METD)
# X-squared = 414.94, df = 4, p-value < 2.2e-16  # 차이 있다고 할 수 있음
table(x=TRAIN$TARGET,y=TRAIN$PAYM_METD)

#T분석
a <- subset(TRAIN,TARGET==0)
b <- subset(TRAIN,TARGET==1)
a1 <- a$AVG_CALL_TIME
b1 <- b$AVG_CALL_TIME

var.test(a1,b1)
# p-value = 0.1014 집단간의 분포형태가 동질함.  (동질성검사)

#동질하지 않다면, wilcox.test()이다.
wilcox.test(a1,b1)

t.test(a1,b1,alter='two.sided',conf.int=T,conf.level = 0.95)  
# p-value = 0.26  두 집단간의 평균차이가 없다. 

t.test(a1,b1,alter='greater',conf.int=T,conf.level = 0.95) 
