SELECT USER
FROM DUAL;
--==>>HR


--���� UNIQUE(UK:U) ����--
--PK - NOT NULL = UK

-- 1. ���̺��� ������ �÷��� �����Ͱ� �ߺ����� �ʰ� ������ �� �ֵ��� �����ϴ� ��������.
--    PRIMARY KEY �� ������ ��������������, NULL �� ����Ѵٴ� �������� �ִ�.
--    ���������� PRIMARY KEY �� ���������� UNIQUE INDEX �� �ڵ� �����ȴ�.
--    �ϳ��� ���̺� ������ UNIQUE ���������� ���� �� �����ϴ� ���� �����ϴ�.(ex. �ֹι�ȣ, �޴�����ȣ...)
--    ��, �ϳ��� ���̺� UNIQUE ���������� ���� �� ����� ���� �����ϴٴ� ���̴�.

-- 2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] UNIQUE

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� UNIQUE(�÷���,...)

--�� UK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST5
( COL1  NUMBER(5)   PRIMARY KEY
, COL2  VARCHAR2(30)  UNIQUE
);
--==>>Table TBL_TEST5��(��) �����Ǿ����ϴ�.

--�������� ��ȸ
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
--==>>
/*
HR	SYS_C007019	TBL_TEST5	P	COL1		
HR	SYS_C007020	TBL_TEST5	U	COL2		
*/

-- ������ �Է�
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST'); --> �����߻�
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'ABCD'); --> �����߻�
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST5(COL1) VALUES(4); --> NULL�� ���� �ƴ϶� �̰� ����
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(5, 'ABCD'); --> �����߻�

SELECT *
FROM TBL_TEST5;

COMMIT;
--==>>Ŀ�� �Ϸ�.

SELECT *
FROM TBL_TEST5;
--==>>
/*
1	TEST
2	ABCD
3	
4	
*/

--�� UK ���� �ǽ� (�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>>Table TBL_TEST6��(��) �����Ǿ����ϴ�.


-- �������� ��ȸ(Ȯ��)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
--==>>
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2		
*/

-- �� UK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST7
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
);
--==>>Table TBL_TEST7��(��) �����Ǿ����ϴ�.

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>> ��ȸ ��� ����

-- �������� �߰�
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
-- +
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL2_UK UNIQUE(COL2);

--��
ALTER TABLE TBL_TEST7
ADD ( CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
      ,CONSTRAINT TEST7_COL2_UK UNIQUE(COL2) );
--==>>Table TBL_TEST7��(��) ����Ǿ����ϴ�.

-- �������� �߰� ���� �ٽ� Ȯ��(��ȸ)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>>
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/

--------------------------------------------------------------------------------

--���� CHECK(CK:C) ����--

-- 1. �÷����� ��� ������ �������� ������ ������ �����ϱ� ���� ��������
--    �÷��� �ԷµǴ� �����͸� �˻��Ͽ� ���ǿ� �´� �����͸� �Էµ� �� �ֵ��� �Ѵ�.
--    ����, �÷����� �����Ǵ� �����͸� �˻��Ͽ� ���ǿ� �´� �����ͷ� �����Ǵ� �͸�
--    ����ϴ� ����� �����ϰ� �ȴ�.

-- 2. ���� �� ����
-- �� �÷� ������ ����
--    �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] CHECK(�÷� ����)

-- �� ���̺� ������ ����
--   �÷��� ������Ÿ��,
--   �÷��� ������Ÿ��,
--   CONSTRAINT CONSTRAINT�� CHECK(�÷� ����)

--�� CK ���� �ǽ� (�� �÷� ������ ����)
--���̺� ����
CREATE TABLE TBL_TEST8
(COL1 NUMBER(5)     PRIMARY KEY
,COL2 VARCHAR2(30)
,COL3 NUMBER(3)     CHECK(COL3 BETWEEN 0 AND 100)
);
--==>>Table TBL_TEST8��(��) �����Ǿ����ϴ�.
--NUMBER(3) : -999 ~ 999
--CHECK �� ��-999 ~ 999�� ���� ���� �ڼ��ϰ�

