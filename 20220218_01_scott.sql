SELECT USER
FROM DUAL;
--==>>SCOTT

SELECT EMPNO "�����ȣ", ENAME "�����" , JOB "������" ,SAL "��   ��", DEPTNO "�μ���ȣ"
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;
/*
7369	SMITH	CLERK	    800	    20
7499	ALLEN	SALESMAN	1600	30
7521	WARD	SALESMAN	1250	30
7566	JONES	MANAGER	    2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	    2850	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	    950	    30
7902	FORD	ANALYST	    3000	20
*/

--�� ���� ������ IN �����ڸ� Ȱ���Ͽ�
--   ������ ���� ó���� �� ������
--   �� ������ ó�� ����� ���� ����� ��ȯ�Ѵ�.
SELECT EMPNO "�����ȣ", ENAME "�����" , JOB "������" ,SAL "��   ��", DEPTNO "�μ���ȣ"
FROM EMP
WHERE DEPTNO IN (20, 30);
-- DEPTNO �ȿ� 20�� ����ְų� 30�� ����ְų�
--==>>
/*
7369	SMITH	CLERK	    800	    20
7499	ALLEN	SALESMAN	1600	30
7521	WARD	SALESMAN	1250	30
7566	JONES	MANAGER	    2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	    2850	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	    950	    30
7902	FORD	ANALYST	    3000	20
*/

--��EMP ���̺��� ������ CLERK �� ������� �����͸� ��� ��ȸ�Ѵ�.
SELECT *
FROM EMP;
WHERE JOB = 'CLERK';
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		    20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	30
7566	JONES	MANAGER 	7839	1981-04-02	2975		20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	140030
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		20
7839	KING	PRESIDENT		    1981-11-17	5000		10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		20
7900	JAMES	CLERK	    7698	1981-12-03	950		    30
7902	FORD	ANALYST	    7566	1981-12-03	3000		20
7934	MILLER	CLERK	    7782	1982-01-23	1300		10
*/

select *
from emp;
where job = "clerk";
--==>> ���� ��� 0 ��

-- �� ����Ŭ����... �Էµ� �������� �� ��ŭ��...
--    ��.��.�� ��ҹ��� ������ �Ѵ�.

--�� EMP ���̺��� ������ CLERK �� ����� ��
--   20�� �μ��� �ٹ��ϴ� �������
--   �����ȣ, �����, ������, �޿�, �μ���ȣ �׸��� ��ȸ�Ѵ�.

SELECT EMPNO "�����ȣ", ENAME "�����", JOB"������", SAL "�� ��", DEPTNO "�μ���ȣ"
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100	20
*/

--�� EMP ���̺��� ������ �����͸� Ȯ���Ͽ�
--   �̿� �Ȱ��� �����Ͱ� ����ִ� ���̺��� ������ �����Ѵ�.(TBL_EMP)


DESCRIBE EMP;
DESC EMP;
--==>>
/*
�̸�       ��?       ����           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)
*/
/*
CREATE TABLE TBL_EMP
( EMPNO     NUMBER(4)
, ENAME     VARCHAR2(10)
, JOB       VARCHAR2(9)
, MGR       NUMBER(4)
, HIREDATE  DATE
, SAL       NUMBER(7,2)
, COMM      NUMBER(7,2)
, DEPTNO    NUMBER(2)
);

SELECT *
FROM EMP;

INSERT INTO ... * 14
*/

CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>>Table TBL_EMP��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;


DESCRIBE TBL_EMP;
--==>>
/*
�̸�       ��?     ����           
-------- --     ------------ 
EMPNO           NUMBER(4)    
ENAME           VARCHAR2(10) 
JOB             VARCHAR2(9)  
MGR             NUMBER(4)    
HIREDATE        DATE         
SAL             NUMBER(7,2)  
COMM            NUMBER(7,2)  
DEPTNO          NUMBER(2)
*/

--�� ���̺� ����(DEPT ��TBL_DEPT)
CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==>>Table TBL_DEPT��(��) �����Ǿ����ϴ�.

--�ۺ����� ���̺� Ȯ��
DESC TBL_DEPT;
--==>>
/*
�̸�     ��?       ����           
------   --       ------------ 
DEPTNO              NUMBER(2)    
DNAME               VARCHAR2(14) 
LOC                 VARCHAR2(13) 
*/


