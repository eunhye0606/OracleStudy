SELECT USER
FROM DUAL;
--==>>TEAM4
--------------------------------------------------------------------------------
SELECT LPAD('1',6,0)
FROM DUAL;
--==>>000001
--------------------------------------------------------------------------------
--1.프로시저 명: PRC_TC_INSERT(이름, 주민번호)
EXEC PRC_TC_INSERT('백이진',8607071234567);

SELECT *
FROM TEACHER_REGISTER;
/*
T1	    1234567	자비스	7005051234567	2022-03-18
T2	    1234567	김아이언맨	8611191234567	2022-03-18
T3	    1234567	남주혁	8801031234567	2022-03-18
T0004	1234567	백이진	8607071234567	2022-03-19
*/SELECT USER
FROM DUAL;
--==>>TEAM4
--------------------------------------------------------------------------------
SELECT LPAD('1',6,0)
FROM DUAL;
--==>>000001
--------------------------------------------------------------------------------
--1.프로시저 명: PRC_TC_INSERT(이름, 주민번호)
EXEC PRC_TC_INSERT('백이진',8607071234567);

SELECT *
FROM TEACHER_REGISTER;
/*
T1	    1234567	자비스	7005051234567	2022-03-18
T2	    1234567	김아이언맨	8611191234567	2022-03-18
T3	    1234567	남주혁	8801031234567	2022-03-18
T0004	1234567	백이진	8607071234567	2022-03-19
*/
SELECT *
FROM MANAGER_REGISTER;                           

SET SERVEROUTPUT ON;

SELECT *
FROM MANAGER_REGISTER;
EXEC PRC_TC_SELECT('M1');

EXEC PRC_SUB_OP_SELECT('M1');

DESC MANAGER_REGISTER;
INSERT INTO MANAGER_REGISTER
VALUES('M1','1234',SYSDATE);



SELECT COUNT(*) 
FROM TEACHER_REGISTER
WHERE TEACHER_CODE = 'T1';

EXEC PRC_LOGIN('M1','1234');
--==>>로그인 성공~!!!

EXEC PRC_LOGIN('M2','1234');
--==>>ORA-20100: 아이디가 일치하지 않습니다.

EXEC PRC_LOGIN('M1','9999');
--==>>ORA-20103: 비밀번호가 일치하지 않습니다.
