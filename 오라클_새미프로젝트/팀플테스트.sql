SET SERVEROUTPUT ON;
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
--------------------------------------------------------------------------------
--*1 로그인 프로시저 PRC_LOGIN(ID,PW)
-- 관리자 로그인 테스트
SELECT *
FROM MANAGER_REGISTER;
/*
M0001	1234567	2022-03-20
M0002	8910	2022-03-20
*/
EXEC PRC_LOGIN('M0001','1234567');
--로그인 성공~!!!

--ID 잘못입력
EXEC PRC_LOGIN('M0003','1234567');
--ORA-20100: 해당 아이디가 존재하지 않습니다.
--PW 잘못입력
EXEC PRC_LOGIN('M0001','999');
--ORA-20103: 아이디, 비밀번호가 일치하지 않습니다.
--------------------------------------------------------------------------------
--*4 관리자계정 PW변경 프로시저 PRC_MA_PW_CHANGE(ID,PW,NEWPW)
EXEC PRC_MA_PW_CHANGE('M0001','1234567','999');
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
--테이블 조회
SELECT *
FROM MANAGER_REGISTER;
-->>M0001	999	2022-03-20

--관리자 ID 잘못기입           사용자에러 없음 ㄱㅊ??
EXEC PRC_MA_PW_CHANGE('M0003','1234567','999');
--==>>ORA-01403: no data found 
--관리자 PW 잘못기입
EXEC PRC_MA_PW_CHANGE('M0001','1010101','999');
--==>>ORA-20103: 아이디, 비밀번호가 일치하지 않습니다.
--------------------------------------------------------------------------------
--*10 관리자의 교수자 정보 변경 프로시저 TEACHER_REGISTER_UPDATE(ID,PW,이름,주민번호,수정일자)
-- 교수테이블 조회
SELECT *
FROM TEACHER_REGISTER;
/*
T0001	1234	김교수	9909091234567	2022-03-20
T0002	2345678	박교수	6501012345678	2022-03-20
*/
-- 비밀번호 변경
EXEC TEACHER_REGISTER_UPDATE('T0001','0104139','김교수','9909091234567',SYSDATE);
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
--테이블 조회
SELECT *
FROM TEACHER_REGISTER;
--T0001	0104139	김교수	9909091234567	2022-03-20


-- 주민번호 변경
EXEC TEACHER_REGISTER_UPDATE('T0001','0104139','김교수','7709091234567',SYSDATE);
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
--테이블 조회
SELECT *
FROM TEACHER_REGISTER;
--T0001	0104139	김교수	7709091234567	2022-03-20


-- 이름변경
EXEC TEACHER_REGISTER_UPDATE('T0001','0104139','남주혁','7709091234567',SYSDATE);
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
--테이블 조회
SELECT *
FROM TEACHER_REGISTER;
--T0001	0104139	남주혁	7709091234567	2022-03-20

--교수코드 잘못기입
EXEC TEACHER_REGISTER_UPDATE('T0003','1234','김교수','9909091234567',SYSDATE);
--==>>ORA-20202: 유효한 교수가 아닙니다.
--------------------------------------------------------------------------------
--*27 학생 등록 삭제 PRC_STD_DELETE(학생ID)
--테이블 조회
SELECT *
FROM STUDENT_REGISTER;
/*
S0001	1234	김공일	9203271234567	2022-03-20
S0002	1234	김공이	9505012234567	2022-03-20
S0003	1234	김공삼	9705031234567	2022-03-20
S0004	1234	김공사	9908012234567	2022-03-20
S0005	1234	김공오	9102031234567	2022-03-20
S0006	1234	김공육	9808182234567	2022-03-20
S0007	1234	김공칠	9909091234567	2022-03-20
S0008	1234	김공팔	9403042234567	2022-03-20
S0009	1234	김공구	9202011234567	2022-03-20
S0010	1234	김공십	9712242234567	2022-03-20
*/
EXEC PRC_STD_DELETE('S0001');
--ORA-20206: 해당 학생이 참조되고 있으므로 삭제가 불가능합니다.
EXEC PRC_STD_DELETE('S1010');
--ORA-20505: 학생이 존재하지 않습니다.
--------------------------------------------------------------------------------
--*18 과정개설 정보 변경 프로시저 
--PRC_OP_COU_UPDATE(과정개설코드,과정코드,교수ID,강의실코드,시작일자,종료일자,개설일자)

