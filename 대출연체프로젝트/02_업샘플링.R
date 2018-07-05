#-------------------업샘플링------------------------------------------------

library(party)
library(caret)
parts <- createDataPartition(DATA$TARGET,p=0.7)
train <- DATA[parts$Resample1,]
test <- DATA[-parts$Resample1,]
table(train$TARGET)
table(test$TARGET)
train$TARGET <- as.factor(train$TARGET)
test$TARGET <- as.factor(test$TARGET)

up.train <- upSample(train,train$TARGET)
library(rpart)
m <- rpart(TARGET~.,data=train)

table(up.train$TARGET)
table(test$TARGET)

write.csv(up.train,'D:\\Rdata\\challenge_data\\select2\\uptrain.csv')
write.csv(test,'D:\\Rdata\\challenge_data\\select2\\test.csv')
write.csv(DATA,'D:\\Rdata\\challenge_data\\select2\\DATA_B.csv')
