SELECT USER
FROM DUAL;
--==>>HR


--■■■ UNIQUE(UK:U) ■■■--
--PK - NOT NULL = UK

-- 1. 테이블에서 지정한 컬럼의 데이터가 중복되지 않고 유일할 수 있도록 설정하는 제약조건.
--    PRIMARY KEY 와 유사한 제약조건이지만, NULL 을 허용한다는 차이점이 있다.
--    내부적으로 PRIMARY KEY 와 마찬가지로 UNIQUE INDEX 가 자동 생성된다.
--    하나의 테이블 내에서 UNIQUE 제약조건은 여러 번 설정하는 것이 가능하다.(ex. 주민번호, 휴대폰번호...)
--    즉, 하나의 테이블에 UNIQUE 제약조건을 여러 개 만드는 것은 가능하다는 것이다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] UNIQUE

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 UNIQUE(컬럼명,...)

--○ UK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST5
( COL1  NUMBER(5)   PRIMARY KEY
, COL2  VARCHAR2(30)  UNIQUE
);
--==>>Table TBL_TEST5이(가) 생성되었습니다.

--제약조건 조회
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
--==>>
/*
HR	SYS_C007019	TBL_TEST5	P	COL1		
HR	SYS_C007020	TBL_TEST5	U	COL2		
*/

-- 데이터 입력
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST'); --> 에러발생
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'ABCD'); --> 에러발생
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST5(COL1) VALUES(4); --> NULL은 값이 아니라 이거 가능
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(5, 'ABCD'); --> 에러발생

SELECT *
FROM TBL_TEST5;

COMMIT;
--==>>커밋 완료.

SELECT *
FROM TBL_TEST5;
--==>>
/*
1	TEST
2	ABCD
3	
4	
*/

--○ UK 지정 실습 (② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>>Table TBL_TEST6이(가) 생성되었습니다.


-- 제약조건 조회(확인)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
--==>>
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2		
*/

-- ○ UK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST7
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
);
--==>>Table TBL_TEST7이(가) 생성되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>> 조회 결과 없음

-- 제약조건 추가
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
-- +
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL2_UK UNIQUE(COL2);

--↓
ALTER TABLE TBL_TEST7
ADD ( CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
      ,CONSTRAINT TEST7_COL2_UK UNIQUE(COL2) );
--==>>Table TBL_TEST7이(가) 변경되었습니다.

-- 제약조건 추가 이후 다시 확인(조회)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>>
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/

--------------------------------------------------------------------------------

--■■■ CHECK(CK:C) ■■■--

-- 1. 컬럼에서 허용 가능한 데이터의 범위나 조건을 지정하기 위한 제약조건
--    컬럼에 입력되는 데이터를 검사하여 조건에 맞는 데이터만 입력될 수 있도록 한다.
--    또한, 컬럼에서 수정되는 데이터를 검사하여 조건에 맞는 데이터로 수정되는 것만
--    허용하는 기능을 수행하게 된다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
--    컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] CHECK(컬럼 조건)

-- ② 테이블 레벨의 형식
--   컬럼명 데이터타입,
--   컬럼명 데이터타입,
--   CONSTRAINT CONSTRAINT명 CHECK(컬럼 조건)

--○ CK 지정 실습 (① 컬럼 레벨의 형식)
--테이블 생성
CREATE TABLE TBL_TEST8
(COL1 NUMBER(5)     PRIMARY KEY
,COL2 VARCHAR2(30)
,COL3 NUMBER(3)     CHECK(COL3 BETWEEN 0 AND 100)
);
--==>>Table TBL_TEST8이(가) 생성되었습니다.
--NUMBER(3) : -999 ~ 999
--CHECK 는 『-999 ~ 999』 보다 범위 자세하게

--데이터 입력
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1,'소민',100);
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2,'현수',101); --> 에러 발생
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2,'태형',-1);  --> 에러 발생
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2,'이삭',80);

SELECT *
FROM TBL_TEST8;

COMMIT;

SELECT *
FROM TBL_TEST8;
--==>>
/*
1	소민	100
2	이삭	80
*/

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
--==>>
/*
HR	SYS_C007025	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	
HR	SYS_C007026	TBL_TEST8	P	COL1		
*/
--> CHECK CONDITION : CHECK 조건 확인!


