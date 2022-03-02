SELECT USER
FROM DUAL;
--==>>SCOTT

--■■■ ROW_NUMBER ■■■--
--      행(가로) 번호

SELECT *
FROM EMP;

SELECT ENAME "사원명", SAL "급여", HIREDATE"입사일"
FROM EMP;

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
       ,ENAME "사원명", SAL "급여", HIREDATE"입사일"
FROM EMP;
--==>>
/*
 1	KING	5000	1981-11-17
 2	FORD	3000	1981-12-03
 3	SCOTT	3000	1987-07-13
 4	JONES	2975	1981-04-02
 5	BLAKE	2850	1981-05-01
 6	CLARK	2450	1981-06-09
 7	ALLEN	1600	1981-02-20
 8	TURNER	1500	1981-09-08
 9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	 950	1981-12-03
14	SMITH	 800	1980-12-17
*/

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
       ,ENAME "사원명", SAL "급여", HIREDATE"입사일"
FROM EMP
ORDER BY ENAME;
--==>>
/*
12	ADAMS	1100	1987-07-13
 7	ALLEN	1600	1981-02-20
 5	BLAKE	2850	1981-05-01
 6	CLARK	2450	1981-06-09
 2	FORD	3000	1981-12-03
13	JAMES	 950	1981-12-03
 4	JONES	2975	1981-04-02
 1	KING	5000	1981-11-17
11	MARTIN	1250	1981-09-28
 9	MILLER	1300	1982-01-23
 3	SCOTT	3000	1987-07-13
14	SMITH	 800	1980-12-17
 8	TURNER	1500	1981-09-08
10	WARD	1250	1981-02-22
*/
SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트"
       ,ENAME "사원명", SAL "급여", HIREDATE"입사일"
FROM EMP
ORDER BY ENAME;
--==>>
/*
 1	ADAMS	1100	1987-07-13 
 2	ALLEN	1600	1981-02-20
 3	BLAKE	2850	1981-05-01
 4 	CLARK	2450	1981-06-09
 5	FORD	3000	1981-12-03
 6	JAMES	 950	1981-12-03
 7 	JONES	2975	1981-04-02
 8	KING	5000	1981-11-17
 9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	 800	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트"    --행번호 붙힘.
       ,ENAME "사원명", SAL "급여", HIREDATE"입사일"
FROM EMP             -- 타겟팅하고
WHERE DEPTNO = 20    -- 대상들을 메모리에 올린 뒤
ORDER BY ENAME;
--==>>
/*
1	ADAMS	1100	1987-07-13
2	FORD	3000	1981-12-03
3	JONES	2975	1981-04-02
4	SCOTT	3000	1987-07-13
5	SMITH	 800	1980-12-17
*/



--※ 게시판의 게시물 번호를 SEQUENCE 나 IDENTITY 를 사용하게 되면
--   게시물을 삭제했을 경우, 삭제한 게시물의 자리에 다음 번호를 가진
--   게시물이 등록되는 상황이 발생하게 된다.
--   이는... 보안성 측면이나... 미관상... 바람직하지 않은 사오항일 수 있기 때문에
--   ROW_NUMBER() 의 사용을 고려해 볼 수 있다.
--   관리 목적으로 사용할 때에는  SEQUENCE 나 IDENTITY 를 사용하지만
--   단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 바람직하다.
--   (SEQUENCE: 오라클 
--    IDENTITY: MSSQL)

--★★★ 여기부터 정신 차리고 다시 !!!★★★--
--○ 기존 잘못 운용되던 시퀀스 삭제
--   중간에 데이터를 삭제해도 시퀀스는 삭제되지않아서 
--   롤백해도 시퀀스가 10번부터 시작 ^^
DROP SEQUENCE SEQ_BOARD;
--==>>Sequence SEQ_BOARD이(가) 삭제되었습니다.

--○ SEQUENCE(시퀀스 : 주문번호) 생성
--   → 사전적인 의미 : 1.(일련의) 연속적인 사건들, 2.(사건 행동 등의) 순서

