SELECT USER
FROM DUAL;
--==>>SCOTT

-- ※※※ BETWEEN ⓐ AND ⓑ 는 날짜형, 숫자형, 문자형 데이터 모두에 적용된다.
--        단, 문자형일 경우 아스키코드 순서를 따르기 때문에 (사전식 배열)
--        대문자가 앞쪽에 위치하고 소문자가 뒤쪽에 위치한다.
--        또한, BETWEEN ⓐ AND ⓑ 는 해당 구문이 수행되는 시점에서
--        오라클 내부적으로는 부등호 연산자의 형태로 바뀌어 연산 처리된다.
--        → 이거 자동형변환아닌가? 차라리 오토박싱에 가깝나?
--           부등호 AND 부등호가 더 빠름, BETWEEN 보다
--           요즘 CPU에서는 딱히 두 개를 비교할 정도는 아니지만
--           사람이 쓰기 어려운게 컴퓨터는 더 빨리 처리한다(ex.자바 비트연산자)


--오라클에서 아스키코드 확인하는 방법!
SELECT ASCII('A')"COL1",ASCII('a')"COL2"
FROM DUAL;
--==>>65	97
SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = 'SALESMAN' 
        OR JOB = 'CLERK';
--==>>
/*
SMITH	CLERK	     800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	     950
MILLER	CLERK	    1300
호석이	SALESMAN   (null)	
문정이	SALESMAN   (null)		
*/
SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB IN ('SALESMAN','CLERK');

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB =ANY('SALESMAN','CLERK');

--> 3개 다 같음.
--  내부적으로는 OR로 바뀌어서 처리됨.
--  OR, IN, ANY

-- ※ 위의 3가지 유형의 쿼리문은 모두 같은 결과를 반환한다.
--    하지만, 맨 위의 쿼리문(OR)이 가장 빠르게 처리된다.
--    물론 메모리에 대한 내용이 아니라 CPU 처리에 대한 내용이므로
--    이 부분까지 감안하여 쿼리문을 구성하게 되는 경우는 많지 않다.
--    → 『IN』과 『ANY』는 같은 연산자 효과를 가진다.
--        이들 모두는 내부적으로 『OR』 구조로 변경되어 연산 처리된다.
-------------------------------------------------------------------------------

--○ 추가 실습 테이블 구성(TBL_SAWON)
CREATE TABLE TBL_SAWON
(SANO    NUMBER(4)
, SNAME  VARCHAR2(30)
, JUBUN  CHAR(13)
, HIREDATE DATE     DEFAULT SYSDATE
, SAL  NUMBER(10)
);
--==>>Table TBL_SAWON이(가) 생성되었습니다.

SELECT *
FROM TBL_SAWON;
--=>> 조회 결과 없음

DESCRIBE TBL_SAWON;
--==>>
/*
이름     널? 유형           
-------- -- ------------ 
SANO        NUMBER(4)    
SNAME       VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)
*/
--○ 생성된 테이블에 데이터 입력(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1001, '김민성' , '9707251234567',TO_DATE('2005-01-03','YYYY-MM-DD'),'3000');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1002, '서민지' , '9505152234567',TO_DATE('1999-11-23','YYYY-MM-DD'),'4000');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1003, '이지연' , '9905192234567',TO_DATE('2006-08-10','YYYY-MM-DD'),'3000');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1004, '이연주' , '9508162234567',TO_DATE('2007-10-10','YYYY-MM-DD'),'4000');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1005, '오이삭' , '9805161234567',TO_DATE('2007-10-10','YYYY-MM-DD'),'4000');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1006, '이현이' , '8005132234567',TO_DATE('1999-10-10','YYYY-MM-DD'),'1000');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1007, '박한이' , '0204053234567',TO_DATE('2010-10-10','YYYY-MM-DD'),'1000');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1008, '선동렬' , '6803171234567',TO_DATE('1998-10-10','YYYY-MM-DD'),'1500');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1009, '선우용녀' , '6912232234567',TO_DATE('1998-10-10','YYYY-MM-DD'),'1300');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1010, '선우선' , '0303044234567',TO_DATE('2010-10-10','YYYY-MM-DD'),'1600');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1011, '남주혁' , '0506073234567',TO_DATE('2012-10-10','YYYY-MM-DD'),'2600');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1012, '남궁민' , '0208073234567',TO_DATE('2012-10-10','YYYY-MM-DD'),'2600');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1013, '남진' , '6712121234567',TO_DATE('1998-10-10','YYYY-MM-DD'),'2200');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1014, '홍수민' , '0005044234567',TO_DATE('2015-10-10','YYYY-MM-DD'),'5200');

INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1015, '임소민' , '9711232234567',TO_DATE('2007-10-10','YYYY-MM-DD'),'5500');

SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	김민성	    9707251234567	2005-01-03	3000
1002	서민지	    9505152234567	1999-11-23	4000
1003	이지연	    9905192234567	2006-08-10	3000
1004	이연주	    9508162234567	2007-10-10	4000
1005	오이삭	    9805161234567	2007-10-10	4000
1006	이현이	    8005132234567	1999-10-10	1000
1007	박한이	    0204053234567	2010-10-10	1000
1010	선우선	    0303044234567	2010-10-10	1600
1011	남주혁	    0506073234567	2012-10-10	2600
1013	남진	    6712121234567	1998-10-10	2200
1014	홍수민	    0005044234567	2015-10-10	5200
1015	임소민	    9711232234567	2007-10-10	5500
1009	선우용녀	6912232234567	1998-10-10	1300
1012	남궁민	    0208073234567	2012-10-10	2600
1008	선동렬	    6803171234567	1998-10-10	1500
*/
DELETE FROM TBL_SAWON
WHERE SNAME = '선동렬';

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ TBL_SAWON 테이블에서 '이지연'사원의 데이터를 조회한다.
SELECT *
FROM TBL_SAWON
WHERE SNAME = '이지연';
--==>>1003	이지연	9905192234567	2006-08-10	3000

SELECT *
FROM TBL_SAWON
WHERE SNAME LIKE '이지연';
--> '~처럼' 위와 같은 결과 실행.

--※ LIKE : 동사 → 좋아하다.
--          부사 → ~와 같이, ~ 처럼 CHECK~!!

--※ WHILD CARD(CHARACTER) →『%』
--   『LIKE』와 함께 사용되는 『%』는 모든 글자를 의미하고
--   『LIKE』와 함께 사용되는 『_』는 아무 글자 한 개를 의미한다.

--○ TBL_SAWON 테이블에서 성씨가 『김』씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.

SELECT *
FROM TBL_SAWON
WHERE SNAME = '김';
--==>> 조회 결과 없음.

SELECT *
FROM TBL_SAWON
WHERE SNAME LIKE '김__';
--==>> 1001	김민성	9707251234567	2005-01-03	3000

SELECT *
FROM TBL_SAWON
WHERE SNAME LIKE '김%';
--==>> 1001	김민성	9707251234567	2005-01-03	3000

--○ TBL_SAWON 테이블에서 성씨가 『이』씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.

SELECT SNAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SNAME LIKE '이__';
--==>>
/*
이지연	9905192234567	3000
이연주	9508162234567	4000
이현이	8005132234567	1000
*/
--○ TBL_SAWON 테이블에서 이름의 마지막 글자가 『민』인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT SNAME "사원명", JUBUN "주민번호", SAL"급여"
FROM TBL_SAWON
WHERE SNAME LIKE '%민';
--==>>
/*
홍수민	0005044234567	5200
임소민	9711232234567	5500
남궁민	0208073234567	2600
*/
--○ 추가 데이터 입력(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SNAME, JUBUN, HIREDATE, SAL)
VALUES(1016, '이이경','0603194234567', TO_DATE('2015-01-02','YYYY-MM-DD'),1500);

SELECT *
FROM TBL_SAWON;

--○ 커밋
COMMIT;
--==>>커밋 완료.

