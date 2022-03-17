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
-- COURSE_OPEN ���̺��� TEACHER_CODE�� NULL ���� �÷�
-- ��, TRG_TC_UPDATE�� ���ؼ� TEACHER_CODE�� NULL���� �� ���
-- ���ν��� �� : PRC_OP_COU_UPDATE ����
-- ���� �����̱� ������ NULL���̰ų� �������̺� �ִ� TEACHER_CODE�� 
-- ���ν��� �Ű������� ���� ����.
CREATE OR REPLACE PROCEDURE PRC_OP_COU_UPDATE
(V_TEACHER_CODE IN COURSE_OPEN.TEACHER_CODE%TYPE)
IS
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = V_TEACHER_CODE
    WHERE TEACHER_CODE IS NULL;
END;
--==>>Procedure PRC_OP_COU_UPDATE��(��) �����ϵǾ����ϴ�.


-- �θ����̺�(TEACHER_REGISTER���̺��� �������� ������ ���,
--            �ڽ� ���̺�(COURSE_OPEN�� TEACHER_CODE�� NULL ������ ����)
-- �������谡 ���� ���� �ٷ� DELETE ����!
CREATE OR REPLACE TRIGGER TRG_TC_UPDATE
       BEFORE
       DELETE ON TEACHER_REGISTER
       FOR EACH ROW
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = NULL
    WHERE TEACHER_CODE = :OLD.TEACHER_CODE;
    --NULL���� �ٸ������ڵ�� �ٲٴ� ���ν��� ȣ��
    -- ������ UPDATE�� WHERE ���ǿ� �����.. 
END;
--==>>Trigger TRG_TC_UPDATE��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------
--�� ���ν��� �� : PRC_OP_COU_INSERT(������, ���۳�¥, ���ᳯ¥, ���ǽ�)
--   �����ڰ� ������ �����Ѵ�.
CREATE OR REPLACE PROCEDURE PRC_OP_COU_INSERT
(N_NAME      IN COURSE.COURSE_NAME%TYPE                     --������
,N_SDATE    IN COURSE_OPEN.START_DATE%TYPE                  --���۳�¥
,N_EDATE    IN COURSE_OPEN.END_DATE%TYPE                    --���ᳯ¥
,N_CROOM      IN CLASSROOM_REGISTER.CLASSROOM_NAME%TYPE     --���ǽ��̸�. 
)
IS
    V_OP_COURSE_CODE    COURSE_OPEN.OP_COURSE_CODE%TYPE;    -- ���������ڵ�
    V_COURSE_CODE       COURSE.COURSE_CODE%TYPE;       --����������� �ڵ�� ã�Ƽ�
    V_CLASSROOM_CODE    CLASSROOM_REGISTER.CLASSROOM_CODE%TYPE;    --���ǽǹ����� �ڵ�� ã�Ƽ�
BEGIN
    
    -- ���������ڵ� �ڵ����� �ο�
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_COURSE_CODE,3))),0) + 1 INTO V_OP_COURSE_CODE
    FROM COURSE_OPEN;
    
    V_OP_COURSE_CODE := 'CO' || V_OP_COURSE_CODE;
    
    
    -- ������ �Է� ������ �ڵ�ȭ�ϱ�
    SELECT COURSE_CODE INTO V_COURSE_CODE
    FROM COURSE
    WHERE COURSE_NAME = N_NAME;     --'�ڹٰ���'
    
    -- ���ǽ� �Է� ������ �ڵ�ȭ�ϱ�
    SELECT CLASSROOM_CODE INTO V_CLASSROOM_CODE
    FROM CLASSROOM_REGISTER
    WHERE CLASSROOM_NAME = N_CROOM; --'1501'
    
    INSERT INTO COURSE_OPEN
    (OP_COURSE_CODE ,COURSE_CODE ,CLASSROOM_CODE ,START_DATE ,END_DATE) 
    VALUES(V_OP_COURSE_CODE,  V_COURSE_CODE,  V_CLASSROOM_CODE, TO_DATE(N_SDATE,'YYYY-MM-DD') ,TO_DATE(N_EDATE,'YYYY-MM-DD'));
    
END;
--==>>Procedure PRC_OP_COU_INSERT��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------















