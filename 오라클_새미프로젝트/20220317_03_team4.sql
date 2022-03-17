SELECT USER
FROM DUAL;

--------------------------------------------------------------------------------
--�� ���� �α��� ��� ����
-- �����ڰ� �������� ������ ���� ����� �� �ִ�.
-- �Է� ���� : �����̸�, �ֹι�ȣ ���ڸ�(�⺻�н�����), �̸�, �ֹι�ȣ
-- ���̵�� T+�ε����ѹ� (�ڵ��ο�)
-- �����ڴ� ���ν����� ȣ���ؼ� �̸�, �ֹι�ȣ�� �Ѱ��ش�.
-- ���� NULL�� �����...

--�����ν��� ��: PRC_TC_INSERT(�̸�, �ֹι�ȣ)
--  ���ν��� ���� ��, �׽�Ʈ ����
EXEC PRC_TC_INSERT('�ں�','7005051234567');
--==>>PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_TC_INSERT('����̾��','8611191234567');
EXEC PRC_TC_INSERT('������','8801031234567');

--�� ���̺� ������ Ȯ��
SELECT *
FROM TEACHER_REGISTER;
--==>>
/*
T2	1234567	����̾��	8611191234567	2022-03-17
T1	1234567	�ں�	    7005051234567	2022-03-17
*/
--------------------------------------------------------------------------------
/*
- �����ڴ� ��� ���� ���� ��� ��� : ������, �����, ����ð�(����, ��)
, �����, ���ǽ�, ���� ���࿩��(���� ����, ������, ��������)
*/
SELECT TC.NAME "������"
       ,SO.NAME"�����"
       ,S0.START_DATE"��������"
       ,S0.END_DATE"��������"
       ,3"�����"  -- �������̺��̶� ��������
       ,4"���ǽ�"  -- ���ǽ����̺��̶� �������� ..
       ,5"���� ���࿩��" -- �������� <= ��������>= , ������..
FROM TEACHER_REGISTER TC, SUBJECT_OPEN SO;
-- SUBJECT_OPEN
-- TEXTBOOK
-- CLASSROOM_REGISTER
-- �� ���̺� ���� �׽�Ʈ ������ �ʿ�
--------------------------------------------------------------------------------
--�� �׽�Ʈ ������ �Է�
--�������̺� �׽�Ʈ ������
INSERT INTO TEXTBOOK(TEXTBOOK_CODE, TEXTBOOK_NAME, PUBLISHER)
VALUES(1,'�ʺ��𿩶�','�ֿ밭��');

INSERT INTO TEXTBOOK(TEXTBOOK_CODE, TEXTBOOK_NAME, PUBLISHER)
VALUES(2,'���ø����̼�','�ֿ밭��');

INSERT INTO TEXTBOOK(TEXTBOOK_CODE, TEXTBOOK_NAME, PUBLISHER)
VALUES(3,'��Ʈ��ũ����','�ֿ밭��');

SELECT *
FROM TEXTBOOK;
--==>>
/*
1	�ʺ��𿩶�	�ֿ밭��
2	���ø����̼�	�ֿ밭��
3	��Ʈ��ũ����	�ֿ밭��
*/

--���ǽ����̺� �׽�Ʈ ������
INSERT INTO CLASSROOM_REGISTER VALUES(1,'1501',30);
INSERT INTO CLASSROOM_REGISTER VALUES(2,'2203',30);
INSERT INTO CLASSROOM_REGISTER VALUES(3,'5603',50);
INSERT INTO CLASSROOM_REGISTER VALUES(4,'7104',10);

SELECT *
FROM CLASSROOM_REGISTER;
--==>>
/*
1	1501	30
2	2203	30
3	5603	50
4	7104	10
*/
--�������̺� �׽�Ʈ ������ �Է�
INSERT INTO SUBJECT VALUES(1,'�ʱ��ڹ�');
INSERT INTO SUBJECT VALUES(2,'�߱��ڹ�');
INSERT INTO SUBJECT VALUES(3,'����ڹ�');
INSERT INTO SUBJECT VALUES(4,'�ʱ޿���Ŭ');
INSERT INTO SUBJECT VALUES(5,'�߱޿���Ŭ');

SELECT *
FROM SUBJECT;
/*
1	�ʱ��ڹ�
2	�߱��ڹ�
3	����ڹ�
4	�ʱ޿���Ŭ
5	�߱޿���Ŭ
*/

-- �������̺� �׽�Ʈ ������ �Է�
INSERT INTO COURSE VALUES (1,'�ڹٰ���');
INSERT INTO COURSE VALUES (2,'����Ŭ����');