--������ �Է�
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1,'�ҹ�',100);
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2,'����',101); --> ���� �߻�
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2,'����',-1);  --> ���� �߻�
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2,'�̻�',80);

SELECT *
FROM TBL_TEST8;

COMMIT;

SELECT *
FROM TBL_TEST8;
--==>>
/*
1	�ҹ�	100
2	�̻�	80
*/

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
--==>>
/*
HR	SYS_C007025	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	
HR	SYS_C007026	TBL_TEST8	P	COL1		
*/
--> CHECK CONDITION : CHECK ���� Ȯ��!


--�� CK ���� �ǽ�(�� ���̺� ������ ����)
--���̺� ����
CREATE TABLE TBL_TEST9
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
,COL3 NUMBER(3)
,CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
,CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>>Table TBL_TEST9��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(1,'�ҹ�',100);
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'����',101);   --> ���� �߻�
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'����',-1);   --> ���� �߻�
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'�̻�',80); 

--Ȯ��
SELECT *
FROM TBL_TEST9;
--==>>
/*
1	�ҹ�	100
2	�̻�	80
*/

COMMIT;
--==>> Ŀ�� �Ϸ�

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
--==>>
/*
HR	TEST9_COL3_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1		
*/

--�� CK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
--���̺� ����
CREATE TABLE TBL_TEST10
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
,COL3 NUMBER(3)
);
--==>>Table TBL_TEST10��(��) �����Ǿ����ϴ�.

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> ��ȸ ��� ����

-- �������� �߰�
ALTER TABLE TBL_TEST10
ADD (CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
     ,CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100) );
--==>>Table TBL_TEST10��(��) ����Ǿ����ϴ�.

--���� ���� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>>
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/

--�� �ǽ� ����
-- ������ ���� TBL_TESTMEMBER ���̺��� �����Ͽ�
-- SSN�÷�(�ֹι�ȣ �÷�)����
-- ������ �Է� �� ������ ��ȿ�� �����͸� �Էµ� �� �ֵ���
-- üũ ���������� �߰��� �� �ֵ��� �Ѵ�.
-- (�� �ֹι�ȣ Ư�� �ڸ��� �Է� ������ �����͸� 1,2,3,4 �� �����ϵ��� ó��)
-- ����, SID �÷����� PRIMARY KEY ���������� ������ �� �ֵ��� �Ѵ�.

-- ���̺� ����
CREATE TABLE TBL_TESTMEMBER
( SID NUMBER
,NAME VARCHAR2(30)
,SSN CHAR(14) --������ �Է� ���� ��'YYMMDD-NNNNNNN'
,TEL VARCHAR2(40)
);
--==>>Table TBL_TESTMEMBER��(��) �����Ǿ����ϴ�.

ALTER TABLE TBL_TESTMEMBER
ADD (CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
     ,CONSTRAINT TESTMEMBER_SSN_CK CHECK(TO_NUMBER(SUBSTR(SSN,8,1)) BETWEEN 1 AND 4)
);
--==>>Table TBL_TESTMEMBER��(��) ����Ǿ����ϴ�.

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';
--==>>
/*
HR	TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	TO_NUMBER(SUBSTR(SSN,8,1)) BETWEEN 1 AND 4	
*/

-- ������ �Է����� Ȯ��
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL) VALUES (1,'����','980606-2169217','01012345678');
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL) VALUES (2,'����','980606-9169217','01012345678'); --> ���� �߻�

-- �׽�Ʈ�� ������ ����
DELETE
FROM TBL_TESTMEMBER
WHERE NAME = '����';
--==>>1 �� ��(��) �����Ǿ����ϴ�.

-- Ȯ��
SELECT *
FROM TBL_TESTMEMBER;
--==>> ��ȸ ��� ����

