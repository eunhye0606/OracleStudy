SELECT USER
FROM DUAL;
--==>>SCOTT

--�� TBL_SAWON ���̺��� Ȱ���Ͽ� 
--   ������ ���� �׸���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--   �����ȣ, �����, �ֹι�ȣ, ����, �Ի���
SELECT SANO "�����ȣ", SNAME"�����",JUBUN"�ֹι�ȣ"
,CASE WHEN MOD(TO_NUMBER(SUBSTR(JUBUN,7,1)),2) = 0 THEN '��'
             WHEN MOD(TO_NUMBER(SUBSTR(JUBUN,7,1)),2) != 0 THEN '��'
             ELSE '�˼�����'
             END"����"
             , HIREDATE"�Ի���"
FROM TBL_SAWON;
--==>>
/*
1001	��μ�	    9707251234567	��	2005-01-03 00:00:00
1002	������	    9505152234567	��	1999-11-23 00:00:00
1003	������	    9905192234567	��	2006-08-10 00:00:00
1004	�̿���	    9508162234567	��	2007-10-10 00:00:00
1005	���̻�	    9805161234567	��	2007-10-10 00:00:00
1006	������	    8005132234567	��	1999-10-10 00:00:00
1007	������	    0204053234567	��	2010-10-10 00:00:00
1010	���켱	    0303044234567	��	2010-10-10 00:00:00
1011	������	    0506073234567	��	2012-10-10 00:00:00
1013	����	    6712121234567	��	1998-10-10 00:00:00
1014	ȫ����	    0005044234567	��	2015-10-10 00:00:00
1015	�Ӽҹ�	    9711232234567	��	2007-10-10 00:00:00
1009	������	6912232234567	��	1998-10-10 00:00:00
1012	���ù�	    0208073234567	��	2012-10-10 00:00:00
1008	������	    6803171234567	��	1998-10-10 00:00:00
1016	���̰�	    0603194234567	��	2015-01-02 00:00:00
*/

SELECT SANO "�����ȣ", SNAME"�����",JUBUN"�ֹι�ȣ"
,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
      WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
             ELSE '���� Ȯ�� �Ұ�'
             END"����"
             , HIREDATE"�Ի���"
FROM TBL_SAWON;


--�� TBL_SAWON ���̺��� Ȱ���Ͽ�
--   ������ ���� �׸��� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--   �������ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���
--     ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ���
--   ��, ���糪�̴� �⺻ �ѱ����� ������ ���� ������ �����Ѵ�.
--   ����, ������������ �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ����
--   �� ������ �Ի� ��, �Ϸ� ������ �����Ѵ�.
--   �׸���, ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� �����
--   �� ����� ���� �޿� ���� 30% ����, 2000�� �̻� �ٹ��� �����
--   �� ����� ���� �޿� ���� 50% ������ �� �� �ֵ��� ó���Ѵ�.

--ex) 1001 ��μ� 9707251234567 ���� 26 2005-01-03 2056-01-03 213123 3123132 3000 4500 

SELECT SANO"�����ȣ", SNAME"�����", JUBUN"�ֹι�ȣ"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
            ELSE '�����˼�����'
            END "����"
     , CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1) 
            ELSE ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1)
            END || '��'"���糪��"
     , HIREDATE"�Ի���"
     ,CASE WHEN TO_DATE((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN ADD_MONTHS(TO_DATE(HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365 --���⼭ Ʋ�� �Ի�⵵�� ���ϴ°� �ƴ϶� SYSDATE�� YEAR�� ���ϰ�
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)),(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')))*12)     -- �Ի���� ����������!
            
            ELSE ADD_MONTHS(TO_DATE(HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)),(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')))*12)
            END"����������"
     ,TRUNC(SYSDATE - HIREDATE) || '��' "�ٹ��ϼ�"
     , CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  
                CASE WHEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)
                  -SYSDATE))) >0
                     THEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)
                  -SYSDATE)))
                     ELSE 0
                     END
            WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)>=100
            THEN 
                CASE WHEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)
                  -SYSDATE))) > 0
                  THEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)
                  -SYSDATE)))
                  ELSE 0
                  END
            END"�����ϼ�"
     , SAL"�޿�"
     , CASE WHEN TRUNC(SYSDATE - HIREDATE)>=1000 AND TRUNC(SYSDATE - HIREDATE)<2000 
            THEN SAL*0.3
            WHEN TRUNC(SYSDATE - HIREDATE)>=2000
            THEN SAL*0.5
            ELSE 0
            END "���ʽ�"
