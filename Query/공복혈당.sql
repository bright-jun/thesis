#공복혈당

DELIMITER $$

CREATE FUNCTION CLASS_BLDS(input1 text) RETURNS int
	DETERMINISTIC
BEGIN
	IF input1<100 THEN
    	RETURN 0;
	ELSEIF input1<126 THEN
    	RETURN 1;
	ELSE
    	RETURN 2;
	END IF;
END;