CREATE SEQUENCE SEQ_BOARD       -- 기본적인 시퀀스 생성 구문
START WITH 1                    -- 시작값(DEFAULT)
INCREMENT BY 1                     -- 증가값(DEFAULT)
NOMAXVALUE                      -- 최대값(DEFAULT)
NOCACHE;                        -- 캐시사용여부
--==>>Sequence SEQ_BOARD이(가) 생성되었습니다.
--    테이블하고 관계 X
--    독립적인 것.
-- (NOCACHE : 번호표뽑을 때도 줄을 서겠지... 하나하나 가져가게 안하고...
--  번호표를 미리 50장 뽑아서 나눠줘 ....→ 그게 캐쉬
--  시퀀스가 튀는걸 방지하는게 노캐쉬...
--  클라이언트 - 서버, 내가 접속해서 처리해야하는 액션이 많으면
--  10개를 임의로 뽑으면 다른 사람은 왔을 때 시퀀스로 이용하는거 뿐인데
--  이전 글이 21번이여도 다른 사람은 31번으로 글을 씀..
--  캐쉬 장점: 대기열에 안걸린다.
--  캐쉬 단점: 중간관리자가 10장 뽑고 5장 나눠주다가 다른 업무하면
--             다음 손님은 기계에서 뽑을 때 11개...
--   NOCACHE : 번호표 미리 뽑기 활용 XX)


--★ 기존 잘못된 데이터가 입력된 테이블 제거(휴지통 거치지 않고 제거 : PURGE) ★--
--    (알아만 두고 쓰지는 말자...)
DROP TABLE TBL_BOARD PURGE;
--==>>Table TBL_BOARD이(가) 삭제되었습니다.

--※ 휴지통 비우기(알아만 두고 쓰지는 말자...)
PURGE RECYCLEBIN;
--==>>RECYCLEBIN이(가) 비워졌습니다.
-- DB에서 휴지통 거치지 않고 삭제하면
-- 복구하기가 어마어마하게 어렵다.

SELECT *
FROM TAB;
--==>>
/*
BIN$NaBzNiwHTDyHPyAqAA7RRw==$0	TABLE → 휴지통	
BIN$qiRn2zalQ1ixvKLEcCFBTQ==$0	TABLE → 휴지통	
BONUS	        TABLE	
DEPT	        TABLE	
EMP	            TABLE	
SALGRADE	    TABLE	
TBL_BOARD	    TABLE	
TBL_DEPT	    TABLE	
TBL_EMP	        TABLE	
TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
TBL_FILES	    TABLE	
TBL_SAWON	    TABLE	
TBL_WATCH	    TABLE	
VIEW_SAWON	    VIEW	
VIEW_SAWON2	    VIEW	
*/

--○ 실습 테이블 생성
CREATE TABLE TBL_BOARD               -- TBL_BOARD 테이블 생성 구문 → 게시판 테이블
( NO           NUMBER                -- 게시물 번호             ｘ
, TITLE        VARCHAR2(50)          -- 게시물 제목             ○
, CONTENTS     VARCHAR2(1000)        -- 게시물 내용             ○
, NAME         VARCHAR2(20)          -- 게시물 작성자           △
, PW           VARCHAR2(20)          -- 게시물 패스워드         △
, CREATED      DATE DEFAULT SYSDATE  -- 게시물 작성일           ｘ
);
--==>>Table TBL_BOARD이(가) 생성되었습니다

--○ 데이터 입력 → 게시판에 게시물을 작성하는 액션
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '풀숲','전 풀숲에 있어요','박현수','java006$',DEFAULT);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오로라','밤하늘 좋네요','정은정','java006$',SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '해변','바람이 부네요','양윤정','java006$',SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '인터뷰','인터뷰중인데, 아이가 들어오네요','이시우','java006$',SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '살려주세요','물에 빠졌어요','최문정','java006$',SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '내가 주인공','나만 빼고 다 블러','김민성','java006$',SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '지구정복','지구를 정복하러 왔다','김정용','java006$',SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '당연히','아무 이유 없다','이아린','java006$',SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	풀숲	    전 풀숲에 있어요	            박현수	java006$	2022-02-25 10:29:37
2	오로라	    밤하늘 좋네요	                정은정	java006$	2022-02-25 10:30:05
3	해변	    바람이 부네요	                양윤정	java006$	2022-02-25 10:30:22
4	인터뷰	    인터뷰중인데, 아이가 들어오네요	이시우	java006$	2022-02-25 10:30:37
5	살려주세요	물에 빠졌어요	                최문정	java006$	2022-02-25 10:30:57
6	내가 주인공	나만 빼고 다 블러	            김민성	java006$	2022-02-25 10:31:17
7	지구정복	지구를 정복하러 왔다	        김정용	java006$	2022-02-25 10:31:34
8	당연히	    아무 이유 없다	                이아린	java006$	2022-02-25 10:31:52
*/

