SELECT USER
FROM DUAL;
--==>>SCOTT

--○ IF 문(조건문)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL 의 IF 문장은 다른 언어의 IF 조건문과 거의 유사하다.
--    일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 한다.
--    TRUE 이면 THEN 과 ELSE 사이의 문장을 수행하고
--    FALSE 나 NULL 이면 ELSE 와 END IF; 사의의 문장을 수행하게 된다.

-- 2. 형식 및 구조
/*
→ 독립적인 IF문
IF 조건
    THEN 처리문;
END IF;
*/
--------------------
/*
→ ELSE는 THEN이 없음.
IF 조건
    THEN 처리문;
ELSE
    처리문;
END IF;
*/
--------------------
/*
→ ELSEIF
IF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
THEN 처리문;
END IF;
*/


/*
COL1 NUMBER → NUMBER이 가진 최솟값 ~ 최댓값
COL2 CHAR   → 한글자만!

NUMBER ↔ CHAR
CHAR : 문자하나 들어가는 타입. 캐릭터.
오라클 내부에서는 문자배열처럼 구성해서 CHAR(10) → 문자10개

*/
-- 자바처럼 블레이스가 있지 않아서
-- 문법적으로 어디서 시작해서 끝나는지 명시해야 함.
-- 그래서 IF, END IF 이런식!

SET SERVEROUTPUT ON;
--> 이걸해야지 PLSQL 출력을 볼 수 있음!

--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    GRADE CHAR; -- 선언부 : GRADE 라는 변수를 선언할거야. CHAR라는 변수를!
BEGIN
    GRADE := 'C'; --실행부 : GRADE에 'A'라는 문자를 담겠다.
    --DBMS_OUTPUT.PUT_LINE(GRADE); --출력
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'C'
        THEN DBMS_OUTPUT.PUT_LINE('COOL');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--> 블록잡아서 실행 잊지 말긔  ~ 

--○ CASE 문(조건문)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조
/*
CASE 변수
    WHEN 값1 THEN 실행문;
    WHEN 값2 THEN 실행문;
    ELSE 실행문;
END CASE;
*/


------
--외부 데이터를 PLSQL 영역으로 끌고 온다.
       ----
       --임의의 변수
           ------
           --사용자에게 띄우겠다.
-- ACCEPT는 뒤로 주석 달면 걔까지 읽어서
-- 에러 발생.
ACCEPT NUM PROMPT '남자1 여자2 입력하세요';