--○ CK 지정 실습(② 테이블 레벨의 형식)
--테이블 생성
CREATE TABLE TBL_TEST9
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
,COL3 NUMBER(3)
,CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
,CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>>Table TBL_TEST9이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(1,'소민',100);
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'현수',101);   --> 에러 발생
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'태형',-1);   --> 에러 발생
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'이삭',80); 

--확인
SELECT *
FROM TBL_TEST9;
--==>>
/*
1	소민	100
2	이삭	80
*/

COMMIT;
--==>> 커밋 완료

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
--==>>
/*
HR	TEST9_COL3_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1		
*/

--○ CK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
--테이블 생성
CREATE TABLE TBL_TEST10
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
,COL3 NUMBER(3)
);
--==>>Table TBL_TEST10이(가) 생성되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> 조회 결과 없음

-- 제약조건 추가
ALTER TABLE TBL_TEST10
ADD (CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
     ,CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100) );
--==>>Table TBL_TEST10이(가) 변경되었습니다.

--제약 조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>>
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/

--○ 실습 문제
-- 다음과 같이 TBL_TESTMEMBER 테이블을 생성하여
-- SSN컬럼(주민번호 컬럼)에서
-- 데이터 입력 시 성별이 유효한 데이터만 입력될 수 있도록
-- 체크 제약조건을 추가할 수 있도록 한다.
-- (→ 주민번호 특정 자리에 입력 가능한 데이터를 1,2,3,4 만 가능하도록 처리)
-- 또한, SID 컬럼에는 PRIMARY KEY 제약조건을 설정할 수 있도록 한다.

-- 테이블 생성
CREATE TABLE TBL_TESTMEMBER
( SID NUMBER
,NAME VARCHAR2(30)
,SSN CHAR(14) --데이터 입력 형태 →'YYMMDD-NNNNNNN'
,TEL VARCHAR2(40)
);
--==>>Table TBL_TESTMEMBER이(가) 생성되었습니다.

ALTER TABLE TBL_TESTMEMBER
ADD (CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
     ,CONSTRAINT TESTMEMBER_SSN_CK CHECK(TO_NUMBER(SUBSTR(SSN,8,1)) BETWEEN 1 AND 4)
);
--==>>Table TBL_TESTMEMBER이(가) 변경되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';
--==>>
/*
HR	TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	TO_NUMBER(SUBSTR(SSN,8,1)) BETWEEN 1 AND 4	
*/

-- 데이터 입력으로 확인
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL) VALUES (1,'은혜','980606-2169217','01012345678');
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL) VALUES (2,'건태','980606-9169217','01012345678'); --> 에러 발생

-- 테스트용 데이터 삭제
DELETE
FROM TBL_TESTMEMBER
WHERE NAME = '은혜';
--==>>1 행 이(가) 삭제되었습니다.

-- 확인
SELECT *
FROM TBL_TESTMEMBER;
--==>> 조회 결과 없음

--------------------------
--데이터 입력 테스트
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (1,'이호석','961112-1234567','010-1111-1111');
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (2,'양윤정','970131-2234567','010-2222-2222');
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (3,'홍수민','000504-4234567','010-3333-3333');
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (4,'김상기','061004-3234567','010-4444-4444');

INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (5,'이호석','961112-5234567','010-1111-1111'); --> 에러 발생
INSERT INTO TBL_TESTMEMBER (SID,NAME,SSN,TEL)
VALUES (6,'양윤정','970131-6234567','010-2222-2222'); --> 에러 발생

SELECT *
FROM TBL_TESTMEMBER;
--==>>
/*
1	이호석	961112-1234567	010-1111-1111
2	양윤정	970131-2234567	010-2222-2222
3	홍수민	000504-4234567	010-3333-3333
4	김상기	061004-3234567	010-4444-4444
*/
COMMIT;
--==>> 커밋 완료.

--------------------------------------------------------------------------------

--■■■ FOREIGN KEY(FK:F:R) ■■■--

-- 1. 참조 키 또는 외래 키(FK)는 두 테이블의 데이터 간 연결을 설정하고
--    강제 적용시키는데 사용되는 열이다.
--    한 테이블의 기본 키 값이 있는 열을
--    다른 테이블에 추가하면 테이블 간 연결을 설정할 수 있다.
--    이 때, 두 번째 테이블에 추가되는 열이 외래키가 된다.