--------------------------------------------------------------------------------
--○ TBL_SAWON 테이블에서 사원의 이름에 『이』라는 글자가
--   하나라도 포함되어 있다면 그 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호",SNAME"사원명",SAL"급여"
FROM TBL_SAWON
WHERE SNAME LIKE '%이%';
--==>>
/*
1003	이지연	3000
1004	이연주	4000
1005	오이삭	4000
1006	이현이	1000
1007	박한이	1000
1016	이이경	1500
*/

--○ TBL_SAWON 테이블에서 사원의 이름에 『이』라는 글자가
--   연속으로 두 번 들어있는 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.

SELECT SANO, SNAME, SAL
FROM TBL_SAWON
WHERE SNAME LIKE '%이이%';
--==>>1016	이이경	1500

--○ TBL_SAWON 테이블에서 사원의 이름에 『이』라는 글자가 두 번 들어있는
--   사원의 사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO, SNAME, SAL
FROM TBL_SAWON
WHERE SNAME LIKE '%이%이%';
--==>>
/*
1006	이현이	1000
1016	이이경	1500
*/

--○ TBL_SAWON 테이블에서 사원 이름의 두 번째 글자가 『이』인 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO, SNAME, SAL
FROM TBL_SAWON
WHERE SNAME LIKE '_이%';
--==>>
/*
1005	오이삭	4000
1016	이이경	1500
*/

--○ TBL_SAWON 테이블에서 사원 성씨가 『선』씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
-->불가능한 문제. 『남』씨도 마찬가지.
-- 불가 ~~CHECK!
SELECT SNAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SNAME LIKE '선__';
--==>>
/*
선우선	0303044234567	1600 -- .. 선씨.. 인지.. 선우씨인지...
선동렬	6803171234567	1500
*/
--※ 데이터베이스 설계 과정에서
--   성과 이름을 분리하여 처리해야 할 업무 계획이 있다면
--   (지금 당장은 아니더라도...)
--   테이블에서 성 컬럼과 이름 컬럼을 분리하여 구성해야 한다.
--   → 데이터베이스 설계 과정에서 ...
-------------------------------------------------------------------------------
-- ○ TBL_SAWON 테이블에서 여직원들의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT SNAME, JUBUN, SAL
FROM TBL_SAWON
--WHERE JUBUN LIKE ANY('______2%','______4%');
--==>>에러 발생
--    ORA-00936: missing expression
--WHERE JUBUN LIKE IN('______2%','______4%');
--==>>에러 발생
--    ORA-00936: missing expression
WHERE JUBUN LIKE '______2%'OR JUBUN LIKE'______4%';
--WHERE JUBUN LIKE '______2_______'OR JUBUN LIKE'______4_______';
--==>>
/*
서민지	    9505152234567	4000
이지연	    9905192234567	3000
이연주	    9508162234567	4000
이현이	    8005132234567	1000
선우선	    0303044234567	1600
홍수민	    0005044234567	5200
임소민	    9711232234567	5500
선우용녀	6912232234567	1300
이이경	    0603194234567	1500
*/
-- ●●● IN, ANY는 왜 못쓰는지 !!!●●●
DESC TBL_SAWON;

--○ 테이블 생성(TBL_WATCH)
CREATE TABLE TBL_WATCH
(WATCH_NAME    VARCHAR2(20)
, BIGO         VARCHAR2(100)
);
--==>>Table TBL_WATCH이(가) 생성되었습니다.

-- ○ 데이터 입력(TBL_WATCH)
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('금시계','순금99.99% 함유된 최고급 시계');
--==>>1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('은시계','고객 만족도 99.99점을 획득한 멋진 시계');
--==>>1 행 이(가) 삽입되었습니다.

--○확인
SELECT *
FROM TBL_WATCH;
--==>>
/*
금시계	순금99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 멋진 시계
*/

--○ 커밋
COMMIT;
--==>>커밋 완료.

--○ TBL_WATCH 테이블의 BIGO(비고) 컬럼에
--   『99.99%』라는 글자가 포함된(들어있는) 행(레코드)의
--   데이터를 조회한다.


