SELECT USER
FROM DUAL;
--==>>SCOTT
--------------------------------------------------------------------------------
--PL/SQL로 프로시저, 트리거, 함수를 만들 줄 알아야 의미있다..

--■■■ FUNCTION(함수) ■■■--

-- 1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화 하는데 사용된다.
--    오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다. → (사용자 정의 함수)
--    이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
--    저장 프로시저 처럼 EXECUTE문을 통해 실행할 수 있다.         
--    (EXECUTE : .exe)

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] FUNCTION 함수명            OR REPLACE : 덮어쓰는 개념.
[(매개변수명1 자료형
  ,매개변수명2 자료형
)]
RETURN 데이터타입                             ---------- 여기까지 함수 선언부.
IS                          -- PL/SQL 구문과 비슷.
    -- 주요 변수 선언
BEGIN                       -- PL/SQL 구문과 비슷.               
    -- 실행문;
    ...
    RETURN (값);                              ----------- RETURN 반드시 있어야함.   
    
    [EXCEPTION]
        -- 예외 처리 구문;
END;                        -- PL/SQL 구문과 비슷.
*/

--※ 사용자 정의 함수(스토어드 함수)는
--   IN 파라미터(입력 매개변수)만 사용할 수 있으며
--   반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고,
--   FUNCTION 은 반드시 단일 값만 반환한다.

-- ○ TBL_INSA 테이블 전용 성별 확인 함수 정의(생성)
-- 함수명 : FN_GENDER()
--             ↑        SSN(주민등록번호) → '771212-1022432' → 'YYMMDD-NNNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2)  -- 매개변수 : 자릿수(길이) 지정 안함.(여기 매개변수 선언하는 곳)
RETURN VARCHAR2     -- 반환자료형 : 자릿수(길이) 지정 안함.
IS
        -- 선언부 → 주요 변수 선언
        V_RESULT    VARCHAR2(20);
BEGIN
        -- 실행부(정의부) → 연산 및 처리
        IF (SUBSTR(V_SSN,8,1) IN ('1','3')) -- IF뒤에 () 권장.
            THEN V_RESULT := '남자';
        ELSIF(SUBSTR(V_SSN,8,1) IN ('2','4'))
            THEN V_RESULT := '여자';
        ELSE
            V_RESULT := '성별확인불가';
        END IF;
        
        -- 결과값 반환 CHECK~!!!
        RETURN V_RESULT;
END;
--==>>Function FN_GENDER이(가) 컴파일되었습니다.

--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아 →(A,B)
--   A의 B승의 값을 반환하는 사용자 정의 함수를 작성한다
--   단, 기존의 오라클 내장 함수를 이용하지 않고, 반복문을 활용하여
--   작성한다.

-- 함수명 : FN_POW()
/*
사용 예)
SELECT FN_POW(10,3)
FROM DUAL;
--==>>1000
*/
CREATE OR REPLACE FUNCTION FN_POW(N1 NUMBER, N2 NUMBER)
RETURN NUMBER
IS
    RESULT NUMBER(10) := N1;
    N NUMBER := 1;      -- LOOP변수, N2까지 횟수.
BEGIN
    WHILE N < N2 LOOP       --N2 가 3이면.. N은 2까지.. 1,2 두번..
    RESULT := RESULT * N1;
    N := N+1;
    END LOOP;
    RETURN RESULT;
END;
--==>>Function FN_POW이(가) 컴파일되었습니다.

--------풀이-------
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)       --여기 새미콜론 XX
RETURN NUMBER           -- 여기 새미콜론 XX
IS 
    V_RESULT    NUMBER := 1;     -- 반환 결과값 변수 → CHECK~!! 1로 초기화
    V_NUM       NUMBER;
BEGIN
    -- 반복문 구성
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A;       --V_RESULT *= A;(자바에서) ★★★★★★
    END LOOP;
    
    -- 최종 결과 값 반환
    RETURN V_RESULT;
END;

-------------------

