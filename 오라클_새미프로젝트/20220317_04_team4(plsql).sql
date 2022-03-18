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
/*
CREATE OR REPLACE PROCEDURE PRC_OP_COU_UPDATE
(V_TEACHER_CODE IN COURSE_OPEN.TEACHER_CODE%TYPE)
IS
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = V_TEACHER_CODE
    WHERE TEACHER_CODE IS NULL;
END;
*/ --�����Ϸ�
--==>>Procedure PRC_OP_COU_UPDATE��(��) �����ϵǾ����ϴ�.


-- �θ����̺�(TEACHER_REGISTER���̺��� �������� ������ ���,
--            �ڽ� ���̺�(COURSE_OPEN�� TEACHER_CODE�� NULL ������ ����)
-- �������谡 ���� ���� �ٷ� DELETE ����!
CREATE OR REPLACE TRIGGER TRG_TC_DELETE
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
--2022-03-18 �۾�����
--�� Ʈ���� �� ����
-- �θ����̺�(TEACHER_REGISTER���̺��� �������� ������ ���,
--            �ڽ� ���̺�(COURSE_OPEN�� TEACHER_CODE�� NULL ������ ����)
-- �������谡 ���� ���� �ٷ� DELETE ����!
CREATE OR REPLACE TRIGGER TRG_TC_DELETE
       BEFORE
       DELETE ON TEACHER_REGISTER
       FOR EACH ROW
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = NULL
    WHERE TEACHER_CODE = :OLD.TEACHER_CODE; 
END;
--==>>Trigger TRG_TC_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------
--�� �������� ���ν��� ����
--�� ���ν��� �� : PRC_OP_COU_INSERT(�����ڵ�, ���۳�¥, ���ᳯ¥, ���ǽ��ڵ�)
--   �����ڰ� ������ �����Ѵ�.
CREATE OR REPLACE PROCEDURE PRC_OP_COU_INSERT
(N_CODE      IN COURSE.COURSE_CODE%TYPE                     --�����ڵ�
,N_SDATE    IN COURSE_OPEN.START_DATE%TYPE                  --���۳�¥
,N_EDATE    IN COURSE_OPEN.END_DATE%TYPE                    --���ᳯ¥
,N_CLACODE      IN CLASSROOM_REGISTER.CLASSROOM_CODE%TYPE     --���ǽ��ڵ�. 
)
IS
    V_OP_COURSE_CODE    COURSE_OPEN.OP_COURSE_CODE%TYPE;    -- ���������ڵ�
    --V_COURSE_CODE       COURSE.COURSE_CODE%TYPE;       --����������� �ڵ�� ã�Ƽ�
    --V_CLASSROOM_CODE    CLASSROOM_REGISTER.CLASSROOM_CODE%TYPE;    --���ǽǹ����� �ڵ�� ã�Ƽ�
BEGIN
    
    -- ���������ڵ� �ڵ����� �ο�
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_COURSE_CODE,3))),0) + 1 INTO V_OP_COURSE_CODE
    FROM COURSE_OPEN;
    
    V_OP_COURSE_CODE := 'CO' || V_OP_COURSE_CODE;
    
    
    -- ������ �Է� ������ �ڵ�ȭ�ϱ�
    /*
    SELECT COURSE_CODE INTO V_COURSE_CODE
    FROM COURSE
    WHERE COURSE_NAME = N_NAME;     --'�ڹٰ���'
    
    -- ���ǽ� �Է� ������ �ڵ�ȭ�ϱ�
    SELECT CLASSROOM_CODE INTO V_CLASSROOM_CODE
    FROM CLASSROOM_REGISTER
    WHERE CLASSROOM_NAME = N_CROOM; --'1501'
    */
    INSERT INTO COURSE_OPEN
    (OP_COURSE_CODE ,COURSE_CODE ,CLASSROOM_CODE ,START_DATE ,END_DATE) 
    VALUES(V_OP_COURSE_CODE,  N_CODE,N_CLACODE, TO_DATE(N_SDATE,'YYYY-MM-DD') ,TO_DATE(N_EDATE,'YYYY-MM-DD'));
    