--○ 커밋
COMMIT;
--==>>커밋 완료.

--○ 게시물 삭제(조회 하고 SELECT → DELETE)
DELETE 
FROM TBL_BOARD
WHERE NO = 2;
--==>>1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_BOARD
WHERE NO =3;
--==>>1 행 이(가) 삭제되었습니다.
DELETE
FROM TBL_BOARD
WHERE NO =5;
--==>>1 행 이(가) 삭제되었습니다.
DELETE
FROM TBL_BOARD
WHERE NO =6;
--==>>1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_BOARD;
--==>>
/*
1	풀숲	    전 풀숲에 있어요	            박현수	java006$	2022-02-25 10:29:37
4	인터뷰	    인터뷰중인데, 아이가 들어오네요	이시우	java006$	2022-02-25 10:30:37
7	지구정복	지구를 정복하러 왔다	        김정용	java006$	2022-02-25 10:31:34
8	당연히	    아무 이유 없다	                이아린	java006$	2022-02-25 10:31:52
*/


--○ 게시물 추가 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '형광등','조명이 좋아요','우수정','java006$',SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	풀숲	    전 풀숲에 있어요	            박현수	java006$	2022-02-25 10:29:37
4	인터뷰	    인터뷰중인데, 아이가 들어오네요	이시우	java006$	2022-02-25 10:30:37
7	지구정복	지구를 정복하러 왔다	        김정용	java006$	2022-02-25 10:31:34
8	당연히	    아무 이유 없다	                이아린	java006$	2022-02-25 10:31:52
9	형광등	    조명이 좋아요	                우수정	java006$	2022-02-25 10:40:30
*/

--○ 커밋
COMMIT;
--==>>커밋 완료.

--○ 게시판의 게시물 리스트를 보여주는 쿼리문 구성

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
        ,TITLE "제목", NAME"작성자",CREATED"작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	형광등	    우수정	2022-02-25 10:40:30
4	당연히	    이아린	2022-02-25 10:31:52
3	지구정복	김정용	2022-02-25 10:31:34
2	인터뷰	    이시우	2022-02-25 10:30:37
1	풀숲	    박현수	2022-02-25 10:29:37
*/
-- 날짜 오름 차순 : 과거<미래
-- INSERT 할 때, NO컬럼이랑 행번호랑 다름!

CREATE OR REPLACE VIEW VIEW_BOARDLIST
AS
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
        ,TITLE "제목", NAME"작성자",CREATED"작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>View VIEW_BOARDLIST이(가) 생성되었습니다.

--○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_BOARDLIST;
--==>>
/*
5	형광등	    우수정	2022-02-25 10:40:30
4	당연히	    이아린	2022-02-25 10:31:52
3	지구정복	김정용	2022-02-25 10:31:34
2	인터뷰	    이시우	2022-02-25 10:30:37
1	풀숲	    박현수	2022-02-25 10:29:37
*/
--------------------------------------------------------------------------------
-- SQL PART의 꽃...
--■■■ JOIN(조인) ■■■--

SELECT *
FROM EMP;

SELECT ENAME
FROM EMP;
-------------------------둘다 메모리 사용량은 같음!
-- 년도 : 이 때 표준화가 되었다
-- 1. SQL 1992 CODE

-- ①CROSS JOIN
SELECT*
FROM EMP,DEPT;
--> 수학에서 말하는 데카르트 곱(CARTESIAN PRODUCT)
--  두 테이블을 결합한 모든 경우의 수

-- ②EQUI JOIN : 서로 정확히 일치하는 것들끼리 연결하여 결합시키는 결합 방법
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

--별칭
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- ③NON EQUI JOIN : 범위 안에 적합한 것들끼리 연결하여 결합시키는 결합 방법
SELECT *
FROM EMP;
SELECT *
FROM SALGRADE;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- EQUI JOIN 시 (+) 를 활용한 결합 방법

SELECT *
FROM TBL_EMP;
--> 19명의 사원 중 부서번호를 갖지 못한 사원들은 5명

