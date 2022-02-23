SELECT USER
FROM DUAL;
--==>>SCOTT

--○ TBL_SAWON 테이블을 활용하여 
--   다음과 같은 항목들을 조회할 수 있도록 쿼리문을 구성한다.
--   사원번호, 사원명, 주민번호, 성별, 입사일
SELECT SANO "사원번호", SNAME"사원명",JUBUN"주민번호"
,CASE WHEN MOD(TO_NUMBER(SUBSTR(JUBUN,7,1)),2) = 0 THEN '여'
             WHEN MOD(TO_NUMBER(SUBSTR(JUBUN,7,1)),2) != 0 THEN '남'
             ELSE '알수없음'
             END"성별"
             , HIREDATE"입사일"
FROM TBL_SAWON;
--==>>
/*
1001	김민성	    9707251234567	남	2005-01-03 00:00:00
1002	서민지	    9505152234567	여	1999-11-23 00:00:00
1003	이지연	    9905192234567	여	2006-08-10 00:00:00
1004	이연주	    9508162234567	여	2007-10-10 00:00:00
1005	오이삭	    9805161234567	남	2007-10-10 00:00:00
1006	이현이	    8005132234567	여	1999-10-10 00:00:00
1007	박한이	    0204053234567	남	2010-10-10 00:00:00
1010	선우선	    0303044234567	여	2010-10-10 00:00:00
1011	남주혁	    0506073234567	남	2012-10-10 00:00:00
1013	남진	    6712121234567	남	1998-10-10 00:00:00
1014	홍수민	    0005044234567	여	2015-10-10 00:00:00
1015	임소민	    9711232234567	여	2007-10-10 00:00:00
1009	선우용녀	6912232234567	여	1998-10-10 00:00:00
1012	남궁민	    0208073234567	남	2012-10-10 00:00:00
1008	선동렬	    6803171234567	남	1998-10-10 00:00:00
1016	이이경	    0603194234567	여	2015-01-02 00:00:00
*/

SELECT SANO "사원번호", SNAME"사원명",JUBUN"주민번호"
,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남성'
      WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여성'
             ELSE '성별 확인 불가'
             END"성별"
             , HIREDATE"입사일"
FROM TBL_SAWON;


--○ TBL_SAWON 테이블을 활용하여
--   다음과 같은 항목을 조회할 수 있도록 쿼리문을 구성한다.
--   『사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--     정년퇴직일, 근무일수, 남은일수, 급여, 보너스』
--   단, 현재나이는 기본 한국나이 계산법에 따라 연산을 수행한다.
--   또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해의
--   그 직원의 입사 월, 일로 연산을 수행한다.
--   그리고, 보너스는 1000일 이상 2000일 미만 근무한 사원은
--   그 사원의 원래 급여 기준 30% 지급, 2000일 이상 근무한 사원은
--   그 사원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.

--ex) 1001 김민성 9707251234567 남성 26 2005-01-03 2056-01-03 213123 3123132 3000 4500 

SELECT SANO"사원번호", SNAME"사원명", JUBUN"주민번호"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남성'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여성'
            ELSE '성별알수없음'
            END "성별"
     , CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1) 
            ELSE ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1)
            END || '세'"현재나이"
     , HIREDATE"입사일"
     ,CASE WHEN TO_DATE((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN ADD_MONTHS(TO_DATE(HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365 --여기서 틀림 입사년도에 더하는게 아니라 SYSDATE의 YEAR에 더하고
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)),(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')))*12)     -- 입사월일 가져오기임!
            
            ELSE ADD_MONTHS(TO_DATE(HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)),(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')))*12)
            END"정년퇴직일"
     ,TRUNC(SYSDATE - HIREDATE) || '일' "근무일수"
     , CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  
                CASE WHEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)
                  -SYSDATE))) >0
                     THEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)
                  -SYSDATE)))
                     ELSE 0
                     END
            WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)>=100
            THEN 
                CASE WHEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)
                  -SYSDATE))) > 0
                  THEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)
                  -SYSDATE)))
                  ELSE 0
                  END
            END"남은일수"
     , SAL"급여"
     , CASE WHEN TRUNC(SYSDATE - HIREDATE)>=1000 AND TRUNC(SYSDATE - HIREDATE)<2000 
            THEN SAL*0.3
            WHEN TRUNC(SYSDATE - HIREDATE)>=2000
            THEN SAL*0.5
            ELSE 0
            END "보너스"
