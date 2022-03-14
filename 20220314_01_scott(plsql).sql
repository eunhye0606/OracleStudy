SELECT USER
FROM DUAL;
--==>>SCOTT

--------------------------------------------------------------------------------

--○ TBL_출고 테이블에서 출고수량을 수정(변경)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_UPDATE()
/*
실행 예)
EXEC PRC_출고_UPDATE(출고번호, 변경할수량);
*/

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(V_출고번호     IN TBL_출고.출고번호%TYPE
,V_변경할수량   IN TBL_상품.재고수량%TYPE
)
IS
    --주요 변수 선언
    V_상품재고수량  TBL_상품.재고수량%TYPE;
    V_기존출고수량  TBL_출고.출고수량%TYPE;
    
    --예외변수
    USER_DEFINE_ERROR1 EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
BEGIN
    --상품테이블 재고수량 담아내기
    SELECT 재고수량 INTO V_상품재고수량
    FROM TBL_상품
    WHERE 상품코드 = (SELECT 상품코드
                      FROM TBL_출고
                      WHERE 출고번호 = V_출고번호);
                      
     --출고테이블 기존출고수량 담아내기
     SELECT 출고수량 INTO V_기존출고수량
     FROM TBL_출고
     WHERE 출고번호 = V_출고번호;
     
    --예외처리
    IF(V_상품재고수량 <V_변경할수량)
        THEN RAISE USER_DEFINE_ERROR1;
    ELSIF (V_변경할수량 = V_기존출고수량)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    --UPDASATE 쿼리문 → TBL_출고
    UPDATE TBL_출고
    SET 출고수량 = V_변경할수량
    WHERE 출고번호 = V_출고번호;
    
    --UPDASATE 쿼리문 → TBL_상품
    /*
    UPDATE (SELECT S.상품코드, S.재고수량, C.출고번호,C.출고수량
            FROM TBL_상품 S JOIN TBL_출고 C
            ON S.상품코드 = C.상품코드) T
    SET T.재고수량 = T.재고수량 - (V_변경할수량-V_기존출고수량)
    WHERE T.출고번호 = V_출고번호;
    */
    UPDATE TBL_상품
    SET 재고수량 = (재고수량 + V_기존출고수량) - V_변경할수량
    WHERE 상품코드 = (SELECT 상품코드
                      FROM TBL_출고
                      WHERE 출고번호 = V_출고번호);
    
    --예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20003,'재고수량부족   재고수량 :'||V_상품재고수량);
                ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20004,'변경사항없음. 기존출고수량 :'||V_기존출고수량);
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    --커밋
    --COMMIT;
END;
--==>>Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
------------------------------풀이------------------------------
CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(
    -- ① 매개변수 구성
 V_출고번호      IN TBL_출고.출고번호%TYPE
,V_출고수량    IN TBL_출고.출고수량%TYPE 
)
IS
    -- ③ 필요한 변수 선언
    V_상품코드      TBL_상품.상품코드%TYPE;
    V_이전출고수량  TBL_출고.출고수량%TYPE;
    V_재고수량      TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ④ 선언한 변수엥 값 담아내기
    -- ⑥
    SELECT 상품코드,출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- ⑧ 출고 정상수행여부 판단 필요
    --    변경 이전의 출고수량 및 현재의 재고수량 확인
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- ⑨ 파악한 재고수량에 따라 데이터 변경 실시 여부 판단
    --    (『재고수량+이전출고수량 < 현재출고수량』인 상황이라면...사용자정의예외 발생)
    IF (V_재고수량+ V_이전출고수량 < V_출고수량)
        -- 사용자정의 예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ② 수행될 쿼리문 체크(UPDATE→TBL_출고 / UPDATE→TBL_상품)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- ⑦ 커밋
    COMMIT;
    
    -- ⑩ 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'재고 부족 ~!!!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>>Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
