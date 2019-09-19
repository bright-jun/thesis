CREATE TABLE T120_E11 AS(
SELECT T1.*
FROM namzle.T120 AS T1
WHERE T1.MAIN_SICK LIKE "E11%"
)
;
CREATE INDEX person ON T120_E11(PERSON_ID)
;
CREATE TABLE T120_E11_YEAR AS
(
    SELECT
        T1.PERSON_ID, T1.MIN_YEAR, GROUP_CONCAT(DISTINCT(MAIN_SICK) SEPARATOR '/') AS MAIN_SICKS
    FROM
        (
        SELECT PERSON_ID, MIN(YEAR(RECU_FR_DT)) AS MIN_YEAR
        FROM namzle.T120_E11
        GROUP BY PERSON_ID
        ) AS T1
    RIGHT JOIN T120_E11 AS T2
        ON T1.PERSON_ID = T2.PERSON_ID
    WHERE T1.MIN_YEAR = YEAR(T2.RECU_FR_DT)
    GROUP BY T1.PERSON_ID
)
;
CREATE INDEX person ON T120_E11_YEAR(PERSON_ID,MIN_YEAR)
;
CREATE TABLE T120_E11_YEAR_JK AS
(
    SELECT
        T2.`PERSON_ID`,
        T2.`MIN_YEAR`,
        T2.`MAIN_SICKS`,
        T1.`SEX`,
        T1.`AGE_GROUP`,
        T1.`SIDO`,
        T1.`IPSN_TYPE_CD`,
        T1.`CTRB_PT_TYPE_CD`,
        T1.`DFAB_GRD_CD`,
        T1.`DFAB_PTN_CD`
    FROM JK_UNIF AS T1
    LEFT JOIN T120_E11_YEAR AS T2
    ON T1.PERSON_ID = T2.PERSON_ID
    WHERE T1.STND_Y = T2.MIN_YEAR AND DTH_YM =""
)
;
CREATE INDEX person ON T120_E11_YEAR_JK(PERSON_ID,MIN_YEAR)
;
CREATE TABLE EXP_DATA_0YEAR
(SELECT    
    T1.`PERSON_ID`,
    T1.`MIN_YEAR` AS `YEAR`,
    T1.`MAIN_SICKS`,
    T1.`SEX`,
    T1.`AGE_GROUP`,
    T1.`SIDO`,
    T1.`IPSN_TYPE_CD`,
    T1.`CTRB_PT_TYPE_CD`,
    T1.`DFAB_GRD_CD`,
    T1.`DFAB_PTN_CD`,
    T2.`HCHK_APOP_PMH_YN`,
    T2.`HCHK_HDISE_PMH_YN`,
    T2.`HCHK_HPRTS_PMH_YN`,
    T2.`HCHK_DIABML_PMH_YN`,
    T2.`HCHK_HPLPDM_PMH_YN`,
    T2.`HCHK_PHSS_PMH_YN`,
    T2.`HCHK_ETCDSE_PMH_YN`,
    T2.`FMLY_APOP_PATIEN_YN`,
    T2.`FMLY_HDISE_PATIEN_YN`,
    T2.`FMLY_HPRTS_PATIEN_YN`,
    T2.`FMLY_DIABML_PATIEN_YN`,
    T2.`FMLY_CANCER_PATIEN_YN`
FROM T120_E11_YEAR_JK AS T1
INNER JOIN GJ_UNIF AS T2
ON T1.PERSON_ID = T2.PERSON_ID
WHERE T1.MIN_YEAR = (T2.HCHK_YEAR + 0) AND
    (T2.`HCHK_APOP_PMH_YN`      IS NOT NULL AND NOT T2.`HCHK_APOP_PMH_YN`      ="") AND
    (T2.`HCHK_HDISE_PMH_YN`     IS NOT NULL AND NOT T2.`HCHK_HDISE_PMH_YN`     ="") AND
    (T2.`HCHK_HPRTS_PMH_YN`     IS NOT NULL AND NOT T2.`HCHK_HPRTS_PMH_YN`     ="") AND
    (T2.`HCHK_DIABML_PMH_YN`    IS NOT NULL AND NOT T2.`HCHK_DIABML_PMH_YN`    ="") AND
    (T2.`HCHK_HPLPDM_PMH_YN`    IS NOT NULL AND NOT T2.`HCHK_HPLPDM_PMH_YN`    ="") AND
    (T2.`HCHK_PHSS_PMH_YN`      IS NOT NULL AND NOT T2.`HCHK_PHSS_PMH_YN`      ="") AND
    (T2.`HCHK_ETCDSE_PMH_YN`    IS NOT NULL AND NOT T2.`HCHK_ETCDSE_PMH_YN`    ="") AND
    (T2.`FMLY_APOP_PATIEN_YN`   IS NOT NULL AND NOT T2.`FMLY_APOP_PATIEN_YN`   ="") AND
    (T2.`FMLY_HDISE_PATIEN_YN`  IS NOT NULL AND NOT T2.`FMLY_HDISE_PATIEN_YN`  ="") AND
    (T2.`FMLY_HPRTS_PATIEN_YN`  IS NOT NULL AND NOT T2.`FMLY_HPRTS_PATIEN_YN`  ="") AND
    (T2.`FMLY_DIABML_PATIEN_YN` IS NOT NULL AND NOT T2.`FMLY_DIABML_PATIEN_YN` ="") AND
    (T2.`FMLY_CANCER_PATIEN_YN` IS NOT NULL AND NOT T2.`FMLY_CANCER_PATIEN_YN` ="")
)
;
CREATE TABLE EXP_DATA_2_2YEAR
(SELECT
    T1.*,
    T2.`HCHK_YEAR` AS `2Y_HCHK_YEAR`,
    T2.`YKIHO_GUBUN_CD` AS `2Y_YKIHO_GUBUN_CD`,
    T2.`BMI` AS `2Y_BMI`,
    T2.`BP` AS `2Y_BP`,
    T2.`BLDS` AS `2Y_BLDS`,
    T2.`TOT_CHOLE` AS `2Y_TOT_CHOLE`,
    T2.`HMG` AS `2Y_HMG`,
    T2.`OLIG_PROTE_CD` AS `2Y_OLIG_PROTE_CD`,
    T2.`SGOT_AST` AS `2Y_SGOT_AST`,
    T2.`SGPT_ALT` AS `2Y_SGPT_ALT`,
    T2.`GAMMA_GTP` AS `2Y_GAMMA_GTP`,
    T2.`SMK_STAT_TYPE_RSPS_CD` AS `2Y_SMK_STAT_TYPE_RSPS_CD`,
    T2.`SMK_TERM_RSPS_CD` AS `2Y_SMK_TERM_RSPS_CD`,
    T2.`DSQTY_RSPS_CD` AS `2Y_DSQTY_RSPS_CD`,
    T2.`DRNK_HABIT_RSPS_CD` AS `2Y_DRNK_HABIT_RSPS_CD`,
    T2.`TM1_DRKQTY_RSPS_CD` AS `2Y_TM1_DRKQTY_RSPS_CD`,
    T2.`EXERCI_FREQ_RSPS_CD` AS `2Y_EXERCI_FREQ_RSPS_CD`
FROM EXP_DATA_0YEAR AS T1
INNER JOIN GJ_UNIF AS T2
ON T1.PERSON_ID = T2.PERSON_ID
WHERE T1.`YEAR` = (T2.HCHK_YEAR + 2)	AND
    (T2.`HCHK_YEAR`             IS NOT NULL AND NOT T2.`HCHK_YEAR`                 ="") AND
    (T2.`YKIHO_GUBUN_CD`         IS NOT NULL AND NOT T2.`YKIHO_GUBUN_CD`         ="") AND
    (T2.`BMI`                 IS NOT NULL) AND
    (T2.`BP`                 IS NOT NULL) AND
    (T2.`BLDS`                     IS NOT NULL AND NOT T2.`BLDS`                     ="") AND
    (T2.`TOT_CHOLE`             IS NOT NULL AND NOT T2.`TOT_CHOLE`                 ="") AND
    (T2.`HMG`                     IS NOT NULL AND NOT T2.`HMG`                     ="") AND
    (T2.`OLIG_PROTE_CD`         IS NOT NULL AND NOT T2.`OLIG_PROTE_CD`             ="") AND
    (T2.`SGOT_AST`                 IS NOT NULL AND NOT T2.`SGOT_AST`                 ="") AND
    (T2.`SGPT_ALT`                 IS NOT NULL AND NOT T2.`SGPT_ALT`                 ="") AND
    (T2.`GAMMA_GTP`             IS NOT NULL AND NOT T2.`GAMMA_GTP`                 ="") AND
    (T2.`SMK_STAT_TYPE_RSPS_CD`    IS NOT NULL AND NOT T2.`SMK_STAT_TYPE_RSPS_CD`    ="") AND
    (T2.`SMK_TERM_RSPS_CD`         IS NOT NULL AND NOT T2.`SMK_TERM_RSPS_CD`         ="") AND
    (T2.`DSQTY_RSPS_CD`         IS NOT NULL AND NOT T2.`DSQTY_RSPS_CD`             ="") AND
    (T2.`DRNK_HABIT_RSPS_CD`     IS NOT NULL AND NOT T2.`DRNK_HABIT_RSPS_CD`     ="") AND
    (T2.`TM1_DRKQTY_RSPS_CD`     IS NOT NULL AND NOT T2.`TM1_DRKQTY_RSPS_CD`     ="") AND
    (T2.`EXERCI_FREQ_RSPS_CD`     IS NOT NULL AND NOT T2.`EXERCI_FREQ_RSPS_CD`     ="")
)
;
UPDATE EXP_DATA_2_2YEAR
SET
`2Y_HMG`=CLASS_HMG(SEX,`2Y_HMG`)
WHERE
(`2Y_HMG` IS NOT NULL AND NOT `2Y_HMG`="")
;
UPDATE EXP_DATA_2_2YEAR
SET
`2Y_GAMMA_GTP`=CLASS_GTP(SEX,`2Y_GAMMA_GTP`)
WHERE
(`2Y_GAMMA_GTP` IS NOT NULL AND NOT `2Y_GAMMA_GTP`="")
;
CREATE TABLE EXP_DATA_2_4YEAR
(SELECT
    T1.*,
    T2.`HCHK_YEAR` AS `4Y_HCHK_YEAR`,
    T2.`YKIHO_GUBUN_CD` AS `4Y_YKIHO_GUBUN_CD`,
    T2.`BMI` AS `4Y_BMI`,
    T2.`BP` AS `4Y_BP`,
    T2.`BLDS` AS `4Y_BLDS`,
    T2.`TOT_CHOLE` AS `4Y_TOT_CHOLE`,
    T2.`HMG` AS `4Y_HMG`,
    T2.`OLIG_PROTE_CD` AS `4Y_OLIG_PROTE_CD`,
    T2.`SGOT_AST` AS `4Y_SGOT_AST`,
    T2.`SGPT_ALT` AS `4Y_SGPT_ALT`,
    T2.`GAMMA_GTP` AS `4Y_GAMMA_GTP`,
    T2.`SMK_STAT_TYPE_RSPS_CD` AS `4Y_SMK_STAT_TYPE_RSPS_CD`,
    T2.`SMK_TERM_RSPS_CD` AS `4Y_SMK_TERM_RSPS_CD`,
    T2.`DSQTY_RSPS_CD` AS `4Y_DSQTY_RSPS_CD`,
    T2.`DRNK_HABIT_RSPS_CD` AS `4Y_DRNK_HABIT_RSPS_CD`,
    T2.`TM1_DRKQTY_RSPS_CD` AS `4Y_TM1_DRKQTY_RSPS_CD`,
    T2.`EXERCI_FREQ_RSPS_CD` AS `4Y_EXERCI_FREQ_RSPS_CD`
FROM EXP_DATA_2_2YEAR AS T1
INNER JOIN GJ_UNIF AS T2
ON T1.PERSON_ID = T2.PERSON_ID
WHERE T1.`YEAR` = (T2.HCHK_YEAR + 4)	AND
    (T2.`HCHK_YEAR`             IS NOT NULL AND NOT T2.`HCHK_YEAR`                 ="") AND
    (T2.`YKIHO_GUBUN_CD`         IS NOT NULL AND NOT T2.`YKIHO_GUBUN_CD`         ="") AND
    (T2.`BMI`                 IS NOT NULL) AND
    (T2.`BP`                 IS NOT NULL) AND
    (T2.`BLDS`                     IS NOT NULL AND NOT T2.`BLDS`                     ="") AND
    (T2.`TOT_CHOLE`             IS NOT NULL AND NOT T2.`TOT_CHOLE`                 ="") AND
    (T2.`HMG`                     IS NOT NULL AND NOT T2.`HMG`                     ="") AND
    (T2.`OLIG_PROTE_CD`         IS NOT NULL AND NOT T2.`OLIG_PROTE_CD`             ="") AND
    (T2.`SGOT_AST`                 IS NOT NULL AND NOT T2.`SGOT_AST`                 ="") AND
    (T2.`SGPT_ALT`                 IS NOT NULL AND NOT T2.`SGPT_ALT`                 ="") AND
    (T2.`GAMMA_GTP`             IS NOT NULL AND NOT T2.`GAMMA_GTP`                 ="") AND
    (T2.`SMK_STAT_TYPE_RSPS_CD`    IS NOT NULL AND NOT T2.`SMK_STAT_TYPE_RSPS_CD`    ="") AND
    (T2.`SMK_TERM_RSPS_CD`         IS NOT NULL AND NOT T2.`SMK_TERM_RSPS_CD`         ="") AND
    (T2.`DSQTY_RSPS_CD`         IS NOT NULL AND NOT T2.`DSQTY_RSPS_CD`             ="") AND
    (T2.`DRNK_HABIT_RSPS_CD`     IS NOT NULL AND NOT T2.`DRNK_HABIT_RSPS_CD`     ="") AND
    (T2.`TM1_DRKQTY_RSPS_CD`     IS NOT NULL AND NOT T2.`TM1_DRKQTY_RSPS_CD`     ="") AND
    (T2.`EXERCI_FREQ_RSPS_CD`     IS NOT NULL AND NOT T2.`EXERCI_FREQ_RSPS_CD`     ="")
)
;
UPDATE EXP_DATA_2_4YEAR
SET
`4Y_HMG`=CLASS_HMG(SEX,`4Y_HMG`)
WHERE
(`4Y_HMG` IS NOT NULL AND NOT `4Y_HMG`="")
;
UPDATE EXP_DATA_2_4YEAR
SET
`4Y_GAMMA_GTP`=CLASS_GTP(SEX,`4Y_GAMMA_GTP`)
WHERE
(`4Y_GAMMA_GTP` IS NOT NULL AND NOT `4Y_GAMMA_GTP`="")
;
CREATE TABLE EXP_DATA_2_6YEAR
(SELECT
    T1.*,
    T2.`HCHK_YEAR` AS `6Y_HCHK_YEAR`,
    T2.`YKIHO_GUBUN_CD` AS `6Y_YKIHO_GUBUN_CD`,
    T2.`BMI` AS `6Y_BMI`,
    T2.`BP` AS `6Y_BP`,
    T2.`BLDS` AS `6Y_BLDS`,
    T2.`TOT_CHOLE` AS `6Y_TOT_CHOLE`,
    T2.`HMG` AS `6Y_HMG`,
    T2.`OLIG_PROTE_CD` AS `6Y_OLIG_PROTE_CD`,
    T2.`SGOT_AST` AS `6Y_SGOT_AST`,
    T2.`SGPT_ALT` AS `6Y_SGPT_ALT`,
    T2.`GAMMA_GTP` AS `6Y_GAMMA_GTP`,
    T2.`SMK_STAT_TYPE_RSPS_CD` AS `6Y_SMK_STAT_TYPE_RSPS_CD`,
    T2.`SMK_TERM_RSPS_CD` AS `6Y_SMK_TERM_RSPS_CD`,
    T2.`DSQTY_RSPS_CD` AS `6Y_DSQTY_RSPS_CD`,
    T2.`DRNK_HABIT_RSPS_CD` AS `6Y_DRNK_HABIT_RSPS_CD`,
    T2.`TM1_DRKQTY_RSPS_CD` AS `6Y_TM1_DRKQTY_RSPS_CD`,
    T2.`EXERCI_FREQ_RSPS_CD` AS `6Y_EXERCI_FREQ_RSPS_CD`
FROM EXP_DATA_2_4YEAR AS T1
INNER JOIN GJ_UNIF AS T2
ON T1.PERSON_ID = T2.PERSON_ID
WHERE T1.`YEAR` = (T2.HCHK_YEAR + 6)	AND
    (T2.`HCHK_YEAR`             IS NOT NULL AND NOT T2.`HCHK_YEAR`                 ="") AND
    (T2.`YKIHO_GUBUN_CD`         IS NOT NULL AND NOT T2.`YKIHO_GUBUN_CD`         ="") AND
    (T2.`BMI`                 IS NOT NULL) AND
    (T2.`BP`                 IS NOT NULL) AND
    (T2.`BLDS`                     IS NOT NULL AND NOT T2.`BLDS`                     ="") AND
    (T2.`TOT_CHOLE`             IS NOT NULL AND NOT T2.`TOT_CHOLE`                 ="") AND
    (T2.`HMG`                     IS NOT NULL AND NOT T2.`HMG`                     ="") AND
    (T2.`OLIG_PROTE_CD`         IS NOT NULL AND NOT T2.`OLIG_PROTE_CD`             ="") AND
    (T2.`SGOT_AST`                 IS NOT NULL AND NOT T2.`SGOT_AST`                 ="") AND
    (T2.`SGPT_ALT`                 IS NOT NULL AND NOT T2.`SGPT_ALT`                 ="") AND
    (T2.`GAMMA_GTP`             IS NOT NULL AND NOT T2.`GAMMA_GTP`                 ="") AND
    (T2.`SMK_STAT_TYPE_RSPS_CD`    IS NOT NULL AND NOT T2.`SMK_STAT_TYPE_RSPS_CD`    ="") AND
    (T2.`SMK_TERM_RSPS_CD`         IS NOT NULL AND NOT T2.`SMK_TERM_RSPS_CD`         ="") AND
    (T2.`DSQTY_RSPS_CD`         IS NOT NULL AND NOT T2.`DSQTY_RSPS_CD`             ="") AND
    (T2.`DRNK_HABIT_RSPS_CD`     IS NOT NULL AND NOT T2.`DRNK_HABIT_RSPS_CD`     ="") AND
    (T2.`TM1_DRKQTY_RSPS_CD`     IS NOT NULL AND NOT T2.`TM1_DRKQTY_RSPS_CD`     ="") AND
    (T2.`EXERCI_FREQ_RSPS_CD`     IS NOT NULL AND NOT T2.`EXERCI_FREQ_RSPS_CD`     ="")
)
;
UPDATE EXP_DATA_2_6YEAR
SET
`6Y_HMG`=CLASS_HMG(SEX,`6Y_HMG`)
WHERE
(`6Y_HMG` IS NOT NULL AND NOT `6Y_HMG`="")
;
UPDATE EXP_DATA_2_6YEAR
SET
`6Y_GAMMA_GTP`=CLASS_GTP(SEX,`6Y_GAMMA_GTP`)
WHERE
(`6Y_GAMMA_GTP` IS NOT NULL AND NOT `6Y_GAMMA_GTP`="")