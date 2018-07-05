#------------------모델링1. 로지스틱 회귀분석------------------------------
#---------1번째 - full모형--------------------
setwd('D:\\Rdata\\challenge_data\\select2')
up.train <- read.csv('uptrain.csv',header=T)
up.train$CRLN_OVDU_RATE <- as.numeric(up.train$CRLN_OVDU_RATE)
up.train$PREM_OVDU_RATE <- as.numeric(up.train$PREM_OVDU_RATE)
up.train$AVG_CALL_TIME <- as.numeric(up.train$AVG_CALL_TIME)
up.train$AVG_CALL_FREQ <- as.numeric(up.train$AVG_CALL_FREQ)
up.train$AVG_STLN_RATE <- as.numeric(up.train$AVG_STLN_RATE)


names(up.train)
up.train <- up.train[,-41] # TEL_CNTT_QTR#제거
up.train <- na.omit(up.train)
str(up.train)
names(up.train)

## data type transformations - factoring
to.factors <- function(df, variables){
  for (variable in variables){
    df[[variable]] <- as.factor(df[[variable]])
  }
  return(df)
}
categorical.vars <- c('AGE','PAYM_METD','LINE_STUS')
up.train <- to.factors(df=up.train, variables=categorical.vars)
indexes <- sample(1:nrow(up.train), size=0.7*nrow(up.train))
train.data <- up.train[indexes,]
test.data <- up.train[-indexes,]

formula.init <- "TARGET ~ ."
formula.init <- as.formula(formula.init)
lr.model <- glm(formula=formula.init, data=train.data, family="binomial")

summary(lr.model)
library(car)
vif(lr.model)

step <- step(object = lr.model,trace=F)
summary(step)
library(car)
vif(step)

plot(step$residuals)  #굳


#------------2. 변수취합 로지스틱 회귀분석------------------------
#1.[카드사/할부사/캐피탈] 건수 * 대출금액
attach(up.train)
up.train$NEW_CPT_LNIF <- CPT_LNIF_AMT*CPT_LNIF_CNT
#2. 2산업, 기타 대출 건수 합치기
up.train$NEW_SPART_ECT <- SPART_LNIF_CNT+ECT_LNIF_CNT

#3. 보장성상품 보험료납입과 가구보장성상품 월납입보험료 
# 내가 가구중 내고 있는 납입 보험료 비중(비율)
up.train$NEW_GDINS_RATE <- ((FMLY_GDINS_MNPREM-GDINS_MON_PREM)/FMLY_GDINS_MNPREM)*100
#Nan - 0으로 처리
up.train$NEW_GDINS_RATE[is.na(up.train$NEW_GDINS_RATE)] <- 0

#4. 저축성상품 보험료납입과 가구저축성보험 월납입 보험료
# 내가 내고있는 저축성보험료 가구 대비 비중
up.train$NEW_SVINS_RATE <- ((FMLY_SVINS_MNPREM-SVINS_MON_PREM)/FMLY_SVINS_MNPREM)*100
up.train$NEW_SVINS_RATE[is.na(up.train$NEW_SVINS_RATE)] <- 0

#5. 기납입보험 가구 대비 비중
up.train$NEW_TOT_PREM <- ((FMLY_TOT_PREM-TOT_PREM)/FMLY_TOT_PREM)*100

#6. 보증 건수 * 금액
up.train$NEW_CB_GUIF <- CB_GUIF_CNT*CB_GUIF_AMT


up.train <- up.train[,-c(3,8,4,5,23,26,24,25,28,29,13,14)]
up.train <- na.omit(up.train)
detach(up.train)  #여기까지 변수취합---------------------

## data type transformations - factoring
to.factors <- function(df, variables){
  for (variable in variables){
    df[[variable]] <- as.factor(df[[variable]])
  }
  return(df)
}
categorical.vars <- c('AGE','PAYM_METD','LINE_STUS')
up.train <- to.factors(df=up.train, variables=categorical.vars)
indexes <- sample(1:nrow(up.train), size=0.7*nrow(up.train))
train.data <- up.train[indexes,]
test.data <- up.train[-indexes,]

formula.init <- "TARGET ~ ."
formula.init <- as.formula(formula.init)
lr.model <- glm(formula=formula.init, data=train.data, family="binomial")

summary(lr.model)
library(car)
vif(lr.model)

step2 <- step(object = lr.model,trace=F)  #stepwise로 변수 선택!
summary(step2)  #모형 stepwise로 최종 선택--------------------------

test.feature.vars <- test.data[,-1]
test.class.var <- test.data[,1]

lr.predictions.new <- predict(step2, test.data, type="response") 
lr.predictions.new <- round(lr.predictions.new)
library(caret)
confusionMatrix(data=lr.predictions.new, reference=test.class.var, positive='1')

lr.predictions.new <- as.factor(lr.predictions.new)
test.class.var <- as.factor(test.class.var)


##------------3. 변수제거 로지스틱 회귀분석------------------------
#해당 변수는 up.train <- up.train[,-c(3,8,4,5,23,26,24,25,28,29,13,14)] 이거만하면 위에거랑 동일!