FROM TBL_SAWON;
--------------------------------------------------------------------------------
--1. ����
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
            ELSE '�����˼�����'
            END "����"
FROM TBL_SAWON;

--2. ���糪��
SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1) 
            ELSE ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1)
            END"���糪��"
FROM TBL_SAWON;

--   ����, ������������ �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ����
--   �� ������ �Ի� ��, �Ϸ� ������ �����Ѵ�.
--3. ����������
SELECT TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')),2005+34
FROM TBL_SAWON;


SELECT HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400)
FROM TBL_SAWON;

SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)) 
            ELSE (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))
            END"����������"
FROM TBL_SAWON;

SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  (TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')) + (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                +(TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')) + (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)
            ELSE  TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')) + (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))
            END"����������"
FROM TBL_SAWON;

SELECT SNAME, HIREDATE,
      CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400)
            
            ELSE  HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/400)
            END"����������"
            ,CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1) 
            ELSE ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1)
            END"���糪��"
FROM TBL_SAWON;
--�����϶� 366 , ����̸� 365(����!)
SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400)
            
            ELSE  HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/400)
            END"����������"
FROM TBL_SAWON;

SELECT 2022/(2022-1)
FROM DUAL;

--4.�ٹ��ϼ�
SELECT TRUNC(SYSDATE - HIREDATE) || '��' "�ٹ��ϼ�"
FROM TBL_SAWON;

--5.�����ϼ�
SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400))
                  -SYSDATE)
            
            WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)>=100
            THEN TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/400))
                  -SYSDATE)
            END"�����ϼ�"
FROM TBL_SAWON;


SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400))
                  -SYSDATE)
            
            WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)>=100
            THEN TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/400))
                  -SYSDATE)
            END"�����ϼ�"
FROM TBL_SAWON;

--   �׸���, ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� �����
--   �� ����� ���� �޿� ���� 30% ����, 2000�� �̻� �ٹ��� �����
--   �� ����� ���� �޿� ���� 50% ������ �� �� �ֵ��� ó���Ѵ�.
--6.���ʽ�
SELECT CASE WHEN TRUNC(SYSDATE - HIREDATE)>=1000 AND TRUNC(SYSDATE - HIREDATE)<2000 
            THEN SAL*0.3
            WHEN TRUNC(SYSDATE - HIREDATE)>=2000
            THEN SAL*0.5
            ELSE 0
            END "���ʽ�"
FROM TBL_SAWON;

--�����ϼ� ����ó��
SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  
                CASE WHEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)
                  -SYSDATE))) >0
                     THEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)
                  -SYSDATE)))
                     ELSE 0
                     END
            WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)>=100
            THEN 
                CASE WHEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)
                  -SYSDATE))) > 0
                  THEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)
                  -SYSDATE)))
                  ELSE 0
                  END
            END"�����ϼ�"
FROM TBL_SAWON;
------------------------------------------------------------------------------------
--�ش�
--   �������ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���
--     ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ���

--������ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, �޿�... ����
SELECT SANO "�����ȣ", SNAME"�����",JUBUN"�ֹι�ȣ"
        -- ����
        ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
              WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
              ELSE '����Ȯ�κҰ�'
              END "����"
        -- ���糪�� = ����⵵ - �¾�� + 1(1900���/2000���)
        ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
              THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
              WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE -1 -- CEHCK~!!!
              END "���糪��"
        --�Ի���
        ,HIREDATE"�Ի���"
        --�޿�
        ,SAL"�޿�"
