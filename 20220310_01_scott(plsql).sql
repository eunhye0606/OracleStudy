SELECT USER
FROM DUAL;
--==>>SCOTT
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

--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� ��(�⺻�� * 12) + ���硻������ ������� �����Ѵ�.
--   �Լ��� : FN_PAY(�⺻��, ����)
CREATE OR REPLACE FUNCTION FN_PAY(B_PAY NUMBER, S_PAY NUMBER)
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    RESULT NUMBER := 0;
BEGIN
    -- ���� �� ó�� 
    RESULT := NVL(B_PAY,0)*12 + NVL(S_PAY,0);
    
    -- ���� ����� ��ȯ
    RETURN RESULT;
END;
--==>>Function FN_PAY��(��) �����ϵǾ����ϴ�.

--�� TBL_INSA ���̺��� �Ի����� �������� ���������
--   �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--   �Լ���:FN_WORKYEAR(�Ի���)
CREATE OR REPLACE FUNCTION FN_WORKYEAR(IBSADATE DATE)
RETURN NUMBER
IS
    V_WORKDAY NUMBER;
BEGIN
    V_WORKDAY := ROUND(SYSDATE - IBSADATE,1);
    --V_WORKDAY := V_WORKDAY / 365;
    --V_WORKDAY := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM IBSADATE);
    RETURN V_WORKDAY;
END;
--==>>Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------
-- Ǯ�� 1.
--(1). 
SELECT MONTHS_BETWEEN(SYSDATE,'2002-02-11')/12
FROM DUAL;
--==>>20.0817787049482277976901632815611310235
--(2).
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,'2002-02-11')/12) || '��' ||
        TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, '2002-02-11'),12))||'����'
FROM DUAL;
--==>>20��0����


CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN NUMBER
IS
    VRESULT NUMBER;
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE,VIBSADATE)/12,1);
    
    RETURN VRESULT;
END;
--==>>Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------

-- �� ����

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Date Manipulation Language)
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>>DDL(Date Definition Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE
--==>>DCL(Date Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)


-- ���� pl/sql �� �� DML��, TCL���� ��� �����ϴ�.
-- ���� pl/sql �� �� DML��, DDL��, DCL��, TCL�� ��� �����ϴ�.
--------------------------------------------------------------------------------

-- ���� PROCEDURE(���ν���) ����--
--pl/sql ���� ���� �� ���ν����� ��ŭ ���� ��. 
--PL:������, ���ν����ȿ� �����Ǿ�����.

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� �� ���� ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ��
  ,�Ű����� OUT ������Ÿ��
  ,�Ű����� INOUT ������Ÿ��
)]
IS
    [-- �ֿ� ���� ����]
BEGIN
    -- ���� ����;
    ...
    [EXCEPTION
        -- ���� ó�� ����;]
END;
*/

--���ν���: �긦 ȣ��������, �ȿ� �ڵ尡 ���ư��ٰ� �߿�,����� �� ����.
--�Լ�    : �긦 ȣ��������, return���� �߿�!, �Է¸Ű�������
-- �Է� �Ű�����: ���� ������ �����͸� �ٰž�.
-- ��� �Ű�����: �����ٰ� ���⿡ �� �����.
-- ����¸Ű�����: ��� ��Ƽ� ���״� �ٸ԰� �ٸ��Ŵ�Ƽ� ��(���� �ٰ�, ������)


-- �� FUNCTION �� ������ �� ��RETURN ��ȯ �ڷ����� �κ��� �������� ������,
--    ��RETURN�� �� ��ü�� �������� ������,
--    ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--    IN(�Է�), OUT(���), INOUT(�����)���� ���еȴ�.

-- 3. ����(ȣ��)
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2,...)];
*/



-- �� (1)���ν��� �ǽ��� ���� ���̺� ������
--    ��20220310_02_scott.sql�� ���� ���� ~!!!


--�� ���ν��� ����
--(1).
/*
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
(V_ID     IN TBL_IDPW.ID%TYPE
,V_PW     IN TBL_IDPW.PW%TYPE
,V_NAME   IN TBL_STUDENTS.NAME%TYPE
,V_TEL    IN TBL_STUDENTS.TEL%TYPE
,V_ADDR   IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
END;
*/

