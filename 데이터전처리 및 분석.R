#경로설정
getwd()
setwd("/")

#출력 자릿수 설정
options(scipen=100, digit = 10, digits = 8)

#특정 질병에 대한 csv읽기
csv <- read.csv(".csv",header=TRUE,sep=",")
#실험군
csv_exp <- read.csv(".csv",header=TRUE,sep=",")
csv_exp$MAIN_SICKS <- 1
#대조군
csv_ctr <- read.csv(".csv",header=TRUE,sep=",")
csv_ctr$MAIN_SICKS <- 0

#예측모델 생성방법 문서의 R생성규칙 참고

csv$AGE_GROUP[csv$AGE_GROUP==1]<-2
csv$AGE_GROUP[csv$AGE_GROUP==7]<-6
csv<-csv[csv$SIDO<4,]
csv<-csv[csv$IPSN_TYPE_CD!=3,]
csv<-csv[csv$CTRB_PT_TYPE_CD!=0,]
csv$DFAB_GRD_CD[csv$DFAB_GRD_CD==2]<-1

#연속형으로 읽어들인 데이터값을 범주형으로 변환하는 작업
#범주의 기준은 대부분 처음의 값임, 그 이외의 값을 범주로 설정하려면 따로 함수를 써야함
csv$SEX                      	<- as.factor(csv$SEX                   	)
csv$AGE_GROUP                	<- as.factor(csv$AGE_GROUP             	)
csv$AGE_GROUP         	<-relevel(csv$AGE_GROUP, ref="2")
csv$SIDO                     	<- as.factor(csv_6Y$SIDO                  	)
csv$IPSN_TYPE_CD             	<- as.factor(csv_6Y$IPSN_TYPE_CD          	)
csv$IPSN_TYPE_CD         	<-relevel(csv_6Y$IPSN_TYPE_CD, ref="2")
csv$CTRB_PT_TYPE_CD          	<- as.factor(csv_6Y$CTRB_PT_TYPE_CD       	)
csv$CTRB_PT_TYPE_CD      	<-relevel(csv_6Y$CTRB_PT_TYPE_CD, ref="4")
csv$DFAB_GRD_CD              	<- as.factor(csv_6Y$DFAB_GRD_CD           	)
csv$DFAB_PTN_CD              	<- as.factor(csv_6Y$DFAB_PTN_CD           	)
csv$X2Y_YKIHO_GUBUN_CD       	<- as.factor(csv$X2Y_YKIHO_GUBUN_CD    	)
csv$X2Y_YKIHO_GUBUN_CD    	<-relevel(csv$X2Y_YKIHO_GUBUN_CD, ref="3")
csv$X2Y_BMI                  	<- as.factor(csv$X2Y_BMI               	)
csv$X2Y_BP                   	<- as.factor(csv$X2Y_BP                	)
csv$X2Y_BLDS                 	<- as.factor(csv$X2Y_BLDS              	)
csv$X2Y_TOT_CHOLE            	<- as.factor(csv$X2Y_TOT_CHOLE         	)
csv$X2Y_HMG                  	<- as.factor(csv$X2Y_HMG               	)
csv$X2Y_OLIG_PROTE_CD        	<- as.factor(csv$X2Y_OLIG_PROTE_CD     	)
csv$X2Y_SGOT_AST             	<- as.factor(csv$X2Y_SGOT_AST          	)
csv$X2Y_SGPT_ALT             	<- as.factor(csv$X2Y_SGPT_ALT          	)
csv$X2Y_GAMMA_GTP            	<- as.factor(csv$X2Y_GAMMA_GTP         	)
csv$X2Y_SMK_STAT_TYPE_RSPS_CD	<- as.factor(csv$X2Y_SMK_STAT_TYPE_RSPS_CD )
csv$X2Y_SMK_TERM_RSPS_CD     	<- as.factor(csv$X2Y_SMK_TERM_RSPS_CD  	)
csv$X2Y_DSQTY_RSPS_CD        	<- as.factor(csv$X2Y_DSQTY_RSPS_CD     	)
csv$X2Y_DRNK_HABIT_RSPS_CD   	<- as.factor(csv$X2Y_DRNK_HABIT_RSPS_CD	)
csv$X2Y_TM1_DRKQTY_RSPS_CD   	<- as.factor(csv$X2Y_TM1_DRKQTY_RSPS_CD	)
csv$X2Y_EXERCI_FREQ_RSPS_CD  	<- as.factor(csv$X2Y_EXERCI_FREQ_RSPS_CD   )