END;
--==>>Procedure PRC_OP_COU_INSERT��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------
--�� ���� �Է� ���ν���
--   ���ν����� : PRC_OP_SUB_INSERT
-- (���������ڵ�, �����ڵ�, ���۳�¥, ���ᳯ¥, �����ڵ�, �����ڵ�)
-- ������(���������ڵ�� ��ġ�Ҷ� �ű� ������� ��ġ�ϴ��� �Ǵ�)
-- ����Ⱓ�� �����Ⱓ�ȿ� ���ؾ� �Ѵ�.
-- ���� �Ⱓ�� ���ļ��� �ȵȴ�. 

--���,�ʱ�,�Ǳ������ NN�� ����. �����Է�? ������Ʈ?
--���� �ϴ� �� �� �����ڰ� ���񰳼� ����̱� ������
-- ����ʱ�Ǳ�� ������ ����!

CREATE OR REPLACE PROCEDURE PRC_OP_SUB_INSERT
(V_OP_COURSE_CODE   IN COURSE_OPEN.OP_COURSE_CODE%TYPE     --���������ڵ�
,V_SUBJECT_CODE     IN SUBJECT.SUBJECT_CODE%TYPE           --�����ڵ�
,V_START_DATE       IN SUBJECT_OPEN.START_DATE%TYPE        --���۳�¥
,V_END_DATE         IN SUBJECT_OPEN.END_DATE%TYPE          --���ᳯ¥
,V_TEXTBOOK_CODE    IN TEXTBOOK.TEXTBOOK_CODE%TYPE         --�����ڵ�
,V_TEACHER_CODE     IN TEACHER_REGISTER.TEACHER_CODE%TYPE  --�����ڵ�
)
IS
    --�ֿ� ���� ����
    V_OP_SUBJECT_CODE    SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE; --���񰳼��ڵ�
    
    V_TCCODE    TEACHER_REGISTER.TEACHER_CODE%TYPE; -- ������ ������� ����
    
    V_SUB_COUNT  NUMBER;  -- �����ȿ� ���� ��ִ��� ���� ����.
    V_COU_SDATE COURSE_OPEN.START_DATE%TYPE;    --�������۳�¥
    V_COU_EDATE COURSE_OPEN.END_DATE%TYPE;      --�������ᳯ¥
    V_SUB_EDATE SUBJECT_OPEN.END_DATE%TYPE;     --�������ᳯ¥
    
    USER_DEFINE_ERROR1  EXCEPTION;  -- 20021 , ������ �������� ��������
    USER_DEFINE_ERROR2  EXCEPTION;  -- 20022 , �Է������� ������ �ش������ ������ �ٸ�����
    USER_DEFINE_ERROR3  EXCEPTION;  --20023,'����Ⱓ�� �����Ⱓ�� ���Ե��� �ʽ��ϴ�.'
    USER_DEFINE_ERROR4  EXCEPTION;  --20024,'����Ⱓ�� �ߺ��˴ϴ�. �ٽ� Ȯ�����ּ���'
