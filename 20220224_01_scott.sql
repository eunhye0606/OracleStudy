SELECT USER
FROM DUAL;
--==>>SCOTT

SELECT DEPTNO, SUM(SAL) -- 그 그룹별로 SUM 반환
FROM EMP
GROUP BY DEPTNO; -- 얘로 먼저 묶고
--==>>
/*
30	9400
20	10875
10	8750
*/

SELECT *
FROM EMP;

SELECT *
FROM TBL_EMP;

--○ 기존에 복사해둔 TBL_EMP 테이블 제거
DROP TABLE TBL_EMP;
--==>>Table TBL_EMP이(가) 삭제되었습니다.
--    CREATE TABLE 권한이랑 같아서 권한 따로 안줘도 삭제되나????????????

--○ 다시 EMP 테이블 복사하여 TBL_EMP 테이블 생성
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>>Table TBL_EMP이(가) 삭제되었습니다.
SELECT *
FROM TBL_EMP;
--○ 실습 데이터 추가 입력(TBL_EMP)
--   기존 테이블 있는 데이터 훼손 안하려고 복사한거고
--   이번엔 데이터바뀜
INSERT INTO TBL_EMP VALUES
( 8001, '홍은혜' , 'CLERK' , 7566, SYSDATE, 1500, 10 , NULL);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_EMP VALUES
( 8002, '김상기' , 'CLERK' , 7566, SYSDATE, 2000, 10 , NULL);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_EMP VALUES
( 8003, '이호석' , 'SALESMAN' , 7698, SYSDATE, 1700, NULL , NULL);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_EMP VALUES
( 8004, '신시은' , 'SALESMAN' , 7698, SYSDATE, 2500, NULL , NULL);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_EMP VALUES
( 8005, '김태형' , 'SALESMAN' , 7698, SYSDATE, 1000, NULL , NULL);
--==>>1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		(null)  20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	    30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	    30
7566	JONES	MANAGER	    7839	1981-04-02	2975	(null)  20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850	(null)	30
7782	CLARK	MANAGER	    7839	1981-06-09	2450	(null)	10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000	(null)	20
7839	KING	PRESIDENT	(null)	1981-11-17	5000	(null)	10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100	(null)	20
7900	JAMES	CLERK	    7698	1981-12-03	950		(null)  30
7902	FORD	ANALYST	    7566	1981-12-03	3000	(null)	20
7934	MILLER	CLERK	    7782	1982-01-23	1300	(null)	10
8001	홍은혜	CLERK	    7566	2022-02-24	1500	10	    (null)
8002	김상기	CLERK	    7566	2022-02-24	2000	10	    (null)
8003	이호석	SALESMAN	7698	2022-02-24	1700	(null)	(null)  
8004	신시은	SALESMAN	7698	2022-02-24	2500	(null)	(null)
8005	김태형	SALESMAN	7698	2022-02-24	1000	(null)	(null)
*/

--○ 커밋
COMMIT;
--==>>커밋 완료.

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
--==>>
/*
20	    800	 (null)   
(null)	1700 (null)	
(null)	1000 (null)	
10	    1300 (null)	
20	    2975 (null)	
30	    2850 (null)	
10	    2450 (null)	
20	    3000 (null)	
10	    5000 (null)	
(null)	2500 (null)	
20	    1100 (null)	
30	    950  (null)	
20	    3000 (null)	
30	    1250  1400
30	    1250  500
30	    1600  300
(null)	1500  10
(null)	2000  10
30	    1500   0
*/

--※ 오라클에서는 NULL을 가장 큰 값의 형태로 간주한다.
--   (ORACLE 9i 까지는 NULL 을 가장 작은 값의 형태로 간주했었다.)
--   MSSQL은 NULL을 가장 작은 값의 형태로 간주한다.

--○ TBL_EMP 테이블을 대상으로 부서별 급여합 조회
--   부서번호, 급여합 항목 조회

SELECT DEPTNO"부서번호",SUM(SAL)
FROM TBL_EMP
GROUP BY DEPTNO
--ORDER BY SUM(SAL);
ORDER BY DEPTNO;
--==>>
/*
10	    8750
20	    10875
30	    9400
(null)	8700
*/
SELECT DEPTNO"부서번호",SUM(SAL)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
(null)	8700    -- 부서번호를 갖지 못한 직원들의 급여합
(null)	37725   -- 모든부서 직원들의 급여합
*/
SELECT 8750+10875+9400+8700
FROM DUAL;
--==>>37725