FROM TBL_SAWON;
--------------------------------------------------------------------------------
--1. 성별
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남성'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여성'
            ELSE '성별알수없음'
            END "성별"
FROM TBL_SAWON;

--2. 현재나이
SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1) 
            ELSE ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1)
            END"현재나이"
FROM TBL_SAWON;

--   또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해의
--   그 직원의 입사 월, 일로 연산을 수행한다.
--3. 정년퇴직일
SELECT TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')),2005+34
FROM TBL_SAWON;


SELECT HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400)
FROM TBL_SAWON;

SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)) 
            ELSE (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))
            END"정년퇴직일"
FROM TBL_SAWON;

SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  (TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')) + (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                +(TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')) + (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)
            ELSE  TO_NUMBER(TO_CHAR(HIREDATE,'YYYY')) + (60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))
            END"정년퇴직일"
FROM TBL_SAWON;

SELECT SNAME, HIREDATE,
      CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400)
            
            ELSE  HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/400)
            END"정년퇴직일"
            ,CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1) 
            ELSE ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1)
            END"현재나이"
FROM TBL_SAWON;
--윤년일때 366 , 평년이면 365(최종!)
SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400)
            
            ELSE  HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/400)
            END"정년퇴직일"
FROM TBL_SAWON;

SELECT 2022/(2022-1)
FROM DUAL;

--4.근무일수
SELECT TRUNC(SYSDATE - HIREDATE) || '일' "근무일수"
FROM TBL_SAWON;

--5.남은일수
SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400))
                  -SYSDATE)
            
            WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)>=100
            THEN TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/400))
                  -SYSDATE)
            END"남은일수"
FROM TBL_SAWON;


SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/400))
                  -SYSDATE)
            
            WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)>=100
            THEN TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4
                  -((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/100
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/400))
                  -SYSDATE)
            END"남은일수"
FROM TBL_SAWON;

--   그리고, 보너스는 1000일 이상 2000일 미만 근무한 사원은
--   그 사원의 원래 급여 기준 30% 지급, 2000일 이상 근무한 사원은
--   그 사원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.
--6.보너스
SELECT CASE WHEN TRUNC(SYSDATE - HIREDATE)>=1000 AND TRUNC(SYSDATE - HIREDATE)<2000 
            THEN SAL*0.3
            WHEN TRUNC(SYSDATE - HIREDATE)>=2000
            THEN SAL*0.5
            ELSE 0
            END "보너스"
FROM TBL_SAWON;

--남은일수 음수처리
SELECT CASE WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)<100
            THEN  
                CASE WHEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)
                  -SYSDATE))) >0
                     THEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1))-1)/4)
                  -SYSDATE)))
                     ELSE 0
                     END
            WHEN ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-1900+1)>=100
            THEN 
                CASE WHEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)
                  -SYSDATE))) > 0
                  THEN (TRUNC((HIREDATE +(((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)*365
                  +((60 - ((TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(SUBSTR(JUBUN,1,2)))-2000+1))-1)/4)
                  -SYSDATE)))
                  ELSE 0
                  END
            END"남은일수"
FROM TBL_SAWON;
------------------------------------------------------------------------------------
--해답
--   『사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--     정년퇴직일, 근무일수, 남은일수, 급여, 보너스』

--①사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여... 먼저
SELECT SANO "사원번호", SNAME"사원명",JUBUN"주민번호"
        -- 성별
        ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남성'
              WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여성'
              ELSE '성별확인불가'
              END "성별"
        -- 현재나이 = 현재년도 - 태어난도 + 1(1900년대/2000년대)
        ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
              THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
              WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE -1 -- CEHCK~!!!
              END "현재나이"
        --입사일
        ,HIREDATE"입사일"
        --급여
        ,SAL"급여"
FROM TBL_SAWON;
--------------------------------------------------------------------------------
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0)"연봉",연봉 *2"두배연봉"
FROM EMP;
--==>> 에러 발생
--     ORA-00904: "연봉": invalid identifier

