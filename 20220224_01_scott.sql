SELECT USER
FROM DUAL;
--==>>SCOTT

SELECT DEPTNO, SUM(SAL) -- �� �׷캰�� SUM ��ȯ
FROM EMP
GROUP BY DEPTNO; -- ��� ���� ����
--==>>
/*
30	9400
20	10875
10	8750
*/

SELECT *
FROM EMP;

SELECT *
FROM TBL_EMP;

--�� ������ �����ص� TBL_EMP ���̺� ����
DROP TABLE TBL_EMP;
--==>>Table TBL_EMP��(��) �����Ǿ����ϴ�.
--    CREATE TABLE �����̶� ���Ƽ� ���� ���� ���൵ �����ǳ�????????????

--�� �ٽ� EMP ���̺� �����Ͽ� TBL_EMP ���̺� ����
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>>Table TBL_EMP��(��) �����Ǿ����ϴ�.
SELECT *
FROM TBL_EMP;
--�� �ǽ� ������ �߰� �Է�(TBL_EMP)
--   ���� ���̺� �ִ� ������ �Ѽ� ���Ϸ��� �����ѰŰ�
--   �̹��� �����͹ٲ�
INSERT INTO TBL_EMP VALUES
( 8001, 'ȫ����' , 'CLERK' , 7566, SYSDATE, 1500, 10 , NULL);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_EMP VALUES
( 8002, '����' , 'CLERK' , 7566, SYSDATE, 2000, 10 , NULL);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_EMP VALUES
( 8003, '��ȣ��' , 'SALESMAN' , 7698, SYSDATE, 1700, NULL , NULL);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_EMP VALUES
( 8004, '�Ž���' , 'SALESMAN' , 7698, SYSDATE, 2500, NULL , NULL);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_EMP VALUES
( 8005, '������' , 'SALESMAN' , 7698, SYSDATE, 1000, NULL , NULL);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		(null)  20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	    30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	    30
7566	JONES	MANAGER	    7839	1981-04-02	2975	(null)  20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850	(null)	30
7782	CLARK	MANAGER	    7839	1981-06-09	2450	(null)	10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000	(null)	20
7839	KING	PRESIDENT	(null)	1981-11-17	5000	(null)	10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100	(null)	20
7900	JAMES	CLERK	    7698	1981-12-03	950		(null)  30
7902	FORD	ANALYST	    7566	1981-12-03	3000	(null)	20
7934	MILLER	CLERK	    7782	1982-01-23	1300	(null)	10
8001	ȫ����	CLERK	    7566	2022-02-24	1500	10	    (null)
8002	����	CLERK	    7566	2022-02-24	2000	10	    (null)
8003	��ȣ��	SALESMAN	7698	2022-02-24	1700	(null)	(null)  
8004	�Ž���	SALESMAN	7698	2022-02-24	2500	(null)	(null)
8005	������	SALESMAN	7698	2022-02-24	1000	(null)	(null)
*/

--�� Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
--==>>
/*
20	    800	 (null)   
(null)	1700 (null)	
(null)	1000 (null)	
10	    1300 (null)	
20	    2975 (null)	
30	    2850 (null)	
10	    2450 (null)	
20	    3000 (null)	
10	    5000 (null)	
(null)	2500 (null)	
20	    1100 (null)	
30	    950  (null)	
20	    3000 (null)	
30	    1250  1400
30	    1250  500
30	    1600  300
(null)	1500  10
(null)	2000  10
30	    1500   0
*/

--�� ����Ŭ������ NULL�� ���� ū ���� ���·� �����Ѵ�.
--   (ORACLE 9i ������ NULL �� ���� ���� ���� ���·� �����߾���.)
--   MSSQL�� NULL�� ���� ���� ���� ���·� �����Ѵ�.

--�� TBL_EMP ���̺��� ������� �μ��� �޿��� ��ȸ
--   �μ���ȣ, �޿��� �׸� ��ȸ

SELECT DEPTNO"�μ���ȣ",SUM(SAL)
FROM TBL_EMP
GROUP BY DEPTNO
--ORDER BY SUM(SAL);
ORDER BY DEPTNO;
--==>>
/*
10	    8750
20	    10875
30	    9400
(null)	8700
*/
SELECT DEPTNO"�μ���ȣ",SUM(SAL)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
(null)	8700    -- �μ���ȣ�� ���� ���� �������� �޿���
(null)	37725   -- ���μ� �������� �޿���
*/
SELECT 8750+10875+9400+8700
FROM DUAL;
--==>>37725

