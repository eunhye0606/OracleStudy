
--1�� �ּ��� ó�� (������ �ּ��� ó��)

/*
������
(������)
�ּ���
ó��
*/

-- �� ���� ����Ŭ ������ ������ �ڽ��� ���� ��ȸ
show user
--==>> USER��(��) "SYS"�Դϴ�. (��ũ��Ʈ ��¿��� ��� ����)
--> sqlplus ������ �� ����ϴ� ��ɾ�


-- ������
select user
from dual;
--==>> SYS(���ǰ�� �ǿ��� ����� ����)

SELECT USER
FROM DUAL;
--==>> SYS
-- from �ڿ��� �޸𸮷� ���� �ø���...
-- dual : � ���̺��� ���� �ø��°� �ƴ϶� select User �ڿ�
-- �ƹ��͵� ���� ��
-- ��, from �ڿ��� �ǹ̰� ����, user�� ��ȸ�� �ϰ� ������!

SELECT 1 + 2
FROM DUAL;
--==>>3


SELECT                              2+4
FROM                    DUAL;
-->>6 
-- ���������� ��������� Ű���忡 ���� ������ �Ű澲��
-- ���鰰���� ũ�� ��ٷӰ� ó�� ����.
-- ������ ������.


SELECT 1+5
FROMDUAL;
--==>>���� �߻�
--    ORA-00923: FROM keyword not found where expected
--    00923. 00000 -  "FROM keyword not found where expected"

SELECT �ֿ밭�ϱ������� F������ --�̺κ��� ����������ó���� �߸��ž� ������.
FROM DUAL;
--==>> ���� �߻�
--==>>ORA-00904: "�ֿ밭�ϱ�������": invalid identifier ��ȿ���� ���� ��ü��
--    00904. 00000 -  "%s: invalid identifier

-- �׷��� ���ڿ��� ó������� �ϴµ� ����Ŭ������ ���� �ٸ�.


SELECT "�ֿ밭�ϱ������� F������"
FORM DUAL;
--==>> ���� �߻�
--    ORA-00972: identifier is too long
--    00972. 00000 -  "identifier is too long"


-- ����Ŭ�� ���ڿ� ǥ�� ''
SELECT '�ֿ밭�ϱ������� F������'
FROM DUAL;
--==>>�ֿ밭�ϱ������� F������


SELECT '�� �� �� �� ���ܿ�.. .. ������ ����Ŭ ����!'
FROM DUAL;
--==>>�� �� �� �� ���ܿ�.. .. ������ ����Ŭ ����!

SELECT 3.14 + 3.14
FROM DUAL;
--==>>6.28

SELECT 10 * 5
FROM DUAL;
--==>>50

SELECT 10 * 5.0
FROM DUAL;
--==>>50

SELECT 4 / 2
FROM DUAL;
--==>>2

SELECT 4.0 / 2
FROM DUAL;
--==>>2

SELECT 4.0 / 2.0
FROM DUAL;
--==>>2

SELECT 5 /2
FROM DUAL;
--==>>2.5

SELECT 100 - 23
FROM DUAL;
--==>>77
