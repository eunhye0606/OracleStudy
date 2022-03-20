SET SERVEROUTPUT ON;
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--------------------------------------------------------------------------------
--*1 �α��� ���ν��� PRC_LOGIN(ID,PW)
-- ������ �α��� �׽�Ʈ
SELECT *
FROM MANAGER_REGISTER;
/*
M0001	1234567	2022-03-20
M0002	8910	2022-03-20
*/
EXEC PRC_LOGIN('M0001','1234567');
--�α��� ����~!!!

--ID �߸��Է�
EXEC PRC_LOGIN('M0003','1234567');
--ORA-20100: �ش� ���̵� �������� �ʽ��ϴ�.
--PW �߸��Է�
EXEC PRC_LOGIN('M0001','999');
--ORA-20103: ���̵�, ��й�ȣ�� ��ġ���� �ʽ��ϴ�.
--------------------------------------------------------------------------------
--*4 �����ڰ��� PW���� ���ν��� PRC_MA_PW_CHANGE(ID,PW,NEWPW)
EXEC PRC_MA_PW_CHANGE('M0001','1234567','999');
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--���̺� ��ȸ
SELECT *
FROM MANAGER_REGISTER;
-->>M0001	999	2022-03-20

--������ ID �߸�����           ����ڿ��� ���� ����??
EXEC PRC_MA_PW_CHANGE('M0003','1234567','999');
--==>>ORA-01403: no data found 
--������ PW �߸�����
EXEC PRC_MA_PW_CHANGE('M0001','1010101','999');
--==>>ORA-20103: ���̵�, ��й�ȣ�� ��ġ���� �ʽ��ϴ�.
--------------------------------------------------------------------------------
--*10 �������� ������ ���� ���� ���ν��� TEACHER_REGISTER_UPDATE(ID,PW,�̸�,�ֹι�ȣ,��������)
-- �������̺� ��ȸ
SELECT *
FROM TEACHER_REGISTER;
/*
T0001	1234	�豳��	9909091234567	2022-03-20
T0002	2345678	�ڱ���	6501012345678	2022-03-20
*/
-- ��й�ȣ ����
EXEC TEACHER_REGISTER_UPDATE('T0001','0104139','�豳��','9909091234567',SYSDATE);
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--���̺� ��ȸ
SELECT *
FROM TEACHER_REGISTER;
--T0001	0104139	�豳��	9909091234567	2022-03-20


-- �ֹι�ȣ ����
EXEC TEACHER_REGISTER_UPDATE('T0001','0104139','�豳��','7709091234567',SYSDATE);
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--���̺� ��ȸ
SELECT *
FROM TEACHER_REGISTER;
--T0001	0104139	�豳��	7709091234567	2022-03-20


-- �̸�����
EXEC TEACHER_REGISTER_UPDATE('T0001','0104139','������','7709091234567',SYSDATE);
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--���̺� ��ȸ
SELECT *
FROM TEACHER_REGISTER;
--T0001	0104139	������	7709091234567	2022-03-20

--�����ڵ� �߸�����
EXEC TEACHER_REGISTER_UPDATE('T0003','1234','�豳��','9909091234567',SYSDATE);
--==>>ORA-20202: ��ȿ�� ������ �ƴմϴ�.
--------------------------------------------------------------------------------
--*27 �л� ��� ���� PRC_STD_DELETE(�л�ID)
--���̺� ��ȸ
SELECT *
FROM STUDENT_REGISTER;
/*
S0001	1234	�����	9203271234567	2022-03-20
S0002	1234	�����	9505012234567	2022-03-20
S0003	1234	�����	9705031234567	2022-03-20
S0004	1234	�����	9908012234567	2022-03-20
S0005	1234	�����	9102031234567	2022-03-20
S0006	1234	�����	9808182234567	2022-03-20
S0007	1234	���ĥ	9909091234567	2022-03-20
S0008	1234	�����	9403042234567	2022-03-20
S0009	1234	�����	9202011234567	2022-03-20
S0010	1234	�����	9712242234567	2022-03-20
*/
EXEC PRC_STD_DELETE('S0001');
--ORA-20206: �ش� �л��� �����ǰ� �����Ƿ� ������ �Ұ����մϴ�.
EXEC PRC_STD_DELETE('S1010');
--ORA-20505: �л��� �������� �ʽ��ϴ�.
--------------------------------------------------------------------------------
--*18 �������� ���� ���� ���ν��� 
--PRC_OP_COU_UPDATE(���������ڵ�,�����ڵ�,����ID,���ǽ��ڵ�,��������,��������,��������)

