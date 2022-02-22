SELECT USER
FROM DUAL;
--==>>SCOTT

--○ ROUND() 반올림을 처리해 주는 함수
SELECT 48.678 "COL1"             -- 48.678
        , ROUND(48.678,2)"COL2"  -- 48.68 -- 소수점 이하 둘째자리까지 표현 → 두 번째 파라미터
        , ROUND(48.674,2)"COL3"  -- 48.67 
        , ROUND(48.674,1)"COL4"  -- 48.7  
        , ROUND(48.674,0)"COL5"  -- 49    -- 정수까지 표현하겠다.
        , ROUND(48.674)"COL6"    -- 49    -- 두번째 파라미터 = 0 → 생략가능!(이렇게를 많이 씀)
        , ROUND(48.674,-1)"COL7" -- 50    -- 10의 자리까지 표현하겠다.
        , ROUND(48.674,-2)"COL8" -- 0     -- 100의 자리까지 표현하겠다. → 반올림x (반올림 O → 100)
        , ROUND(48.674,-3)"COL9" -- 0     -- 100의 자리까지 표현하겠다. → 반올림x 
FROM DUAL;

--○ TRUNC() 절삭을 처리해 주는 함수
SELECT 48.678 "COL1"             -- 48.678          
        , TRUNC(48.678,2)"COL2"  -- 48.67
        , TRUNC(48.674,2)"COL3"  -- 48.67
        , TRUNC(48.674,1)"COL4"  -- 48.6 
        , TRUNC(48.674,0)"COL5"  -- 48
        , TRUNC(48.674)"COL6"    -- 48 -- 두번째 파라미터 = 0 생략가능!
        , TRUNC(48.674,-1)"COL7" -- 40
        , TRUNC(48.674,-2)"COL8" --	0
        , TRUNC(48.674,-3)"COL9" -- 0
FROM DUAL;

--○ MOD() 나머지를 반환하는 함수
SELECT MOD(5,2) "RESULT"
FROM DUAL;
--==>> 1
--> 5를 2로 나눈 나머지 결과값 반환

--○ POWER() 제곱의 결과를 반환하는 함수
SELECT POWER(5,3) "RESULT"
FROM DUAL;
--==>> 125
--> 5의 3승을 결과값으로 반환

--○ SQRT() 루트 결과값을 반환하는 함수
SELECT SQRT(2) "RESULT"
FROM DUAL;
--==>>1.41421356237309504880168872420969807857
--> 루트 2에 대한 결과값 반환

--○ LOG() 로그 함수
--   (오라클은 상용로그만 지원하는 반면, MSSQL은 상용로그 · 자연로그 모두 지원한다.)
SELECT LOG(10, 100) "COL1"
       , LOG(10,20) "COL2"
FROM DUAL;
--==>>2	1.30102999566398119521373889472449302677

--○ 삼각함수
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233
0.5403023058681397174009366074429766037354
1.55740772465490223050697480745836017308
*/
--> 각각 싸인, 코싸인, 탄젠트 결과값을 반환한다.

