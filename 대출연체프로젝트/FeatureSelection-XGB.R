setwd("C:\\Users\\acorn\\Documents\\카카오톡 받은 파일\\select")

TRAIN<-read.csv("train_1.csv", header = T,stringsAsFactors = FALSE)
names(TRAIN)
TRAIN<-na.omit(TRAIN)
library(dummies)
D_TRAIN <- dummy.data.frame(TRAIN)
str(D_TRAIN)
D_TRAIN[,c(3:125)] <- sapply(D_TRAIN[,c(3:125)],as.numeric)
x<-as.matrix(D_TRAIN[,-c(1,2)])
y<-as.factor(D_TRAIN$TARGET)


#XGB를 활용한 변수선택

param <- list("objective" = "multi:softprob", 
              "eval_metric" = "mlogloss", 
              "num_class" = 3) 


install.packages("xgboost")
library(xgboost)

set.seed(131)


bst <- xgboost(param=param, data = x, label = y, nrounds=27) 

imp<-xgb.importance(names(D_TRAIN),model=bst)
class(imp)
imp<-as.matrix(imp)
print(imp) 
xgb.plot.importance(importance_matrix = imp[1:30],xlim=c(0,0.1)) #first 20 variables