--(2).

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
(V_ID     IN TBL_IDPW.ID%TYPE
,V_PW     IN TBL_IDPW.PW%TYPE
,V_NAME   IN TBL_STUDENTS.NAME%TYPE
,V_TEL    IN TBL_STUDENTS.TEL%TYPE
,V_ADDR   IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_IDPW(ID,PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
END;
--==>>Procedure PRC_STUDENT_INSERT��(��) �����ϵǾ����ϴ�.

-- �� (2)���ν��� �ǽ��� ���� ���̺� ������
--    ��20220310_02_scott.sql�� ���� ���� ~!!!


--�� ������ �Է� �� Ư�� �׸��� �����͸� �Է��ϸ�
--                  ---------
--                    (�й�, �̸�, ��������, ��������, ��������)
--   ���������� �ٸ� �߰��׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--                   ---------
--                   (����, ���, ���)
--   ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
--   ���ν��� �� : PRC_SUNGJUK_INSERT()
/*
���� ��)
EXEC PRC_SUNJUK_INSERT(1,'�ּ���',90,80,70);

���ν��� ȣ��� ó���� ���
�й�  �̸�  ��������  ��������  ��������  ����  ���  ���
  1   �ּ���     90       80        70     240   80    B
*/
CREATE OR REPLACE PROCEDURE PRO_SUNGJUK_INSERT
(V_HAKBUN     IN TBL_SUNGJUK.HAKBUN%TYPE
,V_NAME       IN TBL_SUNGJUK.NAME%TYPE
,V_KOR        IN TBL_SUNGJUK.KOR%TYPE
,V_ENG        IN TBL_SUNGJUK.ENG%TYPE
,V_MAT        IN TBL_SUNGJUK.MAY%TYPE
)
IS
V_TOT   TBL_SUNGJUK.TOT%TYPE;
V_AVG   TBL_SUNGJUK.AVG%TYPE;
V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    IF V_AVG >= 90
    THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
    THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
    THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
    THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;
    INSERT INTO TBL_SUNGJUK
    VALUES(V_HAKBUN,V_NAME,V_KOR,V_ENG,V_MAT,V_TOT,V_AVG,V_GRADE);
    
    COMMIT;
    
END;
--==>>Procedure PRO_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.
-----------Ǯ��------------
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
(V_HAKBUN   IN TBL_SUNGJUK.HAKBUN%TYPE
,V_NAME     IN TBL_SUNGJUK.NAME%TYPE
,V_KOR      IN TBL_SUNGJUK.KOR%TYPE
,V_ENG      IN TBL_SUNGJUK.ENG%TYPE
,V_MAT      IN TBL_SUNGJUK.MAY%TYPE
)
IS
    -- �����
    -- INSERT ������ ������ �ϱ� ���� �ʿ��� �߰� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����
    -- �߰��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >=80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN,NAME,KOR,ENG,MAY,TOT,AVG,GRADE)
    VALUES(V_HAKBUN,V_NAME,V_KOR,V_ENG,V_MAT,V_TOT,V_AVG,V_GRADE);
    
    --Ŀ��
    COMMIT;
END;
--==>>Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_SUBJUK ���̺��� Ư�� �л��� ����
--   (�й�, ��������, ��������, ��������) ������ ���� ��
--   ����, ���, ��ޱ��� �Բ� �����Ǵ� ���ν����� �����Ѵ�.
--   ���ν��� �� : PRC_SUNGJUK_UPDATE()
/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(2,50,50,50)
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
(V_HAKBUN   TBL_SUNGJUK.HAKBUN%TYPE
,V_KOR      TBL_SUNGJUK.KOR%TYPE
,V_ENG      TBL_SUNGJUK.ENG%TYPE
,V_MAT      TBL_SUNGJUK.MAY%TYPE
)
IS
--V_NAME    TBL_SUNGJUK.NAME%TYPE;
V_TOT     TBL_SUNGJUK.TOT%TYPE;
V_AVG     TBL_SUNGJUK.AVG%TYPE;
V_GRADE   TBL_SUNGJUK.GRADE%TYPE;

BEGIN
    --V_NAME := (SELECT NAME
             --  FROM TBL_SUNGJUK
             --  WHERE HAKBUN = V_HAKBUN);
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >=80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    UPDATE TBL_SUNGJUK
    SET HAKBUN = V_HAKBUN
        ,KOR = V_KOR
        ,ENG = V_ENG
        ,MAY = V_MAT
        ,TOT = V_TOT
        ,AVG = V_AVG
        ,GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
END;
--==>>Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.
-- ��.. �̸��� ������Ʈ �� �ʿ䰡 ����. ...
-----------Ǯ��-----------
-- ���� �Ķ���� ���� �����ݷ� �Ⱥ����� ���� : �Ķ���� ���̻��� �޸��� �̾���.
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
(V_HAKBUN     IN TBL_SUNGJUK.HAKBUN%TYPE
,V_KOR        IN TBL_SUNGJUK.KOR%TYPE  
,V_ENG        IN TBL_SUNGJUK.ENG%TYPE
,V_MAT        IN TBL_SUNGJUK.MAY%TYPE
)
IS
    --�����
    -- UPDATE �������� �����ϱ� ���� �ʿ��� ����
    V_TOT      TBL_SUNGJUK.TOT%TYPE;
    V_AVG      TBL_SUNGJUK.AVG%TYPE;
    V_GRADE    TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    --�����
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >=80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    --UPDATE ������ ����
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAY = V_MAT
        ,TOT = V_TOT, AVG = V_AVG ,GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    --Ŀ��
    COMMIT;
END;
--==>>Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.


--�� TBL_STUENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
--   ���ν����� �ۼ��Ѵ�.
--   ��,ID �� PW�� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� ó���Ѵ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE()

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(V_ID    IN TBL_IDPW.ID%TYPE
,V_PW    IN TBL_IDPW.PW%TYPE
,V_TEL   IN TBL_STUDENTS.TEL%TYPE
,V_ADDR  IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    --ID AND PW ��� ��ġ
    --UPDATE ������ ����
    UPDATE TBL_STUDENTS 
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID =V_ID
            AND V_PW = (SELECT PW
                        FROM TBL_IDPW
                        WHERE ID = V_ID);
    --Ŀ��
    COMMIT;
END;
--==>>Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.

SELECT USER
FROM DUAL;
--==>>SCOTT

-- �� 20220310_01_soctt(plsql).sql ���Ͽ���
--    FN_PAY() �Լ� ���� �� �׽�Ʈ
SELECT NUM,NAME, BASICPAY, SUDANG, FN_PAY(BASICPAY,SUDANG)"�޿�"
FROM TBL_INSA;
--==>>
/*
1001	ȫ�浿	2610000	200000	31520000
1002	�̼���	1320000	200000	16040000
1003	�̼���	2550000	160000	30760000
1004	������	1954200	170000	23620400
1005	�Ѽ���	1420000	160000	17200000
1006	�̱���	2265000	150000	27330000
1007	����ö	1250000	150000	15150000
1008	�迵��	950000	145000	11545000
1009	������	840000	220400	10300400
1010	������	2540000	130000	30610000
1011	������	1020000	140000	12380000
1012	���ѱ�	880000	114000	10674000
1013	���̼�	1601000	103000	19315000
1014	Ȳ����	1100000	130000	13330000
1015	������	1050000	104000	12704000
1016	�̻���	2350000	150000	28350000
1017	�����	950000	210000	11610000
1018	�̼���	880000	123000	10683000
1019	�ڹ���	2300000	165000	27765000
1020	������	880000	140000	10700000
1021	ȫ�泲	875000	120000	10620000
1022	�̿���	1960000	180000	23700000
1023	���μ�	2500000	170000	30170000
1024	�踻��	1900000	170000	22970000
1025	�����	1100000	160000	13360000
1026	�����	1050000	150000	12750000
1027	�迵��	2340000	170000	28250000
1028	�̳���	892000	110000	10814000
1029	�踻��	920000	124000	11164000
1030	������	2304000	124000	27772000
1031	����ȯ	2450000	160000	29560000
1032	�ɽ���	880000	108000	10668000
1033	��̳�	1020000	104000	12344000
1034	������	1100000	160000	13360000
1035	������	1050000	140000	12740000
1036	���翵	960400	190000	11714800
1037	�ּ���	2350000	187000	28387000
1038	���μ�	2000000	150000	24150000
1039	�����	2010000	160000	24280000
1040	�ڼ���	2100000	130000	25330000
1041	�����	2300000	150000	27750000
1042	ä����	1020000	200000	12440000
1043	��̿�	1100000	210000	13410000
1044	����ȯ	1060000	220000	12940000
1045	ȫ����	960000	152000	11672000
1046	����	2650000	150000	31950000
1047	�긶��	2100000	112000	25312000
1048	�̱��	2050000	106000	24706000
1049	�̹̼�	1300000	130000	15730000
1050	�̹���	1950000	103000	23503000
1051	�ǿ���	2260000	104000	27224000
1052	�ǿ���	1020000	105000	12345000
1053	��̽�	960000	108000	11628000
1054	����ȣ	980000	114000	11874000
1055	���ѳ�	1000000	104000	12104000
1056	������	1950000	200000	23600000
1057	�̹̰�	2520000	160000	30400000
1058	�����	1950000	180000	23580000
1059	�Ӽ���	890000	102000	10782000
1060	��ž�	900000	102000	10902000
*/
SELECT  NAME, FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;


--------------------Ǯ��.
-- �� 20220310_01_soctt(plsql).sql ���Ͽ���
--    FN_WORKYEAR() �Լ� ���� �� �׽�Ʈ
SELECT NAME, IBSADATE,FN_WORKYEAR(IBSADATE) "�ٹ��Ⱓ"
FROM TBL_INSA;
--==>>
/*
ȫ�浿	1998-10-11	23��4����
�̼���	2000-11-29	21��3����
�̼���	1999-02-25	23��0����
������	2000-10-01	21��5����
�Ѽ���	2004-08-13	17��6����
�̱���	2002-02-11	20��0����
����ö	1998-03-16	23��11����
�迵��	2002-04-30	19��10����
������	2003-10-10	18��5����
������	1997-08-08	24��7����
������	2000-07-07	21��8����
���ѱ�	1999-10-16	22��4����
���̼�	1998-06-07	23��9����
Ȳ����	2002-02-15	20��0����
������	1999-07-26	22��7����
�̻���	2001-11-29	20��3����
�����	2000-08-28	21��6����
�̼���	2004-08-08	17��7����
�ڹ���	1999-12-10	22��3����
������	2003-10-10	18��5����
ȫ�泲	2001-09-07	20��6����
�̿���	2003-02-25	19��0����
���μ�	1995-02-23	27��0����
�踻��	1999-08-28	22��6����
�����	2000-10-01	21��5����
�����	2002-08-28	19��6����
�迵��	2000-10-18	21��4����
�̳���	2001-09-07	20��6����
�踻��	2000-09-08	21��6����
������	1999-10-17	22��4����
����ȯ	2001-01-21	21��1����
�ɽ���	2000-05-05	21��10����
��̳�	1998-06-07	23��9����
������	2005-09-26	16��5����
������	2002-05-16	19��9����
���翵	2003-08-10	18��7����
�ּ���	1998-10-15	23��4����
���μ�	1999-11-15	22��3����
�����	2003-12-28	18��2����
�ڼ���	2000-09-10	21��6����
�����	2001-12-10	20��3����
ä����	2003-10-17	18��4����
��̿�	2003-09-24	18��5����
����ȯ	2004-01-21	18��1����
ȫ����	2003-03-16	18��11����
����	1999-05-04	22��10����
�긶��	2001-07-15	20��7����
�̱��	2001-06-07	20��9����
�̹̼�	2000-04-07	21��11����
�̹���	2003-06-07	18��9����
�ǿ���	2000-06-04	21��9����
�ǿ���	2000-10-10	21��5����
��̽�	1999-12-12	22��2����
����ȣ	1999-10-16	22��4����
���ѳ�	2004-06-07	17��9����
������	2004-08-13	17��6����
�̹̰�	1998-02-11	24��0����
�����	2003-08-08	18��7����
�Ӽ���	2001-10-10	20��5����
��ž�	2001-10-10	20��5����
*/
------����!
-- �� 20220310_01_soctt(plsql).sql ���Ͽ���
--    FN_WORKYEAR() �Լ� ����� �� �׽�Ʈ
SELECT NAME, IBSADATE,FN_WORKYEAR(IBSADATE) "�ٹ��Ⱓ"
FROM TBL_INSA;
--==>>
/*
ȫ�浿	1998-10-11	23.4
�̼���	2000-11-29	21.2
�̼���	1999-02-25	23
������	2000-10-01	21.4
�Ѽ���	2004-08-13	17.5
�̱���	2002-02-11	20
����ö	1998-03-16	23.9
�迵��	2002-04-30	19.8
������	2003-10-10	18.4
������	1997-08-08	24.5
������	2000-07-07	21.6
���ѱ�	1999-10-16	22.4
���̼�	1998-06-07	23.7
Ȳ����	2002-02-15	20
������	1999-07-26	22.6
�̻���	2001-11-29	20.2
�����	2000-08-28	21.5
�̼���	2004-08-08	17.5
�ڹ���	1999-12-10	22.2
������	2003-10-10	18.4
ȫ�泲	2001-09-07	20.5
�̿���	2003-02-25	19
���μ�	1995-02-23	27
�踻��	1999-08-28	22.5
�����	2000-10-01	21.4
�����	2002-08-28	19.5
�迵��	2000-10-18	21.3
�̳���	2001-09-07	20.5
�踻��	2000-09-08	21.5
������	1999-10-17	22.3
����ȯ	2001-01-21	21.1
�ɽ���	2000-05-05	21.8
��̳�	1998-06-07	23.7
������	2005-09-26	16.4
������	2002-05-16	19.8
���翵	2003-08-10	18.5
�ּ���	1998-10-15	23.4
���μ�	1999-11-15	22.3
�����	2003-12-28	18.2
�ڼ���	2000-09-10	21.5
�����	2001-12-10	20.2
ä����	2003-10-17	18.3
��̿�	2003-09-24	18.4
����ȯ	2004-01-21	18.1
ȫ����	2003-03-16	18.9
����	1999-05-04	22.8
�긶��	2001-07-15	20.6
�̱��	2001-06-07	20.7
�̹̼�	2000-04-07	21.9
�̹���	2003-06-07	18.7
�ǿ���	2000-06-04	21.7
�ǿ���	2000-10-10	21.4
��̽�	1999-12-12	22.2
����ȣ	1999-10-16	22.4
���ѳ�	2004-06-07	17.7
������	2004-08-13	17.5
�̹̰�	1998-02-11	24
�����	2003-08-08	18.5
�Ӽ���	2001-10-10	20.4
��ž�	2001-10-10	20.4
*/


--------------------------------------------------------------------------------

--�� ���ν��� ���� �ǽ��� ���� �غ�

-- �ǽ� ���̺� ����
CREATE TABLE TBL_STUDENTS
(ID     VARCHAR2(10)
,NAME   VARCHAR2(40)
,TEL    VARCHAR2(30)
,ADDR   VARCHAR2(100)
,CONSTRAINT STUDENTS_ID_PK PRIMARY KEY(ID)
);
--==>>Table TBL_STUDENTS��(��) �����Ǿ����ϴ�.

--�ǽ� ���̺� ����
CREATE TABLE TBL_IDPW
(ID     VARCHAR2(10)
,PW     VARCHAR2(20)
,CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>>Table TBL_IDPW��(��) �����Ǿ����ϴ�.

--> 1:1������ �ٶ������� ���� ��������
--  ���ν��� �������� ����.

-- �� ���̺� ������ �Է�
INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR)
VALUES('happy','�̽ÿ�','010-1111-1111','���ֵ� ��������');
INSERT INTO TBL_IDPW(ID,PW)
VALUES('happy','java006$');
--==>>1 �� ��(��) ���ԵǾ����ϴ�. * 2

-- Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>>happy	�̽ÿ�	010-1111-1111	���ֵ� ��������
SELECT *
FROM TBL_IDPW;
--==>>happy	java006$

-- Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.

--> �� ���̺� INSERT ������ ���������� �ϸ� 
--  ������ ���Ἲ�� ��ĥ ������ ŭ.
--  �̷� ��, �ʿ��� ���� �����ν�����
--  �ѹ��� �� ������ �����ϴ� ���ν���!



-- ���� ������ �����ϴ� ���ν���(INSERT ���ν���, �Է� ���ν���)�� �����ϰ� �Ǹ�
-- ��EXEC PRC_STUDENT_INSERT('happy','java006$','�̽ÿ�','010-1111-1111','���� ��������');��
-- �̿� ���� ���� �� �ٷ� ���� ���̺� ��� ����� �����͸� �Է��� �� �ִ�.

-- �� ���ν����� �����ϴ� ������
--    ��20220310_01_scott(plsql).sql������ ���� ~!!!


-- �� ���ν��� ���� �� ����
EXEC PRC_STUDENT_INSERT('rainbow','java006$','������','010-2222-2222','���� ������');
--==>>PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�

-- �� ���ν��� ȣ�� ���� Ȯ��
SELECT *
FROM TBL_IDPW;
--==>>
/*
happy	java006$
rainbow	java006$
*/
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
happy	�̽ÿ�	010-1111-1111	���ֵ� ��������
rainbow	������	010-2222-2222	���� ������
*/

-- �� (2)�ǽ� ���̺� ����(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
(HAKBUN     NUMBER          --���� �й� NUMBER���� �տ� 0�����ֱ⿡. �ٵ� ���⼱ ���������¶�����)
,NAME       VARCHAR2(40)    
,KOR        NUMBER(3)
,ENG        NUMBER(3)
,MAY        NUMBER(3)
,CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>>Table TBL_SUNGJUK��(��) �����Ǿ����ϴ�.

-- �� ������ ���̺� ���� ���� �� �÷� �߰�
--    (���� �� TOT, ��� �� AVG, ��� �� GRADE)
ALTER TABLE TBL_SUNGJUK
ADD(TOT NUMBER(3),AVG NUMBER(4,1), GRADE CHAR);
--==>>Table TBL_SUNGJUK��(��) ����Ǿ����ϴ�.
--AVG NUMBER(4,1) : �Ҽ��� ���� ���ڸ� ����.


-- �� ���⼭ �߰��� �÷��� ���� �׸���
--    ���ν��� �ǽ��� ���� �߰��׸��� ��
--    ���� ���̺� ������ ����������, �ٶ��������� ���� �����̴�~!!! CHECK~!!!

--==>> ���� ���̺��� �����͸� Ȱ���Ͽ� ���� �� �ִ� �����ʹ� 
--     ��, �������� ���� �� �� �ִ� �����ʹ�
--     ���� ���̺� �߰��� ����(���̺� ���� �÷�ȭ)���� �ʴ´�.
-- �Է� �����͸� ������ �� �ִ� �÷��̶��...
-- �ݵ�� '�ڵ�ȭ'���Ѷ�
--ex) �Ƴ�,�Ƶ�,�� �� 1.�����, 2.�ڳ�...


--�� ����� ���̺� ���� Ȯ��
DESC TBL_SUNGJUK;
--==>>
/*
�̸�     ��?       ����           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAY             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1) 
*/

--Ȯ��
EXEC PRO_SUNGJUK_INSERT(1,'�ּ���',90,80,70);
EXEC PRO_SUNGJUK_INSERT(2,'�ֵѸ�',90,100,90);
EXEC PRO_SUNGJUK_INSERT(3,'��̹�',20,20,20);

SELECT *
FROM TBL_SUNGJUK;

SELECT TRUNC(91,-1)
FROM DUAL;

DELETE
FROM TBL_SUNGJUK
WHERE NAME IN ('�ּ���','�ֵѸ�','��̹�');

--------Ǯ�� Ȯ��---------
-- �� ���ν��� ���� �� ����
EXEC PRC_SUNGJUK_INSERT(1,'�ּ���',90,80,70);
--==>>PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--�� ���ν��� ȣ�� ���� ���̺� ��ȸ
DELETE
FROM TBL_SUNGJUK
WHERE NAME = '�ּ���';

EXEC PRC_SUNGJUK_INSERT(1,'�ּ���',90,80,70);
EXEC PRC_SUNGJUK_INSERT(2,'������',90,80,80);

SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	�ּ���	90	80	70	240	80	    B
2	������	90	80	80	250	83.3	B
*/

--Ȯ��
EXEC PRC_SUNGJUK_UPDATE(2,100,100,100);

SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	�ּ���	90	80	70	240	80	B
2	������	100	100	100	300	100	A
*/
DELETE
FROM TBL_SUNGJUK
WHERE NAME = '��Ѹ�';

--------Ǯ�� Ȯ��---------
-- �� ���ν��� ���� �� ����
EXEC PRC_SUNGJUK_UPDATE(2,50,50,50);
--==>>PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--�� ���ν��� ȣ��(����) ���� ���̺� ��ȸ
SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	�ּ���	90	80	70	240	80	B
2	������	50	50	50	150	50	F
*/

SELECT *
FROM TBL_IDPW;

SELECT *
FROM TBL_STUDENTS;

EXEC PRC_STUDENTS_UPDATE('happy','java006$','010-7777-7777','���ν� ���ﱸ');
--==>> ������ ���� o
SELECT *
FROM TBL_STUDENTS;
EXEC PRC_STUDENTS_UPDATE('rainbow','java00','010-9999-7777','����� ������');
--==>> ������ ���� x
SELECT *
FROM TBL_STUDENTS;
̽ÿ?	010-1111-1111	���ֵ� ��������
SELECT *
FROM TBL_IDPW;
--==>>happy	java006$

-- Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.

--> �� ���̺� INSERT ������ ���������� �ϸ� 
--  ������ ���Ἲ�� ��ĥ ������ ŭ.
--  �̷� ��, �ʿ��� ���� �����ν�����
--  �ѹ��� �� ������ �����ϴ� ���ν���!



-- ���� ������ �����ϴ� ���ν���(INSERT ���ν���, �Է� ���ν���)�� �����ϰ� �Ǹ�
-- ��EXEC PRC_STUDENT_INSERT('happy','java006$','�̽ÿ�','010-1111-1111','���� ��������');��
-- �̿� ���� ���� �� �ٷ� ���� ���̺� ��� ����� �����͸�

----------------Ǯ��----------------
---------------���1.---------------
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(V_ID    IN TBL_IDPW.ID%TYPE
,V_PW    IN TBL_IDPW.PW%TYPE
,V_TEL   IN TBL_STUDENTS.TEL%TYPE
,V_ADDR  IN TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2  TBL_IDPW.PW%TYPE;
    V_FLAG NUMBER := 0;
BEGIN
    -- PW ��ġ�ϴ��� Ȯ��
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = V_ID;
    
    IF (V_PW = V_PW2)
        THEN V_FLAG := 1;
    ELSE
        V_FLAG := 2;
    END IF;
    
    --UPDATE ������
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID 
          AND V_FLAG = 1;
          
    --Ŀ��
    COMMIT;
END;
--==>>Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.
----------------Ǯ��----------------
---------------���2.---------------
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(V_ID    IN TBL_IDPW.ID%TYPE
,V_PW    IN TBL_IDPW.PW%TYPE
,V_TEL   IN TBL_STUDENTS.TEL%TYPE
,V_ADDR  IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
            FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
            ON T1.ID = T2.ID)T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID
          AND T.PW = V_PW;
          
    COMMIT;
END;
--==>>Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.



