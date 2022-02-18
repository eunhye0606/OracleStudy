SELECT USER
FROM DUAL;
--==>>SCOTT

SELECT EMPNO "사원번호", ENAME "사원명" , JOB "직종명" ,SAL "급   여", DEPTNO "부서번호"
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;
/*
7369	SMITH	CLERK	    800	    20
7499	ALLEN	SALESMAN	1600	30
7521	WARD	SALESMAN	1250	30
7566	JONES	MANAGER	    2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	    2850	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	    950	    30
7902	FORD	ANALYST	    3000	20
*/

--※ 위의 구문은 IN 연산자를 활용하여
--   다음과 같이 처리할 수 있으며
--   위 구문의 처리 결과와 같은 결과를 반환한다.
SELECT EMPNO "사원번호", ENAME "사원명" , JOB "직종명" ,SAL "급   여", DEPTNO "부서번호"
FROM EMP
WHERE DEPTNO IN (20, 30);
-- DEPTNO 안에 20이 들어있거나 30이 들어있거나
--==>>
/*
7369	SMITH	CLERK	    800	    20
7499	ALLEN	SALESMAN	1600	30
7521	WARD	SALESMAN	1250	30
7566	JONES	MANAGER	    2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	    2850	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	    950	    30
7902	FORD	ANALYST	    3000	20
*/

--○EMP 테이블에서 직종이 CLERK 인 사원들의 데이터를 모두 조회한다.
SELECT *
FROM EMP;
WHERE JOB = 'CLERK';
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		    20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	30
7566	JONES	MANAGER 	7839	1981-04-02	2975		20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	140030
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		20
7839	KING	PRESIDENT		    1981-11-17	5000		10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		20
7900	JAMES	CLERK	    7698	1981-12-03	950		    30
7902	FORD	ANALYST	    7566	1981-12-03	3000		20
7934	MILLER	CLERK	    7782	1982-01-23	1300		10
*/

select *
from emp;
where job = "clerk";
--==>> 질의 결과 0 개

-- ※ 오라클에서... 입력된 데이터의 값 만큼은...
--    반.드.시 대소문자 구분을 한다.

--○ EMP 테이블에서 직종이 CLERK 인 사원들 중
--   20번 부서에 근무하는 사원들의
--   사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.

SELECT EMPNO "사원번호", ENAME "사원명", JOB"직종명", SAL "급 여", DEPTNO "부서번호"
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100	20
*/

--○ EMP 테이블의 구조와 데이터를 확인하여
--   이와 똑같은 데이터가 들어있는 테이블의 구조를 생성한다.(TBL_EMP)


DESCRIBE EMP;
DESC EMP;
--==>>
/*
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)
*/
/*
CREATE TABLE TBL_EMP
( EMPNO     NUMBER(4)
, ENAME     VARCHAR2(10)
, JOB       VARCHAR2(9)
, MGR       NUMBER(4)
, HIREDATE  DATE
, SAL       NUMBER(7,2)
, COMM      NUMBER(7,2)
, DEPTNO    NUMBER(2)
);

SELECT *
FROM EMP;

INSERT INTO ... * 14
*/

CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>>Table TBL_EMP이(가) 생성되었습니다.

SELECT *
FROM TBL_EMP;


DESCRIBE TBL_EMP;
--==>>
/*
이름       널?     유형           
-------- --     ------------ 
EMPNO           NUMBER(4)    
ENAME           VARCHAR2(10) 
JOB             VARCHAR2(9)  
MGR             NUMBER(4)    
HIREDATE        DATE         
SAL             NUMBER(7,2)  
COMM            NUMBER(7,2)  
DEPTNO          NUMBER(2)
*/

--○ 테이블 복사(DEPT →TBL_DEPT)
CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==>>Table TBL_DEPT이(가) 생성되었습니다.

--○복사한 테이블 확인
DESC TBL_DEPT;
--==>>
/*
이름     널?       유형           
------   --       ------------ 
DEPTNO              NUMBER(2)    
DNAME               VARCHAR2(14) 
LOC                 VARCHAR2(13) 
*/


