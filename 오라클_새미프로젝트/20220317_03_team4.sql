SELECT USER
FROM DUAL;

--------------------------------------------------------------------------------
--○ 교수 로그인 기능 구현
-- 관리자가 여러명의 교수를 사전 등록할 수 있다.
-- 입력 정보 : 교수이름, 주민번호 뒷자리(기본패스워드), 이름, 주민번호
-- 아이디는 T+인덱스넘버 (자동부여)
-- 관리자는 프로시저를 호출해서 이름, 주민번호만 넘겨준다.
-- 교수 NULL값 허용은...

--○프로시저 명: PRC_TC_INSERT(이름, 주민번호)
--  프로시저 생성 후, 테스트 실행
EXEC PRC_TC_INSERT('자비스','7005051234567');
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_TC_INSERT('김아이언맨','8611191234567');
EXEC PRC_TC_INSERT('남주혁','8801031234567');

--○ 테이블 데이터 확인
SELECT *
FROM TEACHER_REGISTER;
--==>>
/*
T2	1234567	김아이언맨	8611191234567	2022-03-17
T1	1234567	자비스	    7005051234567	2022-03-17
*/
--------------------------------------------------------------------------------
/*
- 관리자는 모든 교수 정보 출력 기능 : 교수명, 과목명, 과목시간(시작, 끝)
, 교재명, 강의실, 강의 진행여부(강의 예정, 강의중, 강의종료)
*/
SELECT TC.NAME "교수명"
       ,SO.NAME"과목명"
       ,S0.START_DATE"시작일자"
       ,S0.END_DATE"종료일자"
       ,3"교재명"  -- 교재테이블이랑 조인으로
       ,4"강의실"  -- 강의실테이블이랑 조인으로 ..
       ,5"강의 진행여부" -- 시작일자 <= 종료일자>= , 강의중..
FROM TEACHER_REGISTER TC, SUBJECT_OPEN SO;
-- SUBJECT_OPEN
-- TEXTBOOK
-- CLASSROOM_REGISTER
-- 세 테이블에 대한 테스트 데이터 필요
--------------------------------------------------------------------------------
--○ 테스트 데이터 입력
--교재테이블 테스트 데이터
INSERT INTO TEXTBOOK(TEXTBOOK_CODE, TEXTBOOK_NAME, PUBLISHER)
VALUES(1,'초보모여라','쌍용강북');

INSERT INTO TEXTBOOK(TEXTBOOK_CODE, TEXTBOOK_NAME, PUBLISHER)
VALUES(2,'애플리케이션','쌍용강남');

INSERT INTO TEXTBOOK(TEXTBOOK_CODE, TEXTBOOK_NAME, PUBLISHER)
VALUES(3,'네트워크구현','쌍용강남');

SELECT *
FROM TEXTBOOK;
--==>>
/*
1	초보모여라	쌍용강북
2	애플리케이션	쌍용강남
3	네트워크구현	쌍용강남
*/

--강의실테이블 테스트 데이터
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
--과목테이블 테스트 데이터 입력
INSERT INTO SUBJECT VALUES(1,'초급자바');
INSERT INTO SUBJECT VALUES(2,'중급자바');
INSERT INTO SUBJECT VALUES(3,'고급자바');
INSERT INTO SUBJECT VALUES(4,'초급오라클');
INSERT INTO SUBJECT VALUES(5,'중급오라클');

SELECT *
FROM SUBJECT;
/*
1	초급자바
2	중급자바
3	고급자바
4	초급오라클
5	중급오라클
*/

-- 과정테이블 테스트 데이터 입력
INSERT INTO COURSE VALUES (1,'자바과정');
INSERT INTO COURSE VALUES (2,'오라클과정');

SELECT *
FROM COURSE;
--==>>
/*
1	자바과정
2	오라클과정
*/

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
--==>>Session이(가) 변경되었습니다.

--과정개설테이블 테스트 데이터 입력
INSERT INTO COURSE_OPEN
VALUES ('C1',1,'T1',1,TO_DATE('2021-12-30','YYYY-MM-DD')
        ,TO_DATE('2022-06-20','YYYY-MM-DD')
        ,SYSDATE);


SELECT *
FROM COURSE_OPEN;
--==>>C1	1	T1	1	2021-12-30	2022-06-20	2022-03-17

