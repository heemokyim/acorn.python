#------------------전처리--------------------------------------------------

#납부방법 - 'ETC'변수 변환
dataset$TEL_MBSP_GRAD[dataset$TEL_MBSP_GRAD==""] <- 'ETC'
dataset$PAYM_METD[dataset$PAYM_METD==""] <- 'ETC'

#변수범주화
all <- read.csv('all_F.csv',header=T)
str(all)

plot(table(all$BNK_LNIF_CNT))

all$BNK_LNIF_CNT[all$BNK_LNIF_CNT>=3] <- 3
all$CPT_LNIF_CNT[all$CPT_LNIF_CNT>=3] <- 3
all$SPART_LNIF_CNT[all$SPART_LNIF_CNT>=4] <- 4
all$ECT_LNIF_CNT[all$ECT_LNIF_CNT>=2] <- 2
all$CRDT_CARD_CNT[all$CRDT_CARD_CNT>=6] <- 6
all$CB_GUIF_CNT [all$CB_GUIF_CNT >=2] <- 2
all$LT1Y_CTLT_CNT[all$LT1Y_CTLT_CNT>=2] <- 2
all$AUTR_FAIL_MCNT[all$AUTR_FAIL_MCNT>=12] <- 12
all$FMLY_CLAM_CNT[all$FMLY_CLAM_CNT>=30] <- 30
all$FMLY_PLPY_CNT[all$FMLY_PLPY_CNT >=6] <- 6

up.train$CRLN_OVDU_RATE <- as.numeric(up.train$CRLN_OVDU_RATE)
up.train$PREM_OVDU_RATE <- as.numeric(up.train$PREM_OVDU_RATE)
up.train$AVG_CALL_TIME <- as.numeric(up.train$AVG_CALL_TIME)
up.train$AVG_CALL_FREQ <- as.numeric(up.train$AVG_CALL_FREQ)
up.train$AVG_STLN_RATE <- as.numeric(up.train$AVG_STLN_RATE)


#------------------변수선택3. boruta-----------------------------------------










