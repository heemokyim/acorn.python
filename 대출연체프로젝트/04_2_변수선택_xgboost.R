#------------------변수선택2. Xgboost-------------------------------------
### XGBoost Data importance _XGBoost 변수 선택 ###

# Install each library when if you don't have them
library(xgboost)
library(caret)

# 2. set labels
labels<-D_TRAIN$TARGET
ts_label <- D_TEST$TARGET

# 3. preparing matrix
new_tr <- model.matrix(~.+0,data = D_TRAIN[,-1]) #One hot encoding
new_ts <- model.matrix(~.+0,data = D_TEST[,-1]) #No "dummies" required
dtrain <- xgb.DMatrix(data = new_tr,label = labels)
dtest <- xgb.DMatrix(data = new_ts,label = ts_label)

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

# 7. get importance data (from Feature)
mat <- xgb.importance(feature_names = colnames(new_tr),model = xgb1)
xgb.plot.importance(importance_matrix = mat[1:20], names("Feature Importance"))