--과목개설테이블 테스트 데이터 입력
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
-------------------------교수정보수정---------------------------------
--① 교수의 이름 수정
UPDATE TEACHER_REGISTER
SET NAME = '남주혁'
WHERE TEACHER_CODE = 'T2';
--==>>1 행 이(가) 업데이트되었습니다.
--②
UPDATE TEACHER_REGISTER
SET PASSWORD = '201812801'
WHERE TEACHER_CODE = 'T2';
--==>>1 행 이(가) 업데이트되었습니다.
-------------------------교수정보삭제---------------------------------
--○ 과정개설테이블 조회
SELECT *
FROM COURSE_OPEN;
--==>>C1	1	T1	1	2021-12-30	2022-06-20	2022-03-17
SELECT *
FROM TEACHER_REGISTER;
--==>>
/*
T2	201812801	남주혁	8611191234567	2022-03-17
T1	1234567	    자비스	7005051234567	2022-03-17
*/

--○ 트리거 명 : TRG_TC_UPDATE
--   트리거 생성 후 , 자식테이블 (COURSE_OPEN)의 
--   TEACHER_CODE가 0으로 바뀌는지 확인
DELETE
FROM TEACHER_REGISTER
WHERE TEACHER_CODE = 'T1';
--오 그니까 '0' 이딴거 XX 왜냐하면 참조는 해야하니까!
-- 자식 테이블 코드 컬럼 = NULL 굴러가는지 확인
DELETE
FROM TEACHER_REGISTER
WHERE TEACHER_CODE = 'T2';
-- 성공.
--○ COURE_OPEN 테이블 조회
SELECT *
FROM COURSE_OPEN;
--==>>C1	1		1	2021-12-30	2022-06-20	2022-03-17

EXEC PRC_OP_COU_UPDATE('T2');
SELECT *
FROM COURSE_OPEN;
--==>>C1	1	T1	1	2021-12-30	2022-06-20	2022-03-17
--------------------------------------------------------------------------------
/*
- 관리자는 모든 교수 정보 출력 기능 : 교수명, 과목명, 과목시간(시작, 끝)
, 교재명, 강의실, 강의 진행여부(강의 예정, 강의중, 강의종료)
*/
SELECT TC.NAME "교수명"
       ,S.SUBJECT_NAME "과목명"     --과목테이블
       ,SO.START_DATE "과목시작시간" --과목개설테이블
       ,SO.END_DATE "과목종료시간" --과목개설테이블
       ,T.TEXTBOOK_NAME "교재명"       --교재테이블
       ,CR.CLASSROOM_NAME"강의실"       --강의실테이블
       ,CASE WHEN CO.START_DATE - SYSDATE < 0 AND CO.END_DATE -SYSDATE >= 0
             THEN '강의중'
             WHEN CO.START_DATE - SYSDATE >= 0
             THEN '강의예정'
             WHEN CO.END_DATE - SYSDATE < 0 
             THEN '강의종료'
             ELSE '알수없음.'
             END "강의진행여부" 
FROM TEACHER_REGISTER TC JOIN COURSE_OPEN CO
ON TC.TEACHER_CODE = CO.TEACHER_CODE JOIN CLASSROOM_REGISTER CR
ON CO.CLASSROOM_CODE = CR.CLASSROOM_CODE JOIN SUBJECT_OPEN SO
ON CO.OP_COURSE_CODE = SO.OP_COURSE_CODE JOIN SUBJECT S
ON SO.SUBJECT_CODE = S.SUBJECT_CODE JOIN TEXTBOOK T
ON SO.TEXTBOOK_CODE = T.TEXTBOOK_CODE;
--==>>자비스	초급자바	2022-01-05	2022-03-05	초보모여라	1501	강의중

--------------------------------------------------------------------------------
--강의실 테이블 조회
SELECT *
FROM CLASSROOM_REGISTER;
--==>>
/*
1	1501	30
2	2203	30
3	5603	50
4	7104	10
*/
-- 과정 조회
SELECT *
FROM COURSE;

INSERT INTO COURSE_OPEN(OP_COURSE_CODE,COURSE_CODE,CLASSROOM_CODE,START_DATE,END_DATE)
VALUES('CO1',1,1,TO_DATE('2021-02-02','YYYY-MM-DD'),TO_DATE('2022-05-05','YYYY-MM-DD'));
--○ 프로시저 명 : PRC_OP_COU_INSERT(과정명, 시작날짜, 종료날짜, 강의실)
--   관리자가 과정을 개설한다.
EXEC PRC_OP_COU_INSERT('자바과정','2021-12-31', '2022-06-20', '1501');
EXEC PRC_OP_COU_INSERT('오라클과정','2021-12-31', '2022-06-20', '7104');
EXEC PRC_OP_COU_INSERT('자바과정','2021-12-31', '2022-06-20', '5603');