-- 2. 부모 테이블(참조받는 컬럼이 포함된 테이블)이 먼저 생성된 후
--    자식 테이블(참조하는 컬럼이 포함된 테이블)이 생성되어야 한다.
--    이 때, 자식 테이블에 FORIEIGN KEY 제약조건이 설정된다.

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
--    컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명]
--                       REFERENCES 참조테이블명(참조컬럼명)
--                       [ON DELETE CASCADE | ON DELETE SET NULL]  -- 추가 옵션

-- ② 테이블 레벨의 형식
--    컬럼명 데이터타입,
--    컬럼명 데이터타입,
--    CONSTRAINT CONSTRAINT명 FOREIGN KEY(컬럼명)
--               REFERENCES 참조테이블명(참조컬럼명)
--               [ON DELETE CASECADE | ON DELETE SET NULL]         -- 추가 옵션


-- ※ FOREIGN KEY 제약조건을 설정하는 실습을 진행하기 위해서는
--    부모 테이블의 생성 작업을 먼저 수행해야 한다.
--    그리고 이 때, 부모 테이블에는 반드시 PK 또는 UK 제약조건이
--    설정된 컬럼이 존재해야 한다.

-- UK는 왜 끼냐? 고유한 값을 참조해야지 안그러면 무결성 깨짐.

--  [ON DELETE CASECADE | ON DELETE SET NULL] 
--  -------------------   -------------------
--                둘 다 같은 기능
--  부모테이블의 레코드를 삭제하면
--  자식테이블의 레코드도 삭제되는 위험한 옵션


-- 부모 테이블 생성
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>>Table TBL_JOBS이(가) 생성되었습니다.(PK 가짐.)

-- 부모 테이블에 데이터 입력
INSERT INTO TBL_JOBS(JIKWI_ID,JIKWI_NAME) VALUES(1,'사원');
INSERT INTO TBL_JOBS(JIKWI_ID,JIKWI_NAME) VALUES(2,'대리');
INSERT INTO TBL_JOBS(JIKWI_ID,JIKWI_NAME) VALUES(3,'과장');
INSERT INTO TBL_JOBS(JIKWI_ID,JIKWI_NAME) VALUES(4,'부장');
--==>>1 행 이(가) 삽입되었습니다.*4

--확인
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
4	부장
*/

--커밋
COMMIT;