SELECT DEPTNO"�μ���ȣ",SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
(null)	29025
*/
--���������
/*
--------    ------
�μ���ȣ    �޿���
--------    ------
10	        8750
20	        10875
30	        9400
���μ�	29025
--------    ------
*/

SELECT NVL(TO_CHAR(DEPTNO),'���μ�')"�μ���ȣ",SUM(SAL)"�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
���μ�	29025
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO),'���μ�')"�μ���ȣ",SUM(SAL)"�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--------------------------------------------------------------------------------
SELECT NVL(TO_CHAR(DEPTNO),'���μ�')"�μ���ȣ",SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
���μ�	8700
���μ�	37725
*/
SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO),'���μ�')"�μ���ȣ",SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
-->> null�� �� ���̻��̸� ���߸��� �����������ϰ� ��.

SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "�μ���ȣ", SUM(SAL)"�޿���"
--�� GROUPING() : �׷����� ������ ������ 1 , �׷캰�δ� 0 ���� �׷��� ������ �ٸ�����.
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO); --�� ROLLUP() : �׷����� �������� ���յ� ��ȯ.
--==>>
/*

  GROUPING  �μ���ȣ       �޿���
---------- ---------- ----------
         0         10       8750
         0         20      10875
         0         30       9400
         0       (null)     8700    -- ����
         1       (null)    37725    -- ���μ�
*/

SELECT DEPTNO"�μ���ȣ",SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

--�� ������ ��ȸ�� �ش� ������
/*
10	        8750
20	        10875
30	        9400
����	    8700
���μ�	37725
*/

SELECT CASE WHEN GROUPING(DEPTNO) = 0 THEN NVL2(DEPTNO,TO_CHAR(DEPTNO),'����')
            WHEN GROUPING(DEPTNO) = 1 THEN '���μ�'
            ELSE '�����'
            END "�μ���ȣ", SUM(SAL)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
����	    8700
���μ�	37725
*/
--> CASE WHEN THEN ELSE END �� �� ��!
SELECT CASE GROUPING(DEPTNO) WHEN  0 THEN NVL2(DEPTNO,TO_CHAR(DEPTNO),'����')
                             WHEN 1 THEN '���μ�'
                             ELSE '�����'
                             END "�μ���ȣ"
                             , SUM(SAL)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

--�� TBL_SAWON ���̺��� �������
--   ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
---------------------------
    ����          �޿���
---------------------------
     ��           XXXXXX
     ��           XXXXXX
     �����     XXXXXX
---------------------------
*/
SELECT *
FROM TBL_SAWON;

SELECT CASE GROUPING(T.����) WHEN 0 THEN T.����
                             WHEN 1 THEN '�����'
                             ELSE '�˼�����.'
                             END "����"
        , SUM(T.�޿�)"�޿���"
FROM
(
    SELECT  CASE WHEN SUBSTR(JUBUN,7,1) IN ('1' ,'3') THEN '��'
                 WHEN SUBSTR(JUBUN,7,1) IN ('2' ,'4')THEN '��'
                 ELSE '�˼�����'
                 END "����"
             ,SAL "�޿�"
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.����); 
--==>>
/*
����      �޿���
-----    ----------
��         21900
��         32100
�����   54000
*/
SELECT *
FROM VIEW_SAWON;
--�� TBL_SAWON ���̺��� �������
--   ������ ���� ��ȸ�� �� �ֵ��� ���ɴ뺰 �ο����� Ȯ���� �� �ִ�
--   �������� �����Ѵ�.

/*
--------------------------------------
    ���ɴ�         �ο���
--------------------------------------
    10              X
    20              X
    40              X
    50              X
   ��ü           XXXX
--------------------------------------
*/
--�� �ζ��κ�2��
SELECT NVL(TO_CHAR(S.���ɴ뱸��),'��ü') "���ɴ�"
        , COUNT(S.���ɴ뱸��) "�ο���"
FROM
(
    SELECT CASE SUBSTR(TO_CHAR(T.����),1,1) WHEN '1' THEN 10
                                            WHEN '2' THEN 20
                                            WHEN '3' THEN 30
                                            WHEN '4' THEN 40
                                            WHEN '5' THEN 50
                                            ELSE -1
                                            END "���ɴ뱸��"
    FROM
    (
            SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-1900+1
                        WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-2000+1
                        ELSE -1 
                        END "����"
            FROM TBL_SAWON
    )T
)S
GROUP BY ROLLUP(S.���ɴ뱸��);

