SELECT USER
FROM DUAL;
--==>>SCOTT

------------------------------ Ȯ�� ����
SELECT *
FROM TBL_�԰�;
--==>>
/*
1	H001	2022-03-14 17:41:18	40	1000
2	H001	2022-03-14 17:41:49	60	1000
3	H002	2022-03-14 17:42:06	50	1000
*/
SELECT *
FROM TBL_��ǰ;
--==>>
/*
H001	�ٹ��	 600	100
H002	�ҽ���	 500	50
H003	�޷γ�	 500	0
H004	������	 600	0
H005	�ֹֽ�	 600	0
H006	���ڹ�	 500	0
H007	������	 500	0
C001	������	1600	0
C002	������	1700	0
C003	������	1800	0
C004	��Ÿ��	1500	0
C005	�ζ�	1500	0
C006	������	1500	0
E001	���Ǿ�	1100	0
E002	������	1700	0
E003	������	2500	0
E004	�źϾ�	1500	0
E005	�Ϻ���	1500	0
*/

--1�� INSERT
INSERT INTO TBL_�԰�(�԰���ȣ, ��ǰ�ڵ� ,�԰�����, �԰�����, �԰��ܰ�)
VALUES(4,'H002',SYSDATE,100,1000);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.

--2�� UPDATE

UPDATE TBL_�԰�
SET �԰����� = 10
WHERE �԰���ȣ = 4;
--==>>1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

--3�� DELETE
DELETE
FROM TBL_�԰�
WHERE �԰���ȣ = 4;
--==>>1 �� ��(��) �����Ǿ����ϴ�.
-- ���� �߸� H002 ������� 50�� �Ǿ����.

UPDATE TBL_��ǰ
SET ������� = 50
WHERE ��ǰ�ڵ� = 'H002';
--==>>1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

DELETE
FROM TBL_���;
--------------------------------------------------------------------------------
--�� ��Ű�� Ȱ�� �ǽ�
SELECT INSA_PACK.FN_GENDER('751212-1234567')"�Լ�ȣ����"
FROM DUAL;
--==>>����

SELECT NAME, SSN, INSA_PACK.FN_GENDER(SSN) "�Լ�ȣ��"
FROM TBL_INSA;