--○ 삼각함수의 역함수(범위 : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>>
/*
0.52359877559829887307710723054658381405
1.04719755119659774615421446109316762805
0.4636476090008061162142562314612144020295
*/
--> 각각 어싸인, 어코싸인, 어탄젠트 결과값을 반환한다.

--○ SIGN() 의미 : 서명, 부호, 특징
--> 연산 결과값이 양수이면 1, 0이면 0, 음수이면 -1을 반환한다.
SELECT SIGN(5-2) "COL1"   -- 1
        ,SIGN(5-5) "COL2" -- 0
        ,SIGN(5-8) "COL3" -- -1
FROM DUAL;
--> 매출이나 수지와 관련하여 적자 및 흑자의 개념을 나타낼 때 사용한다.

--○ ASCII(), CHR() → 서로 대응(상응)하는 함수
SELECT ASCII('A') "COL1" --65
    , CHR(65) "COL2"     --A
FROM DUAL;
-->『ASCII()』 : 매개변수로 넘겨받은 문자의 아스키코드 값을 반환한다.
-- 『CHR()』   : 매개변수로 넘겨받은 아스키코드 값으로 해당 문자를 반환한다.

--------------------------------------------------------------------------------

--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.

--※ 날짜 연산의 기본 단위는 DAY(일수)이다~!!!
SELECT SYSDATE "COL1"       -- 2022-02-22 09:43:57
     , SYSDATE + 1 "COL2"   -- 2022-02-23 09:43:57
     , SYSDATE - 2 "COL3"   -- 2022-02-20 09:43:57
     , SYSDATE - 30 "COL4"  -- 2022-01-23 09:43:57
FROM DUAL;

--○ 시간 단위 연산
SELECT SYSDATE "COL1"          -- 2022-02-22 09:46:37
      , SYSDATE + 1/24 "COL2"  -- 2022-02-22 10:46:37 → 한 시간 뒤
      , SYSDATE - 2/24 "COL3"  -- 2022-02-22 07:46:37 → 두 시간 전
FROM DUAL;

--○ 현재 시간과... 현재 시간 기준 1일 2시간 3분 4초 후를 조회하는 쿼리문을 구성한다.

SELECT SYSDATE "현재 시간"
       ,SYSDATE + 1 + 2/ 24 + 3/24/60 + 4/24/60/60 "연산 후 시간"
FROM DUAL;
--==>>
/*
--------------------------------------------
현재 시간               연산 후 시간
--------------------------------------------
2022-02-22 10:04:33	    2022-02-23 12:07:37
*/

-- 방법 1.
SELECT SYSDATE "현재 시간"
       ,SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "연산 후 시간"
FROM DUAL;
--==>>
/*
2022-02-22 10:17:35	
2022-02-23 12:20:39
*/

-- 방법 2. 모두 다 초로 환산해서 처리.
SELECT SYSDATE "현재 시간"
       ,SYSDATE + ((1*24*60*60) + (2 * 60 * 60) + (3 * 60) + 4) / (24*60*60) "연산 후 시간"
FROM DUAL;
--==>>
/*
2022-02-22 10:19:44	
2022-02-23 12:22:48
*/

--○ 날짜 - 날짜 = 일수
SELECT TO_DATE('2022-06-20','YYYY-MM-DD') - TO_DATE('2022-02-22','YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>>118
--> 결과 값이 양수 :앞에 날짜가 뒤 날짜보다 미래다.

--○ 데이터 타입의 변환
SELECT TO_DATE('2022-06-20','YYYY-MM-DD')"RESULT"
FROM DUAL;
--==>>2022-06-20 00:00:00
-->   세션이 시분초도 나오게 되어있어서 

SELECT TO_DATE('2022-06-35','YYYY-MM-DD')"RESULT"
FROM DUAL;
--==>> 에러 발생
--     ORA-01847: day of month must be between 1 and last day of month
--     TO_DATE()는 단순히 날짜변환이 아니라 『유효한 날짜』로 변환시킴.

SELECT TO_DATE('2022-02-29','YYYY-MM-DD')"RESULT"
FROM DUAL;
--==>> 에러 발생
--     ORA-01839: date not valid for month specified
--     그레고리안

SELECT TO_DATE('2022-13-29','YYYY-MM-DD')"RESULT"
FROM DUAL;
--==>> 에러 발생
--     ORA-01843: not a valid month

--※ TO_DATE() 함수를 통해 문자 타입을 날짜 타입으로 변환을 수행하는 과정에서
--   내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다.

--○ ADD_MONTHS() 개월 수를 더해주는 함수
SELECT SYSDATE "COL1"
       ,ADD_MONTHS(SYSDATE,2) "COL2"
       ,ADD_MONTHS(SYSDATE,3) "COL3"
       ,ADD_MONTHS(SYSDATE,-2) "COL4"
       ,ADD_MONTHS(SYSDATE,-3) "COL5"
FROM DUAL;
--==>>
/*
2022-02-22 10:29:56 → 현재
2022-04-22 10:29:56 → 2개월 후
2022-05-22 10:29:56	→ 3개월 후 
2021-12-22 10:29:56	→ 2개월 전
2021-11-22 10:29:56 → 3개월 전
*/
--> 월을 더하고 빼기

--○ MONTHS_BETWEEN()
--   첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환한다.
SELECT MONTHS_BETWEEN(SYSDATE,TO_DATE('2002-05-31','YYYY-MM-DD'))"RESULT"
FROM DUAL;
--==>>236.723883288530465949820788530465949821

--> 개월 수의 차이를 반환하는 함수
--  결과값의 부호가 『-』로 반환되었을 경우에는
--  첫 번째 인자값에 해당하는 날짜보다
--  두 번째 인자값에 해당하는 날짜가 『미래』라는 의미로 확인할 수 있다.

--○ NEXT_DAY() 가장 빠른 두번째 인자값 날짜 반환.
--   시간은 세션 시간..
--   실무에서 에러나는 경우 있음 → 다음거 ㄱ
SELECT NEXT_DAY(SYSDATE,'토')"COL1"
       ,NEXT_DAY(SYSDATE,'월')"COL2"
       ,NEXT_DAY(SYSDATE,'화')"COL3" -- 해당일이 화요일 → 가장빠른건 다음주 화요일
FROM DUAL;
--==>>
/*
2022-02-26 10:38:33	
2022-02-28 10:38:33	
2022-03-01 10:38:33
*/

--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>>Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE,'토')"COL1"
       ,NEXT_DAY(SYSDATE,'월')"COL2"
FROM DUAL;
--==>>에러 발생.
--    ORA-01846: not a valid day of the week
--    세션이 영어로 되어있어서 에러 발생함.

--방법 1.
SELECT NEXT_DAY(SYSDATE,'SAT')"COL1"
       ,NEXT_DAY(SYSDATE,'MON')"COL2"
FROM DUAL;
--==>>
/*
2022-02-26 10:40:57	
2022-02-28 10:40:57
*/
--방법 2.
--※ 세선 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>>Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE,'SAT')"COL1"
       ,NEXT_DAY(SYSDATE,'MON')"COL2"