SELECT *
FROM TBL_WATCH
WHERE BIGO = '99.99%';
--==>> 조회 결과 없음.
-- 99.99% 단일문자열을 찾음.

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '99.99%';
--==>>조회 결과 없음.
-- 99.99로 시작하는 문자열 찾음.

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%';
--==>>
/*
금시계	순금99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 멋진 시계
*/
-- %가 하나든 두개든
-- 99.99가 포함된 문자열 찾음.


-- 와일드캐릭터가 사용되는 조건절에서 특수문자 표현하기 → ESCAPE(ESC)
-- ESCAPE '\'; → 와일드캐릭터에서 탈출시켜라.
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99\%%' ESCAPE '\'; 
--==>>금시계	순금99.99% 함유된 최고급 시계

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99$%%' ESCAPE '$'; 
--==>>금시계	순금99.99% 함유된 최고급 시계

--※ ESCAPE로 정한 문자의 다음 한 글자를 와일드카드에서 탈출시켜라...
--   일반적으로 사용 빈도가 낮은 특수문자(특수기호)를 사용한다.

--------------------------------------------------------------------------------

--■■■ COMMIT / ROLLBACK ■■■--
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

--○ 데이터 입력
INSERT INTO TBL_DEPT VALUES(50, '개발부','서울');
--==>>1 행 이(가) 삽입되었습니다.
SELECT *
FROM TBL_DEPT;
--==>> 
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/
-- 데이터가 테이블안에 있는거처럼 보임.

-- 50번 개발부 서울...
-- 이 데이터는 TBL_DEPT 테이블이 저장되어 있는
-- 하드디스크상에 물리적으로 적용되어 저장된 것이 아니다.
-- 메모리(RAM) 상에 입력된 것이다.

-- ○ 롤백
ROLLBACK;
--==>>롤백 완료.
-- 메모리상에 구성된 모든 것을 되돌림.

-- ○ 다시 확인
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
--> 50번 개발부 서울... 에 대한 데이터가 소실되었음을 확인(존재하지 않음)

--○ 다시 데이터 입력
INSERT INTO TBL_DEPT VALUES(50, '개발부','서울');
--==>>1 행 이(가) 삽입되었습니다.

-- 50번 개발부 서울..
-- 이 데이터는 TBL_DEPT 테이블이 저장되어 있는 하드디스크상에 저장해줘
-- COMMIT을 수행해야한다.

--○ 커밋
COMMIT;
--==>> 커밋 완료


--○ 커밋 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

--○ 커밋을 수행한 이후 롤백
ROLLBACK;
--==>>롤백 완료.
--○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;

--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

--※ 롤백(ROLLBACK)을 수행했음에도 불구하고
--   50번 개발부 서울.... 의 행 데이터는 소실되지 않았음을 확인

--※ COMMIT을 실행한 이후 DML 구문(INSERT, UPDATE, DELETE)을 통해
--   변경된 데이터를 취소할 수 있는 것일 뿐...
--   DML 구문을 사용한 후 COMMIT을 하고 나서 ROLLBACK 을 실행해봐야
--   아무런 소용이 없다.

--○ 데이터 수정(UPDATE → TBL_DEPT)
UPDATE TBL_DEPT
SET DNAME = '연구부', LOC = '경기'
WHERE DEPTNO = 50;
--==>>1 행 이(가) 업데이트되었습니다.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	연구부	    경기
*/

--○ 롤백
ROLLBACK;
--==>>롤백 완료.

--○ 롤백 수행 후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

--○ 데이터 삭제 (DELETE → TBL_DEPT)
DELETE TBL_DEPT
WHERE DEPTNO = 50;
--> 이거도 가능하지만
--  이렇게 안씀.

--① 조회부터
SELECT *
FROM TBL_DEPT
WHERE DEPTNO = 50;
--==>>50	개발부	서울

--② SELECT * → DELETE로 변경.
--   FROM 절은 생략가능.
DELETE 
FROM TBL_DEPT
WHERE DEPTNO = 50;
--==>>1 행 이(가) 삭제되었습니다.


--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

--○ 롤백
ROLLBACK;
--==>>롤백 완료.

--○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/







