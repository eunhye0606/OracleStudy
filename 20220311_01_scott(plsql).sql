SELECT USER
FROM DUAL;
--==>>SCOTT

--○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY,SUDANG
--   으로 구성된 컬럼 중 NUM 을 제외한
--   NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY,SUDANG
--   의 데이터 입력 시
-- NUM 컬럼(사원번호)의 값은
-- 기존 부여된 사원 번호의 마지막 번호 그 다음 번호를 자동으로 입력 처리할 수 있는
-- 프로시저로 구성한다.
-- 프로시저 명 : PRC_INSA_INSERT()
/*
EXEC PRC_INSA_INSERT('양윤정','970131-2234567',SYSDATE,'서울',010-8624-4553'.'개발부','대리',2000000,2000000)
*/
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
V_NUM       TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MAX(NUM) INTO V_NUM      --SELECT문 실행부에 넣을 때, 헷갈리지 말자!
    FROM TBL_INSA;
    
    V_NUM := V_NUM +1;
                
    INSERT INTO TBL_INSA(NUM,NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY,SUDANG)
    VALUES(V_NUM,V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY,V_SUDANG);
END;

--------------------------------------------------------------------------------
--풀이
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM       TBL_INSA.NUM%TYPE;
BEGIN
    --그룹함수 : NULL 제외
    --테이블 데이터 다 삭제되면 조회하면 NULL..
    --그래서 조회했을 때, NULL이면 테이블에 데이터 없음
    --그래서 NULL일때 0으로 조회
    SELECT MAX(NVL(NUM,0)) + 1 INTO V_NUM
    FROM TBL_INSA;
    
    INSERT INTO TBL_INSA(NUM,NAME,SSN,IBSADATE,CITY,TEL,BUSEO,JIKWI,BASICPAY,SUDANG)
    VALUES(V_NUM,V_NAME,V_SSN,V_IBSADATE,V_CITY,V_TEL,V_BUSEO,V_JIKWI,V_BASICPAY,V_SUDANG);
    
    COMMIT; --CHECK~!!
END;
--==>>Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.

--주의할점 4가지.
--입력인지, 출력인지, 입출력인지
--선언부 새미콜론
--이번에 한거처럼 테이블에 데이터 하나도 없을때도 프로시저 돌아갈 수 
--있도록 처리!
--프로시저 내에 COMMIT;




--------------------------------------------------------------------------------
--○ TBL_상품, TBL_입고 테이블을 대상으로
--   TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진 프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리(시퀀스 사용 X)
--   TBL_입고 테이블 구성 컬럼
--   :입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--   프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

--'H001', 30, 400
-- → 입고테이블의 데이터 입력(프로시저 매개변수로 전달받지 못한 나머지 값 → 자동 입력)
-- → 상품테이블의 바밤바 재고수량 30개
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
(V_상품코드     IN TBL_입고.상품코드%TYPE
,V_입고수량     IN TBL_입고.입고수량%TYPE
,V_입고단가     IN TBL_입고.입고단가%TYPE
)
IS
    --입고테이블 변수
    V_입고번호      TBL_입고.입고번호%TYPE;     
    V_입고일자      TBL_입고.입고일자%TYPE;
    --상품테이블 변수
    N_재고수량      TBL_상품.재고수량%TYPE;
BEGIN
    --입고테이블 변수값 할당.
    SELECT NVL(MAX(입고번호),0) +1 INTO V_입고번호
    FROM TBL_입고;
    
    V_입고일자 := SYSDATE;
    
    --입고테이블 INSERT
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
    VALUES(V_입고번호, V_상품코드, V_입고일자, V_입고수량, V_입고단가);
    
    --상품테이블 재고수량 = 입고수량
    N_재고수량 := V_입고수량;
    
    --상품테이블 재고수량 UPDATE
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + N_재고수량
    WHERE 상품코드 = V_상품코드;

END;

--==>>Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.


--------------------------------------------------------------------------------
--풀이

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
(V_상품코드     IN TBL_상품.상품코드%TYPE         --중복되는 컬럼은 부모테이블의 컬럼을 쓰는 것이 좋다!
,V_입고수량     IN TBL_입고.입고수량%TYPE
,V_입고단가     IN TBL_입고.입고단가%TYPE
)
IS
    --선언부
    --아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언
    V_입고번호  TBL_입고.입고번호%TYPE;
BEGIN
    -- 선언한 변수에 값 담아내기
    -- SELECT 쿼리문 수행
    SELECT NVL(MAX(입고번호),0) INTO V_입고번호
    FROM TBL_입고;
    
    --INSERT 쿼리문 수행
    INSERT INTO TBL_입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
    VALUES((V_입고번호)+1,V_상품코드,SYSDATE,V_입고수량,V_입고단가);      -- 아니면 입고일자를 아예빼두됨. 테이블 생성시, 
                                                                -- 입고일자를 DEFULT SYSDATE 해둬서.
    --UPDATE 쿼리문 수행
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리(INSERT만 하고 서비스 다운됐을 때 ...
    --           둘 중 하나만 수행 되었을 때,...
    --           여기서 명시한 상황이 아닌 다른 상황이 발생했을 때..)
    EXCEPTION       --자바의 try ~ catch
        WHEN OTHERS THEN ROLLBACK;
    --커밋
    COMMIT;
END;
--==>>Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
--■■■ 프로시저 내에서의 예외 처리 ■■■--