--테이블의 커멘트 정보 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE      	
TBL_EMP	        TABLE      	
TBL_EXAMPLE2	TABLE      	
TBL_EXAMPLE1	TABLE	   
SALGRADE	    TABLE      	
BONUS	        TABLE      
EMP	            TABLE      
DEPT	        TABLE      		
*/

--○ 테이블 레벨의 커멘트 정보 입력
COMMENT ON TABLE TBL_EMP IS '사원 정보';
--==>>Comment이(가) 생성되었습니다.

--○ 커멘트 정보 입력 후 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	
TBL_EMP	        TABLE	사원 정보
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/

--○ TBL_DEPT 테이블을 대상으로 테이블 레벨의 커멘트 데이터 입력
--   → 부서 정보

--         TABLE를 여기 쓴거 보니 다른 거에서도 커멘트가 가능한가 보오..
COMMENT ON TABLE TBL_DEPT IS '부서 정보';
--==>>Comment이(가) 생성되었습니다.

--○ 커멘트 데이터 입력 후 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	부서 정보
TBL_EMP	        TABLE	사원 정보
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--○ 컬럼 레벨의 커멘트 데이터 확인

SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
TBL_EXAMPLE2	NO	
BONUS	        SAL	
TBL_EMP	        HIREDATE	
DEPT	        LOC	
TBL_EMP	        ENAME	
SALGRADE	    GRADE	
TBL_EXAMPLE2	NAME	
BONUS	        ENAME	
SALGRADE	    LOSAL	
TBL_EMP	        COMM	
BONUS	        JOB	
EMP	            SAL	
TBL_EMP	        EMPNO	
BONUS	        COMM	
TBL_EMP	        DEPTNO	
TBL_EMP	        JOB	
EMP	            ENAME	
TBL_DEPT	    LOC	
*/

--○ 컬럼 레벨의 커멘트 데이터 확인(TBL_DEPT 테이블 소속의 컬럼들만 확인)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT'; --조건 추가
--==>>
/*
TBL_DEPT	DEPTNO	
TBL_DEPT	DNAME	
TBL_DEPT	LOC	
*/

--○ 테이블에 소속된(포함된) 컬럼에 대한 커멘트 데이터 설정

COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '부서 번호';
--==>>Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.DNAME IS '부서명';
--==>>Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.LOC IS '부서 위치';
--==>>Comment이(가) 생성되었습니다.

-- 커멘트 데이터가 입력된 테이블의 컬럼 레벨 커멘트 데이터 확인
-- (TBL_DEPT 테이블 소속의 칼럼들만 조회)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	부서 번호
TBL_DEPT	DNAME	부서명
TBL_DEPT	LOC	    부서 위치
*/

--○ TBL_EMP 테이블을 대상으로
--   테이블에 소속된(포함된) 컬럼에 대한 커멘트 데이터 설정
DESC TBL_EMP;

COMMENT ON COLUMN TBL_EMP.EMPNO IS '사원 번호';
COMMENT ON COLUMN TBL_EMP.ENAME IS '사원 이름';
COMMENT ON COLUMN TBL_EMP.JOB IS '직종명';
COMMENT ON COLUMN TBL_EMP.MGR IS '관리자 사원번호';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '입사 일자';
COMMENT ON COLUMN TBL_EMP.SAL IS '급 여';
COMMENT ON COLUMN TBL_EMP.COMM IS '수 당';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '부서 번호';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    사원 번호
TBL_EMP	ENAME	    사원 이름
TBL_EMP	JOB	        직종명
TBL_EMP	MGR	        관리자 사원번호
TBL_EMP	HIREDATE	입사 일자
TBL_EMP	SAL	        급 여
TBL_EMP	COMM	    수 당
TBL_EMP	DEPTNO	    부서 번호
*/
-- ■■■ 컬럼 구조의 추가 및 제거 ■■■--
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	    30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	    30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		    30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
*/

