SELECT USER
FROM DUAL;
--==>>SYS

SELECT '���ڿ�'
FROM DUAL;
--==>>���ڿ�

SELECT 550 + 230
FROM DUAL;
--==>>780

SELECT '������' + 'ȫ����'
FORM DUAL;
--==>> ���� �߻�
/*
ORA-00923: FROM keyword not found where expected
00923. 00000 -  "FROM keyword not found where expected"
���ڰ� �ƴϸ� ��+���� ��ȿ���� �ʴ�.
*/





-- �� ���� ����Ŭ ������ �����ϴ� ����� ���� ���� ��ȸ

SELECT USERNAME, ACCOUNT_STATUS -- �� �׸���� ��ȸ�Ѵ�.
FROM DBA_USERS; -- TABLESPACE���� ���̺� ������
--   --------- ������ ���ϸ� ���̺��� �ƴ� �Ʒ� ����.
--==>>
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
HR	                OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
*/

SELECT * -- DBA_USERS�� ���� Į��(�׸�)���� ��� ��ȸ�Ѵ�.
FROM DBA_USERS;
--==>>
/*
SYS	0		OPEN		2022-08-14	SYSTEM	TEMP	2014-05-29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
SYSTEM	5		OPEN		2022-08-14	SYSTEM	TEMP	2014-05-29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
ANONYMOUS	35		OPEN		2014-11-25	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP			N	PASSWORD
HR	43		OPEN		2022-08-15	USERS	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_PUBLIC_USER	45		LOCKED	2014-05-29	2014-11-25	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
FLOWS_FILES	44		LOCKED	2014-05-29	2014-11-25	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_040000	47		LOCKED	2014-05-29	2014-11-25	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
OUTLN	9		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DIP	14		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
ORACLE_OCM	21		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XS$NULL	2147483638		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
MDSYS	42		EXPIRED & LOCKED	2014-05-29	2022-02-15	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
CTXSYS	32		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DBSNMP	29		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XDB	34		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APPQOSSYS	30		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
*/

SELECT USERNAME
FROM DBA_USERS;
--==>>
/*
SYS
SYSTEM
ANONYMOUS
HR
APEX_PUBLIC_USER
FLOWS_FILES
APEX_040000
OUTLN
DIP
ORACLE_OCM
XS$NULL
MDSYS
CTXSYS
DBSNMP
XDB
APPQOSSYS
*/

SELECT USERNAME, CREATED
FROM DBA_USERS;
--==>>
/*
SYS	2014-05-29
SYSTEM	2014-05-29
ANONYMOUS	2014-05-29
HR	2014-05-29
APEX_PUBLIC_USER	2014-05-29
FLOWS_FILES	2014-05-29
APEX_040000	2014-05-29
OUTLN	2014-05-29
DIP	2014-05-29
ORACLE_OCM	2014-05-29
XS$NULL	2014-05-29
MDSYS	2014-05-29
CTXSYS	2014-05-29
DBSNMP	2014-05-29
XDB	2014-05-29
APPQOSSYS	2014-05-29
*/


--> ��DBA_���� �����ϴ� Oracle Data Dictionary View��� �Ѵ�.
--   ������ ������ ����(sysdba)���� �������� ��쿡�� ��ȸ�� �����ϴ�.
--   ���� ������ ��ųʸ� ������ ���� ���ص� �������.



--�� ��HR�� ����� ������ ��� ���·� ����
ALTER USER HR ACCOUNT LOCK; -- �ٲٴ� ���� HR ACCOUT�� LOCK.
--==>>User HR��(��) ����Ǿ����ϴ�.



-- �� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
-- :
-- HR	LOCKED
-- :


-- �� ��HR�� ����� ������ ��� ���� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>>User HR��(��) ����Ǿ����ϴ�.

-- �� �ٽ� ����� ���� ���� ��ȸ

SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>HR	OPEN

------------------------------------------------------------------------

--�� TABLESPACE ����

-- �� TABLESPACE ��?
-->   ���׸�Ʈ(���̺�, �ε���,...) �� ��Ƶδ�(�����صδ�)
--    ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.