SELECT *
FROM COURSE;
--==>>
/*
1	�ڹٰ���
2	����Ŭ����
*/

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
--==>>Session��(��) ����Ǿ����ϴ�.

--�����������̺� �׽�Ʈ ������ �Է�
INSERT INTO COURSE_OPEN
VALUES ('C1',1,'T1',1,TO_DATE('2021-12-30','YYYY-MM-DD')
        ,TO_DATE('2022-06-20','YYYY-MM-DD')
        ,SYSDATE);


SELECT *
FROM COURSE_OPEN;
--==>>C1	1	T1	1	2021-12-30	2022-06-20	2022-03-17

--���񰳼����̺� �׽�Ʈ ������ �Է�
INSERT INTO SUBJECT_OPEN 
VALUES('JAVA001',1,1,'C1'
        ,TO_DATE('2022-01-05','YYYY-MM-DD')
        ,TO_DATE('2022-03-05','YYYY-MM-DD')
        ,30
        ,40
        ,30
        ,SYSDATE);
        
SELECT *
FROM SUBJECT_OPEN;
--==>>JAVA001	1	1	C1	2022-01-05	2022-03-05	30	40	30	2022-03-17

--------------------------------------------------------------------------------
SELECT *
FROM TEACHER_REGISTER;
-------------------------������������---------------------------------
--�� ������ �̸� ����
UPDATE TEACHER_REGISTER
SET NAME = '������'
WHERE TEACHER_CODE = 'T2';
--==>>1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
--��
UPDATE TEACHER_REGISTER
SET PASSWORD = '201812801'
WHERE TEACHER_CODE = 'T2';
--==>>1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
-------------------------������������---------------------------------
--�� �����������̺� ��ȸ
SELECT *
FROM COURSE_OPEN;
--==>>C1	1	T1	1	2021-12-30	2022-06-20	2022-03-17
SELECT *
FROM TEACHER_REGISTER;
--==>>
/*
T2	201812801	������	8611191234567	2022-03-17
T1	1234567	    �ں�	7005051234567	2022-03-17
*/

--�� Ʈ���� �� : TRG_TC_UPDATE
--   Ʈ���� ���� �� , �ڽ����̺� (COURSE_OPEN)�� 
--   TEACHER_CODE�� 0���� �ٲ���� Ȯ��
DELETE
FROM TEACHER_REGISTER
WHERE TEACHER_CODE = 'T1';
--�� �״ϱ� '0' �̵��� XX �ֳ��ϸ� ������ �ؾ��ϴϱ�!
-- �ڽ� ���̺� �ڵ� �÷� = NULL ���������� Ȯ��
DELETE
FROM TEACHER_REGISTER
WHERE TEACHER_CODE = 'T2';
-- ����.
--�� COURE_OPEN ���̺� ��ȸ
SELECT *
FROM COURSE_OPEN;
--==>>C1	1		1	2021-12-30	2022-06-20	2022-03-17
--------------------------------------------------------------------------------
/*
- �����ڴ� ��� ���� ���� ��� ��� : ������, �����, ����ð�(����, ��)
, �����, ���ǽ�, ���� ���࿩��(���� ����, ������, ��������)
*/
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
--==>>�ں�	�ʱ��ڹ�	2022-01-05	2022-03-05	�ʺ��𿩶�	1501	������
--------------------------------------------------------------------------------
--�� TEACHER_REGISTER ���̺��� ID �÷� ����
--   ���� : TEACHER_CODE�� ���� ��� ���. 
ALTER TABLE TEACHER_REGISTER DROP COLUMN ID;
--==>>Table TEACHER_REGISTER��(��) ����Ǿ����ϴ�.
ALTER TABLE MANAGER_REGISTER DROP COLUMN ID;
--==>>Table MANAGER_REGISTER��(��) ����Ǿ����ϴ�.
ALTER TABLE STUDENT_REGISTER DROP COLUMN ID;
--==>>Table STUDENT_REGISTER��(��) ����Ǿ����ϴ�.


-- �� COURSE_OPEN�� OP_COU_TEA_CODE_NN�� NOT NULL ���� �Ϸ�
ALTER TABLE COURSE_OPEN 
DROP CONSTRAINT OP_COU_TEA_CODE_NN;
--==>>Table COURSE_OPEN��(��) ����Ǿ����ϴ�.

-- �� �ڵ����̺� �÷� ���� ����. 
ALTER TABLE SCORE_INPUT RENAME COLUMN ATTENDANCE_CODE TO ATTENDANCE_SCORE;
--==>>Table SCORE_INPUT��(��) ����Ǿ����ϴ�.
--------------------------------------------------------------------------------

