SELECT USER
FROM DUAL;
--==>>TEAM4
--------------------------------------------------------------------------------
-- [�������̺� ������ �ִ� ���ν���]
--1.���ν��� ��: PRC_TC_INSERT(�̸�, �ֹι�ȣ)
--  ���ν��� ���� ���� : TEACHER_REGISTER ���̺� �����ڰ� �������� ���� ���
CREATE OR REPLACE PROCEDURE PRC_TC_INSERT
(V_NAME IN TEACHER_REGISTER.NAME%TYPE
,V_SSN  IN TEACHER_REGISTER.SSN%TYPE
)
IS
    V_TEACHER_CODE  TEACHER_REGISTER.TEACHER_CODE%TYPE; --T0001���� ����.       
    V_PASSWORD      TEACHER_REGISTER.PASSWORD%TYPE;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(TEACHER_CODE,2))),0)  + 1 INTO V_TEACHER_CODE
    FROM TEACHER_REGISTER;
    
    V_TEACHER_CODE := 'T' || LPAD(TO_CHAR(V_TEACHER_CODE),4,0);
    
    V_PASSWORD := SUBSTR(V_SSN,7);
    
   INSERT INTO  TEACHER_REGISTER(TEACHER_CODE,PASSWORD,NAME,SSN)
   VALUES(V_TEACHER_CODE,V_PASSWORD, V_NAME, V_SSN);
    
END;
--------------------------------------------------------------------------------
--2. �����ڰ� ������ ��� ������ ����ϴ� SELECT ����     
-- [�����ڰ� �������� ����ϴ� ���ν���]
-- �����ڴ� ��ϵ� ��� �������� ������ ����Ͽ� �� �� �־�� �Ѵ�
-- ���ν��� �� : PRC_TC_SELECT(�Ŵ����ڵ�)
-- ���ν��� �������� : �����ڴ� ��� ���� ������ ����� �� �ִ�.
-- �������
-- (1). �Ŵ����� ���������� ����� �� �ִ�.
-- (2). MANAGER_REGISTER���� MANAGER_CODE�� ��ġ�ϴ��� Ȯ�� ��, ��� ����.
-- ��� �׸� : ������, �����, ����ð�(����, ��), �����, ���ǽ�, �������࿩��
CREATE OR REPLACE PROCEDURE PRC_TC_SELECT
(V_CODE     IN MANAGER_REGISTER.MANAGER_CODE%TYPE
)
IS  
    -- Ŀ�� ������ ��� ���� ����
    V_TC_NAME   TEACHER_REGISTER.NAME%TYPE;     --������
    V_SUB_NAME  SUBJECT.SUBJECT_NAME%TYPE;      --�����
    V_SDATE     SUBJECT_OPEN.START_DATE%TYPE;   --������۽ð�
    V_EDATE     SUBJECT_OPEN.END_DATE%TYPE;     --��������ð�
    V_TEXTBOOK  TEXTBOOK.TEXTBOOK_NAME%TYPE;    --�����
    V_CLANAME   CLASSROOM_REGISTER.CLASSROOM_NAME%TYPE; -- ���ǽǸ�
    V_CHECK     VARCHAR2(20);                   --�������࿩��
    
    -- Ŀ�� ����
    CURSOR CUR_TC_SELECT
    
    IS
    SELECT TC.NAME "������"
       ,S.SUBJECT_NAME "�����"     --�������̺�
       ,SO.START_DATE "������۽ð�" --���񰳼����̺�
       ,SO.END_DATE "��������ð�" --���񰳼����̺�
       ,T.TEXTBOOK_NAME "�����"       --�������̺�
       ,CR.CLASSROOM_NAME"���ǽ�"       --���ǽ����̺�
       ,CASE WHEN CO.START_DATE - SYSDATE < 0 AND CO.END_DATE -SYSDATE >= 0
             THEN '������'
             WHEN CO.START_DATE - SYSDATE >= 0
             THEN '���ǿ���'
             WHEN CO.END_DATE - SYSDATE < 0 
             THEN '��������'
             ELSE '�˼�����.'
             END "�������࿩��" 
    FROM TEACHER_REGISTER TC JOIN COURSE_OPEN CO
    ON TC.TEACHER_CODE = CO.TEACHER_CODE JOIN CLASSROOM_REGISTER CR
    ON CO.CLASSROOM_CODE = CR.CLASSROOM_CODE JOIN SUBJECT_OPEN SO
    ON CO.OP_COURSE_CODE = SO.OP_COURSE_CODE JOIN SUBJECT S
    ON SO.SUBJECT_CODE = S.SUBJECT_CODE JOIN TEXTBOOK T
    ON SO.TEXTBOOK_CODE = T.TEXTBOOK_CODE;
    
    --��ϵ� ���������� �Ǵ��ϴ� �ӽú��� ����
    --�ش� �Ŵ����� ������ V_TEMP�� 0�� ���.
    V_TEMP  NUMBER; 
  
    -- ����� �������� ���� 
    USER_DEFINE_ERROR1   EXCEPTION;  -- 20102,'�����ڰ� �ƴմϴ�. ������������� �����ڸ� �����մϴ�'
    USER_DEFINE_ERROR2   EXCEPTION;  -- 20103,'��ϵ� �����ڰ� �ƴմϴ�.'