--○ TBL_EMP 테이블에 주민등록번호 데이터를 담을 수 있는 컬럼 추가
--   → SSN   CHAR(13)
ALTER TABLE TBL_EMP
ADD SSN CHAR(13);
--==>>Table TBL_EMP이(가) 변경되었습니다.

--○ 확인
SELECT *
FROM TBL_EMP;

SELECT 01012341234
FROM DUAL;
--==>>1012341234
--> 앞에 0 탈락.

SELECT '01012341234'
FROM DUAL;
--==>>01012341234
--> 숫자로만 구성된 데이터라 할지라도 맨 앞에 0이 들어가면
--> 문자열 타입으로!

SELECT EMPNO, SSN
FROM TBL_EMP;

DESC TBL_EMP;

SELECT ENAME "사원명", SSN"주민번호"
FROM TBL_EMP;
--> SSN(주민등록번호) 컬럼이 정상적으로 포함(추가)된 사항을 확인

--※ 테이블 내에서 컬럼의 순서는 구조적으로 의미 없음.

--○ TBL_EMP 테이블에 추가한 SSN(주민등록번호) 컬럼 구조적으로 제거
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>>Table TBL_EMP이(가) 변경되었습니다.

DESC TBL_EMP;
--==>>
/*
이름     널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)
*/
--==>> SSN(주민등록번호) 컬럼이 정상적으로 삭제되었음을 확인.


DELETE TBL_EMP;
--==>>14개 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_EMP;
--==>> 에러 발생 안함
--     질의 결과는 0개 , 데이터 없음
--     테이블의 구조(뼈대, 틀)는 그대로 남아있는 상태에서(컬럼명들)
--     데이터만 모두 소실(삭제)된 상황임을 확인.

DESCRIBE TBL_EMP;
--==>>
/*
이름     널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)
*/
--> 구조 남아 있는 거 확인 가능

DROP TABLE TBL_EMP;
--==>>Table TBL_EMP이(가) 삭제되었습니다.

SELECT *
FROM TBL_EMP;
--==>> 에러 발생
--     ORA-00942: table or view does not exist

DESC TBL_EMP;
--==>> 에러 발생
--     ORA-04043: TBL_EMP 객체가 존재하지 않습니다.

--○ 테이블 다시 복사(생성)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>>Table TBL_EMP이(가) 생성되었습니다.


--○ NULL 의 처리 
SELECT 2, 10+2, 10-2,10*2,10/2
FROM DUAL;
--==>>2	12	8	20	5


SELECT NULL, NULL + 2, 10 - NULL, NULL*2, 2/NULL
FROM DUAL;
--==>>(null) (null) (null) (null)				

--※ 관찰의 결과
--   NULL 은 상태의 값을 의미하며, 물리적으로는 실제 존재하지 않는 값이기 때문에
--   이 NULL 이 연산에 포함될 경우...
--   그 결과는 무조건 NULL 이다.


--○ TBL_EMP 테이블에서 커미션(COMM, 수당)이 NULL 인 직원의
--   사원명, 직종명, 급여, 커미션 항목을 조회한다.

SELECT ENAME "사원명",JOB "직종명",SAL"수 당",COMM"커미션 수당"
FROM TBL_EMP
WHERE COMM = NULL;
--==>> 에러 발생하지 않음
--     조회 결과 없음.

SELECT ENAME "사원명",JOB "직종명",SAL"수 당",COMM"커미션 수당"
FROM TBL_EMP
WHERE COMM = (NULL);
--==>> 에러 발생하지 않음
--     조회 결과 없음.

SELECT ENAME "사원명",JOB "직종명",SAL"수 당",COMM"커미션 수당"
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> 에러 발생
--     ORA-01722: invalid number
--     COMM 컬럼에는 문자열만 들어오는데 
--     이건 머니? 하는 에러