--------------------------
--������ �Է� �׽�Ʈ
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (1,'��ȣ��','961112-1234567','010-1111-1111');
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (2,'������','970131-2234567','010-2222-2222');
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (3,'ȫ����','000504-4234567','010-3333-3333');
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (4,'����','061004-3234567','010-4444-4444');

INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (5,'��ȣ��','961112-5234567','010-1111-1111'); --> ���� �߻�
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (6,'������','970131-6234567','010-2222-2222'); --> ���� �߻�

SELECT *
FROM TBL_TESTMEMBER;
--==>>
/*
1	��ȣ��	961112-1234567	010-1111-1111
2	������	970131-2234567	010-2222-2222
3	ȫ����	000504-4234567	010-3333-3333
4	����	061004-3234567	010-4444-4444
*/
COMMIT;
--==>> Ŀ�� �Ϸ�.

--------------------------------------------------------------------------------

--���� FOREIGN KEY(FK:F:R) ����--

-- 1. ���� Ű �Ǵ� �ܷ� Ű(FK)�� �� ���̺��� ������ �� ������ �����ϰ�
--    ���� �����Ű�µ� ���Ǵ� ���̴�.
--    �� ���̺��� �⺻ Ű ���� �ִ� ����
--    �ٸ� ���̺� �߰��ϸ� ���̺� �� ������ ������ �� �ִ�.
--    �� ��, �� ��° ���̺� �߰��Ǵ� ���� �ܷ�Ű�� �ȴ�.

-- 2. �θ� ���̺�(�����޴� �÷��� ���Ե� ���̺�)�� ���� ������ ��
--    �ڽ� ���̺�(�����ϴ� �÷��� ���Ե� ���̺�)�� �����Ǿ�� �Ѵ�.
--    �� ��, �ڽ� ���̺� FORIEIGN KEY ���������� �����ȴ�.

-- 3. ���� �� ����
-- �� �÷� ������ ����
--    �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��]
--                       REFERENCES �������̺��(�����÷���)
--                       [ON DELETE CASCADE | ON DELETE SET NULL]  -- �߰� �ɼ�

-- �� ���̺� ������ ����
--    �÷��� ������Ÿ��,
--    �÷��� ������Ÿ��,
--    CONSTRAINT CONSTRAINT�� FOREIGN KEY(�÷���)
--               REFERENCES �������̺��(�����÷���)
--               [ON DELETE CASECADE | ON DELETE SET NULL]         -- �߰� �ɼ�


-- �� FOREIGN KEY ���������� �����ϴ� �ǽ��� �����ϱ� ���ؼ���
--    �θ� ���̺��� ���� �۾��� ���� �����ؾ� �Ѵ�.
--    �׸��� �� ��, �θ� ���̺��� �ݵ�� PK �Ǵ� UK ����������
--    ������ �÷��� �����ؾ� �Ѵ�.

-- UK�� �� ����? ������ ���� �����ؾ��� �ȱ׷��� ���Ἲ ����.

--  [ON DELETE CASECADE | ON DELETE SET NULL] 
--  -------------------   -------------------
--                �� �� ���� ���
--  �θ����̺��� ���ڵ带 �����ϸ�
--  �ڽ����̺��� ���ڵ嵵 �����Ǵ� ������ �ɼ�


-- �θ� ���̺� ����
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>>Table TBL_JOBS��(��) �����Ǿ����ϴ�.(PK ����.)

-- �θ� ���̺� ������ �Է�
INSERT INTO TBL_JOBS(JIKWI_ID,JIKWI_NAME) VALUES(1,'���');
INSERT INTO TBL_JOBS(JIKWI_ID,JIKWI_NAME) VALUES(2,'�븮');
INSERT INTO TBL_JOBS(JIKWI_ID,JIKWI_NAME) VALUES(3,'����');
INSERT INTO TBL_JOBS(JIKWI_ID,JIKWI_NAME) VALUES(4,'����');
--==>>1 �� ��(��) ���ԵǾ����ϴ�.*4

--Ȯ��
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	���
2	�븮
3	����
4	����
*/

--Ŀ��
COMMIT;