/*
1. PRC_입고_UPDATE(입고번호, 입고수량)
2. PRC_입고_DELETE(입고번호) : 입고제거 (입고제거하면 상품테이블 재고 돌리기)
3. PRC_출고_DELETE(출고번호) : 출고제거 (출고제거하면 상품테이블 재고 돌리기)
*/
-- 1.PRC_입고_UPDATE(입고번호, 입고수량)
-- 입고수량 변경(입고테이블,상품테이블)
-- UPDATE 쿼리문 → 입고테이블 : 입고번호 = V_입고번호, 입고수량 변경
--               → 상품테이블 : 입고번호 = V_입고번호의 상품코드에서 
--                               재고수량 = 재고수량 - 기존입고수량 + 변경된입고수량
-- 예외 : 변경하는입고수량이 음수이면 에러발생
--        변경하는입고수량 = 기존입고수량 에러발생
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
(V_입고번호     IN TBL_입고.입고번호%TYPE
,V_입고수량     IN TBL_입고.입고수량%TYPE
)
IS
    -- 추가 변수 선언
    V_상품코드  TBL_상품.상품코드%TYPE;
    V_기존입고수량 TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR1     EXCEPTION; -- 입고수량 음수일때,
    USER_DEFINE_ERROR2     EXCEPTION; -- 입고수량 = 기존입고수량 일때,
BEGIN
    --변수에 값 담아내기
    SELECT 상품코드,입고수량 INTO V_상품코드, V_기존입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    --예외발생
    IF (V_입고수량 <0)
        THEN RAISE USER_DEFINE_ERROR1;
    ELSIF (V_입고수량 = V_기존입고수량)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    --UPDATE 쿼리문 → TBL_입고
    UPDATE TBL_입고 
    SET 입고수량 = V_입고수량
    WHERE 입고번호 = V_입고번호;
    
    --UPDATE 쿼리문 → TBL_상품
    --재고수량 = 재고수량 - 기존입고수량 + 변경된입고수량
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_기존입고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    --커밋
    COMMIT;
    
    --예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20005, '입고수량은 양수만 입력 가능');
                ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20006, '변동사항없음. 현재입고수량 :' || V_기존입고수량);
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
        
END;
--==>>Procedure PRC_입고_UPDATE이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
(V_입고번호 IN TBL_입고.입고번호%TYPE)
IS
    --추가 변수 선언
    V_상품코드  TBL_상품.상품코드%TYPE;
    V_입고수량  TBL_입고.입고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
    V_입고일자  TBL_입고.입고일자%TYPE;
    V_출고일자  TBL_출고.출고일자%TYPE;
BEGIN
    --값 담아내기
    SELECT 상품코드,입고수량,입고일자 INTO V_상품코드, V_입고수량, V_입고일자
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;

    SELECT MAX(출고일자) INTO V_출고일자
    FROM TBL_출고
    WHERE 상품코드 = V_상품코드 AND (V_입고일자 <= 출고일자);
    
    --예외발생
    -- 입고일자 < 출고일자 (상품코드 = 상품코드)
    IF (V_입고일자 < V_출고일자)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    --UPDATE 쿼리문 → 상품테이블.재고수량
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    --DELETE 쿼리문 → 입고테이블 컬럼
    DELETE 
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    --커밋
    COMMIT;
    
    -- 예외처리
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007,'이미 출고가 시작되어 입고취소 불가.출고일: '||V_출고일자);
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
END;
--==>>Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.

--예외상황1.
--입고테이블 입고번호 1번에서 00상품을 100개 입고함
--재고수량 100개
--입고테이블 입고번호 2번에서 00상품을 50개 입고함
--재고수량150개
--출고테이블에서 출고번호 1번에서 00 상품을 150개 출고함
--재고수량 0개
--근데 여기서 입고DELETE로 1번을 삭제하면
--재고수량에서 입고번호1번의 입고수량을 빼야하는데
--출고는? 그래서 이미 출고가 된 상황이면 뺄수가 없자나
--재고수량 < 입고수량 → 프로시저 실행 불가?
--이거보다는
--입고한 뒤에 출고가 이루어졌으면 프로시저 실행불가?
-- -----------------------------------
-- 입고일자 < 출고일자 (상품코드 = 상품코드)
-- 이러면 이미 출고가 시작되어 입고취소 불가.


--3.PRC_출고_DELETE(출고번호)
CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(V_출고번호 IN TBL_출고.출고번호%TYPE)
IS
    --추가 변수 선언
    V_상품코드 TBL_상품.상품코드%TYPE;
    V_출고수량 TBL_출고.출고수량%TYPE;
BEGIN
    -- 값 담아내기
    SELECT 상품코드,출고수량 INTO V_상품코드,V_출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --UPDATE 쿼리문 → 상품테이블
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    --DELETE 쿼리문 → 출고테이블
    DELETE
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --커밋
    COMMIT;
END;
--==>>Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.

