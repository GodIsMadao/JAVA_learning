CREATE PROCEDURE p2( IN TRY_SQLCODE VARCHAR(10))   
DYNAMIC RESULT SETS 1   
LANGUAGE SQL  
  
BEGIN   
DECLARE SQLCODE    INT;   
         DECLARE ERR5        VARCHAR(40) default '初始值';   
         DECLARE ERR3        VARCHAR(40);   
         DECLARE ERR2        VARCHAR(40);   
         DECLARE ERR1        VARCHAR(40);   
         DECLARE ERRID     VARCHAR(40);  
  
         DECLARE CUR_SQLCODE CURSOR WITH RETURN TO CLIENT FOR SELECT * FROM RI;  
  
         DECLARE CONTINUE HANDLER FOR SQLEXCEPTION   
                         SET ERR5 = char(SQLCODE);   
         SELECT ID   
             INTO ERRID   
             FROM RINGS   
            WHERE ID=TRY_SQLCODE; --创造各种sqlcode条件的参数  
  
         IF SQLCODE = 100 THEN   
             SET ERR1='NOT FOUND';   
                     INSERT INTO RINGS VALUES('1',ERR1);   
         ELSEIF SQLCODE < 0 THEN   
             SET ERR3 = 'EXCEPTION';   
                     INSERT INTO RINGS VALUES('3',ERR3);   
         END IF;  
  
         INSERT INTO RINGS VALUES('100',ERR5);   
         COMMIT;   
         OPEN CUR_SQLCODE;   
END