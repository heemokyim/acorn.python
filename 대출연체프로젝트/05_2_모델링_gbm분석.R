#------------------모델링3. bgm분석----------------------------------------
### GBM Data importance _XGBoost 변수 선택 ###

# Install each library when if you don't have them 
library(gbm)
library(dummies)
library(caret)

# 2. set random seed
set.seed(1)

# 3. model build
# -----------Stochastic Gradient Boosting Tree model------------
model <- gbm(formula = D_TRAIN$TARGET~.,
             distribution = "bernoulli",
             data = D_TRAIN,
             n.trees = 100,
             interaction.depth = 6,
             shrinkage = 0.1,
             bag.fraction = 0.5,
             train.fraction = 1.0,
             n.cores = NULL)  

# -----------distribution------------
# gaussian : squared error
# laplace : absolute loss
# tdist : t-distribution loss
# bernoulli : logistic regression for 0-1 outcomes
# huberized : huberized hinge loss for 0-1 outcomes
# multinomial : classification when there are more than 2 classes
# adaboost : the AdaBoost exponential loss for 0-1 outcomes
# poisson : count outcomes
# coxph : right censored observations
# quantile,pairwise : ranking measure using the LambdaMart algorithm


# 4. get important features
print(model)
summary(model)

# 4. prediction
pred <- predict(model, newdata = D_TEST, n.trees = 100)
pred2<- ifelse(pred > 0.5,1,0)

# 5. evaluate
confusionMatrix(factor(pred2), factor(D_TEST$TARGET))
res<-ROC(test=pred2, stat = as.numeric(D_TEST$TARGET), plot="ROC", AUC = TRUE) #Drawing ROC Curve