--���̺��� Ŀ��Ʈ ���� Ȯ��
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE      	
TBL_EMP	        TABLE      	
TBL_EXAMPLE2	TABLE      	
TBL_EXAMPLE1	TABLE	   
SALGRADE	    TABLE      	
BONUS	        TABLE      
EMP	            TABLE      
DEPT	        TABLE      		
*/

--�� ���̺� ������ Ŀ��Ʈ ���� �Է�
COMMENT ON TABLE TBL_EMP IS '��� ����';
--==>>Comment��(��) �����Ǿ����ϴ�.

--�� Ŀ��Ʈ ���� �Է� �� �ٽ� Ȯ��
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	
TBL_EMP	        TABLE	��� ����
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/

--�� TBL_DEPT ���̺��� ������� ���̺� ������ Ŀ��Ʈ ������ �Է�
--   �� �μ� ����

--         TABLE�� ���� ���� ���� �ٸ� �ſ����� Ŀ��Ʈ�� �����Ѱ� ����..
COMMENT ON TABLE TBL_DEPT IS '�μ� ����';
--==>>Comment��(��) �����Ǿ����ϴ�.

--�� Ŀ��Ʈ ������ �Է� �� Ȯ��
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	�μ� ����
TBL_EMP	        TABLE	��� ����
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--�� �÷� ������ Ŀ��Ʈ ������ Ȯ��

SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
TBL_EXAMPLE2	NO	
BONUS	        SAL	
TBL_EMP	        HIREDATE	
DEPT	        LOC	
TBL_EMP	        ENAME	
SALGRADE	    GRADE	
TBL_EXAMPLE2	NAME	
BONUS	        ENAME	
SALGRADE	    LOSAL	
TBL_EMP	        COMM	
BONUS	        JOB	
EMP	            SAL	
TBL_EMP	        EMPNO	
BONUS	        COMM	
TBL_EMP	        DEPTNO	
TBL_EMP	        JOB	
EMP	            ENAME	
TBL_DEPT	    LOC	
*/

--�� �÷� ������ Ŀ��Ʈ ������ Ȯ��(TBL_DEPT ���̺� �Ҽ��� �÷��鸸 Ȯ��)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT'; --���� �߰�
--==>>
/*
TBL_DEPT	DEPTNO	
TBL_DEPT	DNAME	
TBL_DEPT	LOC	
*/

--�� ���̺� �Ҽӵ�(���Ե�) �÷��� ���� Ŀ��Ʈ ������ ����

COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '�μ� ��ȣ';
--==>>Comment��(��) �����Ǿ����ϴ�.
COMMENT ON COLUMN TBL_DEPT.DNAME IS '�μ���';
--==>>Comment��(��) �����Ǿ����ϴ�.
COMMENT ON COLUMN TBL_DEPT.LOC IS '�μ� ��ġ';
--==>>Comment��(��) �����Ǿ����ϴ�.

-- Ŀ��Ʈ �����Ͱ� �Էµ� ���̺��� �÷� ���� Ŀ��Ʈ ������ Ȯ��
-- (TBL_DEPT ���̺� �Ҽ��� Į���鸸 ��ȸ)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	�μ� ��ȣ
TBL_DEPT	DNAME	�μ���
TBL_DEPT	LOC	    �μ� ��ġ
*/

--�� TBL_EMP ���̺��� �������
--   ���̺� �Ҽӵ�(���Ե�) �÷��� ���� Ŀ��Ʈ ������ ����
DESC TBL_EMP;

COMMENT ON COLUMN TBL_EMP.EMPNO IS '��� ��ȣ';
COMMENT ON COLUMN TBL_EMP.ENAME IS '��� �̸�';
COMMENT ON COLUMN TBL_EMP.JOB IS '������';
COMMENT ON COLUMN TBL_EMP.MGR IS '������ �����ȣ';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '�Ի� ����';
COMMENT ON COLUMN TBL_EMP.SAL IS '�� ��';
COMMENT ON COLUMN TBL_EMP.COMM IS '�� ��';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '�μ� ��ȣ';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    ��� ��ȣ
TBL_EMP	ENAME	    ��� �̸�
TBL_EMP	JOB	        ������
TBL_EMP	MGR	        ������ �����ȣ
TBL_EMP	HIREDATE	�Ի� ����
TBL_EMP	SAL	        �� ��
TBL_EMP	COMM	    �� ��
TBL_EMP	DEPTNO	    �μ� ��ȣ
*/
-- ���� �÷� ������ �߰� �� ���� ����--
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	    30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	    30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		    30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
*/

