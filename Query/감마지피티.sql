#감마지피티
DELIMITER $$

CREATE FUNCTION CLASS_GTP(input1 text,input2 text) RETURNS int
	DETERMINISTIC
BEGIN
	IF input1=1 THEN
    	IF input2<11 THEN
        	RETURN 9;
    	ELSEIF input2<64 THEN
        	RETURN 0;
    	ELSEIF input2<78 THEN
        	RETURN 1;
    	ELSE
        	RETURN 2;
    	END IF;
	ELSEIF input1=2 THEN
    	IF input2<8 THEN
        	RETURN 9;
    	ELSEIF input2<36 THEN
        	RETURN 0;
    	ELSEIF input2<46 THEN
        	RETURN 1;
    	ELSE
        	RETURN 2;
    	END IF;
	END IF;
END;
