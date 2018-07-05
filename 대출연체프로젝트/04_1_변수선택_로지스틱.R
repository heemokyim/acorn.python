#------------------변수선택1. 로지스틱회귀분석----------------------------
setwd('D:\\Rdata\\challenge_data\\select')
TRAIN <- read.csv('TRAIN.csv',header=T,stringsAsFactors = F)
TRAIN <- na.omit(TRAIN)
summary(TRAIN)
names(TRAIN)

attach(TRAIN)

full3 <- glm(formula = TARGET~BNK_LNIF_CNT+CPT_LNIF_CNT+SPART_LNIF_CNT+ECT_LNIF_CNT+
               TOT_LNIF_AMT+TOT_CLIF_AMT+BNK_LNIF_AMT+CPT_LNIF_AMT+CRDT_OCCR_MDIF+CB_GUIF_CNT+
               CB_GUIF_AMT+factor(OCCP_NAME_G)+CUST_JOB_INCM+HSHD_INFR_INCM+ACTL_FMLY_NUM+
               CUST_FMLY_NUM+factor(LAST_CHLD_AGE)+factor(MATE_OCCP_NAME_G)+log(MATE_JOB_INCM+1)+
               CRDT_LOAN_CNT+TOT_CRLN_AMT+TOT_REPY_AMT+CRLN_OVDU_RATE+
               PREM_OVDU_RATE+AVG_STLN_RATE+STLN_REMN_AMT+LT1Y_STLN_AMT+
               LT1Y_SLOD_RATE+GDINS_MON_PREM+SVINS_MON_PREM+FMLY_GDINS_MNPREM+FMLY_SVINS_MNPREM+
               MAX_MON_PREM+TOT_PREM+FMLY_TOT_PREM+CNTT_LAMT_CNT+LT1Y_CTLT_CNT+AUTR_FAIL_MCNT+FYCM_PAID_AMT+
               FMLY_CLAM_CNT+FMLY_PLPY_CNT+AGE+factor(SEX)+CNTT_YY+CNTT_MM+AVG_CALL_TIME+
               AVG_CALL_FREQ+factor(TEL_MBSP_GRAD)+ARPU+MON_TLFE_AMT+NUM_DAY_SUSP+CRMM_OVDU_AMT+
               TLFE_UNPD_CNT+LT1Y_MXOD_AMT+factor(PAYM_METD)+factor(LINE_STUS)+MOBL_PRIN
             +TEL_CNTT_QTR_YY+TEL_CNTT_QTR_QQ+0,
             family="binomial")
summary(full3)

step3 <- step(object = full3,trace=F)
summary(step3)