--�����������̺�
SELECT *
FROM COURSE_OPEN;
/*
C1	1		101	2021-07-01	2021-12-31	2022-03-20
C2	1		201	2021-09-01	2022-03-01	2022-03-20
C3	1		301	2022-01-01	2022-06-30	2022-03-20
*/
--�������̺�
SELECT *
FROM COURSE;
--1	�ڹٸ���

--���ǽ����̺�
SELECT *
FROM CLASSROOM_REGISTER;
/*
101	101ȣ	10
201	201ȣ	20
301	301ȣ	30
*/
EXEC PRC_OP_COU_UPDATE('C1',1,'T0001',101,'2021-10-10','2022-12-31',SYSDATE);
--------------------------------------------------------------------------------
--*28 �������� ���� ���ν��� PRC_OP_COU_DELETE(���������ڵ�)
EXEC PRC_OP_COU_DELETE('C1');
--ORA-20206: �ش� ������ �����ǰ� �����Ƿ� ������ �Ұ����մϴ�.

--���� ���� �ڵ� ����
EXEC PRC_OP_COU_DELETE('C100');
--ORA-20201: ��ȿ�� ������ �ƴմϴ�.
--------------------------------------------------------------------------------
--*29 ���񰳼� ���� ���ν��� PRC_OP_SUB_DELETE(���񰳼��ڵ�)
EXEC PRC_OP_SUB_DELETE('OSC1');
--ORA-20308: �ش� ������ �����ǰ� �����Ƿ� ������ �Ұ����մϴ�.

--���񰳼� ���� �ڵ� ����
EXEC PRC_OP_SUB_DELETE('OSC999');
--ORA-20300: ��ȿ�� ������ �ƴմϴ�.
--------------------------------------------------------------------------------
--*19 ���� ���� ���ν��� PRC_COURSE_UPDATE(�����ڵ�,������)
EXEC PRC_COURSE_UPDATE(1,'�ʱ��ڹ�');
SELECT *
FROM COURSE;
--1	�ʱ��ڹ�

--�����ڵ� ���°� ����
EXEC PRC_COURSE_UPDATE(99,'�ʱ��ڹ�');
--ORA-20201: ��ȿ�� ������ �ƴմϴ�.
--------------------------------------------------------------------------------
--*24 ���� ���� ���ν��� PRC_COURSE_DELETE(�����ڵ�)
EXEC PRC_COURSE_DELETE(1);
--ORA-20206: �ش� ������ �����ǰ� �����Ƿ� ������ �Ұ����մϴ�.
--���� ���� �ڵ� �Է�
EXEC PRC_COURSE_DELETE(99);
--ORA-20201: ��ȿ�� ������ �ƴմϴ�.
--------------------------------------------------------------------------------
--*22 ���� ���� ���ν��� PRC_SUB_MANEDIT(�����ڵ�,�����)
SELECT *
FROM SUBJECT;
/*
1	�ڹ��ʱ�
2	�ڹ��߱�
3	�ڹٰ��
*/

EXEC PRC_SUB_MANEDIT(1,'����Ŭ�ʺ�'); 
SELECT *
FROM SUBJECT;
--1	����Ŭ�ʺ�

--���� �ڵ� �Է�
EXEC PRC_SUB_MANEDIT(99,'����Ŭ�ʺ�'); 
--ORA-20300: ��ȿ�� ������ �ƴմϴ�.
--------------------------------------------------------------------------------

