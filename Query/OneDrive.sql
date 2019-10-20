#UPDATE SAFE MODE
SET SQL_SAFE_UPDATES = 0;
#GJ_1
SELECT COUNT(*) FROM gj_1 WHERE LDL콜레스테롤 >= 190 OR HDL콜레스테롤 < 40;

#GJ_2
create table gj_2
select *
from gj_1;

#고지혈증 labeling
ALTER TABLE `thesis`.`gj_2` 
DROP COLUMN `기준년도`;

ALTER TABLE `thesis`.`gj_2` 
CHANGE COLUMN `신장(5Cm단위)` `신장` INT(11) NULL DEFAULT NULL ,
CHANGE COLUMN `체중(5Kg 단위)` `체중` INT(11) NULL DEFAULT NULL ;


#GJ_3

CREATE TABLE GJ_3
SELECT `gj_2`.`가입자일련번호`,
    `gj_2`.`성별코드`,
    `gj_2`.`연령대코드(5세단위)`,
    `gj_2`.`시도코드`,
    `gj_2`.`시력(좌)`,
    `gj_2`.`시력(우)`,
    `gj_2`.`청력(좌)`,
    `gj_2`.`청력(우)`,
    `gj_2`.`수축기혈압`,
    `gj_2`.`이완기혈압`,
    `gj_2`.`식전혈당(공복혈당)`,
    `gj_2`.`총콜레스테롤`,
    `gj_2`.`트리글리세라이드`,
    `gj_2`.`HDL콜레스테롤`,
    `gj_2`.`LDL콜레스테롤`,
    `gj_2`.`혈색소`,
    `gj_2`.`요단백`,
    `gj_2`.`혈청크레아티닌`,
    `gj_2`.`(혈청지오티)AST`,
    `gj_2`.`(혈청지오티)ALT`,
    `gj_2`.`감마지티피`,
    `gj_2`.`흡연상태`,
    `gj_2`.`음주여부`,
    `gj_2`.`구강검진 수검여부`,
    `gj_2`.`치석`,
    gj_2.허리둘레/gj_2.신장 as whtr
FROM `thesis`.`gj_2`;




ALTER table gj_3 add 고지혈증 int(11);
UPDATE gj_3 set 고지혈증 = 1 where LDL콜레스테롤 >= 190 OR HDL콜레스테롤 < 40;
UPDATE gj_3 set 고지혈증 = 0 where NOT(LDL콜레스테롤 >= 190 OR HDL콜레스테롤 < 40);
ALTER table gj_3 drop LDL콜레스테롤;
ALTER table gj_3 drop HDL콜레스테롤;


SELECT COUNT(*) FROM gj_2 WHERE 고지혈증 = 0;

#GJ4

CREATE TABLE GJ_4
SELECT `gj_3`.`가입자일련번호`,
    `gj_3`.`성별코드`,
    `gj_3`.`연령대코드(5세단위)`,
    `gj_3`.`시도코드`,
    `gj_3`.`시력(좌)`,
    `gj_3`.`시력(우)`,
    `gj_3`.`청력(좌)`,
    `gj_3`.`청력(우)`,
    `gj_3`.`식전혈당(공복혈당)`,
    `gj_3`.`총콜레스테롤`,
    `gj_3`.`트리글리세라이드`,
    `gj_3`.`혈색소`,
    `gj_3`.`요단백`,
    `gj_3`.`혈청크레아티닌`,
    `gj_3`.`(혈청지오티)AST`,
    `gj_3`.`(혈청지오티)ALT`,
    `gj_3`.`감마지티피`,
    `gj_3`.`흡연상태`,
    `gj_3`.`음주여부`,
    `gj_3`.`구강검진 수검여부`,
    `gj_3`.`치석`,
    `gj_3`.`whtr`,
    CLASS_BP(수축기혈압,이완기혈압) AS 혈압,
    `gj_3`.`고지혈증`
FROM `thesis`.`gj_3`;

UPDATE gj_4 SET `식전혈당(공복혈당)` = CLASS_BLDS(`식전혈당(공복혈당)`);
UPDATE gj_4 SET `총콜레스테롤`=CLASS_CHOLE(`총콜레스테롤`);
UPDATE gj_4 SET `혈색소`=CLASS_HMG(`성별코드`,`혈색소`);
UPDATE gj_4 SET `(혈청지오티)AST`=CLASS_AST(`(혈청지오티)AST`);
UPDATE gj_4 SET `(혈청지오티)ALT`=CLASS_ALT(`(혈청지오티)ALT`);
UPDATE gj_4 SET `감마지티피`=CLASS_GTP(`성별코드`,`감마지티피`);
UPDATE gj_4 SET `whtr`=CLASS_WHTR(`whtr`);

