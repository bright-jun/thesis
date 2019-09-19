CREATE TABLE GJ_UNIF_1 AS
(SELECT *,CONCAT_WS(',',HCHK_PMH_CD1,HCHK_PMH_CD2,HCHK_PMH_CD3) AS CONCATED
FROM GJ_COPY
)
;
UPDATE GJ_UNIF_1
SET
`HCHK_APOP_PMH_YN` = IS_APOP(CONCATED),
`HCHK_DIABML_PMH_YN` = IS_DIABML(CONCATED),
`HCHK_ETCDSE_PMH_YN` = IS_ETCDSE(CONCATED),
`HCHK_HDISE_PMH_YN` = IS_HDISE(CONCATED),
`HCHK_HPLPDM_PMH_YN` =0,
`HCHK_HPRTS_PMH_YN` = IS_HPRTS(CONCATED),
`HCHK_PHSS_PMH_YN` = IS_PHSS(CONCATED)
WHERE NOT CONCATED=",," AND HCHK_YEAR<=2008
;
UPDATE GJ_UNIF_1
SET
`HCHK_APOP_PMH_YN` = IS_01(HCHK_APOP_PMH_YN),
`HCHK_DIABML_PMH_YN` = IS_01(HCHK_DIABML_PMH_YN),
`HCHK_ETCDSE_PMH_YN` = IS_01(HCHK_ETCDSE_PMH_YN),
`HCHK_HDISE_PMH_YN` = IS_01(HCHK_HDISE_PMH_YN),
`HCHK_HPLPDM_PMH_YN` = IS_01(HCHK_HPLPDM_PMH_YN),
`HCHK_HPRTS_PMH_YN` = IS_01(HCHK_HPRTS_PMH_YN),
`HCHK_PHSS_PMH_YN` = IS_01(HCHK_PHSS_PMH_YN)
WHERE HCHK_YEAR>2008 AND
    (`HCHK_APOP_PMH_YN`        LIKE "1" OR
     `HCHK_DIABML_PMH_YN`     LIKE "1" OR
     `HCHK_ETCDSE_PMH_YN`     LIKE "1" OR
     `HCHK_HDISE_PMH_YN`     LIKE "1" OR
     `HCHK_HPLPDM_PMH_YN`    LIKE "1" OR
     `HCHK_HPRTS_PMH_YN`     LIKE "1" OR
     `HCHK_PHSS_PMH_YN`        LIKE "1")