SELECT*
FROM TBL_DEPT;
--> 5개의 부서 중 소속사원을 갖지 못한 부서는 2개

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> 총 14건의 데이터가 결합되어 조회된 상황
--     즉, 부서번호를 갖지 못한 사원들(5명) 모두 누락
--     또한, 소속 사원을 갖지 못한 부서(2개) 모두 누락

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--==>> 총 19건의 데이터가 결합되어 조회된 상황
--    부서번호를 갖지 못한 사원들(5명) 추가.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--==>> 총 16건의 데이터가 결합되어 조회된 상황
--     소속 사원을 갖지 못한 부서(2개) 추가.

-- → (+)가 안붙은 애들이 주인공, (주인공꺼는 싹 다 올라옴!)
--    그리고 (+)붙은 애꺼랑 안붙은 애랑 비교해서
--    일치하는 애들 반환!

-- ※ (+) 가 없는 쪽 테이블의 데이터를 모두 메모리에 머저 적재한 후
--    (+) 가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로
--    JOIN 이 이루어지게 된다.

--   이와 같은 이유로
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--    이런 형식의 JOIN은 존재하지 않는다!
--    기준이 없고 양쪽에서 첨가하는 형태라!
--==>> 에러 발생
--     ORA-01468: a predicate may reference only one outer-joined table


-- 2. SQL 1999 CODE     →『JOIN』 키워드 등장 → 『JOIN』(결합)의 유형 명시
--                      → 『ON』 키워드 등장 → 결합 조건은 WHERE 대신 ON

-- 1999년도에 표준화 되어있는 CODE
-- 크게 다르지는 않다.
-- 차이점
-- 1992년도 CODE에는 『JOIN』이라는 글자가 없어서 
-- 이게 조인인지 아닌지 모호....
-- WHERE 절이 조회인지 조인인지 모호...

-- ①CROSS JOIN
SELECT *
FROM EMP, DEPT;
-- ▼
SELECT *
FROM EMP CROSS JOIN DEPT;

--EQUI JOIN , NON EQUI JOIN 구분이 사라짐.
--②INNER JOIN
SELECT *
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- ▼
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--INNER 생략 가능
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--③ OUTER JOIN(EQUI JOIN 에서 (+))
SELECT *
FROM TBL_EMP, TBL_DEPT
WHERE TBL_EMP.DEPTNO = TBL_DEPT.DEPTNO(+);

-- ▼
SELECT *
FROM EMP E LEFT OUTER JOIN DEPT D --왼쪽이 메인
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E RIGHT OUTER JOIN DEPT D -- 오른쪽이 메인
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E FULL OUTER JOIN DEPT D -- 둘다 메인 뭔가 CUBE랑 비슷한느낌! 크로스조인이랑 다름!
ON E.DEPTNO = D.DEPTNO;
-- OUTER 생략 가능!
--------------------------------------------------------------------------------
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
    AND JOB = 'CLERK';
-- 이와 같은 방법으로 쿼리문을 구성해도
-- 조회 결과를 얻는 과정에 문제는 없다.
--==>>
/*
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10	10	ACCOUNTING	NEW YORK
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20	20	RESEARCH	DALLAS
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20	20	RESEARCH	DALLAS
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		30	30	SALES	CHICAGO
*/
    
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
--> 하지만, 이와 같이 구성하여
--  조회하는 것을 권장한다.(ON이 등장한 이유 : 선택조건, 결합조건 명시하려고!)

--------------------------------------------------------------------------------

--○ EMP 테이블과 DEPT 테이블을 대상으로
--   직종이 MANAGER와 CLERK 인 사원들만 조회한다.
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.
--   E,D       D       E        E      E
--            ---
--   조인해야겠다!
-- ON에서 어떤 조건 말할깔?
SELECT *
FROM EMP;

SELECT *
FROM DEPT;

SELECT D.DEPTNO"부서번호",D.DNAME"부서명",E.ENAME"사원명",E.JOB"직종명",E.SAL"급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO    -- FROM에서 ON에 맞게 결합하는것! (ON → WHERE)
WHERE E.JOB = 'MANAGER' OR E.JOB = 'CLERK'
ORDER BY 1;
--==>>
/*
부서번호   부서명         사원명     직종명        급여
---------- -------------- ---------- --------- ----------
        10 ACCOUNTING     CLARK      MANAGER         2450
        10 ACCOUNTING     MILLER     CLERK           1300
        20 RESEARCH       ADAMS      CLERK           1100
        20 RESEARCH       JONES      MANAGER         2975
        20 RESEARCH       SMITH      CLERK            800
        30 SALES          BLAKE      MANAGER         2850
        30 SALES          JAMES      CLERK            950

*/