BEGIN
    -- �ӽú����� �� ���
    SELECT COUNT(*) INTO V_TEMP
    FROM MANAGER_REGISTER
    WHERE MANAGER_CODE = V_CODE;
    
    -- ���������� Ȯ��. �����ڰ� �ƴϸ� ���� �߻�.
    IF (SUBSTR(V_CODE,1,1) != 'M')
    THEN RAISE USER_DEFINE_ERROR1;
    -- ��ϵ� �����ڰ� �ƴϸ� ���� �߻�
    ELSIF (V_TEMP = 0)
    THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- Ŀ�� ����
    OPEN CUR_TC_SELECT;
    
    -- Ŀ���� ������ ó��
    LOOP
        FETCH CUR_TC_SELECT INTO V_TC_NAME,V_SUB_NAME,V_SDATE,V_EDATE,V_TEXTBOOK,V_CLANAME,V_CHECK;
        
        EXIT WHEN CUR_TC_SELECT%NOTFOUND;
        
        --���
        
        DBMS_OUTPUT.PUT_LINE('������:'||V_TC_NAME||CHR(10) 
                             ||'�����'|| V_SUB_NAME||CHR(10)
                             ||'������۳�¥'||V_SDATE||CHR(10)
                             ||'�������ᳯ¥'||V_EDATE||CHR(10)
                             ||'�����'||V_TEXTBOOK||CHR(10)
                             ||'���ǽǸ�'||V_CLANAME||CHR(10)
                             ||'�������࿩��'||V_CHECK||CHR(10)||CHR(10)
                             ||'----------------------------------------'||CHR(10));
    END LOOP;
    
    -- Ŀ�� Ŭ����
    CLOSE CUR_TC_SELECT;
    
    
    -- ����ó��
    EXCEPTION
    WHEN USER_DEFINE_ERROR1
    THEN RAISE_APPLICATION_ERROR(-20102, '�����ڰ� �ƴմϴ�. ������������� �����ڸ� �����մϴ�.');
    ROLLBACK;
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20103,'��ϵ� �����ڰ� �ƴմϴ�.');
    ROLLBACK;
    
    --Ŀ��
    COMMIT;
END;