SELECT T.EMPNO, T.ENAME, T.SAL, T.연봉, T.연봉*2 "두배연봉"
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0)"연봉"
    FROM EMP
) T; --별칭

SELECT T.* --ALL가능.
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0)"연봉"
    FROM EMP
) T; --별칭
--------------------------------------------------------------------------------
--FROM절에서 쓰는 인라인뷰! 서브쿼리!
-- 답!! 최종!!
--   『사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--     정년퇴직일, 근무일수, 남은일수, 급여, 보너스』
--①사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여... 먼저
--②정년퇴직일, 근무일수, 남은일수, 급여, 보너스
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일

        -- 정년퇴직일
        -- 정년퇴직년도 → 해당 직원의 나이가 한국나이로 60세가 되는 해
        -- 현재 나이가 ... 57세...  3년 후       2022 → 2025
        -- 현재 나이가 ... 28세... 32년 후       2022 → 2054
        -- ADD_MONTHS(SYSDATE,남은년수*12) 대박 이걸 생각못했네 ㅠ
        --                     -------
        --                     60 - 현재나이
        
        -- ADD_MONTHS(SYSDATE,(60 - 현재나이)*12) → 특정날짜(날짜타입)
        -- TO_CHAR('특정날짜','YYYY')        → 정년퇴직 년도만 문자타입으로 추출
        -- TO_CHAR(입사일,'MM-DD')           → 입사 월일만 문자타입으로 추출
        ,TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD') "정년퇴직일"
        
        -- 근무일수
        -- 근무일수 = 현재일 - 입사일
        ,TRUNC(SYSDATE - T.입사일)"근무일수"
        
        -- 남은일수
        -- 남은일수 = 정년퇴직일 - 현재일
        ,TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD')) - SYSDATE) "남은일수"
        --급여
        ,T.급여
        
        -- 보너스
        -- 근무일수가 1000일 이상 2000일 미만 → 원래 급여의 30% 지급
        -- 근무일수가 2000일 이상             → 원래 급여의 50% 지급
        -- 나머지                             → 0
        --------------------------------------------------------------
        -- 근무일수 2000일 이상               → T.급여 * 0.5
        -- 근무일수 1000일 이상               → T.급여 * 0.3
        -- ELSE                               → 0
        --------------------------------------------------------------
        ,CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000
              THEN T.급여 * 0.5
              WHEN TRUNC(SYSDATE - T.입사일) >= 1000
              THEN T.급여 * 0.3
              ELSE 0
              END "보너스" 
FROM 
(
    SELECT SANO "사원번호", SNAME"사원명",JUBUN"주민번호"
            -- 성별
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남성'
                  WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여성'
                  ELSE '성별확인불가'
                  END "성별"
            -- 현재나이 = 현재년도 - 태어난도 + 1(1900년대/2000년대)
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                  THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                  WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                  ELSE -1 -- CEHCK~!!!
                  END "현재나이"
            --입사일
            ,HIREDATE"입사일"
            --급여
            ,SAL"급여"
    FROM TBL_SAWON
)T;
--==>>
/*
1001	김민성	    9707251234567	남성	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	서민지	    9505152234567	여성	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	이지연	    9905192234567	여성	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	이연주	    9508162234567	여성	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	    9805161234567	남성	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	이현이	    8005132234567	여성	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	박한이	    0204053234567	남성	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1010	선우선	    0303044234567	여성	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	남주혁	    0506073234567	남성	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1013	남진	    6712121234567	남성	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	홍수민	    0005044234567	여성	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	    9711232234567	여성	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1009	선우용녀	6912232234567	여성	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1012	남궁민	    0208073234567	남성	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1008	선동렬	    6803171234567	남성	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1016	이이경	    0603194234567	여성	17	2015-01-02	2065-01-02	2609	15653	1500	 750
*/

