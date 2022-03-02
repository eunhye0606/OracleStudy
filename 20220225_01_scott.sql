SELECT USER
FROM DUAL;
--==>>SCOTT

--���� ROW_NUMBER ����--
--      ��(����) ��ȣ

SELECT *
FROM EMP;

SELECT ENAME "�����", SAL "�޿�", HIREDATE"�Ի���"
FROM EMP;

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
       ,ENAME "�����", SAL "�޿�", HIREDATE"�Ի���"
FROM EMP;
--==>>
/*
 1	KING	5000	1981-11-17
 2	FORD	3000	1981-12-03
 3	SCOTT	3000	1987-07-13
 4	JONES	2975	1981-04-02
 5	BLAKE	2850	1981-05-01
 6	CLARK	2450	1981-06-09
 7	ALLEN	1600	1981-02-20
 8	TURNER	1500	1981-09-08
 9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	 950	1981-12-03
14	SMITH	 800	1980-12-17
*/

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
       ,ENAME "�����", SAL "�޿�", HIREDATE"�Ի���"
FROM EMP
ORDER BY ENAME;
--==>>
/*
12	ADAMS	1100	1987-07-13
 7	ALLEN	1600	1981-02-20
 5	BLAKE	2850	1981-05-01
 6	CLARK	2450	1981-06-09
 2	FORD	3000	1981-12-03
13	JAMES	 950	1981-12-03
 4	JONES	2975	1981-04-02
 1	KING	5000	1981-11-17
11	MARTIN	1250	1981-09-28
 9	MILLER	1300	1982-01-23
 3	SCOTT	3000	1987-07-13
14	SMITH	 800	1980-12-17
 8	TURNER	1500	1981-09-08
10	WARD	1250	1981-02-22
*/
SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"
       ,ENAME "�����", SAL "�޿�", HIREDATE"�Ի���"
FROM EMP
ORDER BY ENAME;
--==>>
/*
 1	ADAMS	1100	1987-07-13 
 2	ALLEN	1600	1981-02-20
 3	BLAKE	2850	1981-05-01
 4 	CLARK	2450	1981-06-09
 5	FORD	3000	1981-12-03
 6	JAMES	 950	1981-12-03
 7 	JONES	2975	1981-04-02
 8	KING	5000	1981-11-17
 9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	 800	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"    --���ȣ ����.
       ,ENAME "�����", SAL "�޿�", HIREDATE"�Ի���"
FROM EMP             -- Ÿ�����ϰ�
WHERE DEPTNO = 20    -- ������ �޸𸮿� �ø� ��
ORDER BY ENAME;
--==>>
/*
1	ADAMS	1100	1987-07-13
2	FORD	3000	1981-12-03
3	JONES	2975	1981-04-02
4	SCOTT	3000	1987-07-13
5	SMITH	 800	1980-12-17
*/



--�� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���, ������ �Խù��� �ڸ��� ���� ��ȣ�� ����
--   �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--   �̴�... ���ȼ� �����̳�... �̰���... �ٶ������� ���� ������� �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����� �� �� �ִ�.
--   ���� �������� ����� ������  SEQUENCE �� IDENTITY �� ���������
--   �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� �ٶ����ϴ�.
--   (SEQUENCE: ����Ŭ 
--    IDENTITY: MSSQL)

--�ڡڡ� ������� ���� ������ �ٽ� !!!�ڡڡ�--
--�� ���� �߸� ���Ǵ� ������ ����
--   �߰��� �����͸� �����ص� �������� ���������ʾƼ� 
--   �ѹ��ص� �������� 10������ ���� ^^
DROP SEQUENCE SEQ_BOARD;
--==>>Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.

--�� SEQUENCE(������ : �ֹ���ȣ) ����
--   �� �������� �ǹ� : 1.(�Ϸ���) �������� ��ǵ�, 2.(��� �ൿ ����) ����

CREATE SEQUENCE SEQ_BOARD       -- �⺻���� ������ ���� ����
START WITH 1                    -- ���۰�(DEFAULT)
INCREMENT BY 1                     -- ������(DEFAULT)
NOMAXVALUE                      -- �ִ밪(DEFAULT)
NOCACHE;                        -- ĳ�û�뿩��
--==>>Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.
--    ���̺��ϰ� ���� X
--    �������� ��.
-- (NOCACHE : ��ȣǥ���� ���� ���� ������... �ϳ��ϳ� �������� ���ϰ�...
--  ��ȣǥ�� �̸� 50�� �̾Ƽ� ������ ....�� �װ� ĳ��
--  �������� Ƣ�°� �����ϴ°� ��ĳ��...
--  Ŭ���̾�Ʈ - ����, ���� �����ؼ� ó���ؾ��ϴ� �׼��� ������
--  10���� ���Ƿ� ������ �ٸ� ����� ���� �� �������� �̿��ϴ°� ���ε�
--  ���� ���� 21���̿��� �ٸ� ����� 31������ ���� ��..
--  ĳ�� ����: ��⿭�� �Ȱɸ���.
--  ĳ�� ����: �߰������ڰ� 10�� �̰� 5�� �����ִٰ� �ٸ� �����ϸ�
--             ���� �մ��� ��迡�� ���� �� 11��...
--   NOCACHE : ��ȣǥ �̸� �̱� Ȱ�� XX)


--�� ���� �߸��� �����Ͱ� �Էµ� ���̺� ����(������ ��ġ�� �ʰ� ���� : PURGE) ��--
--    (�˾Ƹ� �ΰ� ������ ����...)
DROP TABLE TBL_BOARD PURGE;
--==>>Table TBL_BOARD��(��) �����Ǿ����ϴ�.

--�� ������ ����(�˾Ƹ� �ΰ� ������ ����...)
PURGE RECYCLEBIN;
--==>>RECYCLEBIN��(��) ��������ϴ�.
-- DB���� ������ ��ġ�� �ʰ� �����ϸ�
-- �����ϱⰡ ���ϰ� ��ƴ�.

SELECT *
FROM TAB;
--==>>
/*
BIN$NaBzNiwHTDyHPyAqAA7RRw==$0	TABLE �� ������	
BIN$qiRn2zalQ1ixvKLEcCFBTQ==$0	TABLE �� ������	
BONUS	        TABLE	
DEPT	        TABLE	
EMP	            TABLE	
SALGRADE	    TABLE	
TBL_BOARD	    TABLE	
TBL_DEPT	    TABLE	
TBL_EMP	        TABLE	
TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
TBL_FILES	    TABLE	
TBL_SAWON	    TABLE	
TBL_WATCH	    TABLE	
VIEW_SAWON	    VIEW	
VIEW_SAWON2	    VIEW	
*/

--�� �ǽ� ���̺� ����
CREATE TABLE TBL_BOARD               -- TBL_BOARD ���̺� ���� ���� �� �Խ��� ���̺�
( NO           NUMBER                -- �Խù� ��ȣ             ��
, TITLE        VARCHAR2(50)          -- �Խù� ����             ��
, CONTENTS     VARCHAR2(1000)        -- �Խù� ����             ��
, NAME         VARCHAR2(20)          -- �Խù� �ۼ���           ��
, PW           VARCHAR2(20)          -- �Խù� �н�����         ��
, CREATED      DATE DEFAULT SYSDATE  -- �Խù� �ۼ���           ��
);
--==>>Table TBL_BOARD��(��) �����Ǿ����ϴ�

--�� ������ �Է� �� �Խ��ǿ� �Խù��� �ۼ��ϴ� �׼�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, 'Ǯ��','�� Ǯ���� �־��','������','java006$',DEFAULT);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ζ�','���ϴ� ���׿�','������','java006$',SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�غ�','�ٶ��� �γ׿�','������','java006$',SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ͺ�','���ͺ����ε�, ���̰� �����׿�','�̽ÿ�','java006$',SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����ּ���','���� �������','�ֹ���','java006$',SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���� ���ΰ�','���� ���� �� ��','��μ�','java006$',SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��������','������ �����Ϸ� �Դ�','������','java006$',SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�翬��','�ƹ� ���� ����','�̾Ƹ�','java006$',SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session��(��) ����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	Ǯ��	    �� Ǯ���� �־��	            ������	java006$	2022-02-25 10:29:37
2	���ζ�	    ���ϴ� ���׿�	                ������	java006$	2022-02-25 10:30:05
3	�غ�	    �ٶ��� �γ׿�	                ������	java006$	2022-02-25 10:30:22
4	���ͺ�	    ���ͺ����ε�, ���̰� �����׿�	�̽ÿ�	java006$	2022-02-25 10:30:37
5	����ּ���	���� �������	                �ֹ���	java006$	2022-02-25 10:30:57
6	���� ���ΰ�	���� ���� �� ��	            ��μ�	java006$	2022-02-25 10:31:17
7	��������	������ �����Ϸ� �Դ�	        ������	java006$	2022-02-25 10:31:34
8	�翬��	    �ƹ� ���� ����	                �̾Ƹ�	java006$	2022-02-25 10:31:52
*/

--�� Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.

--�� �Խù� ����(��ȸ �ϰ� SELECT �� DELETE)
DELETE 
FROM TBL_BOARD
WHERE NO = 2;
--==>>1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO =3;
--==>>1 �� ��(��) �����Ǿ����ϴ�.
DELETE
FROM TBL_BOARD
WHERE NO =5;
--==>>1 �� ��(��) �����Ǿ����ϴ�.
DELETE
FROM TBL_BOARD
WHERE NO =6;
--==>>1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_BOARD;
--==>>
/*
1	Ǯ��	    �� Ǯ���� �־��	            ������	java006$	2022-02-25 10:29:37
4	���ͺ�	    ���ͺ����ε�, ���̰� �����׿�	�̽ÿ�	java006$	2022-02-25 10:30:37
7	��������	������ �����Ϸ� �Դ�	        ������	java006$	2022-02-25 10:31:34
8	�翬��	    �ƹ� ���� ����	                �̾Ƹ�	java006$	2022-02-25 10:31:52
*/


--�� �Խù� �߰� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������','������ ���ƿ�','�����','java006$',SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	Ǯ��	    �� Ǯ���� �־��	            ������	java006$	2022-02-25 10:29:37
4	���ͺ�	    ���ͺ����ε�, ���̰� �����׿�	�̽ÿ�	java006$	2022-02-25 10:30:37
7	��������	������ �����Ϸ� �Դ�	        ������	java006$	2022-02-25 10:31:34
8	�翬��	    �ƹ� ���� ����	                �̾Ƹ�	java006$	2022-02-25 10:31:52
9	������	    ������ ���ƿ�	                �����	java006$	2022-02-25 10:40:30
*/

--�� Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.

--�� �Խ����� �Խù� ����Ʈ�� �����ִ� ������ ����

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
        ,TITLE "����", NAME"�ۼ���",CREATED"�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	������	    �����	2022-02-25 10:40:30
4	�翬��	    �̾Ƹ�	2022-02-25 10:31:52
3	��������	������	2022-02-25 10:31:34
2	���ͺ�	    �̽ÿ�	2022-02-25 10:30:37
1	Ǯ��	    ������	2022-02-25 10:29:37
*/
-- ��¥ ���� ���� : ����<�̷�
-- INSERT �� ��, NO�÷��̶� ���ȣ�� �ٸ�!

CREATE OR REPLACE VIEW VIEW_BOARDLIST
AS
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
        ,TITLE "����", NAME"�ۼ���",CREATED"�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>View VIEW_BOARDLIST��(��) �����Ǿ����ϴ�.

--�� ��(VIEW) ��ȸ
SELECT *
FROM VIEW_BOARDLIST;
--==>>
/*
5	������	    �����	2022-02-25 10:40:30
4	�翬��	    �̾Ƹ�	2022-02-25 10:31:52
3	��������	������	2022-02-25 10:31:34
2	���ͺ�	    �̽ÿ�	2022-02-25 10:30:37
1	Ǯ��	    ������	2022-02-25 10:29:37
*/
--------------------------------------------------------------------------------
-- SQL PART�� ��...
--���� JOIN(����) ����--

SELECT *
FROM EMP;

SELECT ENAME
FROM EMP;
-------------------------�Ѵ� �޸� ��뷮�� ����!
-- �⵵ : �� �� ǥ��ȭ�� �Ǿ���
-- 1. SQL 1992 CODE

-- ��CROSS JOIN
SELECT*
FROM EMP,DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(CARTESIAN PRODUCT)
--  �� ���̺��� ������ ��� ����� ��

-- ��EQUI JOIN : ���� ��Ȯ�� ��ġ�ϴ� �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

--��Ī
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- ��NON EQUI JOIN : ���� �ȿ� ������ �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���
SELECT *
FROM EMP;
SELECT *
FROM SALGRADE;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- EQUI JOIN �� (+) �� Ȱ���� ���� ���

SELECT *
FROM TBL_EMP;
--> 19���� ��� �� �μ���ȣ�� ���� ���� ������� 5��

SELECT*
FROM TBL_DEPT;
--> 5���� �μ� �� �Ҽӻ���� ���� ���� �μ��� 2��

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--     ��, �μ���ȣ�� ���� ���� �����(5��) ��� ����
--     ����, �Ҽ� ����� ���� ���� �μ�(2��) ��� ����

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--==>> �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--    �μ���ȣ�� ���� ���� �����(5��) �߰�.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--==>> �� 16���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--     �Ҽ� ����� ���� ���� �μ�(2��) �߰�.