--○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
--   급여는 『(기본급 * 12) + 수당』연산을 기반으로 수행한다.
--   함수명 : FN_PAY(기본급, 수당)
CREATE OR REPLACE FUNCTION FN_PAY(B_PAY NUMBER, S_PAY NUMBER)
RETURN NUMBER
IS
    -- 주요 변수 선언
    RESULT NUMBER := 0;
BEGIN
    -- 연산 및 처리 
    RESULT := NVL(B_PAY,0)*12 + NVL(S_PAY,0);
    
    -- 최종 결과값 반환
    RETURN RESULT;
END;
--==>>Function FN_PAY이(가) 컴파일되었습니다.

--○ TBL_INSA 테이블에서 입사일을 기준으로 현재까지의
--   근무년수를 반환하는 함수를 정의한다.
--   단, 근무년수는 소수점 이하 한자리까지 계산한다.
--   함수명:FN_WORKYEAR(입사일)
CREATE OR REPLACE FUNCTION FN_WORKYEAR(IBSADATE DATE)
RETURN NUMBER
IS
    V_WORKDAY NUMBER;
BEGIN
    V_WORKDAY := ROUND(SYSDATE - IBSADATE,1);
    --V_WORKDAY := V_WORKDAY / 365;
    --V_WORKDAY := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM IBSADATE);
    RETURN V_WORKDAY;
END;
--==>>Function FN_WORKYEAR이(가) 컴파일되었습니다.


--------------------------------------------------------------------------------
-- 풀이 1.
--(1). 
SELECT MONTHS_BETWEEN(SYSDATE,'2002-02-11')/12
FROM DUAL;
--==>>20.0817787049482277976901632815611310235
--(2).
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,'2002-02-11')/12) || '년' ||
        TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, '2002-02-11'),12))||'개월'
FROM DUAL;
--==>>20년0개월


CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN NUMBER
IS
    VRESULT NUMBER;
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE,VIBSADATE)/12,1);
    
    RETURN VRESULT;
END;
--==>>Function FN_WORKYEAR이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------

-- ※ 참고

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Date Manipulation Language)
-- COMMIT / ROLLBACK 이 필요하다.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>>DDL(Date Definition Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 3. GRANT, REVOKE
--==>>DCL(Date Control Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)


-- 정적 pl/sql 문 → DML문, TCL문만 사용 가능하다.
-- 동적 pl/sql 문 → DML문, DDL문, DCL문, TCL문 사용 가능하다.
--------------------------------------------------------------------------------

-- ■■■ PROCEDURE(프로시저) ■■■--
--pl/sql 쓰는 이유 → 프로시저인 만큼 많이 씀. 
--PL:절차적, 프로시저안에 내포되어있음.

-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야 하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때 마다 호출하여 실행할 수 있도록 처리해 주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 매개변수 IN 데이터타입
  ,매개변수 OUT 데이터타입
  ,매개변수 INOUT 데이터타입
)]
IS
    [-- 주요 변수 선언]
BEGIN
    -- 실행 구문;
    ...
    [EXCEPTION
        -- 예외 처리 구문;]
END;
*/

--프로시저: 얘를 호출했을때, 안에 코드가 돌아간다가 중요,입출력 다 가능.
--함수    : 얘를 호출했을때, return값이 중요!, 입력매개변수만
-- 입력 매개변수: 내가 너한테 데이터를 줄거야.
-- 출력 매개변수: 빈통줄게 여기에 뭐 담아줘.
-- 입출력매개변수: 어디에 담아서 줄테니 다먹고 다른거담아서 줘(내가 줄거, 받을거)


-- ※ FUNCTION 과 비교했을 때 『RETURN 반환 자료형』 부분이 존재하지 않으며,
--    『RETURN』 문 자체도 존재하지 않으며,
--    프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
--    IN(입력), OUT(출력), INOUT(입출력)으로 구분된다.

-- 3. 실행(호출)
/*
EXEC[UTE] 프로시저명[(인수1, 인수2,...)];
*/



-- ※ (1)프로시저 실습을 위한 테이블 생성은
--    『20220310_02_scott.sql』 파일 참조 ~!!!