CREATE TABLESPACE TBS_EDUA -- �����ϰڴ�. ���̺����̽���...TBS_EDUA �̸�����..
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF' -- ������ ������ ���� ��� �� �̸� ����(�ɼ�1)
SIZE 4M                             -- ������(������������ �뷮)(�ɼ�2)
EXTENT MANAGEMENT LOCAL             -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� �����Ѵ�.(�ɼ�3)
SEGMENT SPACE MANAGEMENT AUTO;      -- ���׸�Ʈ ���� ������ ����Ŭ ������ �ڵ����� �������� �� �ִ� �ɼ� ����.(�ɼ�4)
--==>>TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.

-- �� ���̺����̽� ���� ������ �����ϱ� ����
--    �ش� ����� �������� ���͸� ������ �ʿ��ϴ�.
--    (C:\TESTDATA)



-- �� ������ ���̺����̽� ��ȸ
SELECT *
FROM DBA_TABLESPACES; -- ������ ��ųʸ�! DBA_ �� ����!
--==>>
/*
SYSTEM	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/
-- admn part.............


-- �� ���� �뷮 ���� ��ȸ(�������� ���� �̸� ��ȸ)
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
                        :
C:\TESTDATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
                        :
*/
-------------------------������� ���̺��� ������ �� �ִ� ���� ����! 

-- �� ����Ŭ ����� ���� ����
CREATE USER heh IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--==>>User HEH��(��) �����Ǿ����ϴ�.
--> heh ��� ����� ������ �����ϰڴ�. (����ڴ�.)
--  �� ����� ������ �н������ java006$ �� �ϰڴ�.
--  �� ������ ���� �����ϴ� ����Ŭ ���׸�Ʈ��
--  �⺻������ TBS_EDUA ��� ���̺����̽��� ������ �� �ֵ��� �����ϰڴ�.

--------------------------- final ������Ʈ���� �ʿ��� ���� ��Ʈ!

-- �� ������ ����Ŭ ����� ����(���� ���� �̸� �̴ϼ� ����)�� ���� ���� �õ�
--    �� ���� �Ұ�(����)
--    ��create session�� ������ ���� ������ ���� �Ұ�.

-- �� ������ ����Ŭ ����� ����(���� ���� �̸� �̴ϼ� ����)��
--    ����Ŭ ���� ������ �����ϵ��� CREATE SESSION ���� �ο�

--���� ���� ��, �� CREATE SESSION
GRANT CREATE SESSION TO HEH; -- �ο��ϰڴ� ���Ѹ� TO ��������
--==>>Grant��(��) �����߽��ϴ�.

--�� ���� ������ ����Ŭ ����� ������ �ý��� ���� ���� ��ȸ
SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
            :
HEH   CREATE SESSION  NO
            :
*/

-- �� ���� ������ ����Ŭ ����� ������
--    ���̺� ������ �����ϵ��� CREATE TABLE ���� �ο�

-- �� CREATE TABLE
GRANT CREATE TABLE TO HEH;
--==>>Grant��(��) �����߽��ϴ�.


-- �� QUOTA
--�� ���� ������ ����Ŭ ����� ������
--   ���̺� �����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮) ����.
ALTER USER HEH
QUOTA UNLIMITED ON TBS_EDUA; -- �Ҵ緮 ���Ѿ���(1M,2M..) TBS_EDUA��
--==>>User HEH��(��) ����Ǿ����ϴ�.

--------------------------------------------------------------------------

CREATE USER scott
IDENTIFIED BY tiger;
--==>>User SCOTT��(��) �����Ǿ����ϴ�.

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO SCOTT;
--    ����Ʈ,  ���ҽ� Ȱ��, �Ҵ緮 ����
--==>>Grant��(��) �����߽��ϴ�.


ALTER USER SCOTT DEFAULT TABLESPACE USERS;
-- ���� ���� scott users��� ���̺����̽� �����Ұ�
--==>>User SCOTT��(��) ����Ǿ����ϴ�.

ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
-- ���� ���� ���� scott ,�ӽ� ���̺����̽��� temp�� ����
--==>>User SCOTT��(��) ����Ǿ����ϴ�.









