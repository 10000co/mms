
-- 회원정보
DROP TABLE members;
CREATE TABLE members (
	userid 		VARCHAR2(100) PRIMARY KEY,
	userpwd 	VARCHAR2(100) NOT NULL,
	username 	VARCHAR2(100) NOT NULL,
	gender 		VARCHAR2(50),	
	birth 		DATE,
	phone 		VARCHAR2(15),
	height		NUMBER,
	weight		NUMBER,
	address 	VARCHAR2(2000)
);

DROP SEQUENCE intakeInfo_seq;
CREATE SEQUENCE intakeInfo_seq;

DROP TABLE intakeInfo;
CREATE TABLE intakeInfo(
	pnum		NUMBER PRIMARY KEY,
	userid		VARCHAR(100) NOT NULL,
	num			NUMBER,
	desc_kor	VARCHAR2(2000),
	nutr_cont1	FLOAT,
	nutr_cont2	FLOAT,
	nutr_cont3	FLOAT,
	nutr_cont4	FLOAT,
	nutr_cont5	FLOAT,
	nutr_cont6	FLOAT,
	nutr_cont7	FLOAT,
	nutr_cont8	FLOAT,
	nutr_cont9	FLOAT,
	amount		FLOAT,
	regdate		VARCHAR(100)
);

commit;
































-- 음식 정보 데이타(식품안전나라 공공데이타)
CREATE TABLE foodinfo (
	NUM				NUMBER,
	FOOD_CD			NUMBER,
	FDGRP_NM		VARCHAR2(2000),
	DESC_KOR		VARCHAR2(2000),
	SERVING_WT		FLOAT,
	NUTR_CONT1		FLOAT,
	NUTR_CONT2		FLOAT,
	NUTR_CONT3		FLOAT,
	NUTR_CONT4		FLOAT,
	NUTR_CONT5		FLOAT,
	NUTR_CONT6		FLOAT,
	NUTR_CONT7		FLOAT,
	NUTR_CONT8		FLOAT,
	NUTR_CONT9		FLOAT,
	ANIMAL_PLANT	VARCHAR2(2000),
	BGN_YEAR		NUMBER
);

commit;


