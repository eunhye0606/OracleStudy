SELECT USER
FROM DUAL;
--==>>SCOTT
SET SERVEROUTPUT ON;
--�� TBL_INSA���̺��� ���� ���� ������ ���� ���� ������ �����Ͽ� ���
--   (�ݺ��� Ȱ��)
DECLARE
    V_INSA TBL_INSA%ROWTYPE;
    V_NUM TBL_INSA.NUM%TYPE:=1001;
BEGIN
    -- �ݺ��� ����
    LOOP
        -- ��ȸ �� ���� ���ڵ� ������ �� ������ ��Ƴ���
        SELECT NAME, TEL, BUSEO
            INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        -- ���(������ ����ִ� ������ ���)
        DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || '-' || V_INSA.TEL || '-' || V_INSA.BUSEO);
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM > 1060;         -- �ݺ� ����~!!!
    END LOOP;
END;
-- ����
-- 1. ��ȣ�� �������̿��߸� �����ϴ�. (�ø���ȭ)
-- 2. ù���� ������ �˾ƾ��Ѵ�.
-- (�� Ŀ���� Ȱ���ϸ� �ذ� ����.)
--------------------------------------------------------------------------------
--PL/SQL�� ���ν���, Ʈ����, �Լ��� ���� �� �˾ƾ� �ǹ��ִ�..

--���� FUNCTION(�Լ�) ����--

-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴµ� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�. �� (����� ���� �Լ�)
--    �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν��� ó�� EXECUTE���� ���� ������ �� �ִ�.         
--    (EXECUTE : .exe)

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ���            OR REPLACE : ����� ����.
[(�Ű�������1 �ڷ���
  ,�Ű�������2 �ڷ���
)]
RETURN ������Ÿ��                             ---------- ������� �Լ� �����.
IS                          -- PL/SQL ������ ���.
    -- �ֿ� ���� ����
BEGIN                       -- PL/SQL ������ ���.               
    -- ���๮;
    ...
    RETURN (��);                              ----------- RETURN �ݵ�� �־����.   
    
    [EXCEPTION]
        -- ���� ó�� ����;
END;                        -- PL/SQL ������ ���.
*/

--�� ����� ���� �Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--   FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�.

-- �� TBL_INSA ���̺� ���� ���� Ȯ�� �Լ� ����(����)
-- �Լ��� : FN_GENDER()
--             ��        SSN(�ֹε�Ϲ�ȣ) �� '771212-1022432' �� 'YYMMDD-NNNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2)  -- �Ű����� : �ڸ���(����) ���� ����.(���� �Ű����� �����ϴ� ��)
RETURN VARCHAR2     -- ��ȯ�ڷ��� : �ڸ���(����) ���� ����.
IS
        -- ����� �� �ֿ� ���� ����
        V_RESULT    VARCHAR2(20);
BEGIN
        -- �����(���Ǻ�) �� ���� �� ó��
        IF (SUBSTR(V_SSN,8,1) IN ('1','3')) -- IF�ڿ� () ����.
            THEN V_RESULT := '����';
        ELSIF(SUBSTR(V_SSN,8,1) IN ('2','4'))
            THEN V_RESULT := '����';
        ELSE
            V_RESULT := '����Ȯ�κҰ�';
        END IF;
        
        -- ����� ��ȯ CHECK~!!!
        RETURN V_RESULT;
END;
--==>>Function FN_GENDER��(��) �����ϵǾ����ϴ�.

--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾� ��(A,B)
--   A�� B���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�
--   ��, ������ ����Ŭ ���� �Լ��� �̿����� �ʰ�, �ݺ����� Ȱ���Ͽ�
--   �ۼ��Ѵ�.

-- �Լ��� : FN_POW()
/*
��� ��)
SELECT FN_POW(10,3)
FROM DUAL;
--==>>1000
*/
CREATE OR REPLACE FUNCTION FN_POW(N1 NUMBER, N2 NUMBER)
RETURN NUMBER
IS
    RESULT NUMBER(10) := N1;
    N NUMBER := 1;      -- LOOP����, N2���� Ƚ��.
BEGIN
    WHILE N < N2 LOOP       --N2 �� 3�̸�.. N�� 2����.. 1,2 �ι�..
    RESULT := RESULT * N1;
    N := N+1;
    END LOOP;
    RETURN RESULT;
END;
--==>>Function FN_POW��(��) �����ϵǾ����ϴ�.

--------Ǯ��-------
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)       --���� �����ݷ� XX
RETURN NUMBER           -- ���� �����ݷ� XX
IS 
    V_RESULT    NUMBER := 1;     -- ��ȯ ����� ���� �� CHECK~!! 1�� �ʱ�ȭ
    V_NUM       NUMBER;
BEGIN
    -- �ݺ��� ����
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A;       --V_RESULT *= A;(�ڹٿ���) �ڡڡڡڡڡ�
    END LOOP;
    
    -- ���� ��� �� ��ȯ
    RETURN V_RESULT;
END;

-------------------




