#혈색소
DELIMITER $$

CREATE FUNCTION CLASS_HMG(input1 text,input2 text) RETURNS int
	DETERMINISTIC
BEGIN
    IF input1=1 THEN
    	IF input2>16.5 THEN
   		 RETURN 9;
   	 ELSEIF input2>=13 THEN
   		 RETURN 0;
   	 ELSEIF input2>=12 THEN
   		 RETURN 1;
   	 ELSE
   		 RETURN 2;
   	 END IF;
    ELSEIF input1=2 THEN
   	 IF input2>15.5 THEN
   		 RETURN 9;
   	 ELSEIF input2>=12 THEN
   		 RETURN 0;
   	 ELSEIF input2>=10 THEN
   		 RETURN 1;
   	 ELSE
   		 RETURN 2;
   	 END IF;
    END IF;
END;