--------------------------------------------------------------------------------
--3. Ʈ���� �� : TRG_TC_DELETE
-- Ʈ���� �������� : ���� ���� ���� Ʈ����
--                   �θ����̺�(TEACHER_REGISTER���̺��� �������� ������ ���,
--                   �ڽ� ���̺�(COURSE_OPEN�� TEACHER_CODE�� NULL ������ ����)
--                   �������谡 ���� ���� �ٷ� DELETE ����.
CREATE OR REPLACE TRIGGER TRG_TC_DELETE
       BEFORE
       DELETE ON TEACHER_REGISTER
       FOR EACH ROW
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = NULL
    WHERE TEACHER_CODE = :OLD.TEACHER_CODE; 
END;
--------------------------------------------------------------------------------
--[�����������̺� ������ �ִ� ���ν���]
--4. ���ν��� �� : (�����ڵ�, ��������, ��������, ���ǽ��ڵ�)
--   ���ν��� �������� : �����ڰ� ������ �̸� ����Ѵ�.
CREATE OR REPLACE PROCEDURE PRC_OP_COU_INSERT
(N_CODE      IN COURSE.COURSE_CODE%TYPE                     --�����ڵ�
,N_SDATE    IN COURSE_OPEN.START_DATE%TYPE                  --���۳�¥
,N_EDATE    IN COURSE_OPEN.END_DATE%TYPE                    --���ᳯ¥
,N_CLACODE      IN CLASSROOM_REGISTER.CLASSROOM_CODE%TYPE     --���ǽ��ڵ�. 
)
IS
    V_OP_COURSE_CODE    COURSE_OPEN.OP_COURSE_CODE%TYPE;    -- ���������ڵ�   C1 C2 C2...
BEGIN
    
    -- ���������ڵ� �ڵ����� �ο�
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_COURSE_CODE,3))),0) + 1 INTO V_OP_COURSE_CODE
    FROM COURSE_OPEN;
    
    V_OP_COURSE_CODE := 'C' || V_OP_COURSE_CODE;
    
    INSERT INTO COURSE_OPEN
    (OP_COURSE_CODE ,COURSE_CODE ,CLASSROOM_CODE ,START_DATE ,END_DATE) 
    VALUES(V_OP_COURSE_CODE,  N_CODE,N_CLACODE, TO_DATE(N_SDATE,'YYYY-MM-DD') ,TO_DATE(N_EDATE,'YYYY-MM-DD'));
    
END;
--------------------------------------------------------------------------------
-- [���񰳼����̺� �����ͳִ� ���ν���]
--5.���ν��� �� :PRC_OP_SUB_INSERT(���������ڵ�, �����ڵ�, ���۳�¥, ���ᳯ¥, �����ڵ�, �����ڵ�)
--  ���ν��� �������� : �����ڴ� �������� ������ �̸� ����� �� �ִ�.
--  �������
--  (1).������(���������ڵ�� ��ġ�Ҷ� �ű� ������� ��ġ�ϴ��� �Ǵ�)
--  (2).����Ⱓ�� �����Ⱓ�ȿ� ���ؾ� �Ѵ�.
--  (3).���� �Ⱓ�� ���ļ��� �ȵȴ�. 