#회귀분석
logr <- glm(MAIN_SICKS ~
                 PERSON_ID            	+ YEAR                  	+ SEX                   	+
                 AGE_GROUP            	+ SIDO                  	+ IPSN_TYPE_CD          	+ CTRB_PT_TYPE_CD        	+
                 DFAB_GRD_CD          	+ HCHK_APOP_PMH_YN      	+ HCHK_HDISE_PMH_YN      	+
                 HCHK_HPRTS_PMH_YN    	+ HCHK_DIABML_PMH_YN    	+ HCHK_HPLPDM_PMH_YN    	+ HCHK_PHSS_PMH_YN       	+
                 HCHK_ETCDSE_PMH_YN   	+ FMLY_APOP_PATIEN_YN   	+ FMLY_HDISE_PATIEN_YN  	+ FMLY_HPRTS_PATIEN_YN   	+
                 FMLY_DIABML_PATIEN_YN	+ FMLY_CANCER_PATIEN_YN 	+ X2Y_HCHK_YEAR         	+ X2Y_YKIHO_GUBUN_CD     	+
                 X2Y_BMI              	+ X2Y_BP                	+ X2Y_BLDS              	+ X2Y_TOT_CHOLE          	+
                 X2Y_HMG              	+ X2Y_OLIG_PROTE_CD     	+ X2Y_SGOT_AST          	+ X2Y_SGPT_ALT           	+
                 X2Y_GAMMA_GTP        	+ X2Y_SMK_STAT_TYPE_RSPS_CD + X2Y_SMK_TERM_RSPS_CD  	+ X2Y_DSQTY_RSPS_CD      	+
                 X2Y_DRNK_HABIT_RSPS_CD   + X2Y_TM1_DRKQTY_RSPS_CD	+ X2Y_EXERCI_FREQ_RSPS_CD
               , data=csv, family=binomial)


#OR(Odds Ratio)계산
sum_logr<-summary(logr)
para<-sum_logr$coefficients
OR<-exp(para[,1])
cbind(OR,para[,c(2,4)])

#회귀분석 결과 출력
capture.output(cbind(OR,para[,c(2,4)]), file = "glm.txt")

#hoslem.test를/ R^2 통한 유의한 결과값 출력
capture.output(c("GLM analysis"), file = "Report_EXP.txt",append=TRUE)
library(ResourceSelection)
hoslem.test(logr$y, logr$fit)
capture.output(hoslem.test(logr$y, logr$fit), file = "glm_EXP.txt",append=TRUE)
capture.output(hoslem.test(logr$y, logr$fit), file = "Report_EXP.txt",append=TRUE)
library(pscl)
capture.output(pR2(logr), file = "glm_EXP.txt",append=TRUE)
capture.output(pR2(logr), file = "Report_EXP.txt",append=TRUE)

#회귀분석 결과에Stepwise Selection Method를 적용(이하 회귀분석과정과 동일)
Slm <- step(logr,direction = "both")

para<-summary(Slm)$coefficients
OR<-exp(para[,4])
cbind(OR,para[,c(2,4)])
capture.output(cbind(OR,para[,c(2,4)]), file = "slm.txt")

capture.output(c("SLM analysis"), file = "Report_EXP.txt",append=TRUE)

library(ResourceSelection)
hoslem.test(Slm$y, Slm$fit)
capture.output(hoslem.test(Slm$y, Slm$fit), file = "slm_EXP.txt",append=TRUE)
capture.output(hoslem.test(Slm$y, Slm$fit), file = "Report_EXP.txt",append=TRUE)
library(pscl)
capture.output(pR2(Slm), file = "slm_EXP.txt",append=TRUE)
capture.output(pR2(Slm), file = "Report_EXP.txt",append=TRUE)