--○TBL_SAWON 테이블에 데이터 추가 입력
INSERT INTO TBL_SAWON(SANO,SNAME,JUBUN,HIREDATE,SAL)
VALUES(1017,'이호석','9611121234567',SYSDATE,5000);
--==>>1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_SAWON;

--커밋
COMMIT;
--==>>커밋 완료.

SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
        ,TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD') "정년퇴직일"
        ,TRUNC(SYSDATE - T.입사일)"근무일수"
        ,TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD')) - SYSDATE) "남은일수"
        ,T.급여
        ,CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000
              THEN T.급여 * 0.5
                  WHEN TRUNC(SYSDATE - T.입사일) >= 1000
              THEN T.급여 * 0.3
              ELSE 0
              END "보너스" 
FROM 
(
    SELECT SANO "사원번호", SNAME"사원명",JUBUN"주민번호"
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남성'
                  WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여성'
                  ELSE '성별확인불가'
                  END "성별"
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                  THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                  WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                  ELSE -1 -- CEHCK~!!!
                  END "현재나이"
            ,HIREDATE"입사일"
            ,SAL"급여"
    FROM TBL_SAWON
)T; 
--> 이 쿼리문은 오라클에 저장되지 않는다.
--==>>
/*
1001	김민성	    9707251234567	남성	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	서민지	    9505152234567	여성	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	이지연	    9905192234567	여성	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	이연주	    9508162234567	여성	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	    9805161234567	남성	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	이현이	    8005132234567	여성	43	1999-10-10	2039-10-10	8172	6437	1000	500
1007	박한이	    0204053234567	남성	21	2010-10-10	2061-10-10	4154	14473	1000	500
1010	선우선	    0303044234567	여성	20	2010-10-10	2062-10-10	4154	14838	1600	800
1011	남주혁	    0506073234567	남성	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1013	남진	    6712121234567	남성	56	1998-10-10	2026-10-10	8537	1689	2200	1100
1014	홍수민	    0005044234567	여성	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	    9711232234567	여성	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1009	선우용녀	6912232234567	여성	54	1998-10-10	2028-10-10	8537	2420	1300	650
1012	남궁민	    0208073234567	남성	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1008	선동렬	    6803171234567	남성	55	1998-10-10	2027-10-10	8537	2054	1500	750
1016	이이경	    0603194234567	여성	17	2015-01-02	2065-01-02	2609	15653	1500	750
1017	이호석	    9611121234567	남성	27	2022-02-23	2055-02-23	0	    12052	5000	0
*/
-- 위에서 처리한 내용을 기반으로
-- 특정 근무일수의 사원을 확인해야 한다거나...
-- 특정 보너스 금액을 받는 사원을 확인해야할 경우가 발생할 수 있다.
-- 이와 같은 경우... 해당 쿼리문을 다시 구성해야 하는 번거러움을 줄일 수 있도록
-- 뷰(VIEW)를 만들어 저장해 둘 수 있다.

CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
        ,TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD') "정년퇴직일"
        ,TRUNC(SYSDATE - T.입사일)"근무일수"
        ,TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD')) - SYSDATE) "남은일수"
        ,T.급여
        ,CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000
              THEN T.급여 * 0.5
                  WHEN TRUNC(SYSDATE - T.입사일) >= 1000
              THEN T.급여 * 0.3
              ELSE 0
              END "보너스" 
FROM 
(
    SELECT SANO "사원번호", SNAME"사원명",JUBUN"주민번호"
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남성'
                  WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여성'
                  ELSE '성별확인불가'
                  END "성별"
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                  THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                  WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                  ELSE -1 -- CEHCK~!!!
                  END "현재나이"
            ,HIREDATE"입사일"
            ,SAL"급여"
    FROM TBL_SAWON
)T; 
--==>> 에러 발생(권한 불충분)
--     ORA-01031: insufficient privileges 


--※ 테이블만들기랑 VIEW만들기 차이점.
CREATE TABLE TBL_SAWON
--> 기존에 같은 이름의 테이블이 있으면
--  못만들어요 ~~
CREATE OR REPLACE TABLE TBL_SAWON
--> 이렇게 쿼리 못짜.