BEGIN  
    -- �ش� ������ �����ڵ带 �޾Ƽ� �������� ��´�.
    SELECT TEACHER_CODE INTO V_TCCODE
    FROM COURSE_OPEN
    WHERE OP_COURSE_CODE = V_OP_COURSE_CODE;
   
    -- �����ڵ尡 NULL �̸� �����߻�.
    IF (V_TCCODE IS NULL)
    THEN RAISE USER_DEFINE_ERROR1;
    -- �����ڵ尡 ���������� �����ڵ�� �ٸ��� �����߻�.
    ELSIF (V_TEACHER_CODE != V_TCCODE)
    THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- �����Ⱓ ���� ����Ⱓ�� ���ԵǾ�� �Ѵ�.
    -- 1. �������۳�¥, ���ᳯ¥ ������ ���.
    SELECT START_DATE, END_DATE INTO V_COU_SDATE, V_COU_EDATE
    FROM COURSE_OPEN
    WHERE OP_COURSE_CODE = V_OP_COURSE_CODE;
    
    -- �����߻����
    -- �����Ⱓ�� ���۳�¥ - ����Ⱓ�� ���۳�¥  > 0
    -- ����Ⱓ�� ���ᳯ¥ - �����Ⱓ�� ���ᳯ¥ > 0
    IF (V_COU_SDATE - V_START_DATE > 0 OR V_END_DATE - V_COU_EDATE > 0)
    THEN RAISE USER_DEFINE_ERROR3;
    END IF;
      
    -- ����Ⱓ������ �ߺ��ż��� �ȵȴ�.
    -- �ش� ������ ���� �������� ���ᳯ¥�� �������� ��´�.
    -- ������ ������ ������ V_SUB_EDATE���� NULL���� ����.
    SELECT MAX(END_DATE) INTO V_SUB_EDATE
    FROM SUBJECT_OPEN
    WHERE OP_COURSE_CODE = V_OP_COURSE_CODE;
    -- �ִٸ� �� ���� �ֱ��� END_DATE - �ԷµǴ� ���۳�¥ > 0
    IF (V_SUB_EDATE IS NOT NULL AND (V_SUB_EDATE - V_START_DATE > 0))
    THEN RAISE USER_DEFINE_ERROR4;
    END IF;
    -- ���ٸ� �� �ԷµǴ� ���� ù��° ������ �ȴ�.
   
    -- ���񰳼��ڵ忡 �� ��Ƴ���
    -- SUBJECT �ڵ� : SO1  
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_SUBJECT_CODE,3))),0) + 1 INTO V_OP_SUBJECT_CODE
    FROM SUBJECT_OPEN;
    
    V_OP_SUBJECT_CODE := 'SO' || V_OP_SUBJECT_CODE;
    
    
    -- INSERT ������
    INSERT INTO SUBJECT_OPEN
    (OP_SUBJECT_CODE, SUBJECT_CODE, TEXTBOOK_CODE, OP_COURSE_CODE, START_DATE, END_DATE)
    VALUES(V_OP_SUBJECT_CODE, V_SUBJECT_CODE, V_TEXTBOOK_CODE, V_OP_COURSE_CODE, TO_DATE(V_START_DATE,'YYYY-MM-DD') ,TO_DATE(V_END_DATE,'YYYY-MM-DD') );

    --����ó��
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
        THEN RAISE_APPLICATION_ERROR(-20021, '������ ������ ������ �������� �ʾҽ��ϴ�. ������ ������ ������ ��, �ٽ� �Է����ּ���.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR2
        THEN RAISE_APPLICATION_ERROR(-20022, '���������� ���񱳼��� ��ġ�ؾ� �մϴ�. �������� �ٽ� Ȯ�����ּ���');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR3
        THEN RAISE_APPLICATION_ERROR(-20023,'����Ⱓ�� �����Ⱓ�� ���Ե��� �ʽ��ϴ�.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR4
        THEN RAISE_APPLICATION_ERROR(-20024,'����Ⱓ�� �ߺ��˴ϴ�. �ٽ� Ȯ�����ּ���');
        ROLLBACK;
    --Ŀ��
    COMMIT;
END;
--==>>Procedure PRC_OP_SUB_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------
----------------------�Լ��� ����ε� .. �̰� �ϴ� ����
DROP FUNCTION FN_SUB_OP_DATE;
--==>>Function FN_SUB_OP_DATE��(��) �����Ǿ����ϴ�.
--�� ����Ⱓ�� ���Ӽ� �� �Լ�
--   �Լ��� : FN_SUB_OP_DATE(�����ڵ�,������۳�¥,�������ᳯ¥)
/*
CREATE OR REPLACE FUNCTION FN_SUB_OP_DATE
--FN_SUB_OP_DATE(V_OP_COURSE_CODE,V_START_DATE,V_END_DATE)
(V_CODE COURSE_OPEN.OP_COURSE_CODE%TYPE   -- �����ڵ�
, V_SDATE SUBJECT_OPEN.START_DATE%TYPE   -- ������۳�¥
, V_EDATE SUBJECT_OPEN.END_DATE%TYPE    -- �������ᳯ¥
)
RETURN NUMBER
IS
    --�ֿ亯������
    V_COUNT NUMBER;    -- �ش������ �����ִ���
    V_FLAG  NUMBER;    -- ����Ⱓ�� �����Ⱓ�� �����ϴ���, ����Ⱓ�� �����ϴ���
    V_NUM   NUMBER;    -- �Ǵܰ��(0 ��ȿ�� ��¥, 1 ���۳�¥ �߸�����, 2��������¥ �߸�����)
    
    V_SUB_END_DATE  SUBJECT_OPEN.END_DATE%TYPE; -- �������ᳯ¥ ��� ����
    V_COU_START_DATE  COURSE_OPEN.START_DATE%TYPE;  -- �������ᳯ¥ ��� ����
    V_COU_END_DATE  COURSE_OPEN.END_DATE%TYPE;  -- �������ᳯ¥ ��� ����
BEGIN
    -- ���� �������� ������ � �ִ��� Ȯ��. 
    SELECT COUNT(*) INTO V_COUNT
    FROM  COURSE_OPEN
    WHERE COURSE_CODE = V_CODE;
    
    -- �������۳�¥, �������ᳯ¥ ������ ��� (V_COU_START_DATE, V_COU_END_DATE)
    SELECT START_DATE, END_DATE INTO V_COU_START_DATE, V_COU_END_DATE
    FROM COURSE_OPEN
    WHERE COURSE_CODE = V_CODE;
    
    -- �����帶���� ��¥ ���
    SELECT T.END_DATE INTO V_SUB_END_DATE
    FROM
    (
        SELECT END_DATE
        FROM SUBJECT_OPEN
        WHERE OP_COURSE_CODE = V_CODE
        ORDER BY END_DATE DESC
    )T 
    WHERE ROWNUM = 1;
    
    -- 0 ���� ����/ 1 �����߻�
    -- 1. 0�� �� 0 ����
    --    �������۳�¥ != ������۳�¥(1����)
    ----------------------------------------------------------------------------
    -- 2. 0�� �ʰ�. �� ���� ������ ��¥ != ������۳�¥(�Ѱܹ���) (���۳�¥ �ٽ� �Է� 1����)
    -- 3.              ������������¥ > �������ᳯ¥(�Ѱܹ���) (��������¥ �ٽ��Է� 2����)
    -- 4. �� �����ϸ� 0���� 
    
    IF (V_COUNT = 0)
    THEN 
        IF (V_COU_START_DATE - V_SDATE = 0)
        THEN V_NUM := 0;
        ELSE V_NUM := 1;
        END IF;
    ELSIF (V_COUNT > 0)
    THEN 
        IF (V_SUB_END_DATE - V_SDATE != 0)
        THEN V_NUM := 1;
        ELSIF (V_COU_END_DATE - V_EDATE > 0)
        THEN V_NUM := 2;
        END IF;
    ELSE 
        V_NUM := 0;
    END IF;
    RETURN V_NUM;
END;
--==>>Function FN_SUB_OP_DATE��(��) �����ϵǾ����ϴ�.
*/

--------------------------------------------------------------------------------
--�� ������� ���ν��� ����
--   ���ν��� �� : FN_SUNGJUK_PRINT(�����ڵ峪 �л��ڵ�)
--             SUBSTR(�����ڵ�,1,1) �� T
--             SUBSTR(�л��ڵ�,1,1) �� S
--   ���� = T OR S ���
--   IF T �̸� ������������ ���
--   ELSIF S �̸� �л��������� ���

--  ������ �л��� ��ġ�� ����� �л���, �����, ������۳�¥, �������ᳯ¥, �����, ���, �Ǳ�, �ʱ�, ����, ���
--  �� �Լ�����
--  FN_COMMON_PRINT(�����ڵ�)
--  
--  ������ : �ߵ�Ż������
--  �л��� : ������

--1. �����϶�
--   �������:�����, ������۳�¥, �������ᳯ¥, �����, �л���, ���, �Ǳ�, �ʱ�, ����, ���, �ߵ�Ż������
--   ������� 1. �ߵ� Ż���� �л��� �̹� ������ ���� ���ؼ��� ������ ��µȴ�.
--   ������� 2. �ߵ� Ż�� ��� ���θ� Ȯ���ϵ��� ����Ѵ�.
--2. �л��϶�
--   �������: �л���, ������, �����, ������۳�¥, �������ᳯ¥, �����, ���, �Ǳ�,�ʱ�,����, ���
--   ������� 1. ���� ���� ������ ����Ѵ�.
--   ������� 2. ���� ������ ���� ��� ���������� ������ �� �� �ִ�.