--�� TBL_EMP ���̺� �ֹε�Ϲ�ȣ �����͸� ���� �� �ִ� �÷� �߰�
--   �� SSN   CHAR(13)
ALTER TABLE TBL_EMP
ADD SSN CHAR(13);
--==>>Table TBL_EMP��(��) ����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_EMP;

SELECT 01012341234
FROM DUAL;
--==>>1012341234
--> �տ� 0 Ż��.

SELECT '01012341234'
FROM DUAL;
--==>>01012341234
--> ���ڷθ� ������ �����Ͷ� ������ �� �տ� 0�� ����
--> ���ڿ� Ÿ������!

SELECT EMPNO, SSN
FROM TBL_EMP;

DESC TBL_EMP;

SELECT ENAME "�����", SSN"�ֹι�ȣ"
FROM TBL_EMP;
--> SSN(�ֹε�Ϲ�ȣ) �÷��� ���������� ����(�߰�)�� ������ Ȯ��

--�� ���̺� ������ �÷��� ������ ���������� �ǹ� ����.

--�� TBL_EMP ���̺� �߰��� SSN(�ֹε�Ϲ�ȣ) �÷� ���������� ����
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>>Table TBL_EMP��(��) ����Ǿ����ϴ�.

DESC TBL_EMP;
--==>>
/*
�̸�     ��? ����           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)
*/
--==>> SSN(�ֹε�Ϲ�ȣ) �÷��� ���������� �����Ǿ����� Ȯ��.


DELETE TBL_EMP;
--==>>14�� �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;
--==>> ���� �߻� ����
--     ���� ����� 0�� , ������ ����
--     ���̺��� ����(����, Ʋ)�� �״�� �����ִ� ���¿���(�÷����)
--     �����͸� ��� �ҽ�(����)�� ��Ȳ���� Ȯ��.

DESCRIBE TBL_EMP;
--==>>
/*
�̸�     ��? ����           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)
*/
--> ���� ���� �ִ� �� Ȯ�� ����

DROP TABLE TBL_EMP;
--==>>Table TBL_EMP��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;
--==>> ���� �߻�
--     ORA-00942: table or view does not exist

DESC TBL_EMP;
--==>> ���� �߻�
--     ORA-04043: TBL_EMP ��ü�� �������� �ʽ��ϴ�.

--�� ���̺� �ٽ� ����(����)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>>Table TBL_EMP��(��) �����Ǿ����ϴ�.


--�� NULL �� ó�� 
SELECT 2, 10+2, 10-2,10*2,10/2
FROM DUAL;
--==>>2	12	8	20	5


SELECT NULL, NULL + 2, 10 - NULL, NULL*2, 2/NULL
FROM DUAL;
--==>>(null) (null) (null) (null)				

--�� ������ ���
--   NULL �� ������ ���� �ǹ��ϸ�, ���������δ� ���� �������� �ʴ� ���̱� ������
--   �� NULL �� ���꿡 ���Ե� ���...
--   �� ����� ������ NULL �̴�.


--�� TBL_EMP ���̺��� Ŀ�̼�(COMM, ����)�� NULL �� ������
--   �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�.

SELECT ENAME "�����",JOB "������",SAL"�� ��",COMM"Ŀ�̼� ����"
FROM TBL_EMP
WHERE COMM = NULL;
--==>> ���� �߻����� ����
--     ��ȸ ��� ����.

SELECT ENAME "�����",JOB "������",SAL"�� ��",COMM"Ŀ�̼� ����"
FROM TBL_EMP
WHERE COMM = (NULL);
--==>> ���� �߻����� ����
--     ��ȸ ��� ����.

SELECT ENAME "�����",JOB "������",SAL"�� ��",COMM"Ŀ�̼� ����"
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> ���� �߻�
--     ORA-01722: invalid number
--     COMM �÷����� ���ڿ��� �����µ� 
--     �̰� �Ӵ�? �ϴ� ����

SELECT ENAME "�����",JOB "������",SAL"�� ��",COMM"Ŀ�̼� ����"
FROM TBL_EMP
WHERE COMM IS NULL;
--==>>
/*
SMITH	CLERK	     800	(null)
JONES	MANAGER	    2975    (null)	
BLAKE	MANAGER	    2850    (null)	
CLARK	MANAGER	    2450    (null)	
SCOTT	ANALYST	    3000    (null)	
KING	PRESIDENT	5000    (null)	
ADAMS	CLERK	    1100    (null)	
JAMES	CLERK	     950	(null)
FORD	ANALYST	    3000    (null)	
MILLER	CLERK	    1300    (null)	
*/

--�� NULL �� ���� �����ϴ� ���� �ƴϱ� ������
--   �Ϲ����� �����ڸ� Ȱ���Ͽ� ���� �� ����.
--   NULL �� ������� ����� �� ���� �����ڵ�...
--   >= , <=, = , >, <,
--   ���� �ʴ� : != , ^=, <>

--�� TBL_EMP ���̺��� 20�� �μ��� �ٹ����� �ʴ� ��������
--   �����, ������, �μ���ȣ �׸��� ��ȸ�Ѵ�.
SELECT ENAME "�����",JOB "������",DEPTNO"�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO <> 20;
--==>>
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	    30
CLARK	MANAGER	    10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	    30
MILLER	CLERK	    10
*/

--�� TBL_EMP ���̺��� Ŀ�̼��� NULL�� �ƴ� ��������
--   �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT ENAME"�����",JOB"������",SAL"�޿�",COMM"Ŀ�̼� ����"
FROM TBL_EMP
WHERE COMM IS NOT NULL; -- NOT
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/

SELECT ENAME"�����",JOB"������",SAL"�޿�",COMM"Ŀ�̼� ����"
FROM TBL_EMP
WHERE NOT COMM IS NULL;
--==>> IS(�� ������) ���� (NOT)
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/


--�� TBL_EMP ���̺��� ��� �������(�� ������ X)
--   �����ȣ, �����, �޿�, Ŀ�̼�, ���� �׸��� ��ȸ�Ѵ�.
--   ��, �޿�(SAL)�� �ſ� �����Ѵ�.
--   ����, ����(COMM)�� �� 1ȸ �����ϸ�(�ų� ����), ���� ������ ���Եȴ�.

SELECT EMPNO"�����ȣ",ENAME"�����",SAL"�� ��",COMM"Ŀ�̼� ����", 
SAL  * 12 + NVL(COMM,0) AS"����"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	 800   	         9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975		    35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850		    34200
7782	CLARK	2450		    29400
7788	SCOTT	3000		    36000
7839	KING	5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	FORD	3000		    36000
7934	MILLER	1300		    15600	
*/
-->> COMM �� NULL �̸� ������ NULL ��


--�� NVL()
SELECT NULL "COL1", NVL(NULL,10)"COL2",NVL(5,10)"COL3"
FROM DUAL;
--==>>(null) 10	 5
--    ù ��° �Ķ���� ���� NULL�̸�, �� ��° �Ķ���� ���� ��ȯ�Ѵ�.
--    ù ��° �Ķ���� ���� NULL�� �ƴϸ�, �� ���� �״�� ��ȯ�Ѵ�.

SELECT ENAME"�����",COMM"����"
FROM TBL_EMP;
--==>>
/*
SMITH	
ALLEN	300
WARD	500
JONES	
MARTIN	1400
BLAKE	
CLARK	
SCOTT	
KING	
TURNER	0
ADAMS	
JAMES	
FORD	
MILLER	
*/



SELECT ENAME"�����",NVL(COMM,1234)"����"
FROM TBL_EMP;
--==>>
/*
SMITH	1234
ALLEN	300
WARD	500
JONES	1234
MARTIN	1400
BLAKE	1234
CLARK	1234
SCOTT	1234
KING	1234
TURNER	0
ADAMS	1234
JAMES	1234
FORD	1234
MILLER	1234
*/
-- NULL�� �ƴϸ� �״��, NULL�̸� 100���� ������ ä����.




