SELECT DEPTNO"부서번호",SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
(null)	29025
*/
--↓↓↓↓↓↓↓↓
/*
--------    ------
부서번호    급여합
--------    ------
10	        8750
20	        10875
30	        9400
모든부서	29025
--------    ------
*/

SELECT NVL(TO_CHAR(DEPTNO),'모든부서')"부서번호",SUM(SAL)"급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
모든부서	29025
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO),'모든부서')"부서번호",SUM(SAL)"급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--------------------------------------------------------------------------------
SELECT NVL(TO_CHAR(DEPTNO),'모든부서')"부서번호",SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
모든부서	8700
모든부서	37725
*/
SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO),'모든부서')"부서번호",SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
-->> null이 두 개이상이면 『잘못된 정보』제공하게 됨.

SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "부서번호", SUM(SAL)"급여일"
--→ GROUPING() : 그룹으로 묶은걸 총합은 1 , 그룹별로는 0 으로 그룹핑 레벨을 다르게함.
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO); --→ ROLLUP() : 그룹으로 묶은거의 총합도 반환.
--==>>
/*

  GROUPING  부서번호       급여일
---------- ---------- ----------
         0         10       8750
         0         20      10875
         0         30       9400
         0       (null)     8700    -- 인턴
         1       (null)    37725    -- 모든부서
*/

SELECT DEPTNO"부서번호",SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

--○ 위에서 조회한 해당 내용을
/*
10	        8750
20	        10875
30	        9400
인턴	    8700
모든부서	37725
*/

SELECT CASE WHEN GROUPING(DEPTNO) = 0 THEN NVL2(DEPTNO,TO_CHAR(DEPTNO),'인턴')
            WHEN GROUPING(DEPTNO) = 1 THEN '모든부서'
            ELSE '몰라요'
            END "부서번호", SUM(SAL)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
인턴	    8700
모든부서	37725
*/
--> CASE WHEN THEN ELSE END 문 쓸 때!
SELECT CASE GROUPING(DEPTNO) WHEN  0 THEN NVL2(DEPTNO,TO_CHAR(DEPTNO),'인턴')
                             WHEN 1 THEN '모든부서'
                             ELSE '몰라요'
                             END "부서번호"
                             , SUM(SAL)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
---------------------------
    성별          급여합
---------------------------
     남           XXXXXX
     여           XXXXXX
     모든사원     XXXXXX
---------------------------
*/
SELECT *
FROM TBL_SAWON;

SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별
                             WHEN 1 THEN '모든사원'
                             ELSE '알수없음.'
                             END "성별"
        , SUM(T.급여)"급여합"
FROM
(
    SELECT  CASE WHEN SUBSTR(JUBUN,7,1) IN ('1' ,'3') THEN '남'
                 WHEN SUBSTR(JUBUN,7,1) IN ('2' ,'4')THEN '여'
                 ELSE '알수없음'
                 END "성별"
             ,SAL "급여"
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.성별); 
--==>>
/*
성별      급여합
-----    ----------
남         21900
여         32100
모든사원   54000
*/
SELECT *
FROM VIEW_SAWON;
--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 연령대별 인원수를 확인할 수 있는
--   쿼리문을 구성한다.

/*
--------------------------------------
    연령대         인원수
--------------------------------------
    10              X
    20              X
    40              X
    50              X
   전체           XXXX
--------------------------------------
*/
--① 인라인뷰2개
SELECT NVL(TO_CHAR(S.연령대구분),'전체') "연령대"
        , COUNT(S.연령대구분) "인원수"
FROM
(
    SELECT CASE SUBSTR(TO_CHAR(T.나이),1,1) WHEN '1' THEN 10
                                            WHEN '2' THEN 20
                                            WHEN '3' THEN 30
                                            WHEN '4' THEN 40
                                            WHEN '5' THEN 50
                                            ELSE -1
                                            END "연령대구분"
    FROM
    (
            SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-1900+1
                        WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-2000+1
                        ELSE -1 
                        END "나이"
            FROM TBL_SAWON
    )T
)S
GROUP BY ROLLUP(S.연령대구분);