--과정개설테이블
SELECT *
FROM COURSE_OPEN;
/*
C1	1		101	2021-07-01	2021-12-31	2022-03-20
C2	1		201	2021-09-01	2022-03-01	2022-03-20
C3	1		301	2022-01-01	2022-06-30	2022-03-20
*/
--과정테이블
SELECT *
FROM COURSE;
--1	자바만함

--강의실테이블
SELECT *
FROM CLASSROOM_REGISTER;
/*
101	101호	10
201	201호	20
301	301호	30
*/
EXEC PRC_OP_COU_UPDATE('C1',1,'T0001',101,'2021-10-10','2022-12-31',SYSDATE);
--------------------------------------------------------------------------------
--*28 과정개설 삭제 프로시저 PRC_OP_COU_DELETE(과정개설코드)
EXEC PRC_OP_COU_DELETE('C1');
--ORA-20206: 해당 과정은 참조되고 있으므로 삭제가 불가능합니다.

--없는 과정 코드 기입
EXEC PRC_OP_COU_DELETE('C100');
--ORA-20201: 유효한 과정이 아닙니다.
--------------------------------------------------------------------------------
--*29 과목개설 삭제 프로시저 PRC_OP_SUB_DELETE(과목개설코드)
EXEC PRC_OP_SUB_DELETE('OSC1');
--ORA-20308: 해당 과목은 참조되고 있으므로 삭제가 불가능합니다.

--과목개설 없는 코드 기입
EXEC PRC_OP_SUB_DELETE('OSC999');
--ORA-20300: 유효한 과목이 아닙니다.
--------------------------------------------------------------------------------
--*19 과정 변경 프로시저 PRC_COURSE_UPDATE(과정코드,과정명)
EXEC PRC_COURSE_UPDATE(1,'초급자바');
SELECT *
FROM COURSE;
--1	초급자바

--과정코드 없는거 기입
EXEC PRC_COURSE_UPDATE(99,'초급자바');
--ORA-20201: 유효한 과정이 아닙니다.
--------------------------------------------------------------------------------
--*24 과정 삭제 프로시저 PRC_COURSE_DELETE(과정코드)
EXEC PRC_COURSE_DELETE(1);
--ORA-20206: 해당 과정은 참조되고 있으므로 삭제가 불가능합니다.
--없는 과정 코드 입력
EXEC PRC_COURSE_DELETE(99);
--ORA-20201: 유효한 과정이 아닙니다.
--------------------------------------------------------------------------------
--*22 과목 변경 프로시저 PRC_SUB_MANEDIT(과목코드,과목명)
SELECT *
FROM SUBJECT;
/*
1	자바초급
2	자바중급
3	자바고급
*/

EXEC PRC_SUB_MANEDIT(1,'오라클초보'); 
SELECT *
FROM SUBJECT;
--1	오라클초보

--없는 코드 입력
EXEC PRC_SUB_MANEDIT(99,'오라클초보'); 
--ORA-20300: 유효한 과목이 아닙니다.
--------------------------------------------------------------------------------

--*25 과목 삭제 프로시저 PRC_SUBJECT_DELETE(과목코드)
EXEC PRC_SUBJECT_DELETE(1);
--ORA-20308: 해당 과목은 참조되고 있으므로 삭제가 불가능합니다.

--없는 코드 기입
EXEC PRC_SUBJECT_DELETE(99);
--ORA-20300: 유효한 과목이 아닙니다.


--------------------------------------------------------------------------------
--*21 교재 변경 프로시저 PRC_TEXTBOOK_UPDATE(교재코드,교재명,출판사)
SELECT *
FROM TEXTBOOK;
/*
1	자바첫걸음	
2	자바뛴다	
3	자바난다요	
*/
EXEC PRC_TEXTBOOK_UPDATE(1,'자바두걸음','쌍용강북');

SELECT *
FROM TEXTBOOK;
/*
1	자바두걸음	쌍용강북
2	자바뛴다	
3	자바난다요	
*/

--없는 코드 기입
EXEC PRC_TEXTBOOK_UPDATE(99,'자바두걸음','쌍용강북');
--ORA-20307: 유효한 교재가 아닙니다.

--------------------------------------------------------------------------------
--*23 강의실 삭제 프로시저 PRC_CLASSROOM_DLETE(강의실코드)
EXEC PRC_CLASSROOM_DLETE(101);
--ORA-20205: 해당 강의실은 참조되고 있으므로 삭제가 불가능합니다.