CREATE OR REPLACE VIEW VIEW_SAWON
--> OR REPLACE : VIEW_SAWON 있어도 새롭게 덮어씀.


--○ SYS로 부터 CREATE VIEW 권한을 부여받은 이후 다시 실행
CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
        ,TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD') "정년퇴직일"
        ,TRUNC(SYSDATE - T.입사일)"근무일수"
        ,TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD')) - SYSDATE) "남은일수"
        ,T.급여
        ,CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000
              THEN T.급여 * 0.5
                  WHEN TRUNC(SYSDATE - T.입사일) >= 1000
              THEN T.급여 * 0.3
              ELSE 0
              END "보너스" 
FROM 
(
    SELECT SANO "사원번호", SNAME"사원명",JUBUN"주민번호"
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남성'
                  WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여성'
                  ELSE '성별확인불가'
                  END "성별"
            ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                  THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                  WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                  ELSE -1 -- CEHCK~!!!
                  END "현재나이"
            ,HIREDATE"입사일"
            ,SAL"급여"
    FROM TBL_SAWON
)T;
--==>>View VIEW_SAWON이(가) 생성되었습니다.

SELECT *
FROM VIEW_SAWON;


--○ VIEW 생성 이후 TBL_SAWON 테이블에 데이터 추가 입력
INSERT INTO TBL_SAWON(SANO,SNAME,JUBUN,HIREDATE, SAL)
VALUES(1018, '신시은','9910312234567',SYSDATE,5000);
--==>>1 행 이(가) 삽입되었습니다.

SELECT*
FROM VIEW_SAWON;
--==>>
/*
1001	김민성	    9707251234567	남성	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	서민지	    9505152234567	여성	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	이지연	    9905192234567	여성	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	이연주	    9508162234567	여성	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	    9805161234567	남성	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	이현이	    8005132234567	여성	43	1999-10-10	2039-10-10	8172	6437	1000	500
1007	박한이	    0204053234567	남성	21	2010-10-10	2061-10-10	4154	14473	1000	500
1010	선우선	    0303044234567	여성	20	2010-10-10	2062-10-10	4154	14838	1600	800
1011	남주혁	    0506073234567	남성	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1013	남진	    6712121234567	남성	56	1998-10-10	2026-10-10	8537	1689	2200	1100
1014	홍수민	    0005044234567	여성	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	    9711232234567	여성	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1009	선우용녀	6912232234567	여성	54	1998-10-10	2028-10-10	8537	2420	1300	650
1012	남궁민	    0208073234567	남성	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1008	선동렬	    6803171234567	남성	55	1998-10-10	2027-10-10	8537	2054	1500	750
1016	이이경	    0603194234567	여성	17	2015-01-02	2065-01-02	2609	15653	1500	750
1017	이호석	    9611121234567	남성	27	2022-02-23	2055-02-23	0	    12052	5000	0
1018	신시은	    9910312234567	여성	24	2022-02-23	2058-02-23	0	    13148	5000	0
*/


--○ 서브쿼리를 활용하여
--   TBL_SAWON 테이블을 다음과 같이 조회할 수 있도록 한다.
/*
------------------------------------------------------
사원명 성별 현재나이 급여 나이보너스
------------------------------------------------------
단, 나이 보너스는 현재 나이가 50세 이상이면 급여의 70%
    40세 이상 50세 미만 급여의 50%
    20세 이상 40세 미만이면 급여의 30%로 한다.

또한, 완성된 조회 구문을 통해
VIEW_SAWON2 라는 이름의 뷰(VIEW)를 생성한다.
*/
CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.사원명, T.성별, T.현재나이, T.급여
       ,CASE WHEN T.현재나이 >= 50 THEN T.급여*0.7
             WHEN T.현재나이 >= 40 THEN T.급여*0.5
             WHEN T.현재나이 >= 20 THEN T.급여*0.3
             ELSE -1
             END "나이보너스"