--②인라인뷰 1개
SELECT CASE SUBSTR(TO_CHAR(T.나이),1,1) WHEN '1' THEN 10
                                        WHEN '2' THEN 20
                                        WHEN '3' THEN 30
                                        WHEN '4' THEN 40
                                        WHEN '5' THEN 50
                                        ELSE -1
                                        END "연령대"
     ,COUNT(SUBSTR(TO_CHAR(T.나이),1,1))"인원수"
 FROM
    (
            SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-1900+1
                        WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-2000+1
                        ELSE -1 
                        END "나이"
            FROM TBL_SAWON
    )T
GROUP BY ROLLUP(T.나이);
----------------------------------------------------------------------------------------------
SELECT CASE SUBSTR(TO_CHAR(T.나이),1,1) WHEN '1' THEN 10
                                        WHEN '2' THEN 20
                                        WHEN '3' THEN 30
                                        WHEN '4' THEN 40
                                        WHEN '5' THEN 50
                                        ELSE -1
                                        END "연령대"
     ,COUNT(SUBSTR(TO_CHAR(T.나이),1,1))"인원수"
 FROM
    (
            SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                        THEN SUBSTR(TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-1900+1),1,1)
                        WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                        THEN SUBSTR(TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-2000+1),1,1)
                        ELSE '알수없음' 
                        END "연령대앞자리"
            FROM TBL_SAWON
    )T
GROUP BY ROLLUP(T.나이);
-------------------------------------------------------------------------------------------------------------
SELECT CASE GROUPING(T.연령대앞자리) WHEN 0 THEN TO_CHAR(TO_NUMBER(T.연령대앞자리)*10)
                                            ELSE '전체'
                                            END"연령대"
                                            CASE GROUPING(T.연령대앞자리) WHEN 0 THEN TO_CHAR(TO_NUMBER(T.연령대앞자리)*10)
                                            ELSE '전체'
                                            END "연령대"
        ,CASE GROUPING(T.연령대앞자리) WHEN 0 THEN COUNT(GROUPING(T.연령대앞자리))
                                            ELSE COUNT(GROUPING(T.연령대앞자리))
                                            END"인원수"
                                            
 FROM
    (
            SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                        THEN SUBSTR(TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-1900+1),1,1)
                        WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                        THEN SUBSTR(TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(JUBUN,1,2))-2000+1),1,1)
                        ELSE '알수없음'
                        END "연령대앞자리"
            FROM TBL_SAWON
    )T
GROUP BY ROLLUP(T.연령대앞자리);
--------------------------------------------------------------------------------
-- 해답1. 인라인 뷰 두 번 중첩
/*
SELECT CASE WHEN TO_NUMBER(T1.나이)>= 50 THEN 50
            WHEN TO_NUMBER(T1.나이)>= 40 THEN 40
            WHEN TO_NUMBER(T1.나이)>= 30 THEN 30
            WHEN TO_NUMBER(T1.나이)>= 20 THEN 20
            WHEN TO_NUMBER(T1.나이)>= 10 THEN 10
            ELSE 0
            END "연령대"
FROM
        FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1899)
                    WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1999)
                    ELSE -1
                    END "나이"
        FROM TBL_SAWON
    )T1
GROUP BY ROLLUP(T1.나이);
*/
--------------다시 풀기 -----------
/*
연령대, 인원수
    연령대
        나이
*/
--------------------------------------------------------------------------------
--해답2. 인라인뷰 1개(인라인뷰로 한번에 연령대를 추출해야한다.)
SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대)
                               ELSE '전체'
                               END"연령대"
        ,COUNT(*)"인원수" --CHECK!!!!
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1899)
                WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1999)
                ELSE -1
                END,-1) "연령대"
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.연령대);

--연령대 구하기 힌트!
SELECT TRUNC(21,-1) "결과"
FROM DUAL;

--TRUNC() 전체에 씌우는거 헷갈리니까 THEN에만 씌우자!
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1899),-1)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
            THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)+1999),-1)
            ELSE -1
            END "연령대"
FROM TBL_SAWON;