DECLARE
    -- 주요 변수 선언
    SEL NUMBER := &NUM; -- NUM에 들어있는 값을 내부로 끌어오는 거 / TEMP면 &TEMP / INPUT이면 &INPUT
    RESULT VARCHAR2(10) := '남자';
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    -- 연산 및 처리
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('남자입니다.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('여자입니다.');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('확인불가');
    END CASE;
    */
    
    CASE SEL
        WHEN 1
        THEN RESULT := '남자';
        WHEN 2
        THEN RESULT := '여자';
        ELSE
            RESULT := '확인불가';
    END CASE;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('처리결과는 '||RESULT ||'입니다');
END;

-- ※ 외부 입력 처리
-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
--> 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
--  『&외부변수명』 형태로 접근하게 된다.

-- ○ 정수 2개를 외부로부터(사용자로부터) 입력받아
--    이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.

ACCEPT NUM1 PROMPT '첫번째 정수를 입력하세요 :';
ACCEPT NUM2 PROMPT '두번째 정수를 입력하세요 :';

DECLARE
    NUM1 NUMBER := &NUM1;
    NUM2 NUMBER := &NUM2;
    SUMM NUMBER := 0;
BEGIN
    -- 연산
    SUMM := NUM1 + NUM2;
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('첫번째 정수 : ' || NUM1);
    DBMS_OUTPUT.PUT_LINE('두번째 정수 : ' || NUM2);
    DBMS_OUTPUT.PUT_LINE('결과: ' || SUMM);
END;
--==>>
/*
첫번째 정수 : 1
두번째 정수 : 3
결과: 4
*/

--○ 사용자로부터 입력받은 금액을 화폐단위로 구분하여 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.

/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/

ACCEPT INPUT PROMPT '금액 입력';
DECLARE
    -- ○ 주요 변수 선언
    MONEY   NUMBER := &INPUT;   -- 연산을 위해 입력값을 담아둘 변수
    MONEY2  NUMBER := &INPUT;   -- 결과 출력을 위해 입력값을 담아둘 변수
                                -- (MONEY 변수가 연산을 처리하는 과정에서 값이 달라지기 때문이다.)
    
    M500    NUMBER;             -- 500원 짜리 갯수를 담아둘 변수
    M100    NUMBER;             -- 100원 짜리 갯수를 담아둘 변수
    M50     NUMBER;             --  50원 짜리 갯수를 담아둘 변수
    M10     NUMBER;             --  10원 짜리 갯수를 담아둘 변수
BEGIN
    -- ○ 연산 및 처리
    -- MOMEY를 500으로 나눠서 몫을 취하고 나머지는 버린다. → 500원의 갯수
    M500 := TRUNC(MONEY/500);
    
    -- MONEY를 500으로 나눠서 몫은 버리고 나머지를 취한다. → 500원의 갯수 확인하고 남은 금액
    MONEY := MOD(MONEY,500);
    
    -- MONEY를 100으로 나눠서 몫을 취하고 나머지는 버린다 → 100원의 갯수
    M100 := TRUNC(MONEY/100);
    
    --MONEY를 100으로 나눠서 몫은 버리고 나머지를 취한다 → 100원의 갯수 확인하고 남은 갯수 확인
    MONEY := MOD(MONEY,100);
    
    -- MONEY 를 50으로 나눠서 몫을 취하고 나머지는 버린다. → 50원의 갯수
    M50 := TRUNC(MONEY/50);
    
    -- MONEY를 50으로 나눠서 몫은 버리고 나머지를 취한다 → 50원의 갯수 확인하고 남은 금액 확인
    MONEY := MOD(MONEY,50);
    
    -- MONEY를 10으로 나눠서 몫을 취하고 나머지는 버린다 → 10원의 갯수
    M10 := TRUNC(MONEY/10);
    
    --○ 결과 출력
    -- 취합된 결과(화폐단위별 갯수)를 형식에 맞게 최종 출력한다.
    --    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 :990원');
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 :' || MONEY2||'원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 '|| M500
    ||', 백원 ' ||M100
    ||', 오십원'||M50
    ||', 십원 '||M10);
END;
--==>>
/*
입력받은 금액 총액 :990원
화폐단위 : 오백원 1, 백원 4, 오십원1, 십원 4
*/

--○ 기본 반복문
-- LOOP ~ END LOOP;

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP                -- (자바 while(true))
    -- 실행문
    EXIT WHEN 조건; -- 조건이 참인 경우 반복문을 빠져나간다(자바 break)
END LOOP;
*/

-- 1 부터 10 까지의 수 출력(LOOP 문 활용)
DECLARE
    N NUMBER;          -- LOOP 변수 선언
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N >= 10;

        N := N + 1;    -- 자바의 『N++;』,『N+=1;』
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/

--○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 구문을 사용한다.
--    조건은 반복이 시작되는 시점에 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--    LOOP 를 시작할 때 조건이 FALSE 이면 반복 문장을 탈출하게 된다.


-- 2. 형식 및 구조
/*
WHILE 조건 LOOP   -- 조건이 참인 경우 반복 수행
    -- 실행문;
END LOOP;
*/


--※ 
--  LOOP ~ END LOOP; → 조건이 참이면 반복문 탈출
--  WHILE LOOP ~ END LOOP; → 조건이 참이면 반복문 실행