;
CREATE TABLE GJ_UNIF_2 AS
(
SELECT *,
	`HCHK_APOP_PMH_YN` + `HCHK_HDISE_PMH_YN` + `HCHK_HPRTS_PMH_YN` + `HCHK_DIABML_PMH_YN` + `HCHK_HPLPDM_PMH_YN` + `HCHK_PHSS_PMH_YN` + `HCHK_ETCDSE_PMH_YN` AS SUM_PMH
FROM GJ_UNIF_1
)
;
CREATE TABLE GJ_UNIF_3 AS
(
SELECT `GJ_UNIF_2`.`HCHK_YEAR`,
    `GJ_UNIF_2`.`PERSON_ID`,
    `GJ_UNIF_2`.`YKIHO_GUBUN_CD`,
    `GJ_UNIF_2`.`HEIGHT`,
    `GJ_UNIF_2`.`WEIGHT`,
    `GJ_UNIF_2`.`WAIST`,
    `GJ_UNIF_2`.`BP_HIGH`,
    `GJ_UNIF_2`.`BP_LWST`,
    `GJ_UNIF_2`.`BLDS`,
    `GJ_UNIF_2`.`TOT_CHOLE`,
    `GJ_UNIF_2`.`TRIGLYCERIDE`,
    `GJ_UNIF_2`.`HDL_CHOLE`,
    `GJ_UNIF_2`.`LDL_CHOLE`,
    `GJ_UNIF_2`.`HMG`,
    `GJ_UNIF_2`.`GLY_CD`,
    `GJ_UNIF_2`.`OLIG_OCCU_CD`,
    `GJ_UNIF_2`.`OLIG_PH`,
    `GJ_UNIF_2`.`OLIG_PROTE_CD`,
    `GJ_UNIF_2`.`CREATININE`,
    `GJ_UNIF_2`.`SGOT_AST`,
    `GJ_UNIF_2`.`SGPT_ALT`,
    `GJ_UNIF_2`.`GAMMA_GTP`,
    `GJ_UNIF_2`.`HCHK_APOP_PMH_YN`,
    `GJ_UNIF_2`.`HCHK_HDISE_PMH_YN`,
    `GJ_UNIF_2`.`HCHK_HPRTS_PMH_YN`,
    `GJ_UNIF_2`.`HCHK_DIABML_PMH_YN`,
    `GJ_UNIF_2`.`HCHK_HPLPDM_PMH_YN`,
    `GJ_UNIF_2`.`HCHK_PHSS_PMH_YN`,
    `GJ_UNIF_2`.`HCHK_ETCDSE_PMH_YN`,
    `GJ_UNIF_2`.`FMLY_APOP_PATIEN_YN`,
    `GJ_UNIF_2`.`FMLY_HDISE_PATIEN_YN`,
    `GJ_UNIF_2`.`FMLY_HPRTS_PATIEN_YN`,
    `GJ_UNIF_2`.`FMLY_DIABML_PATIEN_YN`,
    `GJ_UNIF_2`.`FMLY_LIVER_DISE_PATIEN_YN`,
    `GJ_UNIF_2`.`FMLY_CANCER_PATIEN_YN`,
    `GJ_UNIF_2`.`SMK_STAT_TYPE_RSPS_CD`,
    `GJ_UNIF_2`.`SMK_TERM_RSPS_CD`,
    `GJ_UNIF_2`.`PAST_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_2`.`PAST_DSQTY_RSPS_CD`,
    `GJ_UNIF_2`.`CUR_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_2`.`CUR_DSQTY_RSPS_CD`,
    `GJ_UNIF_2`.`DSQTY_RSPS_CD`,
    `GJ_UNIF_2`.`DRNK_HABIT_RSPS_CD`,
    `GJ_UNIF_2`.`TM1_DRKQTY_RSPS_CD`,
    `GJ_UNIF_2`.`EXERCI_FREQ_RSPS_CD`,
    `GJ_UNIF_2`.`MOV20_WEK_FREQ_ID`,
    `GJ_UNIF_2`.`MOV30_WEK_FREQ_ID`,
    `GJ_UNIF_2`.`WLK30_WEK_FREQ_ID`
FROM GJ_UNIF_2
WHERE SUM_PMH<=3 OR SUM_PMH IS NULL
)
;
UPDATE GJ_UNIF_3
SET
FMLY_APOP_PATIEN_YN=CONV_FMLY(FMLY_APOP_PATIEN_YN),
FMLY_HDISE_PATIEN_YN=CONV_FMLY(FMLY_HDISE_PATIEN_YN),
FMLY_HPRTS_PATIEN_YN=CONV_FMLY(FMLY_HPRTS_PATIEN_YN),
FMLY_DIABML_PATIEN_YN=CONV_FMLY(FMLY_DIABML_PATIEN_YN),
FMLY_LIVER_DISE_PATIEN_YN=CONV_FMLY(FMLY_LIVER_DISE_PATIEN_YN),
FMLY_CANCER_PATIEN_YN=CONV_FMLY(FMLY_CANCER_PATIEN_YN)
WHERE HCHK_YEAR<2009
;
CREATE TABLE GJ_UNIF_4 AS
(
SELECT
	`GJ_UNIF_3`.`HCHK_YEAR`,
    `GJ_UNIF_3`.`PERSON_ID`,
    `GJ_UNIF_3`.`YKIHO_GUBUN_CD`,
    `GJ_UNIF_3`.`HEIGHT`,
    `GJ_UNIF_3`.`WEIGHT`,
    `GJ_UNIF_3`.`WAIST`,
    `GJ_UNIF_3`.`BP_HIGH`,
    `GJ_UNIF_3`.`BP_LWST`,
    `GJ_UNIF_3`.`BLDS`,
    `GJ_UNIF_3`.`TOT_CHOLE`,
    `GJ_UNIF_3`.`TRIGLYCERIDE`,
    `GJ_UNIF_3`.`HDL_CHOLE`,
    `GJ_UNIF_3`.`LDL_CHOLE`,
    `GJ_UNIF_3`.`HMG`,
    `GJ_UNIF_3`.`GLY_CD`,
    `GJ_UNIF_3`.`OLIG_OCCU_CD`,
    `GJ_UNIF_3`.`OLIG_PH`,
    `GJ_UNIF_3`.`OLIG_PROTE_CD`,
    `GJ_UNIF_3`.`CREATININE`,
    `GJ_UNIF_3`.`SGOT_AST`,
    `GJ_UNIF_3`.`SGPT_ALT`,
    `GJ_UNIF_3`.`GAMMA_GTP`,
    `GJ_UNIF_3`.`HCHK_APOP_PMH_YN`,
    `GJ_UNIF_3`.`HCHK_HDISE_PMH_YN`,
    `GJ_UNIF_3`.`HCHK_HPRTS_PMH_YN`,
    `GJ_UNIF_3`.`HCHK_DIABML_PMH_YN`,
    `GJ_UNIF_3`.`HCHK_HPLPDM_PMH_YN`,
    `GJ_UNIF_3`.`HCHK_PHSS_PMH_YN`,
    `GJ_UNIF_3`.`HCHK_ETCDSE_PMH_YN`,
    `GJ_UNIF_3`.`FMLY_APOP_PATIEN_YN`,
    `GJ_UNIF_3`.`FMLY_HDISE_PATIEN_YN`,
    `GJ_UNIF_3`.`FMLY_HPRTS_PATIEN_YN`,
    `GJ_UNIF_3`.`FMLY_DIABML_PATIEN_YN`,
    `GJ_UNIF_3`.`FMLY_CANCER_PATIEN_YN`,
    `GJ_UNIF_3`.`SMK_STAT_TYPE_RSPS_CD`,
    `GJ_UNIF_3`.`SMK_TERM_RSPS_CD`,
    `GJ_UNIF_3`.`PAST_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_3`.`PAST_DSQTY_RSPS_CD`,
    `GJ_UNIF_3`.`CUR_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_3`.`CUR_DSQTY_RSPS_CD`,
    `GJ_UNIF_3`.`DSQTY_RSPS_CD`,
    `GJ_UNIF_3`.`DRNK_HABIT_RSPS_CD`,
    `GJ_UNIF_3`.`TM1_DRKQTY_RSPS_CD`,
    `GJ_UNIF_3`.`EXERCI_FREQ_RSPS_CD`,
    `GJ_UNIF_3`.`MOV20_WEK_FREQ_ID`,
    `GJ_UNIF_3`.`MOV30_WEK_FREQ_ID`,
    `GJ_UNIF_3`.`WLK30_WEK_FREQ_ID`
FROM GJ_UNIF_3
)
;
CREATE TABLE GJ_UNIF_5 AS
(
SELECT
	`GJ_UNIF_4`.`HCHK_YEAR`,
    `GJ_UNIF_4`.`PERSON_ID`,
    `GJ_UNIF_4`.`YKIHO_GUBUN_CD`,
    BMI(`GJ_UNIF_4`.`HEIGHT`,`GJ_UNIF_4`.`WEIGHT`) AS BMI,
    `GJ_UNIF_4`.`BP_HIGH`,
    `GJ_UNIF_4`.`BP_LWST`,
    `GJ_UNIF_4`.`BLDS`,
    `GJ_UNIF_4`.`TOT_CHOLE`,
    `GJ_UNIF_4`.`TRIGLYCERIDE`,
    `GJ_UNIF_4`.`HDL_CHOLE`,
    `GJ_UNIF_4`.`LDL_CHOLE`,
    `GJ_UNIF_4`.`HMG`,
    `GJ_UNIF_4`.`GLY_CD`,
    `GJ_UNIF_4`.`OLIG_OCCU_CD`,
    `GJ_UNIF_4`.`OLIG_PH`,
    `GJ_UNIF_4`.`OLIG_PROTE_CD`,
    `GJ_UNIF_4`.`CREATININE`,
    `GJ_UNIF_4`.`SGOT_AST`,
    `GJ_UNIF_4`.`SGPT_ALT`,
    `GJ_UNIF_4`.`GAMMA_GTP`,
    `GJ_UNIF_4`.`HCHK_APOP_PMH_YN`,
    `GJ_UNIF_4`.`HCHK_HDISE_PMH_YN`,
    `GJ_UNIF_4`.`HCHK_HPRTS_PMH_YN`,
    `GJ_UNIF_4`.`HCHK_DIABML_PMH_YN`,
    `GJ_UNIF_4`.`HCHK_HPLPDM_PMH_YN`,
    `GJ_UNIF_4`.`HCHK_PHSS_PMH_YN`,
    `GJ_UNIF_4`.`HCHK_ETCDSE_PMH_YN`,
    `GJ_UNIF_4`.`FMLY_APOP_PATIEN_YN`,
    `GJ_UNIF_4`.`FMLY_HDISE_PATIEN_YN`,
    `GJ_UNIF_4`.`FMLY_HPRTS_PATIEN_YN`,
    `GJ_UNIF_4`.`FMLY_DIABML_PATIEN_YN`,
    `GJ_UNIF_4`.`FMLY_CANCER_PATIEN_YN`,
    `GJ_UNIF_4`.`SMK_STAT_TYPE_RSPS_CD`,
    `GJ_UNIF_4`.`SMK_TERM_RSPS_CD`,
    `GJ_UNIF_4`.`PAST_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_4`.`PAST_DSQTY_RSPS_CD`,
    `GJ_UNIF_4`.`CUR_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_4`.`CUR_DSQTY_RSPS_CD`,
    `GJ_UNIF_4`.`DSQTY_RSPS_CD`,
    `GJ_UNIF_4`.`DRNK_HABIT_RSPS_CD`,
    `GJ_UNIF_4`.`TM1_DRKQTY_RSPS_CD`,
    `GJ_UNIF_4`.`EXERCI_FREQ_RSPS_CD`,
    `GJ_UNIF_4`.`MOV20_WEK_FREQ_ID`,
    `GJ_UNIF_4`.`MOV30_WEK_FREQ_ID`,
    `GJ_UNIF_4`.`WLK30_WEK_FREQ_ID`
FROM GJ_UNIF_4
WHERE
    (`GJ_UNIF_4`.`HEIGHT`                     IS NOT NULL AND NOT `GJ_UNIF_4`.`HEIGHT` ="") AND
    (`GJ_UNIF_4`.`WEIGHT`                     IS NOT NULL AND NOT `GJ_UNIF_4`.`WEIGHT` ="")
)
;
UPDATE GJ_UNIF_5
SET
YKIHO_GUBUN_CD=CLASS_YKIHO(YKIHO_GUBUN_CD)
WHERE YKIHO_GUBUN_CD IS NOT NULL AND NOT YKIHO_GUBUN_CD=""
;
UPDATE GJ_UNIF_5
SET
BMI=CLASS_BMI(BMI)
WHERE BMI IS NOT NULL AND NOT BMI=""
;
CREATE TABLE GJ_UNIF_6 AS
(
SELECT `GJ_UNIF_5`.`HCHK_YEAR`,	
    `GJ_UNIF_5`.`PERSON_ID`,
    `GJ_UNIF_5`.`YKIHO_GUBUN_CD`,
    `GJ_UNIF_5`.`BMI`,
    CLASS_BP(BP_HIGH,BP_LWST) AS BP,
    `GJ_UNIF_5`.`BLDS`,
    `GJ_UNIF_5`.`TOT_CHOLE`,
    `GJ_UNIF_5`.`TRIGLYCERIDE`,
    `GJ_UNIF_5`.`HDL_CHOLE`,
    `GJ_UNIF_5`.`LDL_CHOLE`,
    `GJ_UNIF_5`.`HMG`,
    `GJ_UNIF_5`.`GLY_CD`,
    `GJ_UNIF_5`.`OLIG_OCCU_CD`,
    `GJ_UNIF_5`.`OLIG_PH`,
    `GJ_UNIF_5`.`OLIG_PROTE_CD`,
    `GJ_UNIF_5`.`CREATININE`,
    `GJ_UNIF_5`.`SGOT_AST`,
    `GJ_UNIF_5`.`SGPT_ALT`,
    `GJ_UNIF_5`.`GAMMA_GTP`,
    `GJ_UNIF_5`.`HCHK_APOP_PMH_YN`,
    `GJ_UNIF_5`.`HCHK_HDISE_PMH_YN`,
    `GJ_UNIF_5`.`HCHK_HPRTS_PMH_YN`,
    `GJ_UNIF_5`.`HCHK_DIABML_PMH_YN`,
    `GJ_UNIF_5`.`HCHK_HPLPDM_PMH_YN`,
    `GJ_UNIF_5`.`HCHK_PHSS_PMH_YN`,
    `GJ_UNIF_5`.`HCHK_ETCDSE_PMH_YN`,
    `GJ_UNIF_5`.`FMLY_APOP_PATIEN_YN`,
    `GJ_UNIF_5`.`FMLY_HDISE_PATIEN_YN`,
    `GJ_UNIF_5`.`FMLY_HPRTS_PATIEN_YN`,
    `GJ_UNIF_5`.`FMLY_DIABML_PATIEN_YN`,
    `GJ_UNIF_5`.`FMLY_CANCER_PATIEN_YN`,
    `GJ_UNIF_5`.`SMK_STAT_TYPE_RSPS_CD`,
    `GJ_UNIF_5`.`SMK_TERM_RSPS_CD`,
    `GJ_UNIF_5`.`PAST_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_5`.`PAST_DSQTY_RSPS_CD`,
    `GJ_UNIF_5`.`CUR_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_5`.`CUR_DSQTY_RSPS_CD`,
    `GJ_UNIF_5`.`DSQTY_RSPS_CD`,
    `GJ_UNIF_5`.`DRNK_HABIT_RSPS_CD`,
    `GJ_UNIF_5`.`TM1_DRKQTY_RSPS_CD`,
    `GJ_UNIF_5`.`EXERCI_FREQ_RSPS_CD`,
    `GJ_UNIF_5`.`MOV20_WEK_FREQ_ID`,
    `GJ_UNIF_5`.`MOV30_WEK_FREQ_ID`,
    `GJ_UNIF_5`.`WLK30_WEK_FREQ_ID`
FROM GJ_UNIF_5
)
;
UPDATE GJ_UNIF_6
SET
BLDS=CLASS_BLDS(BLDS)
WHERE BLDS IS NOT NULL AND NOT BLDS=""
;
UPDATE GJ_UNIF_6
SET
TOT_CHOLE=CLASS_CHOLE(TOT_CHOLE)
WHERE TOT_CHOLE IS NOT NULL AND NOT TOT_CHOLE=""
;
CREATE TABLE GJ_UNIF_7 AS
(
SELECT
	`GJ_UNIF_6`.`HCHK_YEAR`,	
    `GJ_UNIF_6`.`PERSON_ID`,
    `GJ_UNIF_6`.`YKIHO_GUBUN_CD`,
    `GJ_UNIF_6`.`BMI`,
    `GJ_UNIF_6`.`BP`,
    `GJ_UNIF_6`.`BLDS`,
    `GJ_UNIF_6`.`TOT_CHOLE`,
    `GJ_UNIF_6`.`TRIGLYCERIDE`,
    `GJ_UNIF_6`.`HDL_CHOLE`,
    `GJ_UNIF_6`.`LDL_CHOLE`,
    `GJ_UNIF_6`.`HMG`,
    `GJ_UNIF_6`.`OLIG_PROTE_CD`,
    `GJ_UNIF_6`.`CREATININE`,
    `GJ_UNIF_6`.`SGOT_AST`,
    `GJ_UNIF_6`.`SGPT_ALT`,
    `GJ_UNIF_6`.`GAMMA_GTP`,
    `GJ_UNIF_6`.`HCHK_APOP_PMH_YN`,
    `GJ_UNIF_6`.`HCHK_HDISE_PMH_YN`,
    `GJ_UNIF_6`.`HCHK_HPRTS_PMH_YN`,
    `GJ_UNIF_6`.`HCHK_DIABML_PMH_YN`,
    `GJ_UNIF_6`.`HCHK_HPLPDM_PMH_YN`,
    `GJ_UNIF_6`.`HCHK_PHSS_PMH_YN`,
    `GJ_UNIF_6`.`HCHK_ETCDSE_PMH_YN`,
    `GJ_UNIF_6`.`FMLY_APOP_PATIEN_YN`,
    `GJ_UNIF_6`.`FMLY_HDISE_PATIEN_YN`,
    `GJ_UNIF_6`.`FMLY_HPRTS_PATIEN_YN`,
    `GJ_UNIF_6`.`FMLY_DIABML_PATIEN_YN`,
    `GJ_UNIF_6`.`FMLY_CANCER_PATIEN_YN`,
    `GJ_UNIF_6`.`SMK_STAT_TYPE_RSPS_CD`,
    `GJ_UNIF_6`.`SMK_TERM_RSPS_CD`,
    `GJ_UNIF_6`.`PAST_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_6`.`PAST_DSQTY_RSPS_CD`,
    `GJ_UNIF_6`.`CUR_SMK_TERM_RSPS_CD`,
    `GJ_UNIF_6`.`CUR_DSQTY_RSPS_CD`,
    `GJ_UNIF_6`.`DSQTY_RSPS_CD`,
    `GJ_UNIF_6`.`DRNK_HABIT_RSPS_CD`,
    `GJ_UNIF_6`.`TM1_DRKQTY_RSPS_CD`,
    `GJ_UNIF_6`.`EXERCI_FREQ_RSPS_CD`,
    `GJ_UNIF_6`.`MOV20_WEK_FREQ_ID`,
    `GJ_UNIF_6`.`MOV30_WEK_FREQ_ID`,
    `GJ_UNIF_6`.`WLK30_WEK_FREQ_ID`
FROM GJ_UNIF_6
)
;
UPDATE GJ_UNIF_7
SET
OLIG_PROTE_CD=CLASS_PROTE(OLIG_PROTE_CD)
WHERE OLIG_PROTE_CD IS NOT NULL AND NOT OLIG_PROTE_CD=""
;
UPDATE GJ_UNIF_7
SET
SGOT_AST=CLASS_AST(SGOT_AST)
WHERE SGOT_AST IS NOT NULL AND NOT SGOT_AST=""
;
UPDATE GJ_UNIF_7
SET
SGPT_ALT=CLASS_ALT(SGPT_ALT)
WHERE SGPT_ALT IS NOT NULL AND NOT SGPT_ALT=""
;
UPDATE GJ_UNIF_7
SET
SMK_STAT_TYPE_RSPS_CD=MINUS_1(SMK_STAT_TYPE_RSPS_CD)
WHERE SMK_STAT_TYPE_RSPS_CD IS NOT NULL AND NOT SMK_STAT_TYPE_RSPS_CD=""
;
UPDATE GJ_UNIF_7
SET
SMK_TERM_RSPS_CD=CONV_SMK(PAST_SMK_TERM_RSPS_CD,CUR_SMK_TERM_RSPS_CD)
WHERE NOT (PAST_SMK_TERM_RSPS_CD="" AND CUR_SMK_TERM_RSPS_CD="")
;
CREATE TABLE GJ_UNIF_8 AS
(
SELECT
	`GJ_UNIF_7`.`HCHK_YEAR`,
    `GJ_UNIF_7`.`PERSON_ID`,
    `GJ_UNIF_7`.`YKIHO_GUBUN_CD`,
    `GJ_UNIF_7`.`BMI`,
    `GJ_UNIF_7`.`BP`,
    `GJ_UNIF_7`.`BLDS`,
    `GJ_UNIF_7`.`TOT_CHOLE`,
    `GJ_UNIF_7`.`TRIGLYCERIDE`,
    `GJ_UNIF_7`.`HDL_CHOLE`,
    `GJ_UNIF_7`.`LDL_CHOLE`,
    `GJ_UNIF_7`.`HMG`,
    `GJ_UNIF_7`.`OLIG_PROTE_CD`,
    `GJ_UNIF_7`.`CREATININE`,
    `GJ_UNIF_7`.`SGOT_AST`,
    `GJ_UNIF_7`.`SGPT_ALT`,
    `GJ_UNIF_7`.`GAMMA_GTP`,
    `GJ_UNIF_7`.`HCHK_APOP_PMH_YN`,
    `GJ_UNIF_7`.`HCHK_HDISE_PMH_YN`,
    `GJ_UNIF_7`.`HCHK_HPRTS_PMH_YN`,
    `GJ_UNIF_7`.`HCHK_DIABML_PMH_YN`,
    `GJ_UNIF_7`.`HCHK_HPLPDM_PMH_YN`,
    `GJ_UNIF_7`.`HCHK_PHSS_PMH_YN`,
    `GJ_UNIF_7`.`HCHK_ETCDSE_PMH_YN`,
    `GJ_UNIF_7`.`FMLY_APOP_PATIEN_YN`,
    `GJ_UNIF_7`.`FMLY_HDISE_PATIEN_YN`,
    `GJ_UNIF_7`.`FMLY_HPRTS_PATIEN_YN`,
    `GJ_UNIF_7`.`FMLY_DIABML_PATIEN_YN`,
    `GJ_UNIF_7`.`FMLY_CANCER_PATIEN_YN`,
    `GJ_UNIF_7`.`SMK_STAT_TYPE_RSPS_CD`,
    `GJ_UNIF_7`.`SMK_TERM_RSPS_CD`,
    `GJ_UNIF_7`.`PAST_DSQTY_RSPS_CD`,
    `GJ_UNIF_7`.`CUR_DSQTY_RSPS_CD`,
    `GJ_UNIF_7`.`DSQTY_RSPS_CD`,
    `GJ_UNIF_7`.`DRNK_HABIT_RSPS_CD`,
    `GJ_UNIF_7`.`TM1_DRKQTY_RSPS_CD`,
    `GJ_UNIF_7`.`EXERCI_FREQ_RSPS_CD`,
    `GJ_UNIF_7`.`MOV20_WEK_FREQ_ID`,
    `GJ_UNIF_7`.`MOV30_WEK_FREQ_ID`,
    `GJ_UNIF_7`.`WLK30_WEK_FREQ_ID`
FROM GJ_UNIF_7
)
;
UPDATE GJ_UNIF_8
SET
DSQTY_RSPS_CD=CONV_DSQTY(CUR_DSQTY_RSPS_CD)
WHERE NOT (CUR_DSQTY_RSPS_CD="")
;
CREATE TABLE GJ_UNIF_9 AS
(
SELECT
	`GJ_UNIF_8`.`HCHK_YEAR`,
    `GJ_UNIF_8`.`PERSON_ID`,
    `GJ_UNIF_8`.`YKIHO_GUBUN_CD`,
    `GJ_UNIF_8`.`BMI`,
    `GJ_UNIF_8`.`BP`,
    `GJ_UNIF_8`.`BLDS`,
    `GJ_UNIF_8`.`TOT_CHOLE`,
    `GJ_UNIF_8`.`TRIGLYCERIDE`,
    `GJ_UNIF_8`.`HDL_CHOLE`,
    `GJ_UNIF_8`.`LDL_CHOLE`,
    `GJ_UNIF_8`.`HMG`,
    `GJ_UNIF_8`.`OLIG_PROTE_CD`,
    `GJ_UNIF_8`.`CREATININE`,
    `GJ_UNIF_8`.`SGOT_AST`,
    `GJ_UNIF_8`.`SGPT_ALT`,
    `GJ_UNIF_8`.`GAMMA_GTP`,
    `GJ_UNIF_8`.`HCHK_APOP_PMH_YN`,
    `GJ_UNIF_8`.`HCHK_HDISE_PMH_YN`,
    `GJ_UNIF_8`.`HCHK_HPRTS_PMH_YN`,
    `GJ_UNIF_8`.`HCHK_DIABML_PMH_YN`,
    `GJ_UNIF_8`.`HCHK_HPLPDM_PMH_YN`,
    `GJ_UNIF_8`.`HCHK_PHSS_PMH_YN`,
    `GJ_UNIF_8`.`HCHK_ETCDSE_PMH_YN`,
    `GJ_UNIF_8`.`FMLY_APOP_PATIEN_YN`,
    `GJ_UNIF_8`.`FMLY_HDISE_PATIEN_YN`,
    `GJ_UNIF_8`.`FMLY_HPRTS_PATIEN_YN`,
    `GJ_UNIF_8`.`FMLY_DIABML_PATIEN_YN`,
    `GJ_UNIF_8`.`FMLY_CANCER_PATIEN_YN`,
    `GJ_UNIF_8`.`SMK_STAT_TYPE_RSPS_CD`,
    `GJ_UNIF_8`.`SMK_TERM_RSPS_CD`,
    `GJ_UNIF_8`.`DSQTY_RSPS_CD`,
    `GJ_UNIF_8`.`DRNK_HABIT_RSPS_CD`,
    `GJ_UNIF_8`.`TM1_DRKQTY_RSPS_CD`,
    `GJ_UNIF_8`.`EXERCI_FREQ_RSPS_CD`,
    `GJ_UNIF_8`.`MOV20_WEK_FREQ_ID`,
    `GJ_UNIF_8`.`MOV30_WEK_FREQ_ID`,
    `GJ_UNIF_8`.`WLK30_WEK_FREQ_ID`
FROM GJ_UNIF_8
)
;
UPDATE GJ_UNIF_9
SET
DRNK_HABIT_RSPS_CD=CONV_DRNK(DRNK_HABIT_RSPS_CD)
WHERE NOT (DRNK_HABIT_RSPS_CD="") AND HCHK_YEAR>2008
;
UPDATE GJ_UNIF_9
SET
DRNK_HABIT_RSPS_CD=MINUS_1(DRNK_HABIT_RSPS_CD)
WHERE DRNK_HABIT_RSPS_CD IS NOT NULL AND NOT DRNK_HABIT_RSPS_CD=""
;
CREATE TABLE GJ_UNIF_10 AS
(
SELECT *
FROM GJ_UNIF_9
)
;
UPDATE GJ_UNIF_10
SET
TM1_DRKQTY_RSPS_CD=CONV_DRKQTY(TM1_DRKQTY_RSPS_CD)
WHERE (NOT TM1_DRKQTY_RSPS_CD="") AND HCHK_YEAR>2008
;
CREATE TABLE GJ_UNIF_11 AS(
SELECT *
FROM GJ_UNIF_10
)
;
UPDATE GJ_UNIF_11
SET
EXERCI_FREQ_RSPS_CD=CONV_EXERCI(MOV20_WEK_FREQ_ID,MOV30_WEK_FREQ_ID,WLK30_WEK_FREQ_ID)
WHERE NOT (MOV20_WEK_FREQ_ID="" AND MOV30_WEK_FREQ_ID="" AND WLK30_WEK_FREQ_ID="") AND HCHK_YEAR>2008
;
UPDATE GJ_UNIF_11
SET
EXERCI_FREQ_RSPS_CD=MINUS_1(EXERCI_FREQ_RSPS_CD)
WHERE EXERCI_FREQ_RSPS_CD IS NOT NULL AND NOT EXERCI_FREQ_RSPS_CD=""
;
CREATE TABLE GJ_UNIF_12 AS
(
SELECT
	`GJ_UNIF_11`.`HCHK_YEAR`,
    `GJ_UNIF_11`.`PERSON_ID`,
    `GJ_UNIF_11`.`YKIHO_GUBUN_CD`,
    `GJ_UNIF_11`.`BMI`,
    `GJ_UNIF_11`.`BP`,
    `GJ_UNIF_11`.`BLDS`,
    `GJ_UNIF_11`.`TOT_CHOLE`,
    `GJ_UNIF_11`.`TRIGLYCERIDE`,
    `GJ_UNIF_11`.`HDL_CHOLE`,
    `GJ_UNIF_11`.`LDL_CHOLE`,
    `GJ_UNIF_11`.`HMG`,
    `GJ_UNIF_11`.`OLIG_PROTE_CD`,
    `GJ_UNIF_11`.`CREATININE`,
    `GJ_UNIF_11`.`SGOT_AST`,
    `GJ_UNIF_11`.`SGPT_ALT`,
    `GJ_UNIF_11`.`GAMMA_GTP`,
    `GJ_UNIF_11`.`HCHK_APOP_PMH_YN`,
    `GJ_UNIF_11`.`HCHK_HDISE_PMH_YN`,
    `GJ_UNIF_11`.`HCHK_HPRTS_PMH_YN`,
    `GJ_UNIF_11`.`HCHK_DIABML_PMH_YN`,
    `GJ_UNIF_11`.`HCHK_HPLPDM_PMH_YN`,
    `GJ_UNIF_11`.`HCHK_PHSS_PMH_YN`,
    `GJ_UNIF_11`.`HCHK_ETCDSE_PMH_YN`,
    `GJ_UNIF_11`.`FMLY_APOP_PATIEN_YN`,
    `GJ_UNIF_11`.`FMLY_HDISE_PATIEN_YN`,
    `GJ_UNIF_11`.`FMLY_HPRTS_PATIEN_YN`,
    `GJ_UNIF_11`.`FMLY_DIABML_PATIEN_YN`,
    `GJ_UNIF_11`.`FMLY_CANCER_PATIEN_YN`,
    `GJ_UNIF_11`.`SMK_STAT_TYPE_RSPS_CD`,
    `GJ_UNIF_11`.`SMK_TERM_RSPS_CD`,
    `GJ_UNIF_11`.`DSQTY_RSPS_CD`,
    `GJ_UNIF_11`.`DRNK_HABIT_RSPS_CD`,
    `GJ_UNIF_11`.`TM1_DRKQTY_RSPS_CD`,
    `GJ_UNIF_11`.`EXERCI_FREQ_RSPS_CD`
FROM GJ_UNIF_11
)
;
CREATE TABLE GJ_UNIF_13 AS
(
SELECT
	`GJ_UNIF_12`.`HCHK_YEAR`,
    `GJ_UNIF_12`.`PERSON_ID`,
    `GJ_UNIF_12`.`YKIHO_GUBUN_CD`,
    `GJ_UNIF_12`.`BMI`,
    `GJ_UNIF_12`.`BP`,
    `GJ_UNIF_12`.`BLDS`,
    `GJ_UNIF_12`.`TOT_CHOLE`,
    `GJ_UNIF_12`.`HMG`,
    `GJ_UNIF_12`.`OLIG_PROTE_CD`,
    `GJ_UNIF_12`.`SGOT_AST`,
    `GJ_UNIF_12`.`SGPT_ALT`,
    `GJ_UNIF_12`.`GAMMA_GTP`,
    `GJ_UNIF_12`.`HCHK_APOP_PMH_YN`,
    `GJ_UNIF_12`.`HCHK_HDISE_PMH_YN`,
    `GJ_UNIF_12`.`HCHK_HPRTS_PMH_YN`,
    `GJ_UNIF_12`.`HCHK_DIABML_PMH_YN`,
    `GJ_UNIF_12`.`HCHK_HPLPDM_PMH_YN`,
    `GJ_UNIF_12`.`HCHK_PHSS_PMH_YN`,
    `GJ_UNIF_12`.`HCHK_ETCDSE_PMH_YN`,
    `GJ_UNIF_12`.`FMLY_APOP_PATIEN_YN`,
    `GJ_UNIF_12`.`FMLY_HDISE_PATIEN_YN`,
    `GJ_UNIF_12`.`FMLY_HPRTS_PATIEN_YN`,
    `GJ_UNIF_12`.`FMLY_DIABML_PATIEN_YN`,
    `GJ_UNIF_12`.`FMLY_CANCER_PATIEN_YN`,
    `GJ_UNIF_12`.`SMK_STAT_TYPE_RSPS_CD`,
    `GJ_UNIF_12`.`SMK_TERM_RSPS_CD`,
    `GJ_UNIF_12`.`DSQTY_RSPS_CD`,
    `GJ_UNIF_12`.`DRNK_HABIT_RSPS_CD`,
    `GJ_UNIF_12`.`TM1_DRKQTY_RSPS_CD`,
    `GJ_UNIF_12`.`EXERCI_FREQ_RSPS_CD`
FROM GJ_UNIF_12
)
;
UPDATE GJ_UNIF_13
SET
SMK_TERM_RSPS_CD=IMPUTATION(SMK_STAT_TYPE_RSPS_CD,SMK_TERM_RSPS_CD),
DSQTY_RSPS_CD=IMPUTATION(SMK_STAT_TYPE_RSPS_CD,DSQTY_RSPS_CD)
WHERE NOT(SMK_STAT_TYPE_RSPS_CD IS NULL OR SMK_STAT_TYPE_RSPS_CD="")
;
UPDATE GJ_UNIF_13
SET
TM1_DRKQTY_RSPS_CD=IMPUTATION(DRNK_HABIT_RSPS_CD,TM1_DRKQTY_RSPS_CD)
WHERE NOT(DRNK_HABIT_RSPS_CD IS NULL OR DRNK_HABIT_RSPS_CD="")
;
UPDATE GJ_UNIF_13
SET
DSQTY_RSPS_CD=0
WHERE NOT (SMK_STAT_TYPE_RSPS_CD IS NULL OR SMK_STAT_TYPE_RSPS_CD ="") AND (DSQTY_RSPS_CD IS NULL OR DSQTY_RSPS_CD="")
;

CREATE TABLE GJ_UNIF AS
(
SELECT *
FROM GJ_UNIF_13
)
;
CREATE INDEX person ON GJ_UNIF(PERSON_ID,HCHK_YEAR)