SELECT *
FROM COURSE_OPEN;
--------------------------------------------------------------------------------
-- 출력하기
-- 과정명, 강의실, 과목명, 과목기간, 교재명, 교수자명 → 은혜진행중
-- 과정테이블, 강의실테이블,          과목테이블, 과목개설테이블, 교재테이블,교수테이블
-- COURSE       CLASSROOM_REGISTER    SUBJECT     SUBJECT_OPEN    TEXTBOOK  TEACHER_REGISTER
--                                                --------------

-- 개설된 과목들에 대한 정보 출력임.
-- (과목개설테이블 - 과목테이블) T1     → 과목명, 과목기간
--                                  JOIN 교재테이블   → 교재명
-- (과정개설테이블 - 과정테이블) T3 → 과정명, 강의실명
--                                      JOIN 교수테이블 → 교수명
SELECT T2.과정명, T2.강의실명, T1.과목명
       ,T1.과목시작날짜 || ' ~ ' || T1.과목종료날짜 "과목기간"
       ,T1.교재명, T2.교수자명
FROM
(
    SELECT SO.START_DATE "과목시작날짜"
           ,SO.END_DATE "과목종료날짜"
           ,S.SUBJECT_NAME "과목명"
           ,T.TEXTBOOK_NAME "교재명"
           ,SO.OP_COURSE_CODE "과정개설코드"
    FROM SUBJECT_OPEN SO JOIN SUBJECT S
    ON SO.SUBJECT_CODE = s.SUBJECT_CODE JOIN TEXTBOOK T
    ON SO.TEXTBOOK_CODE = T.TEXTBOOK_CODE
)T1 JOIN
(
    SELECT C.COURSE_NAME "과정명"
           ,CR.CLASSROOM_NAME "강의실명"
           ,CO.OP_COURSE_CODE "과정개설코드"
           ,TR.NAME "교수자명"
    FROM COURSE_OPEN CO JOIN COURSE C 
    ON CO.COURSE_CODE = C.COURSE_CODE JOIN CLASSROOM_REGISTER CR 
    ON CO.CLASSROOM_CODE = CR.CLASSROOM_CODE JOIN TEACHER_REGISTER TR
    ON CO.TEACHER_CODE = TR.TEACHER_CODE
)T2
ON T1.과정개설코드 = T2.과정개설코드;
--------------------------------------------------------------------------------
--○ TEACHER_REGISTER 테이블에서 ID 컬럼 삭제
--   이유 : TEACHER_CODE와 같은 기능 담당. 
ALTER TABLE TEACHER_REGISTER DROP COLUMN ID;
--==>>Table TEACHER_REGISTER이(가) 변경되었습니다.
ALTER TABLE MANAGER_REGISTER DROP COLUMN ID;
--==>>Table MANAGER_REGISTER이(가) 변경되었습니다.
ALTER TABLE STUDENT_REGISTER DROP COLUMN ID;
--==>>Table STUDENT_REGISTER이(가) 변경되었습니다.


-- ○ COURSE_OPEN에 OP_COU_TEA_CODE_NN의 NOT NULL 제거 완료
ALTER TABLE COURSE_OPEN 
DROP CONSTRAINT OP_COU_TEA_CODE_NN;
--==>>Table COURSE_OPEN이(가) 변경되었습니다.

-- ○ 코드테이블 컬럼 네임 변경. 
ALTER TABLE SCORE_INPUT RENAME COLUMN ATTENDANCE_CODE TO ATTENDANCE_SCORE;
--==>>Table SCORE_INPUT이(가) 변경되었습니다.
--------------------------------------------------------------------------------
--2022-03-18 작업시작

DROP PROCEDURE PRC_OP_COU_UPDATE;
--==>>Procedure PRC_OP_COU_UPDATE이(가) 삭제되었습니다.

DROP TRIGGER TRG_TC_UPDATE;
--==>>Trigger TRG_TC_UPDATE이(가) 삭제되었습니다.
--------------------------------------------------------------------------------
--○ 과정테이블 조회
SELECT *
FROM COURSE;
/*
1	자바과정
2	오라클과정
*/
--○ 강의실코드
SELECT *
FROM CLASSROOM_REGISTER;
--==>>
/*
1	1501	30
2	2203	30
3	5603	50
4	7104	10
*/
--○  PRC_OP_COU_INSERT 수정 후, 테스트
EXEC PRC_OP_COU_INSERT(1,'2021-04-05', '2022-12-24', 1);
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_OP_COU_INSERT(1,'2021-04-05', '2022-12-24', 1);
EXEC PRC_OP_COU_INSERT(1,'2021-04-05', '2022-12-24', 1);


