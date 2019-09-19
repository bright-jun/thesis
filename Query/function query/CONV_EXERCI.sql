DELIMITER $$

CREATE FUNCTION CONV_EXERCI(input1 text,input2 text,input3 text) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE EXER_SUM int;
    SET EXER_SUM= input1*10+input2*5+input3*3;
	IF EXER_SUM=0 THEN
		RETURN 1;
	ELSEIF EXER_SUM<5 THEN
		RETURN 2;
	ELSEIF EXER_SUM<10 THEN
		RETURN 3;
	ELSEIF EXER_SUM<20 THEN
		RETURN 4;
	ELSE
		RETURN 5;
	END IF;
END