FROM DUAL;
--==>> 에러 발생
--     ORA-01846: not a valid day of the week

SELECT NEXT_DAY(SYSDATE,'토')"COL1"
       ,NEXT_DAY(SYSDATE,'월')"COL2"
FROM DUAL;
--==>>
/*
2022-02-26 10:42:42	
2022-02-28 10:42:42
*/

--○ LAST_DAY()
-->  해당 날짜가 포함되어 있는 그 달의 마지막 날을 반환한다.
--   자바의 캘린더 클래스 메소드랑 비슷하다!
SELECT LAST_DAY(SYSDATE) "COL1"
        ,LAST_DAY(TO_DATE('2020-02-10','YYYY-MM-DD')) "COL2"
         ,LAST_DAY(TO_DATE('2019-02-10','YYYY-MM-DD')) "COL3"
FROM DUAL;
--==>>
/*
2022-02-28 10:45:19	
2020-02-29 00:00:00	
2019-02-28 00:00:00
*/

--※세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>>Session이(가) 변경되었습니다.

--○ 오늘부로... 상기가 군대에 다시 끌려(?)간다...
--   복무기간은 22개월로 한다.

--1. 전역 일자를 구한다.
SELECT ADD_MONTHS(SYSDATE,22) "상기 전역날"
FROM DUAL;
--==>>2023-12-22

--2. 하루 꼬박꼬박 3끼 식사를 한다고 가정하면
--   상기가 몇 끼를 먹어야 집에 보내줄까...
SELECT ROUND((TO_DATE(ADD_MONTHS(SYSDATE,22),'YYYY-MM-DD') - SYSDATE)*3) "전역까지끼니"
FROM DUAL;
--==>>2003
--> 아놔틀림 ㅡㅡ
SELECT (ADD_MONTHS(SYSDATE,22) - SYSDATE) * 3 
FROM DUAL;
--==>>2004