--*25 ���� ���� ���ν��� PRC_SUBJECT_DELETE(�����ڵ�)
EXEC PRC_SUBJECT_DELETE(1);
--ORA-20308: �ش� ������ �����ǰ� �����Ƿ� ������ �Ұ����մϴ�.

--���� �ڵ� ����
EXEC PRC_SUBJECT_DELETE(99);
--ORA-20300: ��ȿ�� ������ �ƴմϴ�.


--------------------------------------------------------------------------------
--*21 ���� ���� ���ν��� PRC_TEXTBOOK_UPDATE(�����ڵ�,�����,���ǻ�)
SELECT *
FROM TEXTBOOK;
/*
1	�ڹ�ù����	
2	�ڹٶڴ�	
3	�ڹٳ��ٿ�	
*/
EXEC PRC_TEXTBOOK_UPDATE(1,'�ڹٵΰ���','�ֿ밭��');

SELECT *
FROM TEXTBOOK;
/*
1	�ڹٵΰ���	�ֿ밭��
2	�ڹٶڴ�	
3	�ڹٳ��ٿ�	
*/

--���� �ڵ� ����
EXEC PRC_TEXTBOOK_UPDATE(99,'�ڹٵΰ���','�ֿ밭��');
--ORA-20307: ��ȿ�� ���簡 �ƴմϴ�.

--------------------------------------------------------------------------------
--*23 ���ǽ� ���� ���ν��� PRC_CLASSROOM_DLETE(���ǽ��ڵ�)
EXEC PRC_CLASSROOM_DLETE(101);
--ORA-20205: �ش� ���ǽ��� �����ǰ� �����Ƿ� ������ �Ұ����մϴ�.

--���� �ڵ� ����
EXEC PRC_CLASSROOM_DLETE(999);
--ORA-20203: ��ȿ�� ���ǽ��� �ƴմϴ�.
--------------------------------------------------------------------------------
--�������̺� ������ �߰�
INSERT INTO COURSE VALUES(2,'������а���');
SELECT *
FROM COURSE;
/*
2	������а���
1	�ʱ��ڹ�
*/
--���ǽ����̺� ������ �߰�
INSERT INTO CLASSROOM_REGISTER VALUES(401,'401ȣ',40);
SELECT *
FROM CLASSROOM_REGISTER;
/*
101	101ȣ	10
201	201ȣ	20
301	301ȣ	30
401	401ȣ	40
*/


--*30 ���񰳼� ���ν��� PRC_OP_SUB_INSERT(���������ڵ� , �����ڵ�, ���۳�¥, ���ᳯ¥, �����ڵ�, �����ڵ�)
--[ �������Ͽ� *30 �ϰ� �ڿ� ���� ����]
EXEC PRC_OP_SUB_INSERT('C1' , 1, '2021-10-10', '2022-03-23', 1, 'T0001');
--ORA-20306: ����Ⱓ�� �ߺ��˴ϴ�. �ٽ� Ȯ�����ּ���
EXEC PRC_OP_SUB_INSERT('C2' , 1, '2021-10-10', '2022-03-23', 1, 'T0001');
--ORA-20303: ��� ������ �������� ���� �����Դϴ�.
EXEC PRC_OP_SUB_INSERT('C1' , 1, '2001-10-10', '2022-03-23', 1, 'T0001');
--ORA-20305: ����Ⱓ�� �����Ⱓ�� ���Ե��� �ʽ��ϴ�.
EXEC PRC_OP_SUB_INSERT('C1' , 1, '2001-10-10', '2022-03-23', 1, 'T0008');
--ORA-20304: �Է������� ������ �ش������ ������ ��ġ���� �ʽ��ϴ�.
--------------------------------------------------------------------------------
--�������� ���ν��� PRC_OP_COU_INSERT(�����ڵ�, ��������, ��������, ���ǽ��ڵ�)
EXEC PRC_OP_COU_INSERT(2, '2022-01-01', '2022-05-05', 401);