-------------------------------------------------------------------------------
--※ GROUP BY 기준 하나일 필요는 없다!

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1,2;
--==>>
/*
1차로 부서번호, 부서번호가 같을 때, 직종으로 묶음!
    DEPTNO JOB         SUM(SAL)
---------- --------- ----------
        10 CLERK           1300
        10 MANAGER         2450
        10 PRESIDENT       5000
        20 ANALYST         6000
        20 CLERK           1900
        20 MANAGER         2975
        30 CLERK            950
        30 MANAGER         2850
        30 SALESMAN        5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1,2;
--==>>
/*
10	        CLERK	    1300  -- 10번부서 CLERK 직종의 급여합
10	      MANAGER	    2450  -- 10번부서 MANAGER 직종의 급여합
10	    PRESIDENT	    5000  -- 10번부서 PRESIDENT 직종의 급여합
10	       (null)       8750  -- 10번부서 모든 직종의 급여합 -- CHECK~!!! 
20	      ANALYST	    6000
20	        CLERK	    1900
20	      MANAGER	    2975
20	       (null) 	   10875  -- 20번부서 모든 직종의 급여합 -- CHECK~!!!
30	        CLERK	     950
30	      MANAGER	    2850
30	     SALESMAN	    5600
30	       (null) 	    9400  -- 30번부서 모든 직종의 급여합 -- CHECK~!!!
(null)     (null)      29025  -- 모든 부서 모든 직종의 급여합 --CHECK~!!!
*/

--○ CUBE() → ROLLUP() 보다 더 자세한 결과를 반환받는다.

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1,2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10		(null)      8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20		(null)      10875
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30		(null)      9400
(null)	ANALYST	    6000   -- 모든 부서 ANALYST 직종의 급여합
(null)	CLERK	    4150   -- 모든 부서 CLERK 직종의 급여합
(null)	MANAGER	    8275   -- 모든 부서 MANAGER 직종의 급여합
(null)	PRESIDENT	5000   -- 모든 부서 PRESIDENT 직종의 급여합
(null)	SALESMAN	5600   -- 모든 부서 SALESMAN 직종의 급여합
(null)   (null)		29025  
*/

-- ※ ROLLUP() 과 CUBE()는
--    그룹을 묶어주는 방식이 다르다.(차이)

-- ex.
-- ROLLUP(A, B, C)
-- →(A, B, C) / (A, B) / (A) / ()

--CUBE(A, B, C)
-- → (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> 위에서 사용한 것(ROLLUP())은 묶음 방식이 다소 모자라고
--     아래에서 사용한 것 (CUBE())은 묶음 방식이 다소 지나치기 때문에
--     다음과 같은 방식의 쿼리 형태를 더 많이 사용한다.
--     다음 작성하는 쿼리는 조회하고자 하는 그룹만 『GROUPING SETS』를
--     이용하여 묶어주는 방식이다.

--------------------------------------------------------------------------------
--ROLLUP()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴')
                             ELSE '전체부서'
                             END "부서번호"
                             
       ,CASE GROUPING(JOB) WHEN 0 THEN JOB
                           ELSE '전체직종'
                           END "직종"
       ,SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO,JOB)
ORDER BY 1,2;
/*
부서번호                                     직종       급여합
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       전체직종        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       전체직종       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       전체직종        9400
인턴                                     CLERK           3500
인턴                                     SALESMAN        5200
인턴                                     전체직종        8700
전체부서                                 전체직종       37725
*/
--------------------------------------------------------------------------------
--CUBE()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴')
                             ELSE '전체부서'
                             END "부서번호"
                             
       ,CASE GROUPING(JOB) WHEN 0 THEN JOB
                           ELSE '전체직종'
                           END "직종"
       ,SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO,JOB)
ORDER BY 1,2;
/*
부서번호                                     직종      급여합
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       전체직종        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       전체직종       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       전체직종        9400
인턴                                     CLERK           3500
인턴                                     SALESMAN        5200
인턴                                     전체직종        8700
전체부서                                 ANALYST         6000
전체부서                                 CLERK           7650
전체부서                                 MANAGER         8275
전체부서                                 PRESIDENT       5000
전체부서                                 SALESMAN       10800
전체부서                                 전체직종       37725
*/
--------------------------------------------------------------------------------
--GROUPING SETS()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴')
                             ELSE '전체부서'
                             END "부서번호"
                             
       ,CASE GROUPING(JOB) WHEN 0 THEN JOB
                           ELSE '전체직종'
                           END "직종"
       ,SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO,JOB),(DEPTNO),(JOB),())
ORDER BY 1,2;
/*
부서번호                                     직종      급여합
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       전체직종        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       전체직종       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       전체직종        9400
인턴                                     CLERK           3500
인턴                                     SALESMAN        5200
인턴                                     전체직종        8700
전체부서                                 ANALYST         6000
전체부서                                 CLERK           7650
전체부서                                 MANAGER         8275
전체부서                                 PRESIDENT       5000
전체부서                                 SALESMAN       10800
전체부서                                 전체직종       37725
*/
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴')
                             ELSE '전체부서'
                             END "부서번호"
                             
       ,CASE GROUPING(JOB) WHEN 0 THEN JOB
                           ELSE '전체직종'
                           END "직종"
       ,SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO,JOB),(DEPTNO),())