--  (4).���,�ʱ�,�Ǳ������ NN�� ����
--  (5).������ ���, �ʱ�, �Ǳ� ���� UPDATE�ϴ� ���ν���                                             �ʿ�
--      (����ʱ�Ǳ�� ������ �����̴�.)
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
    V_OP_SUBJECT_CODE    SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE; --���񰳼��ڵ� OSC1 OSC2 OSC3...
    
    V_TCCODE    TEACHER_REGISTER.TEACHER_CODE%TYPE; -- ������ ������� ����
    
    V_SUB_COUNT  NUMBER;  -- �����ȿ� ���� ��ִ��� ���� ����.
    V_COU_SDATE COURSE_OPEN.START_DATE%TYPE;    --�������۳�¥
    V_COU_EDATE COURSE_OPEN.END_DATE%TYPE;      --�������ᳯ¥
    V_SUB_EDATE SUBJECT_OPEN.END_DATE%TYPE;     --�������ᳯ¥
    
    USER_DEFINE_ERROR1  EXCEPTION;  -- 20303, '��� ������ �������� ���� �����Դϴ�.'                       
    USER_DEFINE_ERROR2  EXCEPTION;  -- 20304, '�Է������� ������ �ش������ ������ ��ġ���� �ʽ��ϴ�.'
    USER_DEFINE_ERROR3  EXCEPTION;  -- 20305,'����Ⱓ�� �����Ⱓ�� ���Ե��� �ʽ��ϴ�.'
    USER_DEFINE_ERROR4  EXCEPTION;  -- 20306,'����Ⱓ�� �ߺ��˴ϴ�. �ٽ� Ȯ�����ּ���'
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
    -- SUBJECT �ڵ� : OSC1, OSC2,.... 
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_SUBJECT_CODE,3))),0) + 1 INTO V_OP_SUBJECT_CODE
    FROM SUBJECT_OPEN;
    
    V_OP_SUBJECT_CODE := 'OSC' || V_OP_SUBJECT_CODE;
    
    
    -- INSERT ������
    INSERT INTO SUBJECT_OPEN
    (OP_SUBJECT_CODE, SUBJECT_CODE, TEXTBOOK_CODE, OP_COURSE_CODE, START_DATE, END_DATE)
    VALUES(V_OP_SUBJECT_CODE, V_SUBJECT_CODE, V_TEXTBOOK_CODE, V_OP_COURSE_CODE, TO_DATE(V_START_DATE,'YYYY-MM-DD') ,TO_DATE(V_END_DATE,'YYYY-MM-DD') );

    --����ó��
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
        THEN RAISE_APPLICATION_ERROR(-20303, '��� ������ �������� ���� �����Դϴ�.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR2
        THEN RAISE_APPLICATION_ERROR(-20304, '�Է������� ������ �ش������ ������ ��ġ���� �ʽ��ϴ�.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR3
        THEN RAISE_APPLICATION_ERROR(-20305,'����Ⱓ�� �����Ⱓ�� ���Ե��� �ʽ��ϴ�.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR4
        THEN RAISE_APPLICATION_ERROR(-20306,'����Ⱓ�� �ߺ��˴ϴ�. �ٽ� Ȯ�����ּ���');
        ROLLBACK;
    --Ŀ��
    COMMIT;
END;
--------------------------------------------------------------------------------
--6.[�����ڰ� �������� ����ϴ� ���ν���]
-- �����ڴ� ��ϵ� ��� ������ ������ ����Ͽ� �� �� �־�� �Ѵ�. 
-- ���ν��� �� : PRC_SUB_OP_SELECT(�Ŵ����ڵ�)
-- ���ν��� �������� : �����ڴ� ������ ��� ���� ������ ����� �� �ִ�.
-- �������
-- (1). �Ŵ����� ���������� ����� �� �ִ�.
-- (2). MANAGER_REGISTER���� MANAGER_CODE�� ��ġ�ϴ��� Ȯ�� ��, ��� ����.
-- ��� �׸� : ������, ���ǽ�, �����, ����Ⱓ, �����, �����ڸ�
CREATE OR REPLACE PROCEDURE PRC_SUB_OP_SELECT
(V_CODE     IN MANAGER_REGISTER.MANAGER_CODE%TYPE
)
IS  
    -- Ŀ�� ������ ��� ���� ����
    V_CNAME     COURSE.COURSE_NAME%TYPE;        --������
    V_CLANAME   CLASSROOM_REGISTER.CLASSROOM_NAME%TYPE; -- ���ǽǸ�
    V_SUB_NAME  SUBJECT.SUBJECT_NAME%TYPE;      --�����
    V_SDATE     SUBJECT_OPEN.START_DATE%TYPE;   --������۳�¥
    V_EDATE     SUBJECT_OPEN.END_DATE%TYPE;     --�������ᳯ¥
    V_TEXTBOOK  TEXTBOOK.TEXTBOOK_NAME%TYPE;    --�����
    V_TC_NAME   TEACHER_REGISTER.NAME%TYPE;     --������
    
    -- Ŀ�� ����
    CURSOR CUR_SUB_OP_SELECT
    IS
    SELECT T2.������, T2.���ǽǸ�, T1.�����
       ,T1.������۳�¥,T1.�������ᳯ¥
       ,T1.�����, T2.�����ڸ�
    FROM
    (
        SELECT SO.START_DATE "������۳�¥"
               ,SO.END_DATE "�������ᳯ¥"
               ,S.SUBJECT_NAME "�����"
               ,T.TEXTBOOK_NAME "�����"
               ,SO.OP_COURSE_CODE "���������ڵ�"
        FROM SUBJECT_OPEN SO JOIN SUBJECT S
        ON SO.SUBJECT_CODE = s.SUBJECT_CODE JOIN TEXTBOOK T
        ON SO.TEXTBOOK_CODE = T.TEXTBOOK_CODE
    )T1 JOIN
    (
        SELECT C.COURSE_NAME "������"
               ,CR.CLASSROOM_NAME "���ǽǸ�"
               ,CO.OP_COURSE_CODE "���������ڵ�"
               ,TR.NAME "�����ڸ�"
        FROM COURSE_OPEN CO JOIN COURSE C 
        ON CO.COURSE_CODE = C.COURSE_CODE JOIN CLASSROOM_REGISTER CR 
        ON CO.CLASSROOM_CODE = CR.CLASSROOM_CODE JOIN TEACHER_REGISTER TR
        ON CO.TEACHER_CODE = TR.TEACHER_CODE
    )T2
    ON T1.���������ڵ� = T2.���������ڵ�;
    
    --��ϵ� ���������� �Ǵ��ϴ� �ӽú��� ����
    --�ش� �Ŵ����� ������ V_TEMP�� 0�� ���.
    V_TEMP  NUMBER; 
  
    -- ����� �������� ���� 
    USER_DEFINE_ERROR1   EXCEPTION;  -- 20102,'�����ڰ� �ƴմϴ�. ������������� �����ڸ� �����մϴ�'
    USER_DEFINE_ERROR2   EXCEPTION;  -- 20103,'��ϵ� �����ڰ� �ƴմϴ�.'

BEGIN
    -- �ӽú����� �� ���
    SELECT COUNT(*) INTO V_TEMP
    FROM MANAGER_REGISTER
    WHERE MANAGER_CODE = V_CODE;
    
    -- ���������� Ȯ��. �����ڰ� �ƴϸ� ���� �߻�.
    IF (SUBSTR(V_CODE,1,1) != 'M')
    THEN RAISE USER_DEFINE_ERROR1;
    -- ��ϵ� �����ڰ� �ƴϸ� ���� �߻�
    ELSIF (V_TEMP = 0)
    THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- Ŀ�� ����
    OPEN CUR_SUB_OP_SELECT;
    
    -- Ŀ���� ������ ó��
    /*
        V_CNAME     COURSE.COURSE_NAME%TYPE;        --������
    V_CLANAME   CLASSROOM_REGISTER.CLASSROOM_NAME%TYPE; -- ���ǽǸ�
    V_SUB_NAME  SUBJECT.SUBJECT_NAME%TYPE;      --�����
    V_SDATE     SUBJECT_OPEN.START_DATE%TYPE;   --������۳�¥
    V_EDATE     SUBJECT_OPEN.END_DATE%TYPE;     --�������ᳯ¥
    V_TEXTBOOK  TEXTBOOK.TEXTBOOK_NAME%TYPE;    --�����
    V_TC_NAME   TEACHER_REGISTER.NAME%TYPE;     --������
    */
    LOOP
        FETCH CUR_SUB_OP_SELECT INTO V_CNAME,V_CLANAME,V_SUB_NAME,V_SDATE,V_EDATE,V_TEXTBOOK,V_TC_NAME ;
        
        EXIT WHEN CUR_SUB_OP_SELECT%NOTFOUND;
        
        --���
        
        DBMS_OUTPUT.PUT_LINE('������:'||V_CNAME||CHR(10) 
                             ||'���ǽǸ�'|| V_CLANAME||CHR(10)
                             ||'�����'||V_SUB_NAME||CHR(10)
                             ||'������۳�¥'||V_SDATE||CHR(10)
                             ||'�������ᳯ¥'||V_EDATE||CHR(10)
                             ||'�����'||V_TEXTBOOK||CHR(10)
                             ||'������'||V_TC_NAME||CHR(10)||CHR(10)
                             ||'----------------------------------------'||CHR(10));
    END LOOP;
    
    -- Ŀ�� Ŭ����
    CLOSE CUR_SUB_OP_SELECT;
    
    
    -- ����ó��
    EXCEPTION
    WHEN USER_DEFINE_ERROR1
    THEN RAISE_APPLICATION_ERROR(-20102, '�����ڰ� �ƴմϴ�. ������������� �����ڸ� �����մϴ�.');
    ROLLBACK;
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20103,'��ϵ� �����ڰ� �ƴմϴ�.');
    ROLLBACK;
    
    --Ŀ��
    COMMIT;
END;
--------------------------------------------------------------------------------
--[�α��� ���]
-- ���ν��� �� : PRC_LOGIN(���̵�,��й�ȣ)
-- ���ν��� ���� ���� : ID, PW �� ��ġ�ϴ��� Ȯ���Ѵ�.
CREATE OR REPLACE PROCEDURE PRC_LOGIN
--������PK, �л�PK, ����PK ��� VARCHAR2(10)
--������PW, �л�PW, ����PW ��� VARCHAR2(30)
( V_CODE  IN MANAGER_REGISTER.MANAGER_CODE%TYPE
, V_PW    IN MANAGER_REGISTER.PASSWORD%TYPE
)
IS
    V_CHECKID NUMBER;   --��ġ1, ����ġ0
    V_CHECKPW NUMBER;   --��ġ1, ����ġ0
    
    USER_DEFINE_ERROR1   EXCEPTION;           -- ID ����ġ ����
    USER_DEFINE_ERROR2   EXCEPTION;           -- PW ����ġ ����
    
BEGIN
    V_CHECKID := FN_ID_CHECK(V_CODE);
    V_CHECKPW := FN_PW_CHECK(V_PW);
   
    -- �α��� IF��
    IF (V_CHECKID = 0 AND V_CHECKPW = 1)
    THEN RAISE USER_DEFINE_ERROR1;
    ELSIF (V_CHECKPW = 0 AND V_CHECKID = 1)
    THEN RAISE USER_DEFINE_ERROR2;
    ELSE
        DBMS_OUTPUT.PUT_LINE('�α��� ����~!!!');
    END IF;
    
    -- �α��� ���� ���� ó��
    EXCEPTION
       WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20100, '���̵� ��ġ���� �ʽ��ϴ�.');
                ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20103, '��й�ȣ�� ��ġ���� �ʽ��ϴ�.');
                ROLLBACK;

    -- Ŀ��
    COMMIT;