SELECT ENAME "사원명",JOB "직종명",SAL"수 당",COMM"커미션 수당"
FROM TBL_EMP
WHERE COMM IS NULL;
--==>>
/*
SMITH	CLERK	     800	(null)
JONES	MANAGER	    2975    (null)	
BLAKE	MANAGER	    2850    (null)	
CLARK	MANAGER	    2450    (null)	
SCOTT	ANALYST	    3000    (null)	
KING	PRESIDENT	5000    (null)	
ADAMS	CLERK	    1100    (null)	
JAMES	CLERK	     950	(null)
FORD	ANALYST	    3000    (null)	
MILLER	CLERK	    1300    (null)	
*/

--※ NULL 은 실제 존재하는 값이 아니기 때문에
--   일반적인 연산자를 활용하여 비교할 수 없다.
--   NULL 을 대상으로 사용할 수 없는 연산자들...
--   >= , <=, = , >, <,
--   같지 않다 : != , ^=, <>

--○ TBL_EMP 테이블에서 20번 부서에 근무하지 않는 직원들의
--   사원명, 직종명, 부서번호 항목을 조회한다.
SELECT ENAME "사원명",JOB "직종명",DEPTNO"부서번호"
FROM TBL_EMP
WHERE DEPTNO <> 20;
--==>>
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	    30
CLARK	MANAGER	    10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	    30
MILLER	CLERK	    10
*/

--○ TBL_EMP 테이블에서 커미션이 NULL이 아닌 직원들의
--   사원명, 직종명, 급여, 커미션 항목을 조회한다.
SELECT ENAME"사원명",JOB"직종명",SAL"급여",COMM"커미션 수당"
FROM TBL_EMP
WHERE COMM IS NOT NULL; -- NOT
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/

SELECT ENAME"사원명",JOB"직종명",SAL"급여",COMM"커미션 수당"
FROM TBL_EMP
WHERE NOT COMM IS NULL;
--==>> IS(논리 연산자) 부정 (NOT)
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/


--○ TBL_EMP 테이블에서 모든 사원들의(→ 조건절 X)
--   사원번호, 사원명, 급여, 커미션, 연봉 항목을 조회한다.
--   단, 급여(SAL)는 매월 지급한다.
--   또한, 수당(COMM)은 연 1회 지급하며(매년 지급), 연봉 내역에 포함된다.

SELECT EMPNO"사원번호",ENAME"사원명",SAL"급 여",COMM"커미션 수당", 
SAL  * 12 + NVL(COMM,0) AS"연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	 800   	         9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975		    35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850		    34200
7782	CLARK	2450		    29400
7788	SCOTT	3000		    36000
7839	KING	5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	FORD	3000		    36000
7934	MILLER	1300		    15600	
*/
-->> COMM 이 NULL 이면 연봉이 NULL 됨


--○ NVL()
SELECT NULL "COL1", NVL(NULL,10)"COL2",NVL(5,10)"COL3"
FROM DUAL;
--==>>(null) 10	 5
--    첫 번째 파라미터 값이 NULL이면, 두 번째 파라미터 값을 반환한다.
--    첫 번째 파라미터 값이 NULL이 아니면, 그 값을 그대로 반환한다.

SELECT ENAME"사원명",COMM"수당"
FROM TBL_EMP;
--==>>
/*
SMITH	
ALLEN	300
WARD	500
JONES	
MARTIN	1400
BLAKE	
CLARK	
SCOTT	
KING	
TURNER	0
ADAMS	
JAMES	
FORD	
MILLER	
*/



SELECT ENAME"사원명",NVL(COMM,1234)"수당"
FROM TBL_EMP;
--==>>
/*
SMITH	1234
ALLEN	300
WARD	500
JONES	1234
MARTIN	1400
BLAKE	1234
CLARK	1234
SCOTT	1234
KING	1234
TURNER	0
ADAMS	1234
JAMES	1234
FORD	1234
MILLER	1234
*/
-- NULL이 아니면 그대로, NULL이면 100으로 수당을 채웠다.




























