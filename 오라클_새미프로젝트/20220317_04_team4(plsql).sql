SELECT USER
FROM DUAL;
--==>>TEAM4

--------------------------------------------------------------------------------
-- ���ν��� ��: PRC_TC_INSERT(�̸�, �ֹι�ȣ)
-- �����ڰ� ���ν����� �����Ű��, 
-- �������̺� �����Ͱ� �Էµȴ�.
CREATE OR REPLACE PROCEDURE PRC_TC_INSERT
(V_NAME IN TEACHER_REGISTER.NAME%TYPE
,V_SSN  IN TEACHER_REGISTER.SSN%TYPE
)
IS
    V_TEACHER_CODE  TEACHER_REGISTER.TEACHER_CODE%TYPE;
    V_PASSWORD      TEACHER_REGISTER.PASSWORD%TYPE;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(TEACHER_CODE,2))),0)  + 1 INTO V_TEACHER_CODE
    FROM TEACHER_REGISTER;
    
    V_TEACHER_CODE := 'T' || TO_CHAR(V_TEACHER_CODE);
    
    V_PASSWORD := SUBSTR(V_SSN,7);
    
   INSERT INTO  TEACHER_REGISTER(TEACHER_CODE,PASSWORD,NAME,SSN)
   VALUES(V_TEACHER_CODE,V_PASSWORD, V_NAME, V_SSN);
    
END;
--==>>Procedure PRC_TC_INSERT��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------