ORDER BY 1,2;
/*
부서번호                                     직종      급여합
---------------------------------------- --------- ----------
10                                       CLERK           1300
10                                       MANAGER         2450
10                                       PRESIDENT       5000
10                                       전체직종        8750
20                                       ANALYST         6000
20                                       CLERK           1900
20                                       MANAGER         2975
20                                       전체직종       10875
30                                       CLERK            950
30                                       MANAGER         2850
30                                       SALESMAN        5600
30                                       전체직종        9400
인턴                                     CLERK           3500
인턴                                     SALESMAN        5200
인턴                                     전체직종        8700
전체부서                                 전체직종       37725
*/
--------------------------------------------------------------------------------
--실무에서 겪은 문제..

--○ TBL_EMP 테이블을 대상으로
--   입사년도별 인원수를 조회한다.(인원수 총합도)

SELECT HIREDATE
FROM TBL_EMP;

DESC TBL_EMP;

--최종!
SELECT CASE GROUPING(T.입사년도) WHEN 0 THEN T.입사년도
                                 ELSE '전체'
                                 END "입사년도"
    , COUNT(*)"인원수"
FROM
(
    SELECT TO_CHAR(HIREDATE,'YYYY')"입사년도"
    FROM TBL_EMP
)T
GROUP BY ROLLUP(T.입사년도);
/*
입사년도  인원수
----    ----------
1980          1
1981         10
1982          1
1987          2
2022          5
전체         19
*/

--다른 풀이
-- ★
-- GROUP BY랑 SELECT문이랑 같은 타입
-- THEN 뒤랑 ELSE 뒤랑 같은 타입
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
        ,COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
/*
1980	1
1981	10
1982	1
1987	2
2022	5
        19
*/
--------------------------------------------------------------------------------
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
        ,COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;

SELECT TO_CHAR(HIREDATE,'YYYY') "입사년도"
        ,COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--     ORA-00979: not a GROUP BY expression

-- ※ CHECK~!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- GROUP BY절 먼저! SELECT 다음
-- 그룹을 이걸로 묶었으면서 SELECT 에선 다른걸로 뽑아내려하니 에러발생!
-- ROLLUP() , CUBE(), GROUPING SETS(), 안쓰고 GROUP BY만써도!
-- 파싱순서때문이다!
-- SELECT 에서는 GROUP BY에서 수행한 내용으로 조회해야한다!
--------------------------------------------------------------------------------
SELECT TO_CHAR(HIREDATE,'YYYY') "입사년도"
        ,COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2022	5
        19
*/
--------------------------------------------------------------------------------
SELECT CASE GROUPING(TO_CHAR(HIREDATE,'YYYY')) WHEN 0
            THEN  EXTRACT(YEAR FROM HIREDATE)
            ELSE '전체'
            END"입사년도"
            ,COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--     ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
--    THEN 뒤는 숫자타입, ELSE 뒤 문자타입

SELECT CASE GROUPING(TO_CHAR(HIREDATE,'YYYY')) WHEN 0
            THEN  TO_CHAR(HIREDATE,'YYYY')
            ELSE '전체'
            END"입사년도"
            ,COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2022	5
전체	19
*/

SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0
            THEN  EXTRACT(YEAR FROM HIREDATE)
            ELSE -1
            END"입사년도"
            ,COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
-1	    19
1980	1
1981	10
1982	1
1987	2
2022	5
*/
SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0
            THEN  TO_CHAR(EXTRACT(YEAR FROM HIREDATE))
            ELSE '전체'
            END"입사년도"
            ,COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2022	5
전체	19
*/
--------------------------------------------------------------------------------

--■■■ HAVING ■■■--
--○ EMP 테이블에서 부서번호가 20, 30, 인 부서를 대상으로
--   부서의 총 급여가 10000 보다 적을 경우만 부서별 총 급여를 조회한다.
SELECT T.*
FROM
(
    SELECT DEPTNO"부서번호",SUM(SAL)"부서별총급여"
    FROM EMP
    WHERE DEPTNO IN (20, 30)
    GROUP BY DEPTNO
)T
WHERE T.부서별총급여<10000;