FROM
(
    SELECT SNAME"사원명"
           ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남성'
                 WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여성'
                 ELSE '성별알수없음.'
                 END "성별"
           ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-(TO_NUMBER(SUBSTR(JUBUN,1,2))+1900-1) 
                 WHEN SUBSTR(JUBUN,7,1) IN ('3','4') THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-(TO_NUMBER(SUBSTR(JUBUN,1,2))+2000-1)
                 ELSE -1 
                 END "현재나이"
            ,SAL"급여"
    FROM TBL_SAWON
)T;
--==>>View VIEW_SAWON2이(가) 생성되었습니다.

--○ 생성한 뷰(VIEW) 확인(조회)
SELECT *
FROM VIEW_SAWON2;
--==>>
/*
김민성	    남성	26	3000	900
서민지	    여성	28	4000	1200
이지연	    여성	24	3000	900
이연주	    여성	28	4000	1200
오이삭	    남성	25	4000	1200
이현이	    여성	43	1000	500
박한이	    남성	21	1000	300
선우선	    여성	20	1600	480
남주혁	    남성	18	2600	-1
남진	    남성	56	2200	1540
홍수민	    여성	23	5200	1560
임소민	    여성	26	5500	1650
선우용녀	여성	54	1300	910
남궁민	    남성	21	2600	780
선동렬	    남성	55	1500	1050
이이경	    여성	17	1500	-1
이호석	    남성	27	5000	1500
신시은	    여성	24	5000	1500
*/
--------------------------------------------------------------------------------

--○ RANK() → 등수(순위)를 반환하는 함수

SELECT EMPNO"사원번호",ENAME"사원명",DEPTNO"부서번호",SAL"급여"
        ,RANK() OVER(ORDER BY SAL DESC)"전체급여순위" --RANK가 등수를 메길 수 있도록 데이터를 넘겨준다.
                                                      --같은 급여 같은 등수. 
FROM EMP;
--==>>
/*
7839	KING	10	5000	1
7902	FORD	20	3000	2
7788	SCOTT	20	3000	2
7566	JONES	20	2975	4
7698	BLAKE	30	2850	5
7782	CLARK	10	2450	6
7499	ALLEN	30	1600	7
7844	TURNER	30	1500	8
7934	MILLER	10	1300	9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	950	    13
7369	SMITH	20	800	    14
*/

SELECT EMPNO"사원번호",ENAME"사원명",DEPTNO"부서번호",SAL"급여"
        ,RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)"부서별급여순위"
                     -- 분할하겠다 ~의해 부서번호, 정렬한다 급여 내림차순
        ,RANK() OVER(ORDER BY SAL DESC)"전체급여순위"  
FROM EMP;
-- 파티션: 하드디스크를 논리적인 저장공간을 나눠서 쓴다, 회사 파티션..
--==>>
/*
7839	KING	10	5000	1	1
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	3	4
7698	BLAKE	30	2850	1	5
7782	CLARK	10	2450	2	6
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7934	MILLER	10	1300	3	9
7521	WARD	30	1250	4	10
7654	MARTIN	30	1250	4	10
7876	ADAMS	20	1100	4	12
7900	JAMES	30	950	    6	13
7369	SMITH	20	800	    5	14
*/
SELECT EMPNO"사원번호",ENAME"사원명",DEPTNO"부서번호",SAL"급여"
        ,RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)"부서별급여순위"
                     -- 분할하겠다 ~의해 부서번호, 정렬한다 급여 내림차순
        ,RANK() OVER(ORDER BY SAL DESC)"전체급여순위"  
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	6
7934	MILLER	10	1300	3	9
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	3	4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	800	    5	14
7698	BLAKE	30	2850	1	5
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	950	    6	13
*/

--○ DENSE_RANK() → 서열을 반환하는 함수
SELECT EMPNO"사원번호",ENAME"사원명",DEPTNO"부서번호",SAL"급여"
        ,DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)"부서별급여순위"
                     -- 분할하겠다 ~의해 부서번호, 정렬한다 급여 내림차순
        ,DENSE_RANK() OVER(ORDER BY SAL DESC)"전체급여순위"  
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	5
7934	MILLER	10	1300	3	8
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	2	3  → 3등이 아니라 2등
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	    4	12
7698	BLAKE	30	2850	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	4	9
7521	WARD	30	1250	4	9
7900	JAMES	30	950	    5	11 → 6등이 아니라 5등
*/

