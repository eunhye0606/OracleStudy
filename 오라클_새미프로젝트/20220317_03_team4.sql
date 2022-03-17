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