--○ FK 지정 실습(① 컬럼 레벨의 형식)
--테이블 생성 (FK을 건다 X 어떤테이블의 어떤컬럼을 참조하는지가 더 중요)
CREATE TABLE TBL_EMP1
(SID        NUMBER          PRIMARY KEY
,NAME       VARCHAR2(30)
,JIKWI_ID   NUMBER          REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>>Table TBL_EMP1이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007034	TBL_EMP1	P	SID		
HR	SYS_C007035	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/
-- DELETE_RULE = NO ACTION = 옵션건거 없다.

-- 데이터 입력
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(1,'이지연',1);
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(2,'신시은',2);
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(3,'이아린',3);
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(4,'정은정',4);

INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(5,'서민지',5); --> 에러 발생
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(5,'서민지',1);
INSERT INTO TBL_EMP1(SID,NAME,JIKWI_ID) VALUES(6,'오이삭',NULL);
-- 부모테이블 참조하든지 비워둬라 ~!!
INSERT INTO TBL_EMP1(SID,NAME) VALUES(7,'박현지');

-- 확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	이지연	1
2	신시은	2
3	이아린	3
4	정은정	4
5	서민지	1
6	오이삭	
7	박현지	
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

--○ FK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP2
(SID        NUMBER
,NAME       VARCHAR2(30)
,JIKWI_ID   NUMBER
,CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
,CONSTRAINT EMP2_JIKWI_FK FOREIGN KEY(JIKWI_ID)
                          REFERENCES TBL_JOBS(JIKWI_ID)
);                          
--==>>Table TBL_EMP2이(가) 생성되었습니다.

--제약조건 확인(조회)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	TBL_EMP2	P	SID		
HR	EMP2_JIKWI_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/

--○FK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
--테이블 생성
CREATE TABLE TBL_EMP3
(SID        NUMBER
,NAME       VARCHAR2(30)
,JIKWI_ID   NUMBER
);
--==>>Table TBL_EMP3이(가) 생성되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> 조회 결과 없음.

--제약조건 추가
ALTER TABLE TBL_EMP3
ADD (CONSTRAINT EMP3_ID_PK PRIMARY KEY(SID)
     ,CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                                  REFERENCES TBL_JOBS(JIKWI_ID)
);                                  
--==>>Table TBL_EMP3이(가) 변경되었습니다.

--제약조건 추가 후, 제약조건 재확인.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_ID_PK	        TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- 제약조건 제거
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==>>Table TBL_EMP3이(가) 변경되었습니다.

-- 제약조건 제거 후, 제약조건 재확인.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>HR	EMP3_ID_PK	TBL_EMP3	P	SID		

-- FK제약조건 재추가
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                                REFERENCES TBL_JOBS(JIKWI_ID);
--==>>Table TBL_EMP3이(가) 변경되었습니다.

-- 제약조건 추가 후, 제약조건 재확인.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_ID_PK	        TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- 4. FOREIGN KEY 생성 시, 주의사항
--    참조하고자 하는 부모 테이블을 먼저 생성해야 한다.
--    참조하고자 하는 컬럼이 PRIMARY KEY 또는 UNIQUE 제약조건이 설정되어 있어야 한다.
--    테이블 사이에 PRIMARY KEY 와 ROREIGN KEY 가 정의되어 있으면
--    PRIMARY KEY 제약조건이 설정된 컬럼의 데이터 삭제 시
--    FOREIGN KEY 컬럼에 그 값이 입력되어 있는 경우 삭제되지 않는다.
--    (즉, 자식 테이블에 참조하는 레코드가 존재할 경우
--    부모 테이블의 참조받는 레코드는 삭제할 수 없다는 것이다.)
--    단, FK 설정 과정에서 『ON DELETE CASCADE』 나 『ON DELETE SET NULL』옵션을
--    사용하여 설정한 경우에는 삭제가 가능하다.
--    또한, 부모 테이블을 제거하기 위해서는 자식 테이블을 먼저 제거해야 한다.

--부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
4	부장
*/

--자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	이지연	1
2	신시은	2
3	이아린	3
4	정은정	4
5	서민지	1
6	오이삭	
7	박현지	
*/

-- 정은정 부장의 직위를 사원으로 변경
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID =4;
--==>>1 행 이(가) 업데이트되었습니다.

--확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	이지연	1
2	신시은	2
3	이아린	3
4	정은정	1
5	서민지	1
6	오이삭	
7	박현지	
*/

--커밋
COMMIT;
--==>>커밋 완료


-- 부모 테이블(TBL_JOBS)의 부장 데이터를 참조하고 있는
-- 자식 테이블(TBL_EMP1)의 데이터가 존재하지 않는 상황.

-- 이와 같은 상황에서 부모 테이블(TBL_JOBS)의
-- 부장 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID =4;
--==>>1 행 이(가) 삭제되었습니다.

--확인
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
*/

-- 커밋
COMMIT;
--==>>커밋 완료

-- 부모 테이블(TBL_JOBS)의 사원 직위 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_NAME= '사원';
--==>> 에러 발생
--     ORA-02292: integrity constraint (HR.SYS_C007035) violated - child record found

-- 부모 테이블(TBL_JOBS)의 구조적 제거는 가능할까?
DROP TABLE TBL_JOBS;
--==>> 에러 발생
--     ORA-02449: unique/primary keys in table referenced by foreign keys

-- ※ 부모 테이블의 데이터를 자유롭게(?) 삭제하기 위해서는
--    자식 테이블의 FOREING KEY 제약조건 설정 시
--    『ON DELETE CASCADE』 나 『ON DELETE SET NULL』 옵션 지정이 필요하다.

-- TBL_EMP1 테이블(자식 테이블)에서 FK 제약조건을 제거한 후
-- CASCADE 옵션을 포함하여 다시 FK 제약조건을 설정한다.

-- 제약조건 확인.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007034	    TBL_EMP1	P	SID		
HR	SYS_C007035	    TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- 제약조건 제거
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007035;

-- 제약조건 제거 후, 제약조건 재확인.
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>HR	SYS_C007034	TBL_EMP1	P	SID		

-- 『ON DELETE CASECADE』 옵션이 포함된 내용으로 제약조건 다시 지정
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                                REFERENCES TBL_JOBS(JIKWI_ID)
                                ON DELETE CASCADE;
--Table TBL_EMP1이(가) 변경되었습니다.

-- 옵션 추가 후, 제약조건 재확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007034	        TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE ~ CHECK~!!
*/

--※ CASCADE 옵션을 지정한 후에는
--   참조받고 있는 부모 테이블의 데이터를
--   언제든지 자유롭게 삭제하는 것이 가능하다.
--   단,.... 부모 테이블의 데이터가 삭제될 경우...
--   이를 참조하는 자식 테이블의 데이터도
--   모~~~~~~~~~두 함께 삭제된다.       → 절대 주의할 것~!!!



-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	이지연	1
2	신시은	2
3	이아린	3
4	정은정	1
5	서민지	1
6	오이삭	
7	박현지	
*/

-- 부모 테이블(TBL_JOBS)에서 과장 직위 데이터 삭제
DELETE 
FROM TBL_JOBS
WHERE JIKWI_NAME = '과장'; 
--==>>1 행 이(가) 삭제되었습니다.

-- 자식 테이블 조회(확인) 
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	이지연	1
2	신시은	2
4	정은정	1
5	서민지	1
6	오이삭	
7	박현지	
*/
--> 이아린 과장 데이터가 삭제되었음을 확인~!!!

-- 부모 테이블 제거
DROP TABLE TBL_JOBS;
--==>> 에러 발생
--     ORA-02449: unique/primary keys in table referenced by foreign keys
--     EMP2, EMP3도 참조하고 있어서...옵션없이...
--     근데 아니네 CASCADE 하고 있는 EMP1만 남겨도
--     걍 자식 테이블 있어서 삭제안돼... 자식 먼저 없애야돼.....CHECK~!!



-- TBL_EMP1 테이블 이외의 자식 테이블 제거
DROP TABLE TBL_EMP2;
--==>>Table TBL_EMP2이(가) 삭제되었습니다.
DROP TABLE TBL_EMP3;
--==>>Table TBL_EMP3이(가) 삭제되었습니다.

-- 부모 테이블 다시 제거
DROP TABLE TBL_JOBS;
--==>> 에러 발생
--     ORA-02449: unique/primary keys in table referenced by foreign keys

-- 남은 자식 테이블 (TBL_EMP1) 제거
DROP TABLE TBL_EMP1;
--==>>Table TBL_EMP1이(가) 삭제되었습니다.


-- 진짜 최종! 부모 테이블 제거
DROP TABLE TBL_JOBS;
--==>>Table TBL_JOBS이(가) 삭제되었습니다.
--------------------------------------------------------------------------------
--■■■ NOT NULL(NN:CK:C) ■■■--
--------NOT NULL을 별도로 다룬다기 보다 CHECK안에서 NOT NULL로 보는게 많음....

-- 다른 제약조건과 차이점!1!!
-- 1. 다른 제약조건은 테이블 레벨을 많이 쓰지만,
--     NOT NULL은 컬럼 레벨 많이 씀.
-- 2. ADD 보다 MODIFY 쓰는 형태를 많이 씀.



-- 1. 테이블에서 지정한 컬럼의 데이터가
--    NULL 인 상태를 갖지 못하도록 하는 제약조건.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명]NOT NULL

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 CHECK(컬럼명 IS NOT NULL)

