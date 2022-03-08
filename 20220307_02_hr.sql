SELECT USER
FROM DUAL;
--==>> HR

--------------------------------------------------------------------------------

--○ EMPLOYEES 테이블의 직원들 SALARY 를 10% 인상한다.                          -- 문제
--   단, 부서명이 'IT' 인 직원들만 한정한다.
--   (또한, 변경에 대한 결과 확인 후 ROLLBACK 수행한다~!!!)

-- 내 풀이 ---------------------------------------------------------------------
SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE 부서명이 'IT';

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = 'IT';

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME='IT');
--==>> 5개 행 이(가) 업데이트되었습니다.

SELECT *
FROM EMPLOYEES;

ROLLBACK;
--==>> 롤백 완료.

-- 수업 풀이 -------------------------------------------------------------------

-- IT 부서 직원들의 FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID 조회
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE 부서명 = 'IT';

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE 부서번호 = 부서명이 'IT'인 부서의 부서번호;

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE 부서번호 = 60;

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (부서명이 'IT'인 부서의 부서번호);

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
Alexander	Hunold	    9000	60
Bruce	    Ernst	    6000	60
David	    Austin  	4800	60
Valli	    Pataballa	4800	60
Diana	    Lorentz	    4200	60
*/

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
     , SALARY*1.1 "10%인상된급여"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
Alexander	Hunold	    9000	60	9900
Bruce	    Ernst	    6000	60	6600
David	    Austin	    4800	60	5280
Valli	    Pataballa	4800	60	5280
Diana	    Lorentz	    4200	60	4620
*/

UPDATE EMPLOYEES
SET SALARY = SALARY*1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 5개 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;
--==>>
/*
103	Alexander	Hunold	AHUNOLD	        590.423.4567	2006-01-03	IT_PROG	9900		102	60
104	Bruce	    Ernst	BERNST	        590.423.4568	2007-05-21	IT_PROG	6600		103	60
105	David	    Austin	DAUSTIN	        590.423.4569	2005-06-25	IT_PROG	5280		103	60
106	Valli	    Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	5280		103	60
107	Diana	    Lorentz	DLORENTZ	    590.423.5567	2007-02-07	IT_PROG	4620		103	60
*/

-- 롤백
ROLLBACK;
--==>> 롤백 완료.

-------------------------------------------------------------------------------- 

--○ EMPLOYEES 테이블에서 JOB_TITLE이 『Sales Manager』인 사원들의              -- 문제
--   SALARY 를 해당 직무(직종)의 최고급여(MAX_SALARY)로 수정한다.
--   단, 입사일이 2006년 이전(해당 년도 제외) 입사자에 한해 적용할 수 있도록 처리한다.
--   (또한, 변경에 대한 결과 확인 후 ROLLBACK 수행한다~!!!)

-- 수업 풀이 -------------------------------------------------------------------
SELECT *
FROM EMPLOYEES;

SELECT *
FROM JOBS;
--==>> SA_MAN	Sales Manager	10000	20080

UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'의 MAX_SALARY)
WHERE JOB_TITLE = 'Sales Manager'
  AND 입사일이 2006년 이전;
  
UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'의 MAX_SALARY)
WHERE JOB_ID = ('Sales Manager'의 JOB_ID)
  AND TO_CHAR(HIRE_DATE, 'YYYY') < 2006;
  
UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'의 MAX_SALARY)
WHERE JOB_ID = ('Sales Manager'의 JOB_ID)
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
  
-- 'Sales Manager'의 MAX_SALARY
SELECT MAX_SALARY
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> 20080

UPDATE EMPLOYEES
SET SALARY = (20080)
WHERE JOB_ID = ('Sales Manager'의 JOB_ID)
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
  
UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager';)
WHERE JOB_ID = ('Sales Manager'의 JOB_ID)
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;

-- 'Sales Manager'의 JOB_ID
SELECT JOB_ID
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--=>> SA_MAN

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = ('SA_MAN')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;

-- 최종
UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--==>> 3개 행 이(가) 업데이트되었습니다.

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--==>> 
/*
145	John	Russell	    JRUSSEL 	011.44.1344.429268	2004-10-01	SA_MAN	20080	0.4	100	80
146	Karen	Partners	KPARTNER	011.44.1344.467268	2005-01-05	SA_MAN	20080	0.3	100	80
147	Alberto	Errazuriz	AERRAZUR	011.44.1344.429278	2005-03-10	SA_MAN	20080	0.3	100	80
*/

ROLLBACK;
--==>> 롤백 완료.

--------------------------------------------------------------------------------

--○ EMPLOYEES 테이블에서 SALARY 를                                             -- 문제
--   각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--   FINANCE → 10% 인상
--   EXECUTIVE → 15% 인상
--   ACCOUNTING → 20% 인상
--   (또한, 변경에 대한 결과 확인 후 ROLLBACK 수행한다~!!!)

-- 내 풀이 ---------------------------------------------------------------------
SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES;

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTNENT_ID WHEN DEPARTMENT_NAME = 'Finance' THEN SALARY * 1.1 
                                WHEN DEPARTMENT_NAME = 'Executive' THEN SALARY * 1.15 
                                WHEN DEPARTMENT_NAME = 'Accounting' THEN SALARY * 1.2 
                                ELSE SALARY
             END; 
             
UPDATE EMPLOYEES
SET SALARY = CASE DEPARTNENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Finance') THEN SALARY * 1.1 
                                WHEN DEPARTMENT_NAME = 'Executive' THEN SALARY * 1.15 
                                WHEN DEPARTMENT_NAME = 'Accounting' THEN SALARY * 1.2 
                                ELSE SALARY
             END;              
             
             
