SELECT USER
FROM DUAL;
--==>> SCOTT

-- 지금까지는 SQL 파트를 본 거고, 오늘부터는 PLSQL 파트를 볼 거예요~
-- SQL만큼 중요하다고 볼 순 없지만 알아두셔야 합니다~
-- DBA가 아닌 이상 SQL까지만 갖추고 계셔도 상관 없지만
-- 면접이나, 실무에서 유용하니까 알아두면 좋습니닷~


--■■■ PL/SQL ■■■--
-- 절차적인 언어가 확장된 형태?
-- 변수를 선언해야 값을 담을 수 있고, 담아야 연산할 수 있고~ 
-- 결과가 있어야 출력할 수 있고~ --> 절차

-- 1. PL/SQL(Procedural Language extension to SQL) 은
--    프로그래밍 언어의 특성을 가지는 SQL 의 확장이며
--    데이터 조작과 질의 문장은 PL/SQL 의 절차적 코드 안에 포함된다.
--    또한, PL/SQL 을 사용하면 SQL 로 할 수 없는 절차적 작업이 가능하다.
--    여기에서 『절차적』 이라는 단어가 가지는 의미는
--    어떤 것이 어떤 과정을 거쳐서 어떻게 완료되는지
--    그 방법을 정확하게 코드에 기술한다는 것을 의미한다.

-- 2. PL/SQL 은 절차적으로 표현하기 위해
--    변수를 선언할 수 있는 기능,
--    참과 거짓을 구별할 수 있는 기능,
--    실행 흐름을 컨트롤할 수 있는 기능 등을 제공한다.

-- 3. PL/SQL 은 블럭 구조로 되어 있으며
--    블럭은 선언 부분, 실행 부분, 예외 처리 부분의
--    세 부분으로 구성되어 있다.

--    또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같다.

-- 4. 형식 및 구조
/*
[DECLARE]
    -- 선언문(DECLARATIONS)
BEGIN
    -- 실행문(STATEMENTS)
    
    [EXCEPTION]
        -- 예외 처리문(EXCEPTION HANDLERS)
END;
*/

-- 5. 변수 선언
/*
DECLARE
    변수명 자료형;
    변수명 자료형 := 초기값;
BEGIN
END;
*/

/*
    자료형 변수명;
    int num;
    int num = 10
    
    COL1 NUMBER;
    COL1 NUMBER := 10; --> 오라클에서 대입연산자는 『:=』 / 오른쪽 거 왼쪽에 담기
*/

--★★★★★★★★★★★★★★★★★★★★★
-- 앞으로 PLSQL로 파일 만들게 되면
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--★★★★★★★★★★★★★★★★★★★★★

--※ 『DBMS_OUTPUT.PUT_LINE()』 을 통해
--   화면에 결과를 출력하기 위한 환경변수 설정
SET SERVEROUTPUT ON; -- 세션 당 한 번만 하면 됨

--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    V1 NUMBER := 10 ; -- NUM1이라는 변수를 NUMBER 타입으로 선언, 그 안에 10을 담겠다
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'Oracle';
BEGIN
    -- 실행부
    DBMS_OUTPUT.PUT_LINE(V1); -- 출력함수, DBMS_OUTPUT이라는 패키지에 담겨 있다
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
--==>>
/*
10
HELLO
Oracle


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 만약... 실수로... 블럭 안 잡고 실행했으면 바로 의사표현하기...


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'ORACLE';
BEGIN
    -- 실행부
    -- (연산 및 처리)
    V1 := V1 + 20;          -- NUM1 = NUM1 + 20;    NUM1 += 20; --> 오라클에는 복합대입연산 없음
    V2 := V2 || ' 신시은';
    V3 := V3 || ' World~!!!';
    
    -- (결과 출력)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
--==>>
/*
30
HELLO 신시은
ORACLE World~!!!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 지금부터는 오라클을 자바처럼 쓴다고 생각하면 된다..
-- 이제는 변수도 선언하고~ 값도 넣고~ 연산도 하고~ 어떻게 하겠다는 형태로 구성될 거다

-- {} 괄호가 없으니까 들여쓰기를 잘 해야 한다~


--○ PL/SQL 의 조건문부터 이어서 진행 예정~!!!