--�� FK ���� �ǽ�(�� �÷� ������ ����)
--���̺� ���� (FK�� �Ǵ� X ����̺��� ��÷��� �����ϴ����� �� �߿�)
CREATE TABLE TBL_EMP1
(SID        NUMBER          PRIMARY KEY
,NAME       VARCHAR2(30)
,JIKWI_ID   NUMBER          REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>>Table TBL_EMP1��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007034	TBL_EMP1	P	SID		
HR	SYS_C007035	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/
-- DELETE_RULE = NO ACTION = �ɼǰǰ� ����.

-- ������ �Է�
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(1,'������',1);
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(2,'�Ž���',2);
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(3,'�̾Ƹ�',3);
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(4,'������',4);

INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(5,'������',5); --> ���� �߻�
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(5,'������',1);
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(6,'���̻�',NULL);
-- �θ����̺� �����ϵ��� ����ֶ� ~!!
INSERT INTO TBL_EMP1(SID,NAME) VALUES(7,'������');

-- Ȯ��
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	������	1
2	�Ž���	2
3	�̾Ƹ�	3
4	������	4
5	������	1
6	���̻�	
7	������	
*/

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� FK ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_EMP2
(SID        NUMBER
,NAME       VARCHAR2(30)
,JIKWI_ID   NUMBER
,CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
,CONSTRAINT EMP2_JIKWI_FK FOREIGN KEY(JIKWI_ID)
                          REFERENCES TBL_JOBS(JIKWI_ID)
);                          
--==>>Table TBL_EMP2��(��) �����Ǿ����ϴ�.

--�������� Ȯ��(��ȸ)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	TBL_EMP2	P	SID		
HR	EMP2_JIKWI_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/

--��FK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
--���̺� ����
CREATE TABLE TBL_EMP3
(SID        NUMBER
,NAME       VARCHAR2(30)
,JIKWI_ID   NUMBER
);
--==>>Table TBL_EMP3��(��) �����Ǿ����ϴ�.

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> ��ȸ ��� ����.

--�������� �߰�
ALTER TABLE TBL_EMP3
ADD (CONSTRAINT EMP3_ID_PK PRIMARY KEY(SID)
     ,CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                                  REFERENCES TBL_JOBS(JIKWI_ID)
);                                  
--==>>Table TBL_EMP3��(��) ����Ǿ����ϴ�.

--�������� �߰� ��, �������� ��Ȯ��.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_ID_PK	        TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- �������� ����
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==>>Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- �������� ���� ��, �������� ��Ȯ��.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>HR	EMP3_ID_PK	TBL_EMP3	P	SID		

-- FK�������� ���߰�
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                                REFERENCES TBL_JOBS(JIKWI_ID);
--==>>Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- �������� �߰� ��, �������� ��Ȯ��.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_ID_PK	        TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- 4. FOREIGN KEY ���� ��, ���ǻ���
--    �����ϰ��� �ϴ� �θ� ���̺��� ���� �����ؾ� �Ѵ�.
--    �����ϰ��� �ϴ� �÷��� PRIMARY KEY �Ǵ� UNIQUE ���������� �����Ǿ� �־�� �Ѵ�.
--    ���̺� ���̿� PRIMARY KEY �� ROREIGN KEY �� ���ǵǾ� ������
--    PRIMARY KEY ���������� ������ �÷��� ������ ���� ��
--    FOREIGN KEY �÷��� �� ���� �ԷµǾ� �ִ� ��� �������� �ʴ´�.
--    (��, �ڽ� ���̺� �����ϴ� ���ڵ尡 ������ ���
--    �θ� ���̺��� �����޴� ���ڵ�� ������ �� ���ٴ� ���̴�.)
--    ��, FK ���� �������� ��ON DELETE CASCADE�� �� ��ON DELETE SET NULL���ɼ���
--    ����Ͽ� ������ ��쿡�� ������ �����ϴ�.
--    ����, �θ� ���̺��� �����ϱ� ���ؼ��� �ڽ� ���̺��� ���� �����ؾ� �Ѵ�.

--�θ� ���̺�
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	���
2	�븮
3	����
4	����
*/

--�ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	������	1
2	�Ž���	2
3	�̾Ƹ�	3
4	������	4
5	������	1
6	���̻�	
7	������	
*/

-- ������ ������ ������ ������� ����
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID =4;
--==>>1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

--Ȯ��
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	������	1
2	�Ž���	2
3	�̾Ƹ�	3
4	������	1
5	������	1
6	���̻�	
7	������	
*/

--Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�


-- �θ� ���̺�(TBL_JOBS)�� ���� �����͸� �����ϰ� �ִ�
-- �ڽ� ���̺�(TBL_EMP1)�� �����Ͱ� �������� �ʴ� ��Ȳ.

-- �̿� ���� ��Ȳ���� �θ� ���̺�(TBL_JOBS)��
-- ���� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID =4;
--==>>1 �� ��(��) �����Ǿ����ϴ�.

--Ȯ��
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	���
2	�븮
3	����
*/

-- Ŀ��
COMMIT;
--==>>Ŀ�� �Ϸ�

-- �θ� ���̺�(TBL_JOBS)�� ��� ���� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_NAME= '���';
--==>> ���� �߻�
--     ORA-02292: integrity constraint (HR.SYS_C007035) violated - child record found

-- �θ� ���̺�(TBL_JOBS)�� ������ ���Ŵ� �����ұ�?
DROP TABLE TBL_JOBS;
--==>> ���� �߻�
--     ORA-02449: unique/primary keys in table referenced by foreign keys

-- �� �θ� ���̺��� �����͸� �����Ӱ�(?) �����ϱ� ���ؼ���
--    �ڽ� ���̺��� FOREING KEY �������� ���� ��
--    ��ON DELETE CASCADE�� �� ��ON DELETE SET NULL�� �ɼ� ������ �ʿ��ϴ�.

-- TBL_EMP1 ���̺�(�ڽ� ���̺�)���� FK ���������� ������ ��
-- CASCADE �ɼ��� �����Ͽ� �ٽ� FK ���������� �����Ѵ�.

-- �������� Ȯ��.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007034	    TBL_EMP1	P	SID		
HR	SYS_C007035	    TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- �������� ����
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007035;

-- �������� ���� ��, �������� ��Ȯ��.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>HR	SYS_C007034	TBL_EMP1	P	SID		

-- ��ON DELETE CASECADE�� �ɼ��� ���Ե� �������� �������� �ٽ� ����
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                                REFERENCES TBL_JOBS(JIKWI_ID)
                                ON DELETE CASCADE;
--Table TBL_EMP1��(��) ����Ǿ����ϴ�.

-- �ɼ� �߰� ��, �������� ��Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007034	        TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE ~ CHECK~!!
*/

--�� CASCADE �ɼ��� ������ �Ŀ���
--   �����ް� �ִ� �θ� ���̺��� �����͸�
--   �������� �����Ӱ� �����ϴ� ���� �����ϴ�.
--   ��,.... �θ� ���̺��� �����Ͱ� ������ ���...
--   �̸� �����ϴ� �ڽ� ���̺��� �����͵�
--   ��~~~~~~~~~�� �Բ� �����ȴ�.       �� ���� ������ ��~!!!



-- �θ� ���̺�
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	���
2	�븮
3	����
*/

-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	������	1
2	�Ž���	2
3	�̾Ƹ�	3
4	������	1
5	������	1
6	���̻�	
7	������	
*/

-- �θ� ���̺�(TBL_JOBS)���� ���� ���� ������ ����
DELETE 
FROM TBL_JOBS
WHERE JIKWI_NAME = '����'; 
--==>>1 �� ��(��) �����Ǿ����ϴ�.

-- �ڽ� ���̺� ��ȸ(Ȯ��) 
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	������	1
2	�Ž���	2
4	������	1
5	������	1
6	���̻�	
7	������	
*/
--> �̾Ƹ� ���� �����Ͱ� �����Ǿ����� Ȯ��~!!!

-- �θ� ���̺� ����
DROP TABLE TBL_JOBS;
--==>> ���� �߻�
--     ORA-02449: unique/primary keys in table referenced by foreign keys
--     EMP2, EMP3�� �����ϰ� �־...�ɼǾ���...
--     �ٵ� �ƴϳ� CASCADE �ϰ� �ִ� EMP1�� ���ܵ�
--     �� �ڽ� ���̺� �־ �����ȵ�... �ڽ� ���� ���־ߵ�.....CHECK~!!



-- TBL_EMP1 ���̺� �̿��� �ڽ� ���̺� ����
DROP TABLE TBL_EMP2;
--==>>Table TBL_EMP2��(��) �����Ǿ����ϴ�.
DROP TABLE TBL_EMP3;
--==>>Table TBL_EMP3��(��) �����Ǿ����ϴ�.

-- �θ� ���̺� �ٽ� ����
DROP TABLE TBL_JOBS;
--==>> ���� �߻�
--     ORA-02449: unique/primary keys in table referenced by foreign keys

-- ���� �ڽ� ���̺� (TBL_EMP1) ����
DROP TABLE TBL_EMP1;
--==>>Table TBL_EMP1��(��) �����Ǿ����ϴ�.


-- ��¥ ����! �θ� ���̺� ����
DROP TABLE TBL_JOBS;
--==>>Table TBL_JOBS��(��) �����Ǿ����ϴ�.
--------------------------------------------------------------------------------
--���� NOT NULL(NN:CK:C) ����--
--------NOT NULL�� ������ �ٷ�ٱ� ���� CHECK�ȿ��� NOT NULL�� ���°� ����....

-- �ٸ� �������ǰ� ������!1!!
-- 1. �ٸ� ���������� ���̺� ������ ���� ������,
--     NOT NULL�� �÷� ���� ���� ��.
-- 2. ADD ���� MODIFY ���� ���¸� ���� ��.



-- 1. ���̺��� ������ �÷��� �����Ͱ�
--    NULL �� ���¸� ���� ���ϵ��� �ϴ� ��������.

-- 2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��]NOT NULL

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� CHECK(�÷��� IS NOT NULL)