--���ζ��κ� 1��
SELECT CASE SUBSTR(TO_CHAR(T.����),1,1) WHEN '1' THEN 10
                                        WHEN '2' THEN 20
                                        WHEN '3' THEN 30
                                        WHEN '4' THEN 40
                                        WHEN '5' THEN 50
                                        ELSE -1
                                        END "���ɴ�"
     ,COUNT(SUBSTR(TO_CHAR(T.����),1,1))"�ο���"
 FROM
    (
            SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-1900+1
                        WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-2000+1
                        ELSE -1 
                        END "����"
            FROM TBL_SAWON
    )T
GROUP BY ROLLUP(T.����);
----------------------------------------------------------------------------------------------
SELECT CASE SUBSTR(TO_CHAR(T.����),1,1) WHEN '1' THEN 10
                                        WHEN '2' THEN 20
                                        WHEN '3' THEN 30
                                        WHEN '4' THEN 40
                                        WHEN '5' THEN 50
                                        ELSE -1
                                        END "���ɴ�"
     ,COUNT(SUBSTR(TO_CHAR(T.����),1,1))"�ο���"
 FROM
    (
            SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                        THEN SUBSTR(TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-1900+1),1,1)
                        WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                        THEN SUBSTR(TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-2000+1),1,1)
                        ELSE '�˼�����' 
                        END "���ɴ���ڸ�"
            FROM TBL_SAWON
    )T
GROUP BY ROLLUP(T.����);
-------------------------------------------------------------------------------------------------------------
SELECT CASE GROUPING(T.���ɴ���ڸ�) WHEN 0 THEN TO_CHAR(TO_NUMBER(T.���ɴ���ڸ�)*10)
                                            ELSE '��ü'
                                            END"���ɴ�"
                                            CASE GROUPING(T.���ɴ���ڸ�) WHEN 0 THEN TO_CHAR(TO_NUMBER(T.���ɴ���ڸ�)*10)
                                            ELSE '��ü'
                                            END "���ɴ�"
        ,CASE GROUPING(T.���ɴ���ڸ�) WHEN 0 THEN COUNT(GROUPING(T.���ɴ���ڸ�))
                                            ELSE COUNT(GROUPING(T.���ɴ���ڸ�))
                                            END"�ο���"
                                            
 FROM
    (
            SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                        THEN SUBSTR(TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-1900+1),1,1)
                        WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                        THEN SUBSTR(TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-2000+1),1,1)
                        ELSE '�˼�����'
                        END "���ɴ���ڸ�"
            FROM TBL_SAWON
    )T
GROUP BY ROLLUP(T.���ɴ���ڸ�);
--------------------------------------------------------------------------------
-- �ش�1. �ζ��� �� �� �� ��ø
/*
SELECT CASE WHEN TO_NUMBER(T1.����)>= 50 THEN 50
            WHEN TO_NUMBER(T1.����)>= 40 THEN 40
            WHEN TO_NUMBER(T1.����)>= 30 THEN 30
            WHEN TO_NUMBER(T1.����)>= 20 THEN 20
            WHEN TO_NUMBER(T1.����)>= 10 THEN 10
            ELSE 0
            END "���ɴ�"
FROM
        FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1899)
                    WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1999)
                    ELSE -1
                    END "����"
        FROM TBL_SAWON
    )T1
GROUP BY ROLLUP(T1.����);
*/
--------------�ٽ� Ǯ�� -----------
/*
���ɴ�, �ο���
    ���ɴ�
        ����
*/
--------------------------------------------------------------------------------
--�ش�2. �ζ��κ� 1��(�ζ��κ�� �ѹ��� ���ɴ븦 �����ؾ��Ѵ�.)
SELECT CASE GROUPING(T.���ɴ�) WHEN 0 THEN TO_CHAR(T.���ɴ�)
                               ELSE '��ü'
                               END"���ɴ�"
        ,COUNT(*)"�ο���" --CHECK!!!!
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1899)
                WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1999)
                ELSE -1
                END,-1) "���ɴ�"
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.���ɴ�);

--���ɴ� ���ϱ� ��Ʈ!
SELECT TRUNC(21,-1) "���"
FROM DUAL;

--TRUNC() ��ü�� ����°� �򰥸��ϱ� THEN���� ������!
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1899),-1)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
            THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1999),-1)
            ELSE -1
            END "���ɴ�"
FROM TBL_SAWON;