--------------------------------------------------------------------------------
--○ 현재 날짜 및 시각으로부터...
--   수료일(2022-06-20 18:00:00)까지
--   남은 기간을... 다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다.
/*
----------------------------------------------------------------------------
현재시각              | 수료일               |일   |시간 | 분  |초
----------------------------------------------------------------------------
2022-02-22 11:34:35  | 2022-06-20 18:00:00  |117  | 7   | 15  | 15
----------------------------------------------------------------------------
*/

-- 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.

--풀이.
SELECT SYSDATE "현재시각"
       ,TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') "수료일"
       ,수료일 - 현재날짜 "일"
       ,수료일 시간 - 현재 날짜의 시간"시간"
       ,수료일 분 - 현재 날짜의 분"분"
       ,수료일 초 - 현재 날짜의 초"초"
FROM DUAL;
SELECT TO_DATE(SYSDATE+1,'HH24:MI:SS')
FROM DUAL;

SELECT SYSDATE "현재시각"
       ,TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') "수료일"
       , TRUNC(TO_DATE('2022-06-20','YYYY-MM-DD') - SYSDATE) "일수"
      ,18 - SUBSTR(SYSDATE,12,2) "시간"
      ,60 - SUBSTR(SYSDATE,15,2) "분"
      ,60 - SUBSTR(SYSDATE,18,2) "초"