--○ EMP 테이블의 사원 데이터를 
--   사원명, 부서번호, 연봉, 부서내연봉순위, 전체연봉순위 항목으로 조회한다.
--   단, 여기에서 연봉은 앞서 구성했던 연봉의 정책과 동일하다.

SELECT T.사원명, T.부서번호, T.연봉
      ,RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC) "부서내연봉순위"
      ,RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위"
FROM
(
    SELECT ENAME"사원명", DEPTNO"부서번호",SAL*12+NVL(COMM,0)"연봉"
    FROM EMP
)T
ORDER BY T.부서번호;
--==>>
/*
KING	10	60000	1	1
CLARK	10	29400	2	6
MILLER	10	15600	3	10
FORD	20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
ADAMS	20	13200	4	12
SMITH	20	9600	5	14
BLAKE	30	34200	1	5
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
WARD	30	15500	5	11
JAMES	30	11400	6	13
*/

--○ EMP 테이블에서 전체 연봉 등수(순위)가 1등부터 5등까지만...
--   사원명, 부서번호, 연봉, 전체연봉순위 항목으로 조회한다.

SELECT *
FROM
(
    SELECT ENAME "사원명", DEPTNO"부서번호",SAL*12+NVL(COMM,0)"연봉"
    ,RANK() OVER(ORDER BY SAL*12+NVL(COMM,0))"전체연봉순위"
    FROM EMP
)T
WHERE T.전체연봉순위 <=5;
--==>>
/*
SMITH	20	9600	1
JAMES	30	11400	2
ADAMS	20	13200	3
WARD	30	15500	4
MILLER	10	15600	5
*/

SELECT ENAME"사원명",DEPTNO"부서번호", SAL*12+NVL(COMM,0)"연봉"
            ,RANK() OVER(ORDER BY SAL*12+NVL(COMM,0))"전체연봉순위"
FROM EMP
WHERE RANK() OVER(ORDER BY SAL*12+NVL(COMM,0)) <= 5;
--==>> 에러 발생
--     ORA-30483: window  functions are not allowed here
--                ----------------- → 분석함수.

-- ※ 위의 내용은 RANK() OVER() 와 같은 분석 함수를 WHERE절에서 사용한 경우이며...
--    이 함수는 WHERE 조건절에서 사용할 수 없기 때문에 발생하는 에러이다.
--    이 경우, 우리는 INLINE VIEW를 활용해서 풀이해야 한다.

--○ EMP 테이블에서 각 부서별로 연봉등수가 1등부터 2등까지만 조회한다.
--   사원명, 부서번호, 연봉, 부서내연봉등수, 전체연봉등수
--   항목을 조회할 수 있도록 쿼리문을 구성한다.
SELECT T.* -- CHECK~!!
        ,RANK() OVER(ORDER BY T.연봉 DESC)"전체연봉등수"
FROM
(
    SELECT ENAME"사원명",DEPTNO"부서번호"
           ,SAL*12+NVL(COMM,0) "연봉"
          ,DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "부서별내연봉순위"
    FROM EMP
)T
WHERE T.부서별내연봉순위 <= 2
ORDER BY T.부서번호,T.부서별내연봉순위;
--==>>
/*
KING	10	60000	1	1
CLARK	10	29400	2	6
FORD	20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	2	4
BLAKE	30	34200	1	5
ALLEN	30	19500	2	7
*/

--확인 굿

SELECT ENAME,DEPTNO
        ,RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0)DESC)"부서별연봉순위"
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
    KING	10	1
    CLARK	10	2
MILLER	10	3
    SCOTT	20	1
    FORD	20	1
JONES	20	3
ADAMS	20	4
SMITH	20	5
    BLAKE	30	1
    ALLEN	30	2
TURNER	30	3
MARTIN	30	4
WARD	30	5
JAMES	30	6
*/
---------------------------------------------------------------------------------
--■■■그룹 함수■■■--