-------------------------------------------------------------------------------
--�� GROUP BY ���� �ϳ��� �ʿ�� ����!

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1,2;
--==>>
/*
1���� �μ���ȣ, �μ���ȣ�� ���� ��, �������� ����!
    DEPTNO JOB         SUM(SAL)
---------- --------- ----------
        10 CLERK           1300
        10 MANAGER         2450
        10 PRESIDENT       5000
        20 ANALYST         6000
        20 CLERK           1900
        20 MANAGER         2975
        30 CLERK            950
        30 MANAGER         2850
        30 SALESMAN        5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1,2;
--==>>
/*
10	        CLERK	    1300  -- 10���μ� CLERK ������ �޿���
10	      MANAGER	    2450  -- 10���μ� MANAGER ������ �޿���
10	    PRESIDENT	    5000  -- 10���μ� PRESIDENT ������ �޿���
10	       (null)       8750  -- 10���μ� ��� ������ �޿��� -- CHECK~!!! 
20	      ANALYST	    6000
20	        CLERK	    1900
20	      MANAGER	    2975
20	       (null) 	   10875  -- 20���μ� ��� ������ �޿��� -- CHECK~!!!
30	        CLERK	     950
30	      MANAGER	    2850
30	     SALESMAN	    5600
30	       (null) 	    9400  -- 30���μ� ��� ������ �޿��� -- CHECK~!!!
(null)     (null)      29025  -- ��� �μ� ��� ������ �޿��� --CHECK~!!!
*/

--�� CUBE() �� ROLLUP() ���� �� �ڼ��� ����� ��ȯ�޴´�.

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1,2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10		(null)      8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20		(null)      10875
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30		(null)      9400
(null)	ANALYST	    6000   -- ��� �μ� ANALYST ������ �޿���
(null)	CLERK	    4150   -- ��� �μ� CLERK ������ �޿���
(null)	MANAGER	    8275   -- ��� �μ� MANAGER ������ �޿���
(null)	PRESIDENT	5000   -- ��� �μ� PRESIDENT ������ �޿���
(null)	SALESMAN	5600   -- ��� �μ� SALESMAN ������ �޿���
(null)   (null)		29025  
*/

-- �� ROLLUP() �� CUBE()��
--    �׷��� �����ִ� ����� �ٸ���.(����)

-- ex.
-- ROLLUP(A, B, C)
-- ��(A, B, C) / (A, B) / (A) / ()

--CUBE(A, B, C)
-- �� (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> ������ ����� ��(ROLLUP())�� ���� ����� �ټ� ���ڶ��
--     �Ʒ����� ����� �� (CUBE())�� ���� ����� �ټ� ����ġ�� ������
--     ������ ���� ����� ���� ���¸� �� ���� ����Ѵ�.
--     ���� �ۼ��ϴ� ������ ��ȸ�ϰ��� �ϴ� �׷츸 ��GROUPING SETS����
--     �̿��Ͽ� �����ִ� ����̴�.

--------------------------------------------------------------------------------
--ROLLUP()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����')
                             ELSE '��ü�μ�'
                             END "�μ���ȣ"
                             
       ,CASE GROUPING(JOB) WHEN 0 THEN JOB
                           ELSE '��ü����'
                           END "����"
       ,SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO,JOB)
ORDER BY 1,2;
/*
�μ���ȣ                                     ����       �޿���
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       ��ü����        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       ��ü����       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       ��ü����        9400
����                                     CLERK           3500
����                                     SALESMAN        5200
����                                     ��ü����        8700
��ü�μ�                                 ��ü����       37725
*/
--------------------------------------------------------------------------------
--CUBE()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����')
                             ELSE '��ü�μ�'
                             END "�μ���ȣ"
                             
       ,CASE GROUPING(JOB) WHEN 0 THEN JOB
                           ELSE '��ü����'
                           END "����"
       ,SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO,JOB)
ORDER BY 1,2;
/*
�μ���ȣ                                     ����      �޿���
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       ��ü����        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       ��ü����       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       ��ü����        9400
����                                     CLERK           3500
����                                     SALESMAN        5200
����                                     ��ü����        8700
��ü�μ�                                 ANALYST         6000
��ü�μ�                                 CLERK           7650
��ü�μ�                                 MANAGER         8275
��ü�μ�                                 PRESIDENT       5000
��ü�μ�                                 SALESMAN       10800
��ü�μ�                                 ��ü����       37725
*/
--------------------------------------------------------------------------------
--GROUPING SETS()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����')
                             ELSE '��ü�μ�'
                             END "�μ���ȣ"
                             
       ,CASE GROUPING(JOB) WHEN 0 THEN JOB
                           ELSE '��ü����'
                           END "����"
       ,SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO,JOB),(DEPTNO),(JOB),())