-- �� (+)�� �Ⱥ��� �ֵ��� ���ΰ�, (���ΰ����� �� �� �ö��!)
--    �׸��� (+)���� �ֲ��� �Ⱥ��� �ֶ� ���ؼ�
--    ��ġ�ϴ� �ֵ� ��ȯ!

-- �� (+) �� ���� �� ���̺��� �����͸� ��� �޸𸮿� ���� ������ ��
--    (+) �� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�
--    JOIN �� �̷������ �ȴ�.

--   �̿� ���� ������
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--    �̷� ������ JOIN�� �������� �ʴ´�!
--    ������ ���� ���ʿ��� ÷���ϴ� ���¶�!
--==>> ���� �߻�
--     ORA-01468: a predicate may reference only one outer-joined table


-- 2. SQL 1999 CODE     �桺JOIN�� Ű���� ���� �� ��JOIN��(����)�� ���� ���
--                      �� ��ON�� Ű���� ���� �� ���� ������ WHERE ��� ON

-- 1999�⵵�� ǥ��ȭ �Ǿ��ִ� CODE
-- ũ�� �ٸ����� �ʴ�.
-- ������
-- 1992�⵵ CODE���� ��JOIN���̶�� ���ڰ� ��� 
-- �̰� �������� �ƴ��� ��ȣ....
-- WHERE ���� ��ȸ���� �������� ��ȣ...

-- ��CROSS JOIN
SELECT *
FROM EMP, DEPT;
-- ��
SELECT *
FROM EMP CROSS JOIN DEPT;

--EQUI JOIN , NON EQUI JOIN ������ �����.
--��INNER JOIN
SELECT *
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- ��
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--INNER ���� ����
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--�� OUTER JOIN(EQUI JOIN ���� (+))
SELECT *
FROM TBL_EMP, TBL_DEPT
WHERE TBL_EMP.DEPTNO = TBL_DEPT.DEPTNO(+);

-- ��
SELECT *
FROM EMP E LEFT OUTER JOIN DEPT D --������ ����
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E RIGHT OUTER JOIN DEPT D -- �������� ����
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E FULL OUTER JOIN DEPT D -- �Ѵ� ���� ���� CUBE�� ����Ѵ���! ũ�ν������̶� �ٸ�!
ON E.DEPTNO = D.DEPTNO;
-- OUTER ���� ����!
--------------------------------------------------------------------------------
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
    AND JOB = 'CLERK';
-- �̿� ���� ������� �������� �����ص�
-- ��ȸ ����� ��� ������ ������ ����.
--==>>
/*
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10	10	ACCOUNTING	NEW YORK
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20	20	RESEARCH	DALLAS
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20	20	RESEARCH	DALLAS
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		30	30	SALES	CHICAGO
*/
    
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
--> ������, �̿� ���� �����Ͽ�
--  ��ȸ�ϴ� ���� �����Ѵ�.(ON�� ������ ���� : ��������, �������� ����Ϸ���!)

--------------------------------------------------------------------------------

--�� EMP ���̺�� DEPT ���̺��� �������
--   ������ MANAGER�� CLERK �� ����鸸 ��ȸ�Ѵ�.
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.
--   E,D       D       E        E      E
--            ---
--   �����ؾ߰ڴ�!
-- ON���� � ���� ���ұ�?
SELECT *
FROM EMP;

SELECT *
FROM DEPT;

SELECT D.DEPTNO"�μ���ȣ",D.DNAME"�μ���",E.ENAME"�����",E.JOB"������",E.SAL"�޿�"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO    -- FROM���� ON�� �°� �����ϴ°�! (ON �� WHERE)
WHERE E.JOB = 'MANAGER' OR E.JOB = 'CLERK'
ORDER BY 1;
--==>>
/*
�μ���ȣ   �μ���         �����     ������        �޿�
---------- -------------- ---------- --------- ----------
        10 ACCOUNTING     CLARK      MANAGER         2450
        10 ACCOUNTING     MILLER     CLERK           1300
        20 RESEARCH       ADAMS      CLERK           1100
        20 RESEARCH       JONES      MANAGER         2975
        20 RESEARCH       SMITH      CLERK            800
        30 SALES          BLAKE      MANAGER         2850
        30 SALES          JAMES      CLERK            950

*/