END;
--------------------------------------------------------------------------------
--[���̵���ġ �Լ�]
-- �Լ� �� : FN_ID_CHECK(ID)
-- ��ȯ : ��ġ�ϴ� ID�� ������ 1, ������ 0
CREATE OR REPLACE FUNCTION FN_ID_CHECK(ID MANAGER_REGISTER.MANAGER_CODE%TYPE)
RETURN NUMBER 
IS
    V_M NUMBER;
    V_T NUMBER;
    V_S NUMBER;
    V_RESULT    NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_T
    FROM TEACHER_REGISTER
    WHERE TEACHER_CODE = ID;
    
    SELECT COUNT(*) INTO V_M
    FROM MANAGER_REGISTER
    WHERE MANAGER_CODE = ID;
    
    SELECT COUNT(*) INTO V_S
    FROM STUDENT_REGISTER
    WHERE STUDENT_CODE = ID;
    
    IF (SUBSTR(ID,1,1) = 'M')
    THEN V_RESULT := V_M;
    ELSIF (SUBSTR(ID,1,1) = 'T')
    THEN V_RESULT := V_T;
    ELSIF (SUBSTR(ID,1,1) = 'S')
    THEN V_RESULT := V_S;
    ELSE
        V_RESULT := 0;
    END IF;
 
    RETURN V_RESULT;
