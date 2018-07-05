#------------------모델링2. xgboost분석----------------------------------------

# 4. default parameters
params <- list(
  booster = "gbtree",
  objective = "binary:logistic",
  eta=0.1,
  gamma=0,
  max_depth=3,
  min_child_weight=1,
  subsample=1,
  colsample_bytree=1
)

# 5. get cv
xgbcv <- xgb.cv(params = params
                ,data = dtrain
                ,nrounds = 800
                ,nfold = 5
                ,showsd = T
                ,stratified = T
                ,print.every.n = 10
                ,early.stop.round = 20
                ,maximize = F
)

# 6. process train
xgb1 <- xgb.train(
  params = params
  ,data = dtrain
  ,nrounds = 800
  ,watchlist = list(val=dtest,train=dtrain)
  ,print.every.n = 10
  ,early.stop.round = 10
  ,maximize = F
  ,eval_metric = "error"
)

# 7. predict
xgbpred <- predict(xgb1,dtest)
xgbpred <- ifelse(xgbpred > 0.5,1,0)

# 8. evaluate
confusionMatrix(factor(xgbpred), factor(ts_label))
res<-ROC(test=pred2, stat = as.numeric(test$TARGET), plot="ROC", AUC = TRUE) #Drawing ROC Curve