-- 3. ������ �����Ǿ� �ִ� ���̺� NOT NULL ���������� �߰��� ���
--    ADD ���� MODIFY ���� �� ���� ���ȴ�.
-- ALTER TABLE ���̺��
-- MODIFY �÷��� ������Ÿ�� NOT NULL;

-- 4. ���� �����Ǿ� �ִ� ���̺� �����Ͱ� �̹� ������� ���� �÷�(�� NULL �� ������ �÷�)��
--    NOT NULL ���������� ���Բ� �����ϴ� ��쿡�� ���� �߻��Ѵ�.(�Ұ����ϴ�.)
--    (�̹� ���������� ������ ����� �����Ͱ� ������ �������� ����.
--     Ư��, NOT NULL���� ���� �߻�!)


--�� NOT NULL ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST11
(COL1 NUMBER(5)     PRIMARY KEY
,COL2 VARCHAR2(30)  NOT NULL
);
--==>>Table TBL_TEST11��(��) �����Ǿ����ϴ�.
-- NOT NULL ���������� CHECK �������� ���ַ� ����������
-- CHECK Ű���� ��� ��.

--������ �Է�
INSERT INTO TBL_TEST11(COL1,COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST11(COL1,COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST11(COL1,COL2) VALUES(3, NULL); --> ���� �߻�
INSERT INTO TBL_TEST11(COL1) VALUES(3);  --> ���� �߻�

-- Ȯ��
SELECT *
FROM TBL_TEST11;
--==>>
/*
1	TEST
2	ABCD
*/

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST11';
--==>>
/*
HR	SYS_C007042	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007043	TBL_TEST11	P	COL1		
*/

-- �� NOT NULL ���� �ǽ�(�� ���̺� ������ ����)
--���̺� ����
CREATE TABLE TBL_TEST12
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
,CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
,CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>>Table TBL_TEST12��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST12';
--==>>
/*
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/
-- �÷� ������ üũ���ǿ� "COL2"
-- ���̺� ������ üũ���ǿ� COL2
-- ������!!

--�� NOT NULL ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
--���̺� ����
CREATE TABLE TBL_TEST13
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
);
--==>>Table TBL_TEST13��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> ��ȸ��� ����.

-- �������� �߰�
ALTER TABLE TBL_TEST13
ADD (CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    ,CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL));
--==>>Table TBL_TEST13��(��) ����Ǿ����ϴ�.

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>>
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/

--�� NOT NULL �������Ǹ� TBL_TEST13 ���̺��� COL2 �� �߰��ϴ� ���
--   ������ ���� ����� ����ϴ� �͵� �����ϴ�.
ALTER TABLE TBL_TEST13
MODIFY COL2 NOT NULL;
--==>>Table TBL_TEST13��(��) ����Ǿ����ϴ�.

-- �÷� �������� NOT NULL ���������� ������ ���̺�(TBL_TEST11)
DESC TBL_TEST11;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
-- ���̺� �������� NOT NULL ���������� ������ ���̺�(TBL_TEST12)
DESC TBL_TEST12;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/

-- ��, DESCRIBE ������ �÷��������� ������ ���������� �ٷ� ���̰�
-- Ư���� NOT NULL ������ DESC���� �ٷ� ���� �����ϴ� ���� ����
-- DESC�� ���� ���ٰ� ���������� ���� ���� �ƴ�!


-- ���̺� ���� ���� ADD�� ���� NOT NULL ���������� �߰��Ͽ�����(���̺� ����)
-- ���⿡ ���Ͽ� MODIFY ���� ���� NOT NULL ���������� �߰��� ���̺� (TBL_TEST13)
DESC TBL_TEST13;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME IN ('TBL_TEST11','TBL_TEST12','TBL_TEST13');
--==>>
/*
HR	SYS_C007042	        TBL_TEST11	C	COL2	"COL2" IS NOT NULL	  �� �÷�����
HR	SYS_C007043	        TBL_TEST11	P	COL1		
HR	TEST12_COL2_    NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	 �� ���̺���
HR	TEST12_COL1_    PK	TBL_TEST12	P	COL1		
HR	TEST13_COL1_    PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_    NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	�� �÷�����
HR	SYS_C007048	        TBL_TEST13	C	COL2	"COL2" IS NOT NULL	�� ���̺���
*/


--------------------------------------------------------------------------------

--���� DEFAULT ǥ���� ����--

-- 1. INSERT �� UPDATE ������
--    Ư�� ���� �ƴ� �⺻ ���� �Է��ϵ��� ó���� �� �ִ�.

-- 2. ���� �� ����
--    �÷��� ������Ÿ�� DEFAULT �⺻��

-- 3. INSERT ��� ��, �ش� �÷��� �Էµ� ���� �Ҵ����� �ʰų�,
--    DEFAULT Ű���带 Ȱ���Ͽ� �⺻���� ������ ���� �Է��ϵ��� �� �� �ִ�.

-- 4. DEFAULT Ű����� �ٸ� ����(NOT NULL ��) ǥ�Ⱑ �Բ� ���Ǿ�� �ϴ� ���
--    DEFAULT Ű���带 ���� ǥ��(�ۼ�)�� ���� �����Ѵ�.

--�� DEFAULT ǥ���� ���� �ǽ�
--���̺� ����        
CREATE TABLE TBL_BBS                            -- �Խ��� ���̺� ����
( SID       NUMBER          PRIMARY KEY         -- �Խù� ��ȣ �� �ĺ��� �� �ڵ� ����
, NAME      VARCHAR2(20)                        -- �Խù� �ۼ���
, CONTENTS  VARCHAR2(200)                       -- �Խù� ����
, WRITEDAY  DATE            DEFAULT SYSDATE     -- �Խù� �ۼ���
, COUNTS    NUMBER          DEFAULT 0           -- �Խù� ��ȸ��
, COMMENTS  NUMBER          DEFAULT 0           -- �Խù� ��� ����
);
--==>>Table TBL_BBS��(��) �����Ǿ����ϴ�.

-- �� SID �� �ڵ� ���� ������ ��Ϸ��� ������ ��ü�� �ʿ��ϴ�.
--    �ڵ����� �ԷµǴ� �÷��� ������� �Է� �׸񿡼� ���ܽ�ų �� �ִ�.

-- ������ ����
CREATE SEQUENCE SEQ_BBS
NOCACHE;
--==>>Sequence SEQ_BBS��(��) �����Ǿ����ϴ�.

-- ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session��(��) ����Ǿ����ϴ�.


-- �Խù� �ۼ�
INSERT INTO TBL_BBS(SID,NAME,CONTENTS,WRITEDAY,COUNTS,COMMENTS)
VALUES(SEQ_BBS.NEXTVAL,'�ֹ���','����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.'
        ,TO_DATE('2022-02-01 15:34:10','YYYY-MM-DD HH24:MI:SS'),0,0);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
-- ��ȸ���� ����� NULL �̸� �����ϴ� �ڵ尡 �־
-- NULL �� ���� ������ NULL ��ȯ�̶� ��� NULL ��!
INSERT INTO TBL_BBS(SID,NAME,CONTENTS,WRITEDAY,COUNTS,COMMENTS)
VALUES(SEQ_BBS.NEXTVAL,'��ȣ��','��� �ǽ����Դϴ�.'
        ,SYSDATE,0,0);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.        
INSERT INTO TBL_BBS(SID,NAME,CONTENTS,WRITEDAY,COUNTS,COMMENTS)
VALUES(SEQ_BBS.NEXTVAL,'�̿���','������ �ǽ����Դϴ�.'
        ,DEFAULT,0,0);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_BBS(SID,NAME,CONTENTS,WRITEDAY,COUNTS,COMMENTS)
VALUES(SEQ_BBS.NEXTVAL,'������','������ �ǽ����Դϴ�.'
        ,DEFAULT,DEFAULT,DEFAULT);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.    
INSERT INTO TBL_BBS(SID,NAME,CONTENTS)
VALUES(SEQ_BBS.NEXTVAL,'������','������ �ǽ����Դϴ�.');        
--==>>1 �� ��(��) ���ԵǾ����ϴ�.    
-- INSERT �Ҷ�, �÷� ����θ� NULL�ε� DEFALUT�� ���ǵǾ��־
-- �� ������ ä��.

-- Ȯ��
SELECT *
FROM TBL_BBS;
--==>
/*
1	�ֹ���	����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.	2022-02-01 15:34:10	0	0
2	��ȣ��	��� �ǽ����Դϴ�.	                    2022-03-04 14:29:47	0	0
3	�̿���	������ �ǽ����Դϴ�.	                2022-03-04 14:30:30	0	0
4	������	������ �ǽ����Դϴ�.	                2022-03-04 14:31:37	0	0
5	������	������ �ǽ����Դϴ�.	                2022-03-04 14:32:38	0	0
*/


-- �� DEFAULT ǥ���� Ȯ��(��ȸ)
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'TBL_BBS';
--==>>
/*
TBL_BBS	SID	        NUMBER			22			N	1													
TBL_BBS	NAME	    VARCHAR2			20			Y	2											
TBL_BBS	CONTENTS	VARCHAR2			200			Y	3											
TBL_BBS	WRITEDAY	DATE			7			Y	4	8	"SYSDATE"									
TBL_BBS	COUNTS	    NUMBER			22			Y	5	2	"0"
TBL_BBS	COMMENTS	NUMBER			22			Y	6	2	"0"
*/

--�� ���̺� ���� ���� DEFAULT ǥ���� �߰� / ����
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���] DEFAULT �⺻��;

-- �� ������ DEFAULT ǥ���� ����
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���] DEFAULT NULL;

COMMIT;