ORDER BY 1,2;
/*
�μ���ȣ                                     ����      �޿���
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       ��ü����        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       ��ü����       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       ��ü����        9400
����                                     CLERK           3500
����                                     SALESMAN        5200
����                                     ��ü����        8700
��ü�μ�                                 ANALYST         6000
��ü�μ�                                 CLERK           7650
��ü�μ�                                 MANAGER         8275
��ü�μ�                                 PRESIDENT       5000
��ü�μ�                                 SALESMAN       10800
��ü�μ�                                 ��ü����       37725
*/
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����')
                             ELSE '��ü�μ�'
                             END "�μ���ȣ"
                             
       ,CASE GROUPING(JOB) WHEN 0 THEN JOB
                           ELSE '��ü����'
                           END "����"
       ,SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO,JOB),(DEPTNO),())
ORDER BY 1,2;
/*
�μ���ȣ                                     ����      �޿���
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       ��ü����        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       ��ü����       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       ��ü����        9400
����                                     CLERK           3500
����                                     SALESMAN        5200
����                                     ��ü����        8700
��ü�μ�                                 ��ü����       37725
*/
--------------------------------------------------------------------------------
--�ǹ����� ���� ����..

--�� TBL_EMP ���̺��� �������
--   �Ի�⵵�� �ο����� ��ȸ�Ѵ�.(�ο��� ���յ�)

SELECT HIREDATE
FROM TBL_EMP;

DESC TBL_EMP;

--����!
SELECT CASE GROUPING(T.�Ի�⵵) WHEN 0 THEN T.�Ի�⵵
                                 ELSE '��ü'
                                 END "�Ի�⵵"
    , COUNT(*)"�ο���"
FROM
(
    SELECT TO_CHAR(HIREDATE,'YYYY')"�Ի�⵵"
    FROM TBL_EMP
)T
GROUP BY ROLLUP(T.�Ի�⵵);
/*
�Ի�⵵  �ο���
----    ----------
1980          1
1981         10
1982          1
1987          2
2022          5
��ü         19
*/

--�ٸ� Ǯ��
-- ��
-- GROUP BY�� SELECT���̶� ���� Ÿ��
-- THEN �ڶ� ELSE �ڶ� ���� Ÿ��
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
        ,COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
/*
1980	1
1981	10
1982	1
1987	2
2022	5
        19
*/
--------------------------------------------------------------------------------
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
        ,COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;

SELECT TO_CHAR(HIREDATE,'YYYY') "�Ի�⵵"
        ,COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> ���� �߻�
--     ORA-00979: not a GROUP BY expression

-- �� CHECK~!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- GROUP BY�� ����! SELECT ����
-- �׷��� �̰ɷ� �������鼭 SELECT ���� �ٸ��ɷ� �̾Ƴ����ϴ� �����߻�!
-- ROLLUP() , CUBE(), GROUPING SETS(), �Ⱦ��� GROUP BY���ᵵ!
-- �Ľ̼��������̴�!
-- SELECT ������ GROUP BY���� ������ �������� ��ȸ�ؾ��Ѵ�!
--------------------------------------------------------------------------------
SELECT TO_CHAR(HIREDATE,'YYYY') "�Ի�⵵"
        ,COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2022	5
        19
*/
--------------------------------------------------------------------------------
SELECT CASE GROUPING(TO_CHAR(HIREDATE,'YYYY')) WHEN 0
            THEN  EXTRACT(YEAR FROM HIREDATE)
            ELSE '��ü'
            END"�Ի�⵵"
            ,COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> ���� �߻�
--     ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
--    THEN �ڴ� ����Ÿ��, ELSE �� ����Ÿ��

SELECT CASE GROUPING(TO_CHAR(HIREDATE,'YYYY')) WHEN 0
            THEN  TO_CHAR(HIREDATE,'YYYY')
            ELSE '��ü'
            END"�Ի�⵵"
            ,COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2022	5
��ü	19
*/

SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0
            THEN  EXTRACT(YEAR FROM HIREDATE)
            ELSE -1
            END"�Ի�⵵"
            ,COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
-1	    19
1980	1
1981	10
1982	1
1987	2
2022	5
*/
SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0
            THEN  TO_CHAR(EXTRACT(YEAR FROM HIREDATE))
            ELSE '��ü'
            END"�Ի�⵵"
            ,COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2022	5
��ü	19
*/
--------------------------------------------------------------------------------

--���� HAVING ����--
--�� EMP ���̺��� �μ���ȣ�� 20, 30, �� �μ��� �������
--   �μ��� �� �޿��� 10000 ���� ���� ��츸 �μ��� �� �޿��� ��ȸ�Ѵ�.
SELECT T.*
FROM
(
    SELECT DEPTNO"�μ���ȣ",SUM(SAL)"�μ����ѱ޿�"
    FROM EMP
    WHERE DEPTNO IN (20, 30)
    GROUP BY DEPTNO
)T
WHERE T.�μ����ѱ޿�<10000;