FROM DUAL;
--------------------------------------------------------------------------------
SELECT TRUNC(TO_DATE('2022-06-20','YYYY-MM-DD') - SYSDATE) "일수"
      ,TO_DATE(SUBSTR((TO_DATE('2022-06-20','YYYY-MM-DD'),12,2),'HH24:MI:DD') - TO_DATE(SUBSTR(SYSDATE,12,2),'HH24:MI:DD')
FROM DUAL;
--------------------------------------------------------------------------------
--테스트(현재 시간 구하기.)
SELECT (SYSDATE + 1/24 - SYSDATE) * 24 -- 이러면 1시간만 나옴.
FROM DUAL;

SELECT (TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - TO_DATE('2022-06-20','YYYY-MM-DD')) * 24 -- 18시
FROM DUAL;

SELECT (TO_DATE('2022-06-20','YYYY-MM-DD')-SYSDATE)
FROM DUAL;
--==>>117.491759259259259259259259259259259259

SELECT (TO_DATE('2022-06-20','YYYY-MM-DD')-SYSDATE) - TRUNC(TO_DATE('2022-06-20','YYYY-MM-DD')-SYSDATE)
FROM DUAL;
--==>>0.491435185185185185185185185185185185

SELECT TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>>118.235798611111111111111111111111111111
SELECT (0.235798611111111111111111111111111111) * 24
FROM DUAL;
--==>>5.659166666666666666666666666666666664

SELECT (0.235798611111111111111111111111111111) * 60
FROM DUAL;

SELECT TRUNC((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE -(ROUND(TO_DATE('2022-06-20','YYYY-MM-DD')-SYSDATE)+1)) * 24)
FROM DUAL;
--==>>118.235798611111111111111111111111111111

SELECT ((TO_DATE('2022-06-20','YYYY-MM-DD')-SYSDATE) - TRUNC(TO_DATE('2022-06-20','YYYY-MM-DD')-SYSDATE))
FROM DUAL;
--==>>11.791111111111111111111111111111111104


SELECT SYSDATE "현재시각"
       ,TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') "수료일"
       ,TRUNC(TO_DATE('2022-06-20','YYYY-MM-DD')-SYSDATE)"일"
       ,TRUNC((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE -(TRUNC(TO_DATE('2022-06-20','YYYY-MM-DD')-SYSDATE)+1)) * 24)"시간"
       ,1"분"
       ,4"초"
FROM DUAL;
--------------------------------------------------------------------------------
SELECT SYSDATE "현재시각"
       ,TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') "수료일"
       ,1"일수"
       ,2"시간"
       ,3"분"
       ,4"초"
FROM DUAL;

--『1일 2시간 3분 4초』 를.. 『초』로 환산하면...
SELECT (1일) + (2시간) + (3분) + (4초)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>>93784

--『93784』를 ... 다시 『일 시간 분 초』로 환산하면...
SELECT TRUNC(93784/60/60/24) "일수" 
    ,MOD(TRUNC(TRUNC(93784/60)/60),24) "시간"
    ,MOD(TRUNC(93784/60),60) "분" 
    ,MOD(93784,60) "초"
FROM DUAL;

--수료일까지 남은 기간 확인(단위 : 일수)
SELECT 수료일자 - 현재일자
FROM DUAL;
SELECT TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>>118.133020833333333333333333333333333333


--수료일까지 남은 기간 확인(단위 : 초)
SELECT ((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60))
FROM DUAL;
--==>>10205681.99999999999999999999999999999996

SELECT TRUNC(93784/60/60/24) "일수" 
    ,MOD(TRUNC(TRUNC(93784/60)/60),24) "시간"
    ,MOD(TRUNC(93784/60),60) "분" 
    ,MOD(93784,60) "초"
FROM DUAL;

SELECT TRUNC( ((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60))/60/60/24) "일수" 
    ,MOD(TRUNC(TRUNC( ((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60))/60)/60),24) "시간"
    ,MOD(TRUNC( ((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60))/60),60) "분" 
    ,TRUNC(MOD( ((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60)),60)) "초"
FROM DUAL;

SELECT SYSDATE "현재시각" 
    ,TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') "수료일"  
    ,TRUNC( ((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60))/60/60/24) "일수" 
    ,MOD(TRUNC(TRUNC( ((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60))/60)/60),24) "시간"
    ,MOD(TRUNC( ((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60))/60),60) "분" 
    ,TRUNC(MOD( ((TO_DATE('2022-06-20 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60)),60)) "초"
FROM DUAL;
--==>>
/*
2022-02-22 15:08:10	   -- 현재시각
2022-06-20 18:00:00	   -- 수료일
118	                   -- 일수
2                      -- 시간
51                     -- 분
50                     -- 초
*/

--------------------------------------------------------------------------------
--○ 각자 태어난 날짜 및 시각으로부터 ... 현재까지
--   얼마만큼 시간을 살고 있는지...
--   다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다.

--------------------------------------------------------------------------------
/*
----------------------------------------------------------------------------
현재시각              | 생년월일               |일   |시간 | 분  |초
----------------------------------------------------------------------------
2022-02-22 11:34:35  | 1998-06-06 12:00:00  |117  | 7   | 15  | 15
----------------------------------------------------------------------------
*/
--① 일수 구하기.
SELECT SYSDATE - TO_DATE('1998-06-06 12:00:00','YYYY-MM-DD HH24:MI:SS') "일수"
FROM DUAL;
--==>>8662.135162037037037037037037037037037037

--② 일수 → 초로 전환
SELECT ((SYSDATE - TO_DATE('1998-06-06 12:00:00','YYYY-MM-DD HH24:MI:SS')) * (24*60*60)) "전체 초"
FROM DUAL;
--==>>748408526

--③ 초 → 일 시간 분 초로 연산하기
SELECT SYSDATE 
        || '의 은혜는 '
        ||TRUNC(748408526/60/60/24/365)
        ||'년' 
        ||MOD(TRUNC(748408526/60/60/24),365)
        ||'일 '
        ||MOD(TRUNC(748408526/60/60),24) 
        ||'시간 ' 
        ||MOD(TRUNC(748408526/60),60)
        ||'분 '
        ||MOD(748408526,60)
        ||'초를 살아가고 있읍니다....'
        ||TRUNC(748408526/60/60/24)
        ||'일을 살고 있읍니다... 응원해주십쇼 .. '
FROM DUAL;
--==>>2022-02-22 15:30:01의 은혜는 23년267일 3시간 15분 26초를 살아가고 있읍니다....8662일을 살고 있읍니다... 응원해주십쇼 .. 

SELECT SYSDATE "현재 시각"
        ,TO_DATE('1998-06-06 12:00:00','YYYY-MM-DD HH24:MI:SS')"내탄생일"
        ,TRUNC(((SYSDATE - TO_DATE('1998-06-06 12:00:00','YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60/60/24)"일수"
        ,TRUNC(((SYSDATE - TO_DATE('1998-06-06 12:00:00','YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60/60/24/365)"년"  
         ,MOD(TRUNC(((SYSDATE - TO_DATE('1998-06-06 12:00:00','YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60/60/24),365)"일" 
         ,MOD(TRUNC(((SYSDATE - TO_DATE('1998-06-06 12:00:00','YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60/60),24)"시간" 
         ,MOD(TRUNC(((SYSDATE - TO_DATE('1998-06-06 12:00:00','YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60),60)"분" 
         ,MOD(((SYSDATE - TO_DATE('1998-06-06 12:00:00','YYYY-MM-DD HH24:MI:SS')) * (24*60*60)),60)"초" 
FROM DUAL;
--==>>
/*
2022-02-22 17:48:27	  -- 현재 시각
1998-06-06 12:00:00	  -- 내탄생일
8662                  -- 일수
23                    -- 년
267                   -- 남은 일
5                     -- 시간  
48                    -- 분
27                    -- 초
*/


SELECT SUBSTR('123',1,2)
FROM DUAL;
--==>>12
SELECT SUBSTR('123',1,3)
FROM DUAL;
--==>>123

SELECT SUBSTR('123',1,3) - SUBSTR('123',1,2)
FROM DUAL;

--○ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>>Session이(가) 변경되었습니다.

--※ 날짜 데이터를 대상으로 반올림, 절삭 등의 연산을 수행할 수 있다.

--○ 날짜 반올림
SELECT SYSDATE "COL1"                   -- 2022-02-22 → 기본 현재 날짜
        ,ROUND(SYSDATE, 'YEAR')"COL2"   -- 2022-01-01 → 년도까지 유효한 데이터(상반기/하반기 기준)
        ,ROUND(SYSDATE, 'MONTH')"COL3"  -- 2022-03-01 → 월까지 유효한 데이터(15일 기준)
        ,ROUND(SYSDATE, 'DD')"COL4"     -- 2022-02-23 → 일까지 유효한 데이터(정오 기준)
        ,ROUND(SYSDATE, 'DAY')"COL5"    -- 2022-02-20 → 일까지 유효한 데이터(수요일 정오 기준)
FROM DUAL;

--○ 날짜 절삭
SELECT SYSDATE "COL1"                   -- 2022-02-22 → 기본 현재 날짜
        ,TRUNC(SYSDATE, 'YEAR')"COL2"   -- 2022-01-01 → 년도까지 유효한 데이터
        ,TRUNC(SYSDATE, 'MONTH')"COL3"  -- 2022-03-01 → 월까지 유효한 데이터
        ,TRUNC(SYSDATE, 'DD')"COL4"     -- 2022-02-23 → 일까지 유효한 데이터 (현재날짜랑 같음)
        ,TRUNC(SYSDATE, 'DAY')"COL5"    -- 2022-02-20 → 그 전 주에 해당하는 일요일
FROM DUAL;

--------------------------------------------------------------------------------

--■■■ 변환 함수 ■■■--

--TO_CHAR()     : 숫자나 날짜 데이터를 문자 타입으로 변환시켜주는 함수
--TO_DATE()     : 문자 데이터를 날짜 타입으로 변환시켜주는 함수
--TO_NUMBER()   : 문자 데이터를 숫자 타입으로 변환시켜주는 함수

--※ 날짜나 통화 형식이 맞지 않을 경우...
--   설정값을 통해 세션을 설정하여 사용할 수 있다.

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_CURRENCY = '\'; --통화. 원표시임.
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


--○ 날짜형 → 문자형
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')"COL1"    -- 2022-02-22 (TO_CHAR()로 인해 문자열!이 반환!)
       ,TO_CHAR(SYSDATE,'YYYY')"COL2"         -- 2022
       ,TO_CHAR(SYSDATE,'YEAR')"COL3"         -- TWENTY TWENTY-TWO -- 한글로는 안나옴.. 그 머 대응하는 함수 쓰면 가능하겠지?
       ,TO_CHAR(SYSDATE,'MM')"COL4"           -- 02
       ,TO_CHAR(SYSDATE,'MONTH')"COL5"        -- 2월 
       ,TO_CHAR(SYSDATE,'MON')"COL6"          -- 2월 
       ,TO_CHAR(SYSDATE,'DD')"COL7"           -- 22
       ,TO_CHAR(SYSDATE,'MM-DD')"COL8"        -- 02-22
       ,TO_CHAR(SYSDATE,'DAY')"COL9"          -- 화요일
       ,TO_CHAR(SYSDATE,'DY')"COL10"          -- 화
       ,TO_CHAR(SYSDATE,'HH24')"CO11"         -- 16
       ,TO_CHAR(SYSDATE,'HH')"CO12"           -- 04 
       ,TO_CHAR(SYSDATE,'HH AM')"COL13"       -- 04 오후 ↓ 같은 값 반환.
       ,TO_CHAR(SYSDATE,'HH PM')"COL14"       -- 04 오후
       ,TO_CHAR(SYSDATE,'MI')"COL15"          -- 28 → 분
       ,TO_CHAR(SYSDATE,'SS')"COL16"          -- 58
       ,TO_CHAR(SYSDATE,'SSSSS')"COL17"       -- 59307 (오늘 날짜 자정 ~ 지금까지 흘러온 초)
       ,TO_CHAR(SYSDATE,'Q')"COL18"           -- 1 (분기 1분기...2분기...)

FROM DUAL;

SELECT 7"COL1" -- 숫자 → 우측정렬
    ,'7'"COL2" -- 문자 → 좌측정렬
    ,TO_CHAR(7)"COL3" -- 문자로 변환하는 함수안에 숫자 넣으면 문자반환
FROM DUAL;
--> 조회 결과가 좌측 정렬인지 우측 정렬인지 확인~!!!

SELECT '4' "COL1" --→ 문자
    ,TO_NUMBER('4')"COL2" --→ 숫자
    ,4 "COL3" --→ 숫자
    ,TO_NUMBER('04')"COL4" --→ 숫자(문자에서 숫자로 변환하면서 앞에 0 탈락 (오라클에선 0탈락))!!
FROM DUAL;
--------------------------------------------------------------------------------
--년도 바로 숫자타입으로 추출 X
-- TO_CHAR은 문자만 숫자로 가능

SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) "RESULT"
FROM DUAL;
--==>>2022(숫자, 우측 정렬)
--------------------------------------------------------------------------------

--○ EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "COL1" -- 2022(문자형) → 연도를 추출하여 문자 타입으로 반환
       ,TO_CHAR(SYSDATE, 'MM') "COL2"  -- 02 (문자형) → 월을 추출하여 문자 타입으로 반환
       ,TO_CHAR(SYSDATE,'DD') "COL3"   -- 22(문자형) → 일을 추출하여 문자 타입으로 반환
       ,EXTRACT(YEAR FROM SYSDATE) "COL4"  -- 2022(숫자형) → 연도를 추출하여 숫자 타입으로 반환
       ,EXTRACT(MONTH FROM SYSDATE) "COL5" -- 2 (숫자형) → 월을 추출하여 숫자 타입으로 반환
       ,EXTRACT(DAY FROM SYSDATE) "COL6" -- 22 (숫자형) → 일을 추출하여 숫자 타입으로 반환(CHECK~!! 요일 X 일O)
FROM DUAL;
--> 연, 월, 일 이외의 다른 항목은 불가~!!! (시분초 XXX)

--○ TO_CHAR() 활용 → 형식 맞춤 표기 결과값 반환(자바의 printf(), format()처럼)
SELECT 60000 "COL1"
       ,TO_CHAR(60000, '99,999')"COL2"
       ,TO_CHAR(60000, '$99,999')"COL3"
       ,TO_CHAR(60000, 'L99,999')"COL4" -- L은 그 나라에서 쓰는 통화 위에서 세션 '\'로 설정.
       ,LTRIM(TO_CHAR(60000, 'L99,999')) "RESULT"
FROM DUAL;
--==>>60000	 60,000	 $60,000  ￦60,000
-- 통화라 좌측정렬인데 단순공백으로 채워져서 LTRIM()
--------------------------------------------------------------------------------
--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.

--○ 현재 시간을 기준으로 1일 2시간 3분 4초 후를 조회한다.
SELECT SYSDATE"현재 시간"
    ,SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "1일2시간3분4초후"
FROM DUAL;
--==>>
/*
2022-02-22 16:49:22
2022-02-23 18:52:26
*/


--○ 현재 시간을 기준으로 1년 2개월 3일 4시간 5분 6초 후를 조회한다.
--   TO_YMINTERVAL(), TO_DSINTERVAL()
--   YEAR ~ MONTH      DAY ~ S(초까지)
--   매개변수 → 문자타입으로 넘김.
--   DAY넘길때 3자리! 

SELECT SYSDATE "현재 시간"
        ,SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06')"연산 시간"
FROM DUAL;
--==>>
/*
2022-02-22 17:04:51	
2023-04-25 21:09:57
*/
--------------------------------------------------------------------------------
--PLSQL 전 단계...(절차...자바 배웠으니까 괜찬을거야...)

--○ CASE 구문(조건문, 분기문)
--   CASE문 이렇게 부르지 말고 CASE WHEN THEN ELSE END 구문..
/*
CASE
WHEN
THEN
ELSE
END
*/

SELECT CASE 5+2 WHEN 4 THEN '5+2 = 4' ELSE '5+2 몰라융' END
FROM DUAL;
--==>>5+2 몰라융

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2=6' END
FROM DUAL;
--==>>5+2=7

SELECT CASE 1+1 WHEN 2 THEN '1+1=2'
                WHEN 3 THEN '1+1=3'
                WHEN 2 THEN '1+1=4'
                ELSE '난산수싫엉'
                END "RESULT"
FROM DUAL;
--==>>1+1=2
--> WHEN 조건 맞는거 나오면 그거 THEN 반환하고
--  끝남.

SELECT CASE WHEN 5+2 = 4 THEN '5+2 = 4'
            WHEN 6-3 = 2 THEN '6-3 = 2'
            WHEN 7*1 = 8 THEN '7*1 = 8'
            WHEN 6/2 = 3 THEN '6/2 = 3'
            ELSE '모르겠네'
            END
FROM DUAL;
--==>>6/2 = 3
--> CASE 하고 WHEN이 힘을 합쳐 TRUE/FALSE만 반환할 수 있으면 됨!.



--○ DECODE()
--   파라미터 개수는 무제한~!
SELECT DECODE(5-2,1,'5-2=1',2,'5-2=2',3,'5-2=3','5-2는 몰라요!')"RESULT"
FROM DUAL;
--==>>5-2=3

--○ CASE WHEN THEN ELSE END (조건문, 분기문) 활용
SELECT CASE WHEN 5<2 OR 3>1 AND 2=2 THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
            END "RESULT"
FROM DUAL;

SELECT CASE WHEN F OR T AND T THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
            END "RESULT"
FROM DUAL;

SELECT CASE WHEN T AND T THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
            END "RESULT"
FROM DUAL;

SELECT CASE WHEN T THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
            END "RESULT"
FROM DUAL;
--==>>은혜만세
--------------------------------------------------------------------------------
SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '현수만세'
            WHEN 5<2 AND 2=3 THEN '이삭만세'
            ELSE '태형만세'END "결과"
FROM DUAL;
--==>> 현수만세

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '현수만세'
            WHEN 5<2 AND 2=3 THEN '이삭만세'
            ELSE '태형만세'END "결과"
FROM DUAL;
--==>>태형만세

--------------------------------------------------------------------------------
SELECT *
FROM TBL_SAWON;

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