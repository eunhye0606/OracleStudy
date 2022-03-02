SELECT USER
FROM DUAL;
--==>> SCOTT

--���� UNION / UNION ALL ����--

--�� �ǽ� ���̺� ����(TBL_JUMUN)
CREATE TABLE TBL_JUMUN               -- �ֹ� ���̺� ����
( JUNO      NUMBER                   -- �ֹ� ��ȣ
, JECODE    VARCHAR2(30)             -- �ֹ��� ��ǰ �ڵ�
, JUSU      NUMBER                   -- �ֹ� ����
, JUDAY     DATE DEFAULT SYSDATE     -- �ֹ� ����
);
--==>> Table TBL_JUMUN��(��) �����Ǿ����ϴ�.
--> ���� �ֹ��� �߻�(����)�Ǿ��� ���
--  �ֹ� ���뿡 ���� �����Ͱ� �Էµ� �� �ִ� ���̺� 

--�� ������ �Է� �� ���� �ֹ� �߻�(����)
INSERT INTO TBL_JUMUN VALUES
(1, '������', 20, TO_DATE('2001-11-01 09:10:12', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(2, '�ž�', 10, TO_DATE('2001-11-01 10:20:30', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(3, '��˽�', 30, TO_DATE('2001-11-01 11:10:05', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(4, '������', 10, TO_DATE('2001-11-02 13:20:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(5, '������', 20, TO_DATE('2001-11-05 07:30:22', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(6, 'Ȩ����', 70, TO_DATE('2001-11-06 15:20:34', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(7, '����', 50, TO_DATE('2001-11-07 11:10:13', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(8, '��īĨ', 20, TO_DATE('2001-11-07 19:42:53', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(9, '��īĨ', 20, TO_DATE('2001-11-08 19:42:53', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(10, '��īĨ', 20, TO_DATE('2001-11-09 11:12:53', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(11, '����', 50, TO_DATE('2001-11-10 12:12:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(12, '����', 40, TO_DATE('2001-11-11 08:09:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(13, 'Ȩ����', 60, TO_DATE('2001-11-12 09:10:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(14, '������', 20, TO_DATE('2001-11-13 10:11:12', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(15, 'Ȩ����', 70, TO_DATE('2001-11-14 11:12:13', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(16, 'Ȩ����', 80, TO_DATE('2001-11-15 12:13:14', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(17, 'Ȩ����', 90, TO_DATE('2001-11-16 13:14:15', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(18, '������', 10, TO_DATE('2001-11-17 14:15:16', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(19, '������', 20, TO_DATE('2001-11-19 15:16:17', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(20, '������', 30, TO_DATE('2001-11-20 16:17:18', 'YYYY-MM-DD HH24:MI:SS'));
--==>>1 �� ��(��) ���ԵǾ����ϴ�.*20

--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session��(��) ����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	������	20	2001-11-01 09:10:12
2	�ž�	10	2001-11-01 10:20:30
3	��˽�	30	2001-11-01 11:10:05
4	������	10	2001-11-02 13:20:11
5	������	20	2001-11-05 07:30:22
6	Ȩ����	70	2001-11-06 15:20:34
7	����	50	2001-11-07 11:10:13
8	��īĨ	20	2001-11-07 19:42:53
9	��īĨ	20	2001-11-08 19:42:53
10	��īĨ	20	2001-11-09 11:12:53
11	����	50	2001-11-10 12:12:23
12	����	40	2001-11-11 08:09:10
13	Ȩ����	60	2001-11-12 09:10:11
14	������	20	2001-11-13 10:11:12
15	Ȩ����	70	2001-11-14 11:12:13
16	Ȩ����	80	2001-11-15 12:13:14
17	Ȩ����	90	2001-11-16 13:14:15
18	������	10	2001-11-17 14:15:16
19	������	20	2001-11-19 15:16:17
20	������	30	2001-11-20 16:17:18
*/

--��Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.

--�� �߰� ������ �Է� �� 2001�� ���� ���۵� �ֹ��� ����(2022��)���� ��� �߻�~!!!
INSERT INTO TBL_JUMUN VALUES(98764, '����',10,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98765, '������',20,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98766, '������',30,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98767, 'Ȩ����',40,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98768, '������',50,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98769, '���Ͻ�',30,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98770, '����',20,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98771, '������',20,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98772, '���Ͻ�',20,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98773, '������',90,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98774, '���̽�',20,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98775, '����Ĩ',30,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	    ������	20	2001-11-01 09:10:12
2	    �ž�	10	2001-11-01 10:20:30
3	    ��˽�	30	2001-11-01 11:10:05
4	    ������	10	2001-11-02 13:20:11
5   	������	20	2001-11-05 07:30:22
6	    Ȩ����	70	2001-11-06 15:20:34
7	    ����	50	2001-11-07 11:10:13
8	    ��īĨ	20	2001-11-07 19:42:53
9	    ��īĨ	20	2001-11-08 19:42:53
10	    ��īĨ	20	2001-11-09 11:12:53
11	    ����	50	2001-11-10 12:12:23
12	    ����	40	2001-11-11 08:09:10
13	    Ȩ����	60	2001-11-12 09:10:11
14	    ������	20	2001-11-13 10:11:12
15	    Ȩ����	70	2001-11-14 11:12:13
16	    Ȩ����	80	2001-11-15 12:13:14
17	    Ȩ����	90	2001-11-16 13:14:15
18	    ������	10	2001-11-17 14:15:16
19	    ������	20	2001-11-19 15:16:17
20	    ������	30	2001-11-20 16:17:18
                   :
98764	����	10	2022-03-02 09:28:38
98765	������	20	2022-03-02 09:30:32
98766	������	30	2022-03-02 09:31:09
98767	Ȩ����	40	2022-03-02 09:31:32
98768	������	50	2022-03-02 09:31:58
98769	���Ͻ�	30	2022-03-02 09:32:24
98770	����	20	2022-03-02 09:33:10
98771	������	20	2022-03-02 09:33:44
98772	���Ͻ�	20	2022-03-02 09:33:58
98773	������	90	2022-03-02 09:34:21
98774	���̽�	20	2022-03-02 09:34:40
98775	����Ĩ	30	2022-03-02 09:34:59
*/

--�� Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.

--�� ��Ⱑ ���� ���θ� � ��...
--   TBL_JUMUN ���̺��� �ʹ� ���ſ��� ��Ȳ
--   ���ø����̼ǰ��� �������� ���� �ֹ� ������ �ٸ� ���̺�
--   ����� �� �ֵ��� ����� ���� �Ұ����� ��Ȳ.(�� �̰� ���α׷� �� ������.)
--   ������ ��� �����͸� ������� ����� �͵� �Ұ����� ��Ȳ
--   �� ���������...
--      ������� ������ �ֹ� �����͵� ��
--      ���� �߻��� �ֹ� ������ �����ϰ�
--      ������ �����͸� �ٸ� ���̺�(TBL_JUMUNBACKUP)�� ������ �̰��� ������ ��ȹ

CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY,'YYYY-MM-DD') != TO_CHAR(SYSDATE,'YYYY-MM-DD');
--                                          -------
--                                  2022-03-02 10:09:38
--                                  ��2022-03-02

--==>>Table TBL_JUMUNBACKUP��(��) �����Ǿ����ϴ�.
SELECT *
FROM TBL_JUMUNBACKUP;
--==>>
/*
1	������	20	2001-11-01
2	�ž�	10	2001-11-01
3	��˽�	30	2001-11-01
4	������	10	2001-11-02
5	������	20	2001-11-05
6	Ȩ����	70	2001-11-06
7	����	50	2001-11-07
8	��īĨ	20	2001-11-07
9	��īĨ	20	2001-11-08
10	��īĨ	20	2001-11-09
11	����	50	2001-11-10
12	����	40	2001-11-11
13	Ȩ����	60	2001-11-12
14	������	20	2001-11-13
15	Ȩ����	70	2001-11-14
16	Ȩ����	80	2001-11-15
17	Ȩ����	90	2001-11-16
18	������	10	2001-11-17
19	������	20	2001-11-19
20	������	30	2001-11-20
*/
--> TBL_JUMUN ���̺��� �����͵� ��
--  ���� �ֹ� ���� �̿��� �����ʹ� ��� TBL_JUMUNBACKUP ���̺�
-- ����� ��ģ ����

--TBL_JUMUN ���̺��� �����͵� ��
-- ����� ��ģ �����͵� ���� �� ��, ���� �߻��� �ֹ� ������ �ƴ� �����͵� ����

DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY,'YYYY-MM-DD') != TO_CHAR(SYSDATE,'YYYY-MM-DD');
--==>>20�� �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	����	10	2022-03-02
98765	������	20	2022-03-02
98766	������	30	2022-03-02
98767	Ȩ����	40	2022-03-02
98768	������	50	2022-03-02
98769	���Ͻ�	30	2022-03-02
98770	����	20	2022-03-02
98771	������	20	2022-03-02
98772	���Ͻ�	20	2022-03-02
98773	������	90	2022-03-02
98774	���̽�	20	2022-03-02
98775	����Ĩ	30	2022-03-02
*/

--�� Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.

--�� ���� ��ǰ�� �߼��� �̷������ ���� ���� �ֹ� �����͸� �����ϰ�
--   ������ ��� �ֹ� �����͵��� ������ ��Ȳ�̹Ƿ�
--   ���̺��� ��(���ڵ�)�� ������ �پ��� �ſ� �������� ��Ȳ�̴�.

-- TBL_JUMUN, TBL_JUMUNBACKUP
-- ���̺� ���� ����
-- UNION, UNION ALL ���� ��� ���
SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	������	20	2001-11-01
2	�ž�	10	2001-11-01
3	��˽�	30	2001-11-01
4	������	10	2001-11-02
5	������	20	2001-11-05
6	Ȩ����	70	2001-11-06
7	����	50	2001-11-07
8	��īĨ	20	2001-11-07
9	��īĨ	20	2001-11-08
10	��īĨ	20	2001-11-09
11	����	50	2001-11-10
12	����	40	2001-11-11
13	Ȩ����	60	2001-11-12
14	������	20	2001-11-13
15	Ȩ����	70	2001-11-14
16	Ȩ����	80	2001-11-15
17	Ȩ����	90	2001-11-16
18	������	10	2001-11-17
19	������	20	2001-11-19
20	������	30	2001-11-20
98764	����	10	2022-03-02
98765	������	20	2022-03-02
98766	������	30	2022-03-02
98767	Ȩ����	40	2022-03-02
98768	������	50	2022-03-02
98769	���Ͻ�	30	2022-03-02
98770	����	20	2022-03-02
98771	������	20	2022-03-02
98772	���Ͻ�	20	2022-03-02
98773	������	90	2022-03-02
98774	���̽�	20	2022-03-02
98775	����Ĩ	30	2022-03-02
*/

-- �׷���, ���ݱ��� �ֹ����� ������ ���� ������
-- ��ǰ�� �� �ֹ������� ��Ÿ����� �� ��Ȳ�� �߻��ϰ� �Ǿ���.
-- �׷��ٸ�, TBL_JUMUNBACKUP ���̺��� ���ڵ�(��)��
-- TBL_JUMNUN ���̺��� ���ڵ�(��)�� ���ļ�
-- �ϳ��� ���̺��� ��ȸ�ϴ� �Ͱ� ���� ����� Ȯ���� �� �ֵ���
-- ��ȸ�� �̷������ �Ѵ�.

-- �� �÷��� �÷��� ���踦 ����Ͽ� ���̺��� �����ϰ��� �ϴ� ���
--    JOIN�� ���������
--    ���ڵ�� ���ڵ带 �����ϰ��� �ϴ� ���
--    UNION / UNION ALL �� ����� �� �ִ�.
SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;

-->UNION ALL �� ������ �ִ�.

-- �� UNION �� �׻� ������� ù ��° �÷� ��������
--    �������� ������ �����Ѵ�.(���⼭�� JUNO)
--    UNION ALL �� ���յ� �������(���̺��� ���������� ����� �������)
--    ��ȸ�� ����� ��ȯ�Ѵ�.(��, ���� ��� ����.)
--    �̷� ���� UNION �� ���ϰ� �� ũ��.(���ҽ� �Ҹ� �� ũ��.)
--    ���� UNION �� ������� �ߺ��� ���� ������ ���
--    �ߺ��� �����ϰ� 1�� �ุ ��ȸ�� ����� ��ȯ�ϰ� �ȴ�.
--    DISTINCTó��...

--�� ���ݱ��� �ֹ����� �����͵� ����
--   ��ǰ�� �� �ֹ����� ��ȸ�� �� �ִ� �������� �����Ѵ�.

SELECT JECODE
FROM TBL_JUMUNBACKUP
UNION 
SELECT JECODE
FROM TBL_JUMUN;
--==>>JECODE 13��.

SELECT T.JECODE, SUM(T.JUSU)
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
)T
GROUP BY T.JECODE;
--==>>
/*
������	40
����Ĩ	30
������	10
������	50
���Ͻ�	50
���̽�	20
��īĨ	60
������	50
�ž�	10
��˽�	30
������	190
Ȩ����	410
����	170
*/

--�� ������ �߰� �Է�
INSERT INTO TBL_JUMUN VALUES(98776, '��˽�',30,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
--�� Ȯ��
SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	����	10	2022-03-02
98765	������	20	2022-03-02
98766	������	30	2022-03-02
98767	Ȩ����	40	2022-03-02
98768	������	50	2022-03-02
98769	���Ͻ�	30	2022-03-02
98770	����	20	2022-03-02
98771	������	20	2022-03-02
98772	���Ͻ�	20	2022-03-02
98773	������	90	2022-03-02
98774	���̽�	20	2022-03-02
98775	����Ĩ	30	2022-03-02
98776	��˽�	30	2022-03-02
*/
--�� Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.


--�� INTERSECT / MINUS (�� �����հ� ������)

-- TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
-- ��ǰ�ڵ�� �ֹ������� ���� �Ȱ��� �ุ �����ϰ��� �Ѵ�.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
��˽�	30
������	20
*/

--�� TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺��� �������
--   ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� ���� ������
--   �ֹ���ȣ, ��ǰ�ڵ�, �ֹ���, �ֹ����� �׸����� ��ȸ�Ѵ�.

SELECT *
FROM TBL_JUMUN;

DESC TBL_JUMUN;

(SELECT JECODE"��ǰ�ڵ�",JUSU"�ֹ���"
FROM TBL_JUMUNBACKUP
INTERSECT 
SELECT JECODE"��ǰ�ڵ�",JUSU"�ֹ���"
FROM TBL_JUMUN);

SELECT
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T
WHERE ��ǰ�ڵ�, ������ ������;

SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T
WHERE (SELECT TB.JECODE,TB.JUSU
        FROM TBL_JUMUNBACKUP TB
        INTERSECT
        SELECT T.JECODE,T.JUSU
        FROM TBL_JUMUN T);

SELECT JECODE
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE
FROM TBL_JUMUN;
------------------------------------------------����!
SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T JOIN (SELECT JECODE,JUSU
         FROM TBL_JUMUNBACKUP
         INTERSECT
         SELECT JECODE,JUSU
         FROM TBL_JUMUN)T2
ON T2.JECODE = T.JECODE
    AND T2.JUSU = T.JUSU;
--==>>
/*
1	    ������	20	2001-11-01
3	    ��˽�	30	2001-11-01
19	    ������	20	2001-11-19
98765	������	20	2022-03-02
98776	��˽�	30	2022-03-02
*/

--���2.
SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
) T
WHERE T.JECODE IN ('������','��˽�')
    AND T.JUSU IN (20,30);
--==>>
/*
1	������	20	2001-11-01
3	��˽�	30	2001-11-01
19	������	20	2001-11-19
20	������	30	2001-11-20
98765	������	20	2022-03-02
98776	��˽�	30	2022-03-02
*/


--�� ������ �߰� �Է�
INSERT INTO TBL_JUMUN VALUES(98777,'��˽�',10,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98778,'������',40,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98779,'������',20,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98780,'��˽�',20,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(98781,'������',30,SYSDATE);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
98778	������	40	2022-03-02
98779	������	20	2022-03-02
98780	��˽�	20	2022-03-02
98781	������	30	2022-03-02
98764	����	10	2022-03-02
98765	������	20	2022-03-02
98766	������	30	2022-03-02
98767	Ȩ����	40	2022-03-02
98768	������	50	2022-03-02
98769	���Ͻ�	30	2022-03-02
98770	����	20	2022-03-02
98771	������	20	2022-03-02
98772	���Ͻ�	20	2022-03-02
98773	������	90	2022-03-02
98774	���̽�	20	2022-03-02
98775	����Ĩ	30	2022-03-02
98776	��˽�	30	2022-03-02
98777	��˽�	10	2022-03-02
*/

--�� Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�.
------------------------------------------------����!
SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T JOIN (SELECT JECODE,JUSU
         FROM TBL_JUMUNBACKUP
         INTERSECT
         SELECT JECODE,JUSU
         FROM TBL_JUMUN)T2
ON T2.JECODE = T.JECODE
    AND T2.JUSU = T.JUSU;
--==>> ������ �߰� ��..
/*
1	    ������	20	2001-11-01
3	    ��˽�	30	2001-11-01
19	    ������	20	2001-11-19
20	    ������	30	2001-11-20
98781	������	30	2022-03-02
98765	������	20	2022-03-02
98776	��˽�	30	2022-03-02
*/

--���2.
SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
) T
WHERE T.JECODE IN ('������','��˽�')
    AND T.JUSU IN (20,30);

--------------------------------------------------------------------------------
-- �� TBL_JUMUN_scott.sql ������ ���� ������ ���� ~!!!
--------------------------------------------------------------------------------
-- ������ Ȯ��.
SELECT JECODE,JUSU
 FROM TBL_JUMUNBACKUP
 INTERSECT
 SELECT JECODE,JUSU
 FROM TBL_JUMUN;
 --==>>
 /*
��˽�	30
������	20
������	30
 */

-- ���1.
SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T JOIN (SELECT JECODE,JUSU
         FROM TBL_JUMUNBACKUP
         INTERSECT
         SELECT JECODE,JUSU
         FROM TBL_JUMUN)T2
ON T2.JECODE = T.JECODE
    AND T2.JUSU = T.JUSU;
--==>> ������ �߰� ��..
/*
1	    ������	20	2001-11-01
3	    ��˽�	30	2001-11-01
19	    ������	20	2001-11-19
20	    ������	30	2001-11-20
98781	������	30	2022-03-02
98765	������	20	2022-03-02
98776	��˽�	30	2022-03-02
*/

--���2-1.
SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
) T
WHERE T.JECODE IN ('������','��˽�')
    AND T.JUSU IN (20,30);
--==>> �� 98780 �� ���ñ�?
/*
1	    ������	20	2001-11-01 �� O
3	    ��˽�	30	2001-11-01 �� O
19	    ������	20	2001-11-19 �� O
20	    ������	30	2001-11-20 �� O
98780	��˽�	20	2022-03-02 �� ������ ���� �� ���� 20���� �ش���� XX CHECK~!!
98781	������	30	2022-03-02 �� O
98765	������	20	2022-03-02 �� O
98776	��˽�	30	2022-03-02 �� O
*/
--> ����!
-- ��˽�	30 / ������	20 / ������	30 / (��˽� 20)
--                                       ----------- ���2-1....

--���2-2.
SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU)
    IN('��˽�30', '������20','������30');
--==>>
/*
1	    ������	20	2001-11-01
3	    ��˽�	30	2001-11-01
19	    ������	20	2001-11-19
20	    ������	30	2001-11-20
98781	������	30	2022-03-02
98765	������	20	2022-03-02
98776	��˽�	30	2022-03-02
*/

--���2-3. (����! ��! ����!)
SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU)
    IN( SELECT CONCAT(JECODE, JUSU)
        FROM TBL_JUMUNBACKUP
        INTERSECT
        SELECT CONCAT(JECODE, JUSU)
        FROM TBL_JUMUN
        );
--==>>
/*
1	    ������	20	2001-11-01
3	    ��˽�	30	2001-11-01
19	    ������	20	2001-11-19
20	    ������	30	2001-11-20
98781	������	30	2022-03-02
98765	������	20	2022-03-02
98776	��˽�	30	2022-03-02
*/
--------------------------------------------------------------------------------

--�� TBL_EMP ���̺��� �޿��� ���� ���� �����
--   �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� �����Ѵ�.
SELECT *
FROM TBL_EMP
ORDER BY SAL DESC;

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL =( SELECT MAX(SAL)
        FROM TBL_EMP);
--==>>7839	KING	PRESIDENT	5000

--��=ANY��

--��=ALL��

SELECT EMPNO, ENAME, JOB,SAL
FROM TBL_EMP
WHERE SAL >=ALL( SELECT SAL
                 FROM TBL_EMP);

--==>>7839	KING	PRESIDENT	5000

--�� TBL_EMP ���̺��� 20�� �μ��� �ٹ��ϴ� ��� ��
--   �޿��� ���� ���� ����� 
--   �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� �����Ѵ�.

--> ��������
SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL(SELECT SAL
                FROM TBL_EMP
                WHERE DEPTNO = 20) -- 3000�� ��� ���� ����
      AND DEPTNO = 20; -- ��ȸ�� ���� ��������
--==>>
/*
7902	FORD	ANALYST	3000
7788	SCOTT	ANALYST	3000
*/

-- ��TBL_EMP ���̺��� ����(Ŀ�̼�:COMM)�� ���� ���� �����
-- �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP
ORDER BY COMM DESC;
-->1400�� MAX
--> ����Ŭ���� NULL�� ���� ū���̴�.

SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM = (  SELECT MAX(COMM)
                FROM TBL_EMP);
--> ������ MAX() �Լ������� NULL�� ��������!
--  �����Լ����� null�� ����
--==>>7654	MARTIN	30	SALESMAN	1400

SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM >= ALL( SELECT COMM
                    FROM TBL_EMP);
--==>> ��ȸ ��� ����
--   NULL�� �����ؼ� COMM�� ��ȸ�ϴµ�
--   NULL�� NULL�� ���� �� ���⿡.. 
--   NULL ���� ū��... ��ȸ�� �� ����..?

SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM >= ALL( SELECT COMM
                    FROM TBL_EMP
                    WHERE COMM IS NOT NULL);
                    
--�� DISTINCT() �ߺ� ��(���ڵ�)�� �����ϴ� �Լ�
--1.
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO = (�����ڷ� ��ϵ� ��ȣ);

--2.
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (SELECT MGR
                FROM EMP);
--> �̰� Ǯ��....�� 
--3.
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (7902,7698,7698,7839,7698,7839,7839,7566,NULL,7698,7788,7698,7566,7782);
-- ������ ��ȣ �ߺ��Ǵ°� �ִ�.
-- �ϳ��� �� �˻�...
SELECT DISTINCT(DEPTNO)
FROM EMP;
--==>>
/*
30
20
10
*/

--4.
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (SELECT DISTINCT (MGR)
                FROM EMP);
--==>>
/*
7566	JONES	MANAGER
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7788	SCOTT	ANALYST
7839	KING	PRESIDENT
7902	FORD	ANALYST
*/
--------------------------------------------------------------------------------
--�� JOIN �߰� �� NATURAL JOIN(JOIN �ʱ⿡....UNUON ����....)
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/
-- � �÷��� ������ ���ս��Ѷ� ��� X
-- �Ҽ� �÷� ��� X
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT;
--==>> ���� �߻�
--     ORA-00905: missing keyword

-- ���벬 �˾Ƽ� �θ� ���� �ڽĲ� ����
-- �ϰ� �˾Ƽ� ���� ~ 
-- ���������� ���°� ����!
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP NATURAL JOIN DEPT;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/
--JOIN ���� ������ �ϱ�~

--DBA..���...
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
USING(DEPTNO);
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/
--------------------------------------------------------------------------------
--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>>Session��(��) ����Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	��μ�	    9707251234567	2005-01-03	3000
1002	������	    9505152234567	1999-11-23	4000
1003	������	    9905192234567	2006-08-10	3000
1004	�̿���	    9508162234567	2007-10-10	4000
1005	���̻�	    9805161234567	2007-10-10	4000
1006	������	    8005132234567	1999-10-10	1000
1007	������	    0204053234567	2010-10-10	1000
1010	���켱	    0303044234567	2010-10-10	1600
1011	������	    0506073234567	2012-10-10	2600
1013	����	    6712121234567	1998-10-10	2200
1014	ȫ����	    0005044234567	2015-10-10	5200
1015	�Ӽҹ�	    9711232234567	2007-10-10	5500
1009	������	6912232234567	1998-10-10	1300
1012	���ù�	    0208073234567	2012-10-10	2600
1008	������	    6803171234567	1998-10-10	1500
1016	���̰�	    0603194234567	2015-01-02	1500
1017	��ȣ�� 	    9611121234567	2022-02-23	5000
1018	�Ž���	    9910312234567	2022-02-23	5000
*/
-- �� TBL_SAWON ���̺� ���(������ ����) �氢 ���̺� ���� ���質 �������� ���� ����
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT SANO, SNAME, JUBUN,HIREDATE,SAL
FROM TBL_SAWON;
--==>>Table TBL_SAWONBACKUP��(��) �����Ǿ����ϴ�.
--> ADMIN PART������ BACKUP�� �ſ� ��ٷο�(��Ŀ����,,,)

--�� ������ Ȱ��...����...���� ���·� ���...


--�� ������ ����
-- �� UPDATE���� WHERE�� �ʼ�... ���߿� ������� �Ф� ����
--    COMMIT�� ���� �ض�... ����...
UPDATE TBL_SAWON
SET SNAME = '�ʶ���';
COMMIT;
--==>>
/*
18�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

Ŀ�� �Ϸ�.
*/
SELECT *
FROM TBL_SAWON;

ROLLBACK;
--==>>�ѹ� �Ϸ�.

SELECT *
FROM TBL_SAWON;

-- ������ ����(UPDATE) �� �ҿ��� ����
-- �����ϴ� �������� ���̺�ȿ� ������ ��ȭ��
-- �װ� ������ ����..
UPDATE TBL_SAWON -- �̰� ����..
SET SNAME = (SELECT SNAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = TBL_SAWON.SANO)
WHERE SNAME = '�ʶ���'; --�̰� �ۿ÷�����..
--==>>18�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
SELECT *
FROM TBL_SAWON;

COMMIT;
--==>>Ŀ�� �Ϸ�.