-- 1부터 10까지의 수 출력(WHILE LOOP 문 활용)
DECLARE
    N NUMBER;       -- LOOP 변수 선언
BEGIN
    N := 0;         -- 초기값
    WHILE N<10 LOOP
        N := N + 1;     -- N이 0~ 9까지
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--○ FOR 반복문
-- FOR LOOP ~ END LOOP;
-- (자바의 향상된 for문 생각..)

-- 1. 『시작수』에서 1씩 증가하여
--    『끝냄수』가 될 때 까지 반복 수행한다.

--2. 형식 및 구조

/*
FOR 카운터 IN [REVERSE] 시작수 .. 끝남수 LOOP
    -- 실행문;
END LOOP;
*/

-- 1부터 10까지의 수 출력(FOR LOOP 문 활용)
DECLARE
    N   NUMBER;         --LOOP 변수 선언.
BEGIN
    FOR N IN 1 .. 10 LOOP   -- N에 1 ~ 10까지 순차적으로 담을거야
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--○ 사용자로부터 임의의 단(구구단)을 입력받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : 2
2 * 1 = 2
2 * 2 = 4
  :
2 * 9 = 18
*/

-- 1.LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER := 1; --LOOP 변수 선언
    
BEGIN
    LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N); 
    
    N := N +1;
    EXIT WHEN N >10;
    
    END LOOP;
    
END;
----------------------------수업 풀이-------------------------------------------
ACCEPT INPUT PROMPT '단을 입력하세요. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
    
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N); 
        EXIT WHEN N >=9;
        N := N +1;
    END LOOP;
END;
--------------------------------------------------------------------------------
SET SERVEROUTPUT ON;


-- 2. WHILE LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER := 1;
BEGIN
    WHILE N<=10 LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N); 
    N := N + 1;
    END LOOP;
END;
----------------------------수업 풀이-------------------------------------------
ACCEPT INPUT PROMPT '단을 입력하세요. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
    
BEGIN
    N := 0;
    WHILE N<9 LOOP
        N := N +1;
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N); 
    END LOOP;
END;
--------------------------------------------------------------------------------
-- 3. FOR LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
BEGIN
    FOR N IN 1.. 10 LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N);
    END LOOP;
END;
----------------------------수업 풀이-------------------------------------------
ACCEPT INPUT PROMPT '단을 입력하세요. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
    
BEGIN
   FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N);
   END LOOP;
END;
--------------------------------------------------------------------------------

--○ 구구단 전체(2단 ~ 9단)를 출력하는 PL/SQL 구문을 작성한다.
--   단, 이중 반복문(반복문의 중첩)구문을 활용한다.
/*
실행 예)
==[ 2 단 ]==
2 * 1 = 2
   :
==[ 3 단 ]==
   :
==[ 9 단 ]==
*/
-- LOOP .ver
DECLARE
    DAN NUMBER := 2; 
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('==['||DAN||'단]==');
        LOOP 
            DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '==' || DAN * N);
            N := N + 1;
            EXIT WHEN N > 9;
        END LOOP;
        N := 1; -- N 초기화.
        DAN := DAN + 1;
        EXIT WHEN DAN > 9;
    END LOOP;
END;

-- WHILE LOOP .ver
DECLARE
    DAN NUMBER := 2;
    N NUMBER := 1;
BEGIN
    WHILE DAN < 10 LOOP
        DBMS_OUTPUT.PUT_LINE('==['||DAN||'단]==');
        WHILE N < 10 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '==' || DAN * N);
            N := N + 1;
        END LOOP;
        N := 1; -- N값 초기화
        DAN := DAN + 1;
    END LOOP;
END;

-- FOR LOOP.ver
DECLARE
    DAN NUMBER; --LOOP 변수(단) 2 ~ 9
    N NUMBER; -- LOOP변수(행) 1 ~ 9
BEGIN
    FOR DAN IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==['||DAN||'단]==');
        FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '==' || DAN * N);
        END LOOP;
    END LOOP;
END;