-- SUM() 합, AVG() 평균, COUNT() 카운트, MAX() 최대값, MIN() 최솟값
-- , VERIENCE() 분산, STDDEV() 표준편차

--※ 그룹 함수의 가장 큰 특징
--   처리해야 할 데이터들 중 NULL이 존재한다면(포함되어 있다면)
--   이 NULL은 제외한 상태로 연산을 수행한다는 것이다.
--   즉, 그룹 함수가 작동하는 과정에서 NULL은 연산의 대상에서 제외된다.

-- 원래 오라클에서 NULL 포함해서 연산하면 NULL이 나왔는데
-- 그룹함수는 NULL빼고 연산!

--○ SUM() 합
--   EMP 테이블을 대상으로 전체 사원들의 급여 총합을 조회한다.
SELECT SAL
FROM EMP;
--==>>
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
*/
SELECT SUM(SAL)
FROM EMP;
--==>>29025
--    반환되는 레코드 하나인거 확인!
SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> 에러 발생(컬럼수가 안맞음!)
--     ORA-00937: not a single-group group function

SELECT SUM(SAL) -- 800 +...+ 1300
FROM EMP;
--==>>29025

SELECT COMM
FROM EMP;
--==>>
/*
(null)
300
500
(null)
1400
(null)
(null)
(null)
(null)
0
(null)
(null)
(null)
(null)
*/

SELECT SUM(COMM) --(null) + 300 +... + (null)
FROM EMP;
--==>>2200
--    원칙적으로는 null이 나와야하는데.. null을 연산에서 제외하는구나..

--○ COUNT() 행(레코드)의 갯수 조회 → 데이터가 몇 건인지 확인...
SELECT COUNT(ENAME)
FROM EMP;
--==>>14

SELECT COUNT(COMM) --COMM컬럼 행의 갯수 조회 → NULL은 제외~!!!
FROM EMP;
--==>>4

-- 그래서 일반적으로는....모든 레코드가 NULL이 들어간 경우는 없기에..
SELECT COUNT(*)
FROM EMP;
--==>>14


--AVG() 평균 반환 ★
SELECT SUM(SAL)/ COUNT(SAL) "RESULT1" -- 2073.214285714285714285714285714285714286
       ,AVG(SAL) "RESULT2" -- 2073.214285714285714285714285714285714286
FROM EMP;

SELECT SUM(COMM)/COUNT(COMM) "RESULT1" -- 550
        ,AVG(COMM) "RESULT2" -- 550
FROM EMP;
--> 모든 카운트의 개수로 나눠야 올바른 평균값임!

SELECT SUM(COMM)/COUNT(*) "RESULT"
FROM EMP;
--==>>157.142857142857142857142857142857142857

-- ※ 데이터가 NULL 인 컬럼의 레코드는 연산 대상에서 제외되기 때문에
--    주의하여 연산 처리해야 한다.★

--○ VARIANCE(), STDDEV()
--   ※ 표준편차의 제곱이 분산, 분산의 제곱근이 표준편차
--      서로 상응하는 개념이다!

SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637
1182.503223516271699458653359613061928508
*/

-- 제곱
SELECT POWER(STDDEV(SAL),2) "RESULT1"
        ,VARIANCE(SAL) "RESULT2"
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637
1398313.87362637362637362637362637362637
*/

-- 제곱근

SELECT SQRT(VARIANCE(SAL))"RESULT1"
    ,STDDEV(SAL)"RESULT2"
FROM EMP;
--==>>
/*
1182.503223516271699458653359613061928508
1182.503223516271699458653359613061928508
*/

--○ MAX() / MIN()
-- 최대값   최솟값
SELECT MAX(SAL) "RESULT1"
        ,MIN(SAL) "RESULT2"
FROM EMP;
--==>>5000	800


-- ※ 주의
SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> 에러 발생
--     ORA-00937: not a single-group group function

SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==>> 에러 발생
--     ORA-00937: not a single-group group function

SELECT DEPTNO, SUM(SAL) -- 그 그룹별로 SUM 반환
FROM EMP
GROUP BY DEPTNO -- 얘로 먼저 묶고
--==>>
/*
30	9400
20	10875
10	8750
*/