-- 해답
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
    AND SUM(SAL)<10000
GROUP BY DEPTNO;
--==>> 에러 발생
--     ORA-00934: group function is not allowed here
--     SUM() : 그룹함수. WHERE 절에서 사용 X


--★ 오라클에서 FROM, WHERE이 먼저 메모리에 퍼올린다.
--   FROM으로 테이블에 접근
--   WHERE에 해당하는거만 메모리에 올린다.
--  그러므로, 오라클에서 더 잘되는건 WHERE 절에서
--  한번 조건 거친거!
--  이런걸 알아야 쿼리를 효율적으로 짠다.
--  프로그래머 보단 DBA한테 ... 
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY DEPTNO
HAVING SUM(SAL)<10000;
--==>>30	9400

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL)<10000 AND DEPTNO IN(20,30);
--==>>30	9400
--------------------------------------------------------------------------------

--■■■ 중첩 그룹함수 / 분석함수■■■--

-- 그룹 함수는 2 LEVEL 까지 중첩해서 사용할 수 있다.
-- 함수(함수()) 까지만 가능하다는 뜻!
-- MSSQL은 이마저도 불가능하다.

SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>>10875
SELECT MIN(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>>8750

--○ RANK()
--   DENSE_RANK()
--> ORACLE 9i 부터 적용... MSSQL 2005 부터 적용...

-- 하위 버전에서는  RANK()나 DENSE_RANK() 를 사용할 수 없기 때문에
-- 예를 들어...급여 순위를 구하고자 한다면
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
-- 확인한 값에 +1 을 추가 연산해 주면
-- 그 값이 곧 해당 사원의 급여 등수가 된다.

SELECT ENAME, SAL
FROM EMP;
--==>>
/*
SMITH	800
ALLEN	1600
WARD	1250
JONES	2975
MARTIN	1250
BLAKE	2850
CLARK	2450
SCOTT	3000
KING	5000
TURNER	1500
ADAMS	1100
JAMES	950
FORD	3000
MILLER	1300
*/

--○ SMITH 의 급여 등수 확인
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL> 800; -- SMITH의 급여
--==>>14        -- SMITH의 급여 등수

--○ ALLEN 의 급여 등수 확인
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL> 1600; -- ALLEN의 급여
--==>>7          -- ALLEN의 급여 등수

--※ 서브 상관 쿼리(상관 서브 쿼리)
--   (RANK() 쓴 것처럼 안에 들어간 형태로 쿼리 구성 가능.)
--   메인 쿼리가 있는 테이블이 컬럼이
--   서브 쿼리의 조건절(WHERE절, HAVING절)에 사용되는 경우
--   우리는 이 쿼리문을 서브 상관 쿼리(상관 서브 쿼리)라고 부른다.

SELECT ENAME "사원명", SAL"급여",1"급여등수"
FROM EMP;
--==>>
/*
SMITH	 800	1
ALLEN	1600	1
WARD	1250	1
JONES	2975	1
MARTIN	1250	1
BLAKE	2850	1
CLARK	2450	1
SCOTT	3000	1
KING	5000	1
TURNER	1500	1
ADAMS	1100	1
JAMES	 950	1
FORD	3000	1
MILLER	1300	1
*/

SELECT ENAME "사원명", SAL"급여",(SELECT COUNT(*) + 1 FROM EMP WHERE SAL> 800)"급여등수"
FROM EMP;
--==>>
/*
SMITH	 800	14
ALLEN	1600	14
WARD	1250	14
JONES	2975	14
MARTIN	1250	14
BLAKE	2850	14
CLARK	2450	14
SCOTT	3000	14
KING	5000	14
TURNER	1500	14
ADAMS	1100	14
JAMES	 950	14
FORD	3000	14
MILLER	1300	14
*/
-- 밖에있는 쿼리가 메인쿼리!
SELECT ENAME "사원명", SAL"급여"
        ,(SELECT COUNT(*) + 1 
          FROM EMP 
          WHERE SAL> E.SAL)"급여등수"
FROM EMP E;
--==>>
/*
SMITH	 800	14
ALLEN	1600	7
WARD	1250	10
JONES	2975	4
MARTIN	1250	10
BLAKE	2850	5
CLARK	2450	6
SCOTT	3000	2
KING	5000	1
TURNER	1500	8
ADAMS	1100	12
JAMES	 950	13
FORD	3000	2
MILLER	1300	9
*/
--------------------------------------------------------------------------------
--○ EMP 테이블을 대상으로
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목을 조회한다.
--   단, RANK() 함수를 사용하지 않고 서브상관쿼리를 활용할 수 있도록 한다.

SELECT ENAME"사원명", SAL"급여",DEPTNO"부서번호"
       ,CASE DEPTNO WHEN 10 
                    THEN (SELECT COUNT(*) + 1
                          FROM EMP
                          WHERE SAL>E.SAL AND DEPTNO =10)
                    WHEN 20
                    THEN (SELECT COUNT(*) + 1
                          FROM EMP
                          WHERE SAL>E.SAL AND DEPTNO =20)
                    WHEN 30
                    THEN (SELECT COUNT(*) + 1
                          FROM EMP
                          WHERE SAL>E.SAL AND DEPTNO =30)
                    ELSE -1
                    END"부서내급여등수"
       ,(SELECT COUNT(*) + 1
         FROM EMP
         WHERE SAL > E.SAL)"전체급여등수"
FROM EMP E
ORDER BY DEPTNO;    
--==>>
/*
사원명      급여       부서번호  부서내급여등수    전체급여등수
---------- ---------- ----------   ----------       ----------
CLARK            2450         10          2          6
KING             5000         10          1          1
MILLER           1300         10          3          9
JONES            2975         20          3          4
FORD             3000         20          1          2
ADAMS            1100         20          4         12
SMITH             800         20          5         14
SCOTT            3000         20          1          2
WARD             1250         30          4         10
TURNER           1500         30          3          8
ALLEN            1600         30          2          7
JAMES             950         30          6         13
BLAKE            2850         30          1          5
MARTIN           1250         30          4         10
*/
--해답
SELECT ENAME"사원명", SAL"급여",DEPTNO"부서번호"
       ,(SELECT COUNT(*) + 1
         FROM EMP
         WHERE SAL>E.SAL AND DEPTNO =E.DEPTNO)"부서내급여등수"
         
       ,(SELECT COUNT(*) + 1
         FROM EMP
         WHERE SAL > E.SAL)"전체급여등수"
FROM EMP E
ORDER BY DEPTNO; 
--------------------------------------------------------------------------------
--1.부서내급여등수
--  10번 부서에서 123등
--  20번 부서에서 123등
--  30번 부서에서 123등

SELECT COUNT(*) + 1
FROM EMP
WHERE (DEPTNO = 10 AND SAL>800)
       OR (DEPTNO = 20 AND SAL>800)
       OR (DEPTNO = 30 AND SAL>800);

SELECT COUNT(*) + 1
FROM EMP
WHERE DEPTNO = 20 AND SAL>800;

SELECT COUNT(*) + 1
FROM EMP
WHERE DEPTNO = 30 AND SAL>800;
--2.전체급여등수

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
--------------------------------------------------------------------------------

--○ EMP 테이블을 대상으로 다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
--------------------------------------------------------------------------------
--  사원명  부서번호  입사일       급여  부서내입사별급여누적
--------------------------------------------------------------------------------
--                               :
--  SMITH      20      1980-12-17         800                   800
--  JONES      20      1981-04-02        2975                  3775  
--  FORD       20      1981-12-03        3000                  6775
--------------------------------------------------------------------------------

SELECT ENAME"사원명", DEPTNO"부서번호"
      ,HIREDATE"입사일"
      ,SAL"급여"
      ,(SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E.DEPTNO AND HIREDATE <=E.HIREDATE
        GROUP BY DEPTNO)"부서내입사별급여누적"
FROM EMP E
ORDER BY DEPTNO, HIREDATE;
--==>>
/*
사원명     부서번호    입사일    급여       부서내입사별급여누적
---------- ---------- ---------- ---------- --------------------
CLARK              10 1981-06-09       2450       2450
KING               10 1981-11-17       5000       7450
MILLER             10 1982-01-23       1300       8750
SMITH              20 1980-12-17        800        800
JONES              20 1981-04-02       2975       3775
FORD               20 1981-12-03       3000       6775
SCOTT              20 1987-07-13       3000      10875
ADAMS              20 1987-07-13       1100      10875
ALLEN              30 1981-02-20       1600       1600
WARD               30 1981-02-22       1250       2850
BLAKE              30 1981-05-01       2850       5700
TURNER             30 1981-09-08       1500       7200
MARTIN             30 1981-09-28       1250       8450
JAMES              30 1981-12-03        950       9400
---------- ---------- ---------- ---------- --------------------
*/


--부서내입사별급여누적
-- 부서별
--       입사일이 빠른 순서대로
--                             SAL항목 SUM...

SELECT ENAME, HIREDATE,SAL,DEPTNO
FROM EMP
WHERE DEPTNO = 10
ORDER BY HIREDATE;

--해답..
--1.
SELECT EMP.ENAME"사원명", DEPTNO"부서번호", HIREDATE"입사일", SAL"급여"
        , (1)"부서내입사별급여누적"
FROM SCOTT.EMP
ORDER BY 2,3;

--2.
SELECT E1.ENAME"사원명", E1.DEPTNO"부서번호", E1.HIREDATE"입사일", E1.SAL"급여"
        , (1)"부서내입사별급여누적"
FROM EMP E1
ORDER BY 2,3;

--3.
SELECT E1.ENAME"사원명", E1.DEPTNO"부서번호", E1.HIREDATE"입사일", E1.SAL"급여"
        , (SELECT SUM(E2.SAL)
           FROM EMP E2)"부서내입사별급여누적"
FROM EMP E1
ORDER BY 2,3;

--4.
SELECT E1.ENAME"사원명", E1.DEPTNO"부서번호", E1.HIREDATE"입사일", E1.SAL"급여"
        , (SELECT SUM(E2.SAL)
           FROM EMP E2
           WHERE E2.DEPTNO = E1.DEPTNO
                 AND E2.HIREDATE <= E1.HIREDATE )"부서내입사별급여누적"
FROM EMP E1
ORDER BY 2,3;
--------------------------------------------------------------------------------

--○ EMP 테이블을 대상으로
--   입사한 사원의 수가 가장 많았을 때의
--   입사년월과 인원수를 조회할 수 있도록 쿼리문을 구성한다.

SELECT EXTRACT(YEAR FROM HIREDATE)
FROM EMP;
-- 년도
SELECT EXTRACT(MONTH FROM HIREDATE)
FROM EMP;
--월

SELECT (SELECT (TO_CHAR(E.3HIREDATE,'YYYY') || TO_CHAR(HIREDATE,'MM')
        FROM EMP E3
        WHERE COUNT((EXTRACT(YEAR FROM E3.HIREDATE) = EXTRACT(YEAR FROM E1.HIREDATE))
              AND (EXTRACT(MONTH FROM E3.HIREDATE) = EXTRACT(MONTH FROM E1.HIREDATE))) = 2)"입사년월"
              
        ,(MAX((SELECT COUNT(*)
         FROM EMP E2
         WHERE EXTRACT(YEAR FROM E2.HIREDATE) = EXTRACT(YEAR FROM E1.HIREDATE)
               AND EXTRACT(MONTH FROM E2.HIREDATE) = EXTRACT(MONTH FROM E1.HIREDATE))))"인원수"
FROM EMP E1
ORDER BY 1;


SELECT (TO_CHAR(HIREDATE,'YYYY') || TO_CHAR(HIREDATE,'MM'))"입사년월"
FROM EMP E1
ORDER BY 1;

SELECT (SELECT (TO_CHAR(E.3HIREDATE,'YYYY') || TO_CHAR(HIREDATE,'MM')
        FROM EMP E3
        WHERE COUNT((EXTRACT(YEAR FROM E3.HIREDATE) = EXTRACT(YEAR FROM E1.HIREDATE))
              AND (EXTRACT(MONTH FROM E3.HIREDATE) = EXTRACT(MONTH FROM E1.HIREDATE))) = 2)"입사년월"
FROM EMP E1
ORDER BY 1;

SELECT (SELECT (TO_CHAR(E.3HIREDATE,'YYYY') || TO_CHAR(HIREDATE,'MM')
        FROM EMP E3
        WHERE COUNT(SAL>800))"입사년월"
FROM EMP E1
ORDER BY 1;


-- 해답
--1. COUNT(*) 좀 써라! HAVING 좀 써라!!
SELECT TO_CHAR(HIREDATE,'YYYY-MM')"입사년월"
       ,COUNT(*) "인원수"
FROM EMP E1
GROUP BY TO_CHAR(HIREDATE,'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM EMP
                   GROUP BY TO_CHAR(HIREDATE,'YYYY-MM'))             
ORDER BY 1;
--==>> 최종!
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

--2. 인원수가 MAX인거
SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY-MM');