SELECT *
FROM COURSE_OPEN;
/*
C4	2		    401	2022-01-01	2022-05-05	2022-03-20
C1	1	T0001	101	2021-10-10	2022-12-31	2022-03-20
C2	1		    201	2021-09-01	2022-03-01	2022-03-20
C3	1		    301	2022-01-01	2022-06-30	2022-03-20
*/
--------------------------------------------------------------------------------

/*
*31 �����ڰ� ���������� ����ϴ� ���ν��� PRC_SUB_OP_SELECT(�����ڵ�)
*32 �������� �л� ���� �߰� ���ν��� PRC_STD_INSERT(�л��̸�, �ֹι�ȣ)
[ �������Ͽ� *32 �ϰ� �ڿ� ���� ����]
*34 �������� �л����� ���� ���ν��� PRC_STU_REG_MANEDIT(�л��ڵ�, ��й�ȣ, �л��̸�, �ֹι�ȣ, ��������)
[ �������Ͽ� *34 �ϰ� �ڿ� ���� ����]
*37 �ߵ�Ż�� �л� �Է� ���ν��� PRC_DR_STD_INSERT(�л��ڵ�, ������û�ڵ�, �����¥, ����ڵ�, �������)
CREATE OR REPLACE PROCEDURE PRC_DR_STD_INSERT
( V_STUDENT_CODE        IN  STUDENT_REGISTER.STUDENT_CODE%TYPE
, V_REG_COURSE_CODE     IN  COURSE_REGISTER.REG_COURSE_CODE%TYPE
, V_DROP_DATE           IN  STUDENT_DROP.DROP_DATE%TYPE
, V_DR_REASON_CODE      IN  DROP_REASON.DR_REASON_CODE%TYPE
, V_DETAIL              IN  DROP_REASON.DETAIL%TYPE
)
[ �������Ͽ� *37 �ϰ� �ڿ� ���� ����]
*38 �ߵ�Ż�� ���� ���ν��� PRC_DR_RE_UPDATE(�ߵ�Ż�������ڵ�, �ߵ��󼼻���)
*39 �ߵ�Ż�������� ���� ���ν��� PRC_DR_STD_UPDATE(�ߵ�Ż���ڵ�, �ߵ�Ż������)
*41 �ߵ�Ż�� ���� ���ν��� PRC_DR_STD_DELETE(�л��ڵ�, ������û�ڵ�)
COURSE_REGISTER : ������û�ڵ� �³�
*7 ������ ������ �߰� ���ν��� PRC_TC_INSERT(�̸�, �ֹι�ȣ)
*31 �����ڰ� �������� ���� ���ν��� TEACHER_REGISTER_TC_UPDATE(�����ڵ�, ��й�ȣ, ���ο��й�ȣ, �̸�, �ֹι�ȣ)
[ �������Ͽ� *31 �ϰ� �ڿ� ���� ����]
*5 ������ ��й�ȣ���� ���ν��� PRC_TC_PW_CHANGE(ID,PW,NEWPW)
*42 ���� �Է� ���ν��� PRC_IN_SCR_INSERT(�Ű����� �Ʒ� �ڵ庸�� ��)
( V_ATTENDANCE_SCORE     IN SCORE_INPUT.ATTENDANCE_SCORE%TYPE
, V_WRITING_SCORE        IN SCORE_INPUT.WRITING_SCORE%TYPE
, V_PERFORMANCE_SCORE    IN SCORE_INPUT.PERFORMANCE_SCORE%TYPE
, V_OP_SUBJECT_CODE      IN SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE
, V_STUDENT_CODE         IN STUDENT_REGISTER.STUDENT_CODE%TYPE
)
[ �������Ͽ� *42 �ϰ� �ڿ� ���� ����]
*43 ���� ���� ���� ���ν��� PRC_OP_SUB_UPDATE_RATE(���⵵ �Ű����� ����)
CREATE OR REPLACE PROCEDURE PRC_OP_SUB_UPDATE_RATE
( V_OP_SUBJECT_CODE     IN SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE
, V_ATTENDANCE_RATE     IN SUBJECT_OPEN.ATTENDANCE_RATE%TYPE
, V_WRITING_RATE         IN SUBJECT_OPEN.WRITING_RATE%TYPE
, V_PERFORMANCE_RATE    IN SUBJECT_OPEN.PERFORMANCE_RATE%TYPE
)
[ �������Ͽ� *43 �ϰ� �ڿ� ���� ����]
*44 ����� ���㰭�� ��ġ�ϴ��� Ȯ�� ��, �� ���� ���� ��ü �л� ���� ����ϴ� ���ν���
PRC_PRINT_SUBJECT_GRADE(���񰳼��ڵ�, �����ڵ�)
[ �������Ͽ� *44 �ϰ� �ڿ� ���� ����]
*45 ���� ���� ���� ����� ���� Ŀ�� ȣ�� ���ν���
PRC_GRADE_CURSOR(���񰳼��ڵ�, Ŀ��)
[ �������Ͽ� *45 �ϰ� �ڿ� ���� ����]
*46 �л� ���� ���� ���ν���PRC_IN_SCR_DELETE(�����Է��ڵ�)
[ �������Ͽ� *46 �ϰ� �ڿ� ���� ����]
*47 ���� ���� ���ν��� PRC_IN_SCR_UPDATE(�Ű������̸���)
( V_ATTENDANCE_SCORE     IN SCORE_INPUT.ATTENDANCE_SCORE%TYPE
, V_WRITING_SCORE        IN SCORE_INPUT.WRITING_SCORE%TYPE
, V_PERFORMANCE_SCORE    IN SCORE_INPUT.PERFORMANCE_SCORE%TYPE
, V_OP_SUBJECT_CODE     IN SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE
, V_STUDENT_CODE     IN STUDENT_REGISTER.STUDENT_CODE%TYPE
)
[ �������Ͽ� *47 �ϰ� �ڿ� ���� ����]
*48 �Է��Ϸ��µ�, ���� �����ؼ� �����ؾ��ϴ� ��� ���� UPDATE ���ν���
PRC_IN_SCR_UPDATE2(�Ű����� ����)
CREATE OR REPLACE PROCEDURE PRC_IN_SCR_UPDATE2
( V_ATTENDANCE_SCORE     IN SCORE_INPUT.ATTENDANCE_SCORE%TYPE
, V_WRITING_SCORE        IN SCORE_INPUT.WRITING_SCORE%TYPE
, V_PERFORMANCE_SCORE    IN SCORE_INPUT.PERFORMANCE_SCORE%TYPE
, V_SCORE_CODE           IN SCORE_INPUT.SCORE_CODE%TYPE 
, V_REG_COURSE_CODE      IN COURSE_REGISTER.REG_COURSE_CODE%TYPE
)
[ �������Ͽ� *48 �ϰ� �ڿ� ���� ����]
*6 �л� ��й�ȣ���� ���ν��� PRC_STD_PW_CHANGE(ID,PW,NEWPW)
*35 �л��� �л����� ���� ���ν��� PRC_STU_REG_STUEDIT(�л��ڵ�, ��й�ȣ, ����й�ȣ, �л���, �ֹι�ȣ)
[ �������Ͽ� *35 �ϰ� �ڿ� ���� ����]
*49 �л��� ���� ���� ���� ����Ʈ Ȯ���ϴ� ���ν���
PRC_GET_SUBJECT_LIST(�л��ڵ�, Ŀ��)
[ �������Ͽ� *49 �ϰ� �ڿ� ���� ����]
*50 �л��� �� ���� ������ ������ ���ν���
PRC_GET_STUDENT_GRADE(�л��ڵ�, ���񰳼��ڵ�, Ŀ��)
[ �������Ͽ� *50 �ϰ� �ڿ� ���� ����]
*51 �л��� �ڽ��� �����ϴ� ��� ���� ���� ���� ��� ���ν���
PRC_PRINT_STUDENT_GRADE(�л��ڵ�)
*/