--예외상황
--재고수량 10개
--출고 10개
--재고수량 0개
--입고 5개 
--재고5개
--출고취소
--재고 15개
-- 여기선 예외상황이 없는 듯하다 ...
--------------------------------------------------------------------------------
--■■■ CURSOR(커서) ■■■--

-- 1. 오라클에서는 하나의 레코드가 아닌 여러 레코드로 구성된
--    작업 영역에서 SQL 문을 실행하고 그 과정에서 발생한 정보를
--    저장하기 위해 커서(CURSOR)를 사용하며,
--    커서에는 암시적인 커서와 명시적인 커서가 있다.

-- 2. 암시적 커서는 모든 SQL 구문에 존재하며
--    SQL 문 실행 후 오직 하나의 행(ROW)만 출력하게 된다.
--    그러나 SQL 문을 실행한 결과물(RESULT SET)이
--    여러 행(ROW)으로 구성된 경우
--    커서(CURSOR)를 명시적으로 선언해야 여러 행(ROW)을 다룰 수 있다.

--○ 커서 이용 전 상황(단일 행 접근 시)
SET SERVEROUTPUT ON;
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.

DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL  TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME,V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
--==>>
/*
홍길동 -- 011-2356-4528
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 커서 이용 전 상황(다중 행 접근 시)
DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL  TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME,V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
--==>>에러발생
--    01422. 00000 -  "exact fetch returns more than requested number of rows"

--○ 커서 이용 전 상황(다중 행 접근 시 - 반복문 활용)
DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL  TBL_INSA.TEL%TYPE;
    V_NUM  TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME,V_TEL
        FROM TBL_INSA
        WHERE NUM=V_NUM;        --WHERE NUM=1001;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM >= 1061;
    END LOOP;
    
    
END;
--==>>
/*
홍길동 -- 011-2356-4528
이순신 -- 010-4758-6532
이순애 -- 010-4231-1236
김정훈 -- 019-5236-4221
한석봉 -- 018-5211-3542
이기자 -- 010-3214-5357
장인철 -- 011-2345-2525
김영년 -- 016-2222-4444
나윤균 -- 019-1111-2222
김종서 -- 011-3214-5555
유관순 -- 010-8888-4422
정한국 -- 018-2222-4242
조미숙 -- 019-6666-4444
황진이 -- 010-3214-5467
이현숙 -- 016-2548-3365
이상헌 -- 010-4526-1234
엄용수 -- 010-3254-2542
이성길 -- 018-1333-3333
박문수 -- 017-4747-4848
유영희 -- 011-9595-8585
홍길남 -- 011-9999-7575
이영숙 -- 017-5214-5282
김인수 -- 
김말자 -- 011-5248-7789
우재옥 -- 010-4563-2587
김숙남 -- 010-2112-5225
김영길 -- 019-8523-1478
이남신 -- 016-1818-4848
김말숙 -- 016-3535-3636
정정해 -- 019-6564-6752
지재환 -- 019-5552-7511
심심해 -- 016-8888-7474
김미나 -- 011-2444-4444
이정석 -- 011-3697-7412
정영희 -- 
이재영 -- 011-9999-9999
최석규 -- 011-7777-7777
손인수 -- 010-6542-7412
고순정 -- 010-2587-7895
박세열 -- 016-4444-7777
문길수 -- 016-4444-5555
채정희 -- 011-5125-5511
양미옥 -- 016-8548-6547
지수환 -- 011-5555-7548
홍원신 -- 011-7777-7777
허경운 -- 017-3333-3333
산마루 -- 018-0505-0505
이기상 -- 
이미성 -- 010-6654-8854
이미인 -- 011-8585-5252
권영미 -- 011-5555-7548
권옥경 -- 010-3644-5577
김싱식 -- 011-7585-7474
정상호 -- 016-1919-4242
정한나 -- 016-2424-4242
전용재 -- 010-7549-8654
이미경 -- 016-6542-7546
김신제 -- 010-2415-5444
임수봉 -- 011-4151-4154
김신애 -- 011-4151-4444


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/
/*
일반변수 → 선언
예외변수 → 선언
커서 → 정의

변수명 타입
예외변수명 타입
커서명 CURSOR(X)

커서 → 정의
(『변수명 타입』 이랑 순서가 다름 얘네는 선언한다.)
--얘네는 정의한다.
TABLE 테이블명
INDEX 인덱스명
USER 사용자명
CURSOR 커서명(○)
*/
--○ 커서 이용 후 상황
DECLARE
    -- 주요 변수 선언
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
BEGIN
END;

