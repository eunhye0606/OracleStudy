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