END;

--------------------------------------------------------------------------------    
--[��й�ȣ��ġ �Լ�]
-- �Լ� �� : FN_PW_CHECK(PW)
-- ��ȯ : ��ġ�ϴ� PW�� ������ 1, ������ 0
CREATE OR REPLACE FUNCTION FN_PW_CHECK(PW MANAGER_REGISTER.PASSWORD%TYPE)
RETURN NUMBER 
IS
    V_M NUMBER;
    V_T NUMBER;
    V_S NUMBER;
    V_RESULT    NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_T
    FROM TEACHER_REGISTER
    WHERE PASSWORD = PW;
    
    SELECT COUNT(*) INTO V_M
    FROM MANAGER_REGISTER
    WHERE PASSWORD = PW;
    
    SELECT COUNT(*) INTO V_S
    FROM STUDENT_REGISTER
    WHERE PASSWORD = PW;
    
    IF (V_M = 1 AND V_T = 0 AND V_S = 0)
    THEN V_RESULT := V_M;
    ELSIF (V_T = 1 AND V_M = 0 AND V_S = 0)
    THEN V_RESULT := V_T;
    ELSIF (V_S = 1 AND V_M = 0 AND V_T = 0)
    THEN V_RESULT := V_S;
    ELSE
        V_RESULT := 0;
    END IF;
 
    RETURN V_RESULT;
END;
--------------------------------------------------------------------------------