-- 3. 기존에 생성되어 있는 테이블에 NOT NULL 제약조건을 추가할 경우
--    ADD 보다 MODIFY 절이 더 많이 사용된다.
-- ALTER TABLE 테이블명
-- MODIFY 컬럼명 데이터타입 NOT NULL;

-- 4. 기존 생성되어 있는 테이블에 데이터가 이미 들어있지 않은 컬럼(→ NULL 인 상태의 컬럼)을
--    NOT NULL 제약조건을 갖게끔 수정하는 경우에는 에러 발생한다.(불가능하다.)
--    (이미 제약조건을 위반한 사례의 데이터가 있으면 제약조건 못검.
--     특히, NOT NULL에서 많이 발생!)


--○ NOT NULL 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST11
(COL1 NUMBER(5)     PRIMARY KEY
,COL2 VARCHAR2(30)  NOT NULL
);
--==>>Table TBL_TEST11이(가) 생성되었습니다.
-- NOT NULL 제약조건을 CHECK 제약조건 범주로 보긴하지만
-- CHECK 키워드 없어도 됨.

--데이터 입력
INSERT INTO TBL_TEST11(COL1,COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST11(COL1,COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST11(COL1,COL2) VALUES(3, NULL); --> 에러 발생
INSERT INTO TBL_TEST11(COL1) VALUES(3);  --> 에러 발생

-- 확인
SELECT *
FROM TBL_TEST11;
--==>>
/*
1	TEST
2	ABCD
*/

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST11';
--==>>
/*
HR	SYS_C007042	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007043	TBL_TEST11	P	COL1		
*/

-- ○ NOT NULL 지정 실습(② 테이블 레벨의 형식)
--테이블 생성
CREATE TABLE TBL_TEST12
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
,CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
,CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>>Table TBL_TEST12이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST12';
--==>>
/*
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/
-- 컬럼 레벨은 체크조건에 "COL2"
-- 테이블 레벨은 체크조건에 COL2
-- 차이점!!

--○ NOT NULL 지정 실습(③ 테이블 생성 이후 제약조건 추가)
--테이블 생성
CREATE TABLE TBL_TEST13
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
);
--==>>Table TBL_TEST13이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 조회결과 없음.

-- 제약조건 추가
ALTER TABLE TBL_TEST13
ADD (CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    ,CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL));
--==>>Table TBL_TEST13이(가) 변경되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>>
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/

--※ NOT NULL 제약조건만 TBL_TEST13 테이블의 COL2 에 추가하는 경우
--   다음과 같은 방법을 사용하는 것도 가능하다.
ALTER TABLE TBL_TEST13
MODIFY COL2 NOT NULL;
--==>>Table TBL_TEST13이(가) 변경되었습니다.

-- 컬럼 레벨에서 NOT NULL 제약조건을 지정한 테이블(TBL_TEST11)
DESC TBL_TEST11;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
-- 테이블 레벨에서 NOT NULL 제약조건을 지정한 테이블(TBL_TEST12)
DESC TBL_TEST12;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/

-- 즉, DESCRIBE 에서는 컬럼레벨에서 설정한 제약조건이 바로 보이고
-- 특히나 NOT NULL 같은거 DESC에서 바로 보게 설정하는 것이 좋고
-- DESC에 낫널 없다고 제약조건이 없는 것은 아님!


-- 테이블 생성 이후 ADD를 통해 NOT NULL 제약조건을 추가하였으며(테이블 레벨)
-- 여기에 더하여 MODIFY 절을 통해 NOT NULL 제약조건을 추가한 테이블 (TBL_TEST13)
DESC TBL_TEST13;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME IN ('TBL_TEST11','TBL_TEST12','TBL_TEST13');
--==>>
/*
HR	SYS_C007042	        TBL_TEST11	C	COL2	"COL2" IS NOT NULL	  → 컬럼레벨
HR	SYS_C007043	        TBL_TEST11	P	COL1		
HR	TEST12_COL2_    NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	 → 테이블레벨
HR	TEST12_COL1_    PK	TBL_TEST12	P	COL1		
HR	TEST13_COL1_    PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_    NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	→ 컬럼레벨
HR	SYS_C007048	        TBL_TEST13	C	COL2	"COL2" IS NOT NULL	→ 테이블레벨
*/


--------------------------------------------------------------------------------

--■■■ DEFAULT 표현식 ■■■--

-- 1. INSERT 와 UPDATE 문에서
--    특정 값이 아닌 기본 값을 입력하도록 처리할 수 있다.

-- 2. 형식 및 구조
--    컬럼명 데이터타입 DEFAULT 기본값

-- 3. INSERT 명령 시, 해당 컬럼에 입력될 값을 할당하지 않거나,
--    DEFAULT 키워드를 활용하여 기본으로 설정된 값을 입력하도록 할 수 있다.

-- 4. DEFAULT 키워드와 다른 제약(NOT NULL 등) 표기가 함께 사용되어야 하는 경우
--    DEFAULT 키워드를 먼저 표기(작성)할 것을 권장한다.

--○ DEFAULT 표현식 적용 실습
--테이블 생성        
CREATE TABLE TBL_BBS                            -- 게시판 테이블 생성
( SID       NUMBER          PRIMARY KEY         -- 게시물 번호 → 식별자 → 자동 증가
, NAME      VARCHAR2(20)                        -- 게시물 작성자
, CONTENTS  VARCHAR2(200)                       -- 게시물 내용
, WRITEDAY  DATE            DEFAULT SYSDATE     -- 게시물 작성일
, COUNTS    NUMBER          DEFAULT 0           -- 게시물 조회수
, COMMENTS  NUMBER          DEFAULT 0           -- 게시물 댓글 갯수
);
--==>>Table TBL_BBS이(가) 생성되었습니다.

-- ※ SID 를 자동 증가 값으로 운영하려면 시퀀스 객체가 필요하다.
--    자동으로 입력되는 컬럼은 사용자의 입력 항목에서 제외시킬 수 있다.

-- 시퀀스 생성
CREATE SEQUENCE SEQ_BBS
NOCACHE;
--==>>Sequence SEQ_BBS이(가) 생성되었습니다.

-- 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.


-- 게시물 작성
INSERT INTO TBL_BBS(SID,NAME,CONTENTS,WRITEDAY,COUNTS,COMMENTS)
VALUES(SEQ_BBS.NEXTVAL,'최문정','오라클 DEFAULT 표현식을 실습중입니다.'
        ,TO_DATE('2022-02-01 15:34:10','YYYY-MM-DD HH24:MI:SS'),0,0);
--==>>1 행 이(가) 삽입되었습니다.
-- 조회수랑 댓글이 NULL 이면 증가하는 코드가 있어도
-- NULL 과 숫자 연산은 NULL 반환이라 계속 NULL 임!
INSERT INTO TBL_BBS(SID,NAME,CONTENTS,WRITEDAY,COUNTS,COMMENTS)
VALUES(SEQ_BBS.NEXTVAL,'이호석','계속 실습중입니다.'
        ,SYSDATE,0,0);
--==>>1 행 이(가) 삽입되었습니다.        
INSERT INTO TBL_BBS(SID,NAME,CONTENTS,WRITEDAY,COUNTS,COMMENTS)
VALUES(SEQ_BBS.NEXTVAL,'이연주','열심히 실습중입니다.'
        ,DEFAULT,0,0);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_BBS(SID,NAME,CONTENTS,WRITEDAY,COUNTS,COMMENTS)
VALUES(SEQ_BBS.NEXTVAL,'김태형','열심히 실습중입니다.'
        ,DEFAULT,DEFAULT,DEFAULT);
--==>>1 행 이(가) 삽입되었습니다.    
INSERT INTO TBL_BBS(SID,NAME,CONTENTS)
VALUES(SEQ_BBS.NEXTVAL,'김태형','무진장 실습중입니다.');        
--==>>1 행 이(가) 삽입되었습니다.    
-- INSERT 할때, 컬럼 비워두면 NULL인데 DEFALUT값 정의되어있어서
-- 그 값으로 채움.

-- 확인
SELECT *
FROM TBL_BBS;
--==>
/*
1	최문정	오라클 DEFAULT 표현식을 실습중입니다.	2022-02-01 15:34:10	0	0
2	이호석	계속 실습중입니다.	                    2022-03-04 14:29:47	0	0
3	이연주	열심히 실습중입니다.	                2022-03-04 14:30:30	0	0
4	김태형	열심히 실습중입니다.	                2022-03-04 14:31:37	0	0
5	김태형	무진장 실습중입니다.	                2022-03-04 14:32:38	0	0
*/


-- ○ DEFAULT 표현식 확인(조회)
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

--○ 테이블 생성 이후 DEFAULT 표현식 추가 / 변경
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT 기본값;

-- ○ 기존의 DEFAULT 표현식 제거
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT NULL;

COMMIT;