--○ 프로시저 생성
--(1).
/*
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
(V_ID     IN TBL_IDPW.ID%TYPE
,V_PW     IN TBL_IDPW.PW%TYPE
,V_NAME   IN TBL_STUDENTS.NAME%TYPE
,V_TEL    IN TBL_STUDENTS.TEL%TYPE
,V_ADDR   IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
END;
*/

--(2).

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
(V_ID     IN TBL_IDPW.ID%TYPE
,V_PW     IN TBL_IDPW.PW%TYPE
,V_NAME   IN TBL_STUDENTS.NAME%TYPE
,V_TEL    IN TBL_STUDENTS.TEL%TYPE
,V_ADDR   IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_IDPW(ID,PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- 커밋
    COMMIT;
END;
--==>>Procedure PRC_STUDENT_INSERT이(가) 컴파일되었습니다.

-- ※ (2)프로시저 실습을 위한 테이블 생성은
--    『20220310_02_scott.sql』 파일 참조 ~!!!


--○ 데이터 입력 시 특정 항목의 데이터만 입력하면
--                  ---------
--                    (학번, 이름, 국어점수, 영어점수, 수학점수)
--   내부적으로 다른 추가항목에 대한 처리가 함께 이루어질 수 있도록 하는
--                   ---------
--                   (총점, 평균, 등급)
--   프로시저를 작성한다.(생성한다.)
--   프로시저 명 : PRC_SUNGJUK_INSERT()
/*
실행 예)
EXEC PRC_SUNJUK_INSERT(1,'최선하',90,80,70);

프로시저 호출로 처리된 결과
학번  이름  국어점수  영어점수  수학점수  총점  평균  등급
  1   최선하     90       80        70     240   80    B
*/
CREATE OR REPLACE PROCEDURE PRO_SUNGJUK_INSERT
(V_HAKBUN     IN TBL_SUNGJUK.HAKBUN%TYPE
,V_NAME       IN TBL_SUNGJUK.NAME%TYPE
,V_KOR        IN TBL_SUNGJUK.KOR%TYPE
,V_ENG        IN TBL_SUNGJUK.ENG%TYPE
,V_MAT        IN TBL_SUNGJUK.MAY%TYPE
)
IS
V_TOT   TBL_SUNGJUK.TOT%TYPE;
V_AVG   TBL_SUNGJUK.AVG%TYPE;
V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    IF V_AVG >= 90
    THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
    THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
    THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
    THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;
    INSERT INTO TBL_SUNGJUK
    VALUES(V_HAKBUN,V_NAME,V_KOR,V_ENG,V_MAT,V_TOT,V_AVG,V_GRADE);
    
    COMMIT;
    
END;
--==>>Procedure PRO_SUNGJUK_INSERT이(가) 컴파일되었습니다.
-----------풀이------------
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
(V_HAKBUN   IN TBL_SUNGJUK.HAKBUN%TYPE
,V_NAME     IN TBL_SUNGJUK.NAME%TYPE
,V_KOR      IN TBL_SUNGJUK.KOR%TYPE
,V_ENG      IN TBL_SUNGJUK.ENG%TYPE
,V_MAT      IN TBL_SUNGJUK.MAY%TYPE
)
IS
    -- 선언부
    -- INSERT 쿼리문 수행을 하기 위해 필요한 추가 변수
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 실행부
    -- 추가로 선언한 주요 변수들에 값을 담아내야 한다.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >=80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- INSERT 쿼리문 수행
    INSERT INTO TBL_SUNGJUK(HAKBUN,NAME,KOR,ENG,MAY,TOT,AVG,GRADE)
    VALUES(V_HAKBUN,V_NAME,V_KOR,V_ENG,V_MAT,V_TOT,V_AVG,V_GRADE);
    
    --커밋
    COMMIT;
END;
--==>>Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.


--○ TBL_SUBJUK 테이블에서 특정 학생의 점수
--   (학번, 국어점수, 영어점수, 수학점수) 데이터 수정 시
--   총점, 평균, 등급까지 함께 수정되는 프로시저를 생성한다.
--   프로시저 명 : PRC_SUNGJUK_UPDATE()
/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(2,50,50,50)
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
(V_HAKBUN   TBL_SUNGJUK.HAKBUN%TYPE
,V_KOR      TBL_SUNGJUK.KOR%TYPE
,V_ENG      TBL_SUNGJUK.ENG%TYPE
,V_MAT      TBL_SUNGJUK.MAY%TYPE
)
IS
--V_NAME    TBL_SUNGJUK.NAME%TYPE;
V_TOT     TBL_SUNGJUK.TOT%TYPE;
V_AVG     TBL_SUNGJUK.AVG%TYPE;
V_GRADE   TBL_SUNGJUK.GRADE%TYPE;

BEGIN
    --V_NAME := (SELECT NAME
             --  FROM TBL_SUNGJUK
             --  WHERE HAKBUN = V_HAKBUN);
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >=80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    UPDATE TBL_SUNGJUK
    SET HAKBUN = V_HAKBUN
        ,KOR = V_KOR
        ,ENG = V_ENG
        ,MAY = V_MAT
        ,TOT = V_TOT
        ,AVG = V_AVG
        ,GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
END;
--==>>Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.
-- 하.. 이름은 업데이트 할 필요가 없음. ...
-----------풀이-----------
-- 위에 파라미터 끝에 새미콜론 안붙히는 이유 : 파라미터 사이사이 콤마로 이어짐.
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
(V_HAKBUN     IN TBL_SUNGJUK.HAKBUN%TYPE
,V_KOR        IN TBL_SUNGJUK.KOR%TYPE  
,V_ENG        IN TBL_SUNGJUK.ENG%TYPE
,V_MAT        IN TBL_SUNGJUK.MAY%TYPE
)
IS
    --선언부
    -- UPDATE 쿼리문을 수행하기 위해 필요한 변수
    V_TOT      TBL_SUNGJUK.TOT%TYPE;
    V_AVG      TBL_SUNGJUK.AVG%TYPE;
    V_GRADE    TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    --실행부
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >=80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    --UPDATE 쿼리문 수행
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAY = V_MAT
        ,TOT = V_TOT, AVG = V_AVG ,GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    --커밋
    COMMIT;
END;
--==>>Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.


--○ TBL_STUENTS 테이블에서 전화번호와 주소 데이터를 수정하는(변경하는)
--   프로시저를 작성한다.
--   단,ID 와 PW가 일치하는 경우에만 수정을 진행할 수 있도록 처리한다.
--   프로시저 명 : PRC_STUDENTS_UPDATE()

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(V_ID    IN TBL_IDPW.ID%TYPE
,V_PW    IN TBL_IDPW.PW%TYPE
,V_TEL   IN TBL_STUDENTS.TEL%TYPE
,V_ADDR  IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    --ID AND PW 모두 일치
    --UPDATE 쿼리문 실행
    UPDATE TBL_STUDENTS 
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID =V_ID
            AND V_PW = (SELECT PW
                        FROM TBL_IDPW
                        WHERE ID = V_ID);
    --커밋
    COMMIT;
END;
--==>>Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.

SELECT USER
FROM DUAL;
--==>>SCOTT

-- ※ 20220310_01_soctt(plsql).sql 파일에서
--    FN_PAY() 함수 생성 후 테스트
SELECT NUM,NAME, BASICPAY, SUDANG, FN_PAY(BASICPAY,SUDANG)"급여"
FROM TBL_INSA;
--==>>
/*
1001	홍길동	2610000	200000	31520000
1002	이순신	1320000	200000	16040000
1003	이순애	2550000	160000	30760000
1004	김정훈	1954200	170000	23620400
1005	한석봉	1420000	160000	17200000
1006	이기자	2265000	150000	27330000
1007	장인철	1250000	150000	15150000
1008	김영년	950000	145000	11545000
1009	나윤균	840000	220400	10300400
1010	김종서	2540000	130000	30610000
1011	유관순	1020000	140000	12380000
1012	정한국	880000	114000	10674000
1013	조미숙	1601000	103000	19315000
1014	황진이	1100000	130000	13330000
1015	이현숙	1050000	104000	12704000
1016	이상헌	2350000	150000	28350000
1017	엄용수	950000	210000	11610000
1018	이성길	880000	123000	10683000
1019	박문수	2300000	165000	27765000
1020	유영희	880000	140000	10700000
1021	홍길남	875000	120000	10620000
1022	이영숙	1960000	180000	23700000
1023	김인수	2500000	170000	30170000
1024	김말자	1900000	170000	22970000
1025	우재옥	1100000	160000	13360000
1026	김숙남	1050000	150000	12750000
1027	김영길	2340000	170000	28250000
1028	이남신	892000	110000	10814000
1029	김말숙	920000	124000	11164000
1030	정정해	2304000	124000	27772000
1031	지재환	2450000	160000	29560000
1032	심심해	880000	108000	10668000
1033	김미나	1020000	104000	12344000
1034	이정석	1100000	160000	13360000
1035	정영희	1050000	140000	12740000
1036	이재영	960400	190000	11714800
1037	최석규	2350000	187000	28387000
1038	손인수	2000000	150000	24150000
1039	고순정	2010000	160000	24280000
1040	박세열	2100000	130000	25330000
1041	문길수	2300000	150000	27750000
1042	채정희	1020000	200000	12440000
1043	양미옥	1100000	210000	13410000
1044	지수환	1060000	220000	12940000
1045	홍원신	960000	152000	11672000
1046	허경운	2650000	150000	31950000
1047	산마루	2100000	112000	25312000
1048	이기상	2050000	106000	24706000
1049	이미성	1300000	130000	15730000
1050	이미인	1950000	103000	23503000
1051	권영미	2260000	104000	27224000
1052	권옥경	1020000	105000	12345000
1053	김싱식	960000	108000	11628000
1054	정상호	980000	114000	11874000
1055	정한나	1000000	104000	12104000
1056	전용재	1950000	200000	23600000
1057	이미경	2520000	160000	30400000
1058	김신제	1950000	180000	23580000
1059	임수봉	890000	102000	10782000
1060	김신애	900000	102000	10902000
*/
SELECT  NAME, FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;


--------------------풀이.
-- ※ 20220310_01_soctt(plsql).sql 파일에서
--    FN_WORKYEAR() 함수 생성 후 테스트
SELECT NAME, IBSADATE,FN_WORKYEAR(IBSADATE) "근무기간"
FROM TBL_INSA;
--==>>
/*
홍길동	1998-10-11	23년4개월
이순신	2000-11-29	21년3개월
이순애	1999-02-25	23년0개월
김정훈	2000-10-01	21년5개월
한석봉	2004-08-13	17년6개월
이기자	2002-02-11	20년0개월
장인철	1998-03-16	23년11개월
김영년	2002-04-30	19년10개월
나윤균	2003-10-10	18년5개월
김종서	1997-08-08	24년7개월
유관순	2000-07-07	21년8개월
정한국	1999-10-16	22년4개월
조미숙	1998-06-07	23년9개월
황진이	2002-02-15	20년0개월
이현숙	1999-07-26	22년7개월
이상헌	2001-11-29	20년3개월
엄용수	2000-08-28	21년6개월
이성길	2004-08-08	17년7개월
박문수	1999-12-10	22년3개월
유영희	2003-10-10	18년5개월
홍길남	2001-09-07	20년6개월
이영숙	2003-02-25	19년0개월
김인수	1995-02-23	27년0개월
김말자	1999-08-28	22년6개월
우재옥	2000-10-01	21년5개월
김숙남	2002-08-28	19년6개월
김영길	2000-10-18	21년4개월
이남신	2001-09-07	20년6개월
김말숙	2000-09-08	21년6개월
정정해	1999-10-17	22년4개월
지재환	2001-01-21	21년1개월
심심해	2000-05-05	21년10개월
김미나	1998-06-07	23년9개월
이정석	2005-09-26	16년5개월
정영희	2002-05-16	19년9개월
이재영	2003-08-10	18년7개월
최석규	1998-10-15	23년4개월
손인수	1999-11-15	22년3개월
고순정	2003-12-28	18년2개월
박세열	2000-09-10	21년6개월
문길수	2001-12-10	20년3개월
채정희	2003-10-17	18년4개월
양미옥	2003-09-24	18년5개월
지수환	2004-01-21	18년1개월
홍원신	2003-03-16	18년11개월
허경운	1999-05-04	22년10개월
산마루	2001-07-15	20년7개월
이기상	2001-06-07	20년9개월
이미성	2000-04-07	21년11개월
이미인	2003-06-07	18년9개월
권영미	2000-06-04	21년9개월
권옥경	2000-10-10	21년5개월
김싱식	1999-12-12	22년2개월
정상호	1999-10-16	22년4개월
정한나	2004-06-07	17년9개월
전용재	2004-08-13	17년6개월
이미경	1998-02-11	24년0개월
김신제	2003-08-08	18년7개월
임수봉	2001-10-10	20년5개월
김신애	2001-10-10	20년5개월
*/
------최종!
-- ※ 20220310_01_soctt(plsql).sql 파일에서
--    FN_WORKYEAR() 함수 재생성 후 테스트
SELECT NAME, IBSADATE,FN_WORKYEAR(IBSADATE) "근무기간"
FROM TBL_INSA;
--==>>
/*
홍길동	1998-10-11	23.4
이순신	2000-11-29	21.2
이순애	1999-02-25	23
김정훈	2000-10-01	21.4
한석봉	2004-08-13	17.5
이기자	2002-02-11	20
장인철	1998-03-16	23.9
김영년	2002-04-30	19.8
나윤균	2003-10-10	18.4
김종서	1997-08-08	24.5
유관순	2000-07-07	21.6
정한국	1999-10-16	22.4
조미숙	1998-06-07	23.7
황진이	2002-02-15	20
이현숙	1999-07-26	22.6
이상헌	2001-11-29	20.2
엄용수	2000-08-28	21.5
이성길	2004-08-08	17.5
박문수	1999-12-10	22.2
유영희	2003-10-10	18.4
홍길남	2001-09-07	20.5
이영숙	2003-02-25	19
김인수	1995-02-23	27
김말자	1999-08-28	22.5
우재옥	2000-10-01	21.4
김숙남	2002-08-28	19.5
김영길	2000-10-18	21.3
이남신	2001-09-07	20.5
김말숙	2000-09-08	21.5
정정해	1999-10-17	22.3
지재환	2001-01-21	21.1
심심해	2000-05-05	21.8
김미나	1998-06-07	23.7
이정석	2005-09-26	16.4
정영희	2002-05-16	19.8
이재영	2003-08-10	18.5
최석규	1998-10-15	23.4
손인수	1999-11-15	22.3
고순정	2003-12-28	18.2
박세열	2000-09-10	21.5
문길수	2001-12-10	20.2
채정희	2003-10-17	18.3
양미옥	2003-09-24	18.4
지수환	2004-01-21	18.1
홍원신	2003-03-16	18.9
허경운	1999-05-04	22.8
산마루	2001-07-15	20.6
이기상	2001-06-07	20.7
이미성	2000-04-07	21.9
이미인	2003-06-07	18.7
권영미	2000-06-04	21.7
권옥경	2000-10-10	21.4
김싱식	1999-12-12	22.2
정상호	1999-10-16	22.4
정한나	2004-06-07	17.7
전용재	2004-08-13	17.5
이미경	1998-02-11	24
김신제	2003-08-08	18.5
임수봉	2001-10-10	20.4
김신애	2001-10-10	20.4
*/


--------------------------------------------------------------------------------

--※ 프로시저 관련 실습을 위한 준비

-- 실습 테이블 생성
CREATE TABLE TBL_STUDENTS
(ID     VARCHAR2(10)
,NAME   VARCHAR2(40)
,TEL    VARCHAR2(30)
,ADDR   VARCHAR2(100)
,CONSTRAINT STUDENTS_ID_PK PRIMARY KEY(ID)
);
--==>>Table TBL_STUDENTS이(가) 생성되었습니다.

--실습 테이블 생성
CREATE TABLE TBL_IDPW
(ID     VARCHAR2(10)
,PW     VARCHAR2(20)
,CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>>Table TBL_IDPW이(가) 생성되었습니다.

--> 1:1구조로 바람직하지 않은 구조지만
--  프로시저 설명때문에 만듬.

-- 두 테이블에 데이터 입력
INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR)
VALUES('happy','이시우','010-1111-1111','제주도 서귀포시');
INSERT INTO TBL_IDPW(ID,PW)
VALUES('happy','java006$');
--==>>1 행 이(가) 삽입되었습니다. * 2

-- 확인
SELECT *
FROM TBL_STUDENTS;
--==>>happy	이시우	010-1111-1111	제주도 서귀포시
SELECT *
FROM TBL_IDPW;
--==>>happy	java006$

-- 커밋
COMMIT;
--==>>커밋 완료.

--> 두 테이블에 INSERT 구문을 독립적으로 하면 
--  데이터 무결성을 헤칠 위험이 큼.
--  이럴 때, 필요한 것이 『프로시저』
--  한번에 이 업무를 진행하는 프로시저!



-- 위의 업무를 수행하는 프로시저(INSERT 프로시저, 입력 프로시저)를 생성하게 되면
-- 『EXEC PRC_STUDENT_INSERT('happy','java006$','이시우','010-1111-1111','제주 서귀포시');』
-- 이와 같은 구문 한 줄로 양쪽 테이블 모두 제대로 데이터를 입력할 수 있다.

-- ※ 프로시저를 생성하는 구문은
--    『20220310_01_scott(plsql).sql』파일 참조 ~!!!


-- ○ 프로시저 생성 후 실행
EXEC PRC_STUDENT_INSERT('rainbow','java006$','김정용','010-2222-2222','서울 강남구');
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다

-- ○ 프로시저 호출 이후 확인
SELECT *
FROM TBL_IDPW;
--==>>
/*
happy	java006$
rainbow	java006$
*/
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
happy	이시우	010-1111-1111	제주도 서귀포시
rainbow	김정용	010-2222-2222	서울 강남구
*/

-- ○ (2)실습 테이블 생성(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
(HAKBUN     NUMBER          --원래 학번 NUMBER안함 앞에 0들어갈수있기에. 근데 여기선 시퀀스형태때문에)
,NAME       VARCHAR2(40)    
,KOR        NUMBER(3)
,ENG        NUMBER(3)
,MAY        NUMBER(3)
,CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>>Table TBL_SUNGJUK이(가) 생성되었습니다.

-- ※ 생성된 테이블 구조 변경 → 컬럼 추가
--    (총점 → TOT, 평균 → AVG, 등급 → GRADE)
ALTER TABLE TBL_SUNGJUK
ADD(TOT NUMBER(3),AVG NUMBER(4,1), GRADE CHAR);
--==>>Table TBL_SUNGJUK이(가) 변경되었습니다.
--AVG NUMBER(4,1) : 소수점 이하 한자리 까지.


-- ※ 여기서 추가한 컬럼에 대한 항목은
--    프로시저 실습을 위한 추가항목일 뿐
--    실제 테이블 구조에 적합하지도, 바람직하지도 않은 내용이다~!!! CHECK~!!!

--==>> 기존 테이블의 데이터를 활용하여 얻을 수 있는 데이터는 
--     즉, 쿼리문을 통해 얻어낼 수 있는 데이터는
--     절대 테이블에 추가로 구성(테이블 내에 컬럼화)하지 않는다.
-- 입력 데이터를 예측할 수 있는 컬럼이라면...
-- 반드시 '코드화'시켜라
--ex) 아내,아들,딸 → 1.배우자, 2.자녀...


--○ 변경된 테이블 구조 확인
DESC TBL_SUNGJUK;
--==>>
/*
이름     널?       유형           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAY             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1) 
*/

--확인
EXEC PRO_SUNGJUK_INSERT(1,'최선하',90,80,70);
EXEC PRO_SUNGJUK_INSERT(2,'최둘리',90,100,90);
EXEC PRO_SUNGJUK_INSERT(3,'김미미',20,20,20);

SELECT *
FROM TBL_SUNGJUK;

SELECT TRUNC(91,-1)
FROM DUAL;

DELETE
FROM TBL_SUNGJUK
WHERE NAME IN ('최선하','최둘리','김미미');

--------풀이 확인---------
-- ○ 프로시저 생성 후 실행
EXEC PRC_SUNGJUK_INSERT(1,'최선하',90,80,70);
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ 프로시저 호출 이후 테이블 조회
DELETE
FROM TBL_SUNGJUK
WHERE NAME = '최선하';

EXEC PRC_SUNGJUK_INSERT(1,'최선하',90,80,70);
EXEC PRC_SUNGJUK_INSERT(2,'박현수',90,80,80);

SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	최선하	90	80	70	240	80	    B
2	박현수	90	80	80	250	83.3	B
*/

--확인
EXEC PRC_SUNGJUK_UPDATE(2,100,100,100);

SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	최선하	90	80	70	240	80	B
2	박현수	100	100	100	300	100	A
*/
DELETE
FROM TBL_SUNGJUK
WHERE NAME = '김둘리';

--------풀이 확인---------
-- ○ 프로시저 생성 후 실행
EXEC PRC_SUNGJUK_UPDATE(2,50,50,50);
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ 프로시저 호출(실행) 이후 테이블 조회
SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	최선하	90	80	70	240	80	B
2	박현수	50	50	50	150	50	F
*/

SELECT *
FROM TBL_IDPW;

SELECT *
FROM TBL_STUDENTS;

EXEC PRC_STUDENTS_UPDATE('happy','java006$','010-7777-7777','용인시 기흥구');
--==>> 데이터 수정 o
SELECT *
FROM TBL_STUDENTS;
EXEC PRC_STUDENTS_UPDATE('rainbow','java00','010-9999-7777','서울시 성동구');
--==>> 데이터 수정 x
SELECT *
FROM TBL_STUDENTS;
決첼?	010-1111-1111	제주도 서귀포시
SELECT *
FROM TBL_IDPW;
--==>>happy	java006$

-- 커밋
COMMIT;
--==>>커밋 완료.

--> 두 테이블에 INSERT 구문을 독립적으로 하면 
--  데이터 무결성을 헤칠 위험이 큼.
--  이럴 때, 필요한 것이 『프로시저』
--  한번에 이 업무를 진행하는 프로시저!



-- 위의 업무를 수행하는 프로시저(INSERT 프로시저, 입력 프로시저)를 생성하게 되면
-- 『EXEC PRC_STUDENT_INSERT('happy','java006$','이시우','010-1111-1111','제주 서귀포시');』
-- 이와 같은 구문 한 줄로 양쪽 테이블 모두 제대로 데이터를

----------------풀이----------------
---------------방법1.---------------
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(V_ID    IN TBL_IDPW.ID%TYPE
,V_PW    IN TBL_IDPW.PW%TYPE
,V_TEL   IN TBL_STUDENTS.TEL%TYPE
,V_ADDR  IN TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2  TBL_IDPW.PW%TYPE;
    V_FLAG NUMBER := 0;
BEGIN
    -- PW 일치하는지 확인
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = V_ID;
    
    IF (V_PW = V_PW2)
        THEN V_FLAG := 1;
    ELSE
        V_FLAG := 2;
    END IF;
    
    --UPDATE 쿼리문
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID 
          AND V_FLAG = 1;
          
    --커밋
    COMMIT;
END;
--==>>Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.
----------------풀이----------------
---------------방법2.---------------
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(V_ID    IN TBL_IDPW.ID%TYPE
,V_PW    IN TBL_IDPW.PW%TYPE
,V_TEL   IN TBL_STUDENTS.TEL%TYPE
,V_ADDR  IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
            FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
            ON T1.ID = T2.ID)T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID
          AND T.PW = V_PW;
          
    COMMIT;
END;
--==>>Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.