SELECT *
FROM COURSE_OPEN;

DELETE
FROM COURSE_OPEN
WHERE TEACHER_CODE IS NULL;
--==>>ORA-02292: integrity constraint (TEAM4.OP_SUB_OP_COU_CODE_FK) violated - child record found

DELETE 
FROM SUBJECT_OPEN;
DELETE
FROM TEACHER_REGISTER;

--------------------------------------------------------------------------------
--○과목개설테이블 테스트 데이터 입력
INSERT INTO SUBJECT_OPEN 
VALUES('JAVA001',1,1,'C1'
        ,TO_DATE('2022-01-05','YYYY-MM-DD')
        ,TO_DATE('2022-03-05','YYYY-MM-DD')
        ,30
        ,40
        ,30
        ,SYSDATE);
        
--------------------------------------------------------------------------------
SELECT TO_NUMBER(SUBSTR('SO00001',3))
FROM DUAL;

SELECT TO_DATE('2001-01-20','YYYY-MM-DD') - TO_DATE('2010-12-31','YYYY-MM-DD')
FROM DUAL;
-- 뒤에날짜가 더 큼.
--------------------------------------------------------------------------------
--과정개설테이블
SELECT *
FROM COURSE_OPEN;

UPDATE COURSE_OPEN
SET TEACHER_CODE = 'T1'
WHERE TEACHER_CODE IS NULL;
/*
CO1	1	T1	1	2021-04-05	2022-12-24	2022-03-18
CO2	1	T1	1	2021-04-05	2022-12-24	2022-03-18
CO3	1	T1	1	2021-04-05	2022-12-24	2022-03-18
*/
--과목테이블
SELECT *
FROM SUBJECT;
/*
1	초급자바
2	중급자바
3	고급자바
4	초급오라클
5	중급오라클
*/
--교재테이블
SELECT *
FROM TEXTBOOK;
/*
1	초보모여라	    쌍용강북
2	애플리케이션	쌍용강남
3	네트워크구현	쌍용강남
*/
--교수테이블
--○프로시저 명: PRC_TC_INSERT(이름, 주민번호)
--  프로시저 생성 후, 테스트 실행
EXEC PRC_TC_INSERT('자비스','7005051234567');
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_TC_INSERT('김아이언맨','8611191234567');
EXEC PRC_TC_INSERT('남주혁','8801031234567');

SELECT *
FROM TEACHER_REGISTER;
/*
T1	1234567	자비스	    7005051234567	2022-03-18
T2	1234567	김아이언맨	8611191234567	2022-03-18
T3	1234567	남주혁	    8801031234567	2022-03-18
*/
-- ○프로시저명 : PRC_OP_SUB_INSERT
-- (개설과정코드, 과목코드, 시작날짜, 종료날짜, 교재코드, 교수코드)
-- 'CO1',1,'2021-04-05','2022-12-24',1,'T1'
-- 프로시저 생성 후, 테스트
EXEC PRC_OP_SUB_INSERT('CO1',1,'2021-04-05','2022-12-24',1,'T1');
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_OP_SUB_INSERT('CO6',1,'2021-04-05','2022-12-24',1,'T1');
--==>>ORA-01403: no data found (개설된 과정이 없음. 사용자에러 발생안함.)
EXEC PRC_OP_SUB_INSERT('CO4',1,'2021-12-31','2022-06-06',1,'T1');
EXEC PRC_OP_SUB_INSERT('CO4',1,'2021-12-31','2022-06-30',1,'T1');
EXEC PRC_OP_SUB_INSERT('CO4',1,'2021-12-31','2022-01-20',1,'T1');
EXEC PRC_OP_SUB_INSERT('CO4',1,'2022-01-25','2022-03-05',1,'T1');
EXEC PRC_OP_SUB_INSERT('CO4',1,'2022-02-25','2022-03-05',1,'T1');



UPDATE COURSE_OPEN
SET TEACHER_CODE = 'T1'
WHERE TEACHER_CODE IS NULL;

--○ SUBJECT_OPEN 테이블 조회
SELECT *
FROM COURSE_OPEN;

SELECT *
FROM SUBJECT_OPEN;

SELECT MAX(END_DATE)
FROM SUBJECT_OPEN
WHERE OP_COURSE_CODE = 'CO4';
--==>> 개설된게 없으면 NULL 출력