-- �ش�
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
    AND SUM(SAL)<10000
GROUP BY DEPTNO;
--==>> ���� �߻�
--     ORA-00934: group function is not allowed here
--     SUM() : �׷��Լ�. WHERE ������ ��� X


--�� ����Ŭ���� FROM, WHERE�� ���� �޸𸮿� �ۿø���.
--   FROM���� ���̺� ����
--   WHERE�� �ش��ϴ°Ÿ� �޸𸮿� �ø���.
--  �׷��Ƿ�, ����Ŭ���� �� �ߵǴ°� WHERE ������
--  �ѹ� ���� ��ģ��!
--  �̷��� �˾ƾ� ������ ȿ�������� §��.
--  ���α׷��� ���� DBA���� ... 
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY DEPTNO
HAVING SUM(SAL)<10000;
--==>>30	9400

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL)<10000 AND DEPTNO IN(20,30);
--==>>30	9400
--------------------------------------------------------------------------------

--���� ��ø �׷��Լ� / �м��Լ�����--

-- �׷� �Լ��� 2 LEVEL ���� ��ø�ؼ� ����� �� �ִ�.
-- �Լ�(�Լ�()) ������ �����ϴٴ� ��!
-- MSSQL�� �̸����� �Ұ����ϴ�.

SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>>10875
SELECT MIN(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>>8750

--�� RANK()
--   DENSE_RANK()
--> ORACLE 9i ���� ����... MSSQL 2005 ���� ����...

-- ���� ����������  RANK()�� DENSE_RANK() �� ����� �� ���� ������
-- ���� ���...�޿� ������ ���ϰ��� �Ѵٸ�
-- �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� ��
-- Ȯ���� ���� +1 �� �߰� ������ �ָ�
-- �� ���� �� �ش� ����� �޿� ����� �ȴ�.

SELECT ENAME, SAL
FROM EMP;
--==>>
/*
SMITH	800
ALLEN	1600
WARD	1250
JONES	2975
MARTIN	1250
BLAKE	2850
CLARK	2450
SCOTT	3000
KING	5000
TURNER	1500
ADAMS	1100
JAMES	950
FORD	3000
MILLER	1300
*/

--�� SMITH �� �޿� ��� Ȯ��
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL> 800; -- SMITH�� �޿�
--==>>14        -- SMITH�� �޿� ���

--�� ALLEN �� �޿� ��� Ȯ��
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL> 1600; -- ALLEN�� �޿�
--==>>7          -- ALLEN�� �޿� ���

--�� ���� ��� ����(��� ���� ����)
--   (RANK() �� ��ó�� �ȿ� �� ���·� ���� ���� ����.)
--   ���� ������ �ִ� ���̺��� �÷���
--   ���� ������ ������(WHERE��, HAVING��)�� ���Ǵ� ���
--   �츮�� �� �������� ���� ��� ����(��� ���� ����)��� �θ���.

SELECT ENAME "�����", SAL"�޿�",1"�޿����"
FROM EMP;
--==>>
/*
SMITH	 800	1
ALLEN	1600	1
WARD	1250	1
JONES	2975	1
MARTIN	1250	1
BLAKE	2850	1
CLARK	2450	1
SCOTT	3000	1
KING	5000	1
TURNER	1500	1
ADAMS	1100	1
JAMES	 950	1
FORD	3000	1
MILLER	1300	1
*/

SELECT ENAME "�����", SAL"�޿�",(SELECT COUNT(*) + 1 FROM EMP WHERE SAL> 800)"�޿����"
FROM EMP;
--==>>
/*
SMITH	 800	14
ALLEN	1600	14
WARD	1250	14
JONES	2975	14
MARTIN	1250	14
BLAKE	2850	14
CLARK	2450	14
SCOTT	3000	14
KING	5000	14
TURNER	1500	14
ADAMS	1100	14
JAMES	 950	14
FORD	3000	14
MILLER	1300	14
*/
-- �ۿ��ִ� ������ ��������!
SELECT ENAME "�����", SAL"�޿�"
        ,(SELECT COUNT(*) + 1 
          FROM EMP 
          WHERE SAL> E.SAL)"�޿����"
FROM EMP E;
--==>>
/*
SMITH	 800	14
ALLEN	1600	7
WARD	1250	10
JONES	2975	4
MARTIN	1250	10
BLAKE	2850	5
CLARK	2450	6
SCOTT	3000	2
KING	5000	1
TURNER	1500	8
ADAMS	1100	12
JAMES	 950	13
FORD	3000	2
MILLER	1300	9
*/
--------------------------------------------------------------------------------
--�� EMP ���̺��� �������
--   �����, �޿�, �μ���ȣ, �μ����޿����, ��ü�޿���� �׸��� ��ȸ�Ѵ�.
--   ��, RANK() �Լ��� ������� �ʰ� ������������ Ȱ���� �� �ֵ��� �Ѵ�.

SELECT ENAME"�����", SAL"�޿�",DEPTNO"�μ���ȣ"
       ,CASE DEPTNO WHEN 10 
                    THEN (SELECT COUNT(*) + 1
                          FROM EMP
                          WHERE SAL>E.SAL AND DEPTNO =10)
                    WHEN 20
                    THEN (SELECT COUNT(*) + 1
                          FROM EMP
                          WHERE SAL>E.SAL AND DEPTNO =20)
                    WHEN 30
                    THEN (SELECT COUNT(*) + 1
                          FROM EMP
                          WHERE SAL>E.SAL AND DEPTNO =30)
                    ELSE -1
                    END"�μ����޿����"
       ,(SELECT COUNT(*) + 1
         FROM EMP
         WHERE SAL > E.SAL)"��ü�޿����"
FROM EMP E
ORDER BY DEPTNO;    
--==>>
/*
�����      �޿�       �μ���ȣ  �μ����޿����    ��ü�޿����
---------- ---------- ----------   ----------       ----------
CLARK            2450         10          2          6
KING             5000         10          1          1
MILLER           1300         10          3          9
JONES            2975         20          3          4
FORD             3000         20          1          2
ADAMS            1100         20          4         12
SMITH             800         20          5         14
SCOTT            3000         20          1          2
WARD             1250         30          4         10
TURNER           1500         30          3          8
ALLEN            1600         30          2          7
JAMES             950         30          6         13
BLAKE            2850         30          1          5
MARTIN           1250         30          4         10
*/
--�ش�
SELECT ENAME"�����", SAL"�޿�",DEPTNO"�μ���ȣ"
       ,(SELECT COUNT(*) + 1
         FROM EMP
         WHERE SAL>E.SAL AND DEPTNO =E.DEPTNO)"�μ����޿����"
         
       ,(SELECT COUNT(*) + 1
         FROM EMP
         WHERE SAL > E.SAL)"��ü�޿����"
FROM EMP E
ORDER BY DEPTNO; 
--------------------------------------------------------------------------------
--1.�μ����޿����
--  10�� �μ����� 123��
--  20�� �μ����� 123��
--  30�� �μ����� 123��

SELECT COUNT(*) + 1
FROM EMP
WHERE (DEPTNO = 10 AND SAL>800)
       OR (DEPTNO = 20 AND SAL>800)
       OR (DEPTNO = 30 AND SAL>800);

SELECT COUNT(*) + 1
FROM EMP
WHERE DEPTNO = 20 AND SAL>800;

SELECT COUNT(*) + 1
FROM EMP
WHERE DEPTNO = 30 AND SAL>800;
--2.��ü�޿����

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
--------------------------------------------------------------------------------

--�� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--------------------------------------------------------------------------------
--  �����  �μ���ȣ  �Ի���       �޿�  �μ����Ի纰�޿�����
--------------------------------------------------------------------------------
--                               :
--  SMITH      20      1980-12-17         800                   800
--  JONES      20      1981-04-02        2975                  3775  
--  FORD       20      1981-12-03        3000                  6775
--------------------------------------------------------------------------------

SELECT ENAME"�����", DEPTNO"�μ���ȣ"
      ,HIREDATE"�Ի���"
      ,SAL"�޿�"
      ,(SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E.DEPTNO AND HIREDATE <=E.HIREDATE
        GROUP BY DEPTNO)"�μ����Ի纰�޿�����"
FROM EMP E
ORDER BY DEPTNO, HIREDATE;
--==>>
/*
�����     �μ���ȣ    �Ի���    �޿�       �μ����Ի纰�޿�����
---------- ---------- ---------- ---------- --------------------
CLARK              10 1981-06-09       2450       2450
KING               10 1981-11-17       5000       7450
MILLER             10 1982-01-23       1300       8750
SMITH              20 1980-12-17        800        800
JONES              20 1981-04-02       2975       3775
FORD               20 1981-12-03       3000       6775
SCOTT              20 1987-07-13       3000      10875
ADAMS              20 1987-07-13       1100      10875
ALLEN              30 1981-02-20       1600       1600
WARD               30 1981-02-22       1250       2850
BLAKE              30 1981-05-01       2850       5700
TURNER             30 1981-09-08       1500       7200
MARTIN             30 1981-09-28       1250       8450
JAMES              30 1981-12-03        950       9400
---------- ---------- ---------- ---------- --------------------
*/


--�μ����Ի纰�޿�����
-- �μ���
--       �Ի����� ���� �������
--                             SAL�׸� SUM...

SELECT ENAME, HIREDATE,SAL,DEPTNO
FROM EMP
WHERE DEPTNO = 10
ORDER BY HIREDATE;

--�ش�..
--1.
SELECT EMP.ENAME"�����", DEPTNO"�μ���ȣ", HIREDATE"�Ի���", SAL"�޿�"
        , (1)"�μ����Ի纰�޿�����"
FROM SCOTT.EMP
ORDER BY 2,3;

--2.
SELECT E1.ENAME"�����", E1.DEPTNO"�μ���ȣ", E1.HIREDATE"�Ի���", E1.SAL"�޿�"
        , (1)"�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2,3;

--3.
SELECT E1.ENAME"�����", E1.DEPTNO"�μ���ȣ", E1.HIREDATE"�Ի���", E1.SAL"�޿�"
        , (SELECT SUM(E2.SAL)
           FROM EMP E2)"�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2,3;

--4.
SELECT E1.ENAME"�����", E1.DEPTNO"�μ���ȣ", E1.HIREDATE"�Ի���", E1.SAL"�޿�"
        , (SELECT SUM(E2.SAL)
           FROM EMP E2
           WHERE E2.DEPTNO = E1.DEPTNO
                 AND E2.HIREDATE <= E1.HIREDATE )"�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2,3;
--------------------------------------------------------------------------------

--�� EMP ���̺��� �������
--   �Ի��� ����� ���� ���� ������ ����
--   �Ի����� �ο����� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.

SELECT EXTRACT(YEAR FROM HIREDATE)
FROM EMP;
-- �⵵
SELECT EXTRACT(MONTH FROM HIREDATE)
FROM EMP;
--��

SELECT (SELECT (TO_CHAR(E.3HIREDATE,'YYYY') || TO_CHAR(HIREDATE,'MM')
        FROM EMP E3
        WHERE COUNT((EXTRACT(YEAR FROM E3.HIREDATE) = EXTRACT(YEAR FROM E1.HIREDATE))
              AND (EXTRACT(MONTH FROM E3.HIREDATE) = EXTRACT(MONTH FROM E1.HIREDATE))) = 2)"�Ի���"
              
        ,(MAX((SELECT COUNT(*)
         FROM EMP E2
         WHERE EXTRACT(YEAR FROM E2.HIREDATE) = EXTRACT(YEAR FROM E1.HIREDATE)
               AND EXTRACT(MONTH FROM E2.HIREDATE) = EXTRACT(MONTH FROM E1.HIREDATE))))"�ο���"
FROM EMP E1
ORDER BY 1;


SELECT (TO_CHAR(HIREDATE,'YYYY') || TO_CHAR(HIREDATE,'MM'))"�Ի���"
FROM EMP E1
ORDER BY 1;

SELECT (SELECT (TO_CHAR(E.3HIREDATE,'YYYY') || TO_CHAR(HIREDATE,'MM')
        FROM EMP E3
        WHERE COUNT((EXTRACT(YEAR FROM E3.HIREDATE) = EXTRACT(YEAR FROM E1.HIREDATE))
              AND (EXTRACT(MONTH FROM E3.HIREDATE) = EXTRACT(MONTH FROM E1.HIREDATE))) = 2)"�Ի���"
FROM EMP E1
ORDER BY 1;

SELECT (SELECT (TO_CHAR(E.3HIREDATE,'YYYY') || TO_CHAR(HIREDATE,'MM')
        FROM EMP E3
        WHERE COUNT(SAL>800))"�Ի���"
FROM EMP E1
ORDER BY 1;


-- �ش�
--1. COUNT(*) �� ���! HAVING �� ���!!
SELECT TO_CHAR(HIREDATE,'YYYY-MM')"�Ի���"
       ,COUNT(*) "�ο���"
FROM EMP E1
GROUP BY TO_CHAR(HIREDATE,'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM EMP
                   GROUP BY TO_CHAR(HIREDATE,'YYYY-MM'))             
ORDER BY 1;
--==>> ����!
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

--2. �ο����� MAX�ΰ�
SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY-MM');