--없는 코드 기입
EXEC PRC_CLASSROOM_DLETE(999);
--ORA-20203: 유효한 강의실이 아닙니다.
--------------------------------------------------------------------------------
--과정테이블 데이터 추가
INSERT INTO COURSE VALUES(2,'생명과학과정');
SELECT *
FROM COURSE;
/*
2	생명과학과정
1	초급자바
*/
--강의실테이블 데이터 추가
INSERT INTO CLASSROOM_REGISTER VALUES(401,'401호',40);
SELECT *
FROM CLASSROOM_REGISTER;
/*
101	101호	10
201	201호	20
301	301호	30
401	401호	40
*/


--*30 과목개설 프로시저 PRC_OP_SUB_INSERT(과정개설코드 , 과목코드, 시작날짜, 종료날짜, 교재코드, 교수코드)
--[ 최종파일에 *30 하고 뒤에 정보 없음]
EXEC PRC_OP_SUB_INSERT('C1' , 1, '2021-10-10', '2022-03-23', 1, 'T0001');
--ORA-20306: 과목기간이 중복됩니다. 다시 확인해주세요
EXEC PRC_OP_SUB_INSERT('C2' , 1, '2021-10-10', '2022-03-23', 1, 'T0001');
--ORA-20303: 담당 교수가 배정되지 않은 과목입니다.
EXEC PRC_OP_SUB_INSERT('C1' , 1, '2001-10-10', '2022-03-23', 1, 'T0001');
--ORA-20305: 과목기간이 과정기간에 포함되지 않습니다.
EXEC PRC_OP_SUB_INSERT('C1' , 1, '2001-10-10', '2022-03-23', 1, 'T0008');
--ORA-20304: 입력정보의 교수와 해당과정의 교수가 일치하지 않습니다.
--------------------------------------------------------------------------------
--과정개설 프로시저 PRC_OP_COU_INSERT(과정코드, 시작일자, 종료일자, 강의실코드)
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
*31 관리자가 과목정보를 출력하는 프로시저 PRC_SUB_OP_SELECT(과목코드)
*32 관리자의 학생 정보 추가 프로시저 PRC_STD_INSERT(학생이름, 주민번호)
[ 최종파일에 *32 하고 뒤에 정보 없음]
*34 관리자의 학생정보 수정 프로시저 PRC_STU_REG_MANEDIT(학생코드, 비밀번호, 학생이름, 주민번호, 가입일자)
[ 최종파일에 *34 하고 뒤에 정보 없음]
*37 중도탈락 학생 입력 프로시저 PRC_DR_STD_INSERT(학생코드, 수강신청코드, 드랍날짜, 드랍코드, 드랍이유)
CREATE OR REPLACE PROCEDURE PRC_DR_STD_INSERT
( V_STUDENT_CODE        IN  STUDENT_REGISTER.STUDENT_CODE%TYPE
, V_REG_COURSE_CODE     IN  COURSE_REGISTER.REG_COURSE_CODE%TYPE
, V_DROP_DATE           IN  STUDENT_DROP.DROP_DATE%TYPE
, V_DR_REASON_CODE      IN  DROP_REASON.DR_REASON_CODE%TYPE
, V_DETAIL              IN  DROP_REASON.DETAIL%TYPE
)
[ 최종파일에 *37 하고 뒤에 정보 없음]
*38 중도탈락 수정 프로시저 PRC_DR_RE_UPDATE(중도탈락사유코드, 중도상세사유)
*39 중도탈락데이터 수정 프로시저 PRC_DR_STD_UPDATE(중도탈락코드, 중도탈락일자)
*41 중도탈락 삭제 프로시저 PRC_DR_STD_DELETE(학생코드, 수강신청코드)
COURSE_REGISTER : 수강신청코드 맞나
*7 교수자 데이터 추가 프로시저 PRC_TC_INSERT(이름, 주민번호)
*31 교수자가 교수정보 수정 프로시저 TEACHER_REGISTER_TC_UPDATE(교수코드, 비밀번호, 새로운비밀번호, 이름, 주민번호)
[ 최종파일에 *31 하고 뒤에 정보 없음]
*5 교수자 비밀번호변경 프로시저 PRC_TC_PW_CHANGE(ID,PW,NEWPW)
*42 성적 입력 프로시저 PRC_IN_SCR_INSERT(매개변수 아래 코드보고 …)
( V_ATTENDANCE_SCORE     IN SCORE_INPUT.ATTENDANCE_SCORE%TYPE
, V_WRITING_SCORE        IN SCORE_INPUT.WRITING_SCORE%TYPE
, V_PERFORMANCE_SCORE    IN SCORE_INPUT.PERFORMANCE_SCORE%TYPE
, V_OP_SUBJECT_CODE      IN SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE
, V_STUDENT_CODE         IN STUDENT_REGISTER.STUDENT_CODE%TYPE
)
[ 최종파일에 *42 하고 뒤에 정보 없음]
*43 배점 정보 수정 프로시저 PRC_OP_SUB_UPDATE_RATE(여기도 매개변수 몰라)
CREATE OR REPLACE PROCEDURE PRC_OP_SUB_UPDATE_RATE
( V_OP_SUBJECT_CODE     IN SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE
, V_ATTENDANCE_RATE     IN SUBJECT_OPEN.ATTENDANCE_RATE%TYPE
, V_WRITING_RATE         IN SUBJECT_OPEN.WRITING_RATE%TYPE
, V_PERFORMANCE_RATE    IN SUBJECT_OPEN.PERFORMANCE_RATE%TYPE
)
[ 최종파일에 *43 하고 뒤에 정보 없음]
*44 과목과 전담강사 일치하는지 확인 후, 그 과목에 대한 전체 학생 성적 출력하는 프로시저
PRC_PRINT_SUBJECT_GRADE(과목개설코드, 교수코드)
[ 최종파일에 *44 하고 뒤에 정보 없음]
*45 과목에 대한 성적 출력을 위한 커서 호출 프로시저
PRC_GRADE_CURSOR(과목개설코드, 커서)
[ 최종파일에 *45 하고 뒤에 정보 없음]
*46 학생 성적 삭제 프로시저PRC_IN_SCR_DELETE(성적입력코드)
[ 최종파일에 *46 하고 뒤에 정보 없음]
*47 성적 수정 프로시저 PRC_IN_SCR_UPDATE(매개변수이름모름)
( V_ATTENDANCE_SCORE     IN SCORE_INPUT.ATTENDANCE_SCORE%TYPE
, V_WRITING_SCORE        IN SCORE_INPUT.WRITING_SCORE%TYPE
, V_PERFORMANCE_SCORE    IN SCORE_INPUT.PERFORMANCE_SCORE%TYPE
, V_OP_SUBJECT_CODE     IN SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE
, V_STUDENT_CODE     IN STUDENT_REGISTER.STUDENT_CODE%TYPE
)
[ 최종파일에 *47 하고 뒤에 정보 없음]
*48 입력하려는데, 값이 존재해서 수정해야하는 경우 쓰는 UPDATE 프로시저
PRC_IN_SCR_UPDATE2(매개변수 몰라)
CREATE OR REPLACE PROCEDURE PRC_IN_SCR_UPDATE2
( V_ATTENDANCE_SCORE     IN SCORE_INPUT.ATTENDANCE_SCORE%TYPE
, V_WRITING_SCORE        IN SCORE_INPUT.WRITING_SCORE%TYPE
, V_PERFORMANCE_SCORE    IN SCORE_INPUT.PERFORMANCE_SCORE%TYPE
, V_SCORE_CODE           IN SCORE_INPUT.SCORE_CODE%TYPE 
, V_REG_COURSE_CODE      IN COURSE_REGISTER.REG_COURSE_CODE%TYPE
)
[ 최종파일에 *48 하고 뒤에 정보 없음]
*6 학생 비밀번호변경 프로시저 PRC_STD_PW_CHANGE(ID,PW,NEWPW)
*35 학생의 학생정보 수정 프로시저 PRC_STU_REG_STUEDIT(학생코드, 비밀번호, 뉴비밀번호, 학생명, 주민번호)
[ 최종파일에 *35 하고 뒤에 정보 없음]
*49 학생이 수강 끝낸 과목 리스트 확인하는 프로시저
PRC_GET_SUBJECT_LIST(학생코드, 커서)
[ 최종파일에 *49 하고 뒤에 정보 없음]
*50 학생의 한 과목 성적을 얻어오는 프로시저
PRC_GET_STUDENT_GRADE(학생코드, 과목개설코드, 커서)
[ 최종파일에 *50 하고 뒤에 정보 없음]
*51 학생이 자신이 수강하는 모든 과목에 대한 성적 출력 프로시저
PRC_PRINT_STUDENT_GRADE(학생코드)
*/