FROM TBL_SAWON;
--------------------------------------------------------------------------------
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0)"����",���� *2"�ι迬��"
FROM EMP;
--==>> ���� �߻�
--     ORA-00904: "����": invalid identifier

SELECT T.EMPNO, T.ENAME, T.SAL, T.����, T.����*2 "�ι迬��"
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0)"����"
    FROM EMP
) T; --��Ī

SELECT T.* --ALL����.
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0)"����"
    FROM EMP
) T; --��Ī
--------------------------------------------------------------------------------
--FROM������ ���� �ζ��κ�! ��������!
-- ��!! ����!!
--   �������ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���
--     ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ���
--������ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, �޿�... ����
--������������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ�
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���

        -- ����������
        -- ���������⵵ �� �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��
        -- ���� ���̰� ... 57��...  3�� ��       2022 �� 2025
        -- ���� ���̰� ... 28��... 32�� ��       2022 �� 2054
        -- ADD_MONTHS(SYSDATE,�������*12) ��� �̰� �������߳� ��
        --                     -------
        --                     60 - ���糪��
        
        -- ADD_MONTHS(SYSDATE,(60 - ���糪��)*12) �� Ư����¥(��¥Ÿ��)
        -- TO_CHAR('Ư����¥','YYYY')        �� �������� �⵵�� ����Ÿ������ ����
        -- TO_CHAR(�Ի���,'MM-DD')           �� �Ի� ���ϸ� ����Ÿ������ ����
        ,TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.���糪��)*12),'YYYY') || '-' || TO_CHAR(T.�Ի���,'MM-DD') "����������"
        
        -- �ٹ��ϼ�
        -- �ٹ��ϼ� = ������ - �Ի���
        ,TRUNC(SYSDATE - T.�Ի���)"�ٹ��ϼ�"
        
        -- �����ϼ�
        -- �����ϼ� = ���������� - ������
        ,TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.���糪��)*12),'YYYY') || '-' || TO_CHAR(T.�Ի���,'MM-DD')) - SYSDATE) "�����ϼ�"
        --�޿�
        ,T.�޿�
        
        -- ���ʽ�
        -- �ٹ��ϼ��� 1000�� �̻� 2000�� �̸� �� ���� �޿��� 30% ����
        -- �ٹ��ϼ��� 2000�� �̻�             �� ���� �޿��� 50% ����
        -- ������                             �� 0
        --------------------------------------------------------------
        -- �ٹ��ϼ� 2000�� �̻�               �� T.�޿� * 0.5
        -- �ٹ��ϼ� 1000�� �̻�               �� T.�޿� * 0.3
        -- ELSE                               �� 0
        --------------------------------------------------------------
        ,CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000
              THEN T.�޿� * 0.5
              WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000
              THEN T.�޿� * 0.3
              ELSE 0
              END "���ʽ�" 
FROM 
(
    SELECT SANO "�����ȣ", SNAME"�����",JUBUN"�ֹι�ȣ"
            -- ����
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
                  WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
                  ELSE '����Ȯ�κҰ�'
                  END "����"
            -- ���糪�� = ����⵵ - �¾�� + 1(1900���/2000���)
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                  THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                  WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                  ELSE -1 -- CEHCK~!!!
                  END "���糪��"
            --�Ի���
            ,HIREDATE"�Ի���"
            --�޿�
            ,SAL"�޿�"
    FROM TBL_SAWON
)T;
--==>>
/*
1001	��μ�	    9707251234567	����	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	������	    9505152234567	����	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	������	    9905192234567	����	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	�̿���	    9508162234567	����	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	���̻�	    9805161234567	����	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	������	    8005132234567	����	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	������	    0204053234567	����	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1010	���켱	    0303044234567	����	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	������	    0506073234567	����	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1013	����	    6712121234567	����	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	ȫ����	    0005044234567	����	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	�Ӽҹ�	    9711232234567	����	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1009	������	6912232234567	����	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1012	���ù�	    0208073234567	����	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1008	������	    6803171234567	����	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1016	���̰�	    0603194234567	����	17	2015-01-02	2065-01-02	2609	15653	1500	 750
*/