-- 최종
UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Finance') THEN SALARY * 1.1 
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Executive') THEN SALARY * 1.15 
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Accounting') THEN SALARY * 1.2 
                                ELSE SALARY
             END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));
--==>> 11개 행 이(가) 업데이트되었습니다.

-- 조회
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));

ROLLBACK;     
--==>> 롤백 완료.

-- 수업 풀이 -------------------------------------------------------------------

UPDATE EMPLOYEES;

-- WHERE 부서명 IN ('Finance', 'Executive', 'Accounting')
--               ↓
-- WHERE 부서명이 ('Finance', 'Executive', 'Accounting')인 부서아이디 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting');
--==>>
/*
90
100
110
*/

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finance'의 부서아이디) 
                                THEN SALARY * 1.1 
                                WHEN  ('Executive'의 부서아이디) 
                                THEN SALARY * 1.15  
                                WHEN  ('Accounting'의 부서아이디) 
                                THEN SALARY * 1.2  
                                ELSE SALARY
             END
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));

-- ('Finance'의 부서아이디) 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance';

-- ('Executive'의 부서아이디) 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Executive';

-- ('Accounting'의 부서아이디) 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Accounting';


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Executive') 
                                THEN SALARY * 1.1 
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Executive') 
                                THEN SALARY * 1.15  
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Accounting') 
                                THEN SALARY * 1.2  
                                ELSE SALARY
             END
WHERE DEPARTMENT_ID in (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));
--==>> 11개 행 이(가) 업데이트되었습니다.

-- WHERE 절의 유무 관계없이 실행은 될 것이다. 그러나 WHERE절이 있는 것이 메모리를 덜 쓸 것.
-- 각각 107, 11개 행 대상으로 처리가 된다.

-- 롤백
ROLLBACK;
--==>> 롤백 완료.

-- 위와 같은 구문
UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (100) THEN SALARY * 1.1 
                                WHEN (90) THEN SALARY * 1.15  
                                WHEN (110) THEN SALARY * 1.2  
                                ELSE SALARY
             END
WHERE DEPARTMENT_ID IN (90, 100, 110);


--------------------------------------------------------------------------------

--■■■ DELETE ■■■--

-- 1. 테이블에서 지정된 행(레코드)을 삭제하는 데 사용하는 구문

-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명 -- 프롬절 없어도 돌아간다
-- [WHERE 조건절];


-- 테이블 복사(데이터 위주)
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>> Table TBL_EMPLOYEES이(가) 생성되었습니다.

SELECT * -- 딜리트 할 때는 먼저 셀렉트로 조회해 보고~
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 198	Donald	OConnell	DOCONNEL	650.507.9833	2007-06-21	SH_CLERK	2600		124	50

-- ↓

DELETE
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 행 이(가) 삭제되었습니다.

ROLLBACK;
--==>> 롤백 완료.

--------------------------------------------------------------------------------

--○ EMPLOYEES 테이블에서 직원들의 데이터를 삭제한다.                           -- 문제
--   단, 부서명이 'IT' 인 경우로 한정한다.

--※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상 데이터)
--   다른 레코드에 의해 참조당하고 있는 경우
--   삭제되지 않을 수 있다는 사실을 염두해야 하며...
--   그에 대한 이유도 알아야 한다.

-- 내 풀이 ---------------------------------------------------------------------
SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
                       
DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 에러 발생
--     (ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)

-- 수업 풀이 -------------------------------------------------------------------
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ('IT' 부서의 부서아이디);

-- ('IT' 부서의 부서아이디)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';
--==>> 60

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
103	Alexander	Hunold	AHUNOLD	590.423.4567	2006-01-03	IT_PROG	9000		102	60
104	Bruce	Ernst	BERNST	590.423.4568	2007-05-21	IT_PROG	6000		103	60
105	David	Austin	DAUSTIN	590.423.4569	2005-06-25	IT_PROG	4800		103	60
106	Valli	Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	4800		103	60
107	Diana	Lorentz	DLORENTZ	590.423.5567	2007-02-07	IT_PROG	4200		103	60
*/

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 에러 발생
--     (ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)
-- MGR 컬럼에서 참조하고 있는 레코드가 있어서 딜리트 되지 않는 것


--------------------------------------------------------------------------------

--■■■ 뷰(VIEW) ■■■--

-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
--    하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
--    정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만을 모아서
--    만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.

--    가상의 테이블이란... 뷰가 실제로 존재하는 테이블(객체)이 아니라
--    하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이라는 의미이며,
--    그 정보를 추출해내는 SQL 문장이라고 볼 수 있다.

-- 2. 형식 및 구조
-- CREATE [OR REPLACE] VIEW 뷰이름
-- [(ALIAS[, ALIAS, ...])]
-- AS
-- 서브쿼리(SUBQUERY)
-- [WITH CHECK OPTION] -- 어드민 파트 일부니까 크게 신경 안 써도 됨
-- [WITE READ ONLY] -- 어드민 파트 일부니까 크게 신경 안 써도 됨

-- ○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID;


--○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_EMPLOYEES;

--○ 뷰(VIEW)의 구조 조회
DESC VIEW_EMPLOYEES;
--==>>
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/


--○ 뷰(VIEW) 소스 확인       CHECK~!!!
-- 어드민 파트에서 쓰이는 건데 알아두면 유용할 것
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS -- S 붙어있는 거 확인
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>>
/*
VIEW_EMPLOYEES	

"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID"
*/














