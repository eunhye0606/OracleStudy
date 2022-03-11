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

--○ TBL_MEMBER 테이블에 데이터를 입력하는 프로시저를 작성
--   단, 이 프로시저를 통해 데이터를 입력할 경우
--   CITY(지역) 항목에 '서울' , '경기','대전' 만 입력이 가능하도록 구성한다.
--   이 지역 외의 다른 지역을 프로시저 호출을 통해 입력하고자 하는 경우
--   (즉, 입력을 시도하는 경우)
--   예외에 대한 처리를 하려고 한다.

/*
실행 예)
EXEC PRC_MEMBER_INSERT('임소민','010-1111-1111','서울');
--==>> 데이터 입력 O
EXEC PRC_MEMBER_INSERT('이연주','010-2222-2222','부산');
--==>> 데이터 입력 X
*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
(V_NAME         IN TBL_MEMBER.NAME%TYPE
,V_TEL          IN TBL_MEMBER.TEL%TYPE
,V_CITY         IN TBL_MEMBER.CITY%TYPE
)
IS
    --선언부(주요 변수 선언)
    --변수명  데이터타입;
    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 선언①
    -- ※ 오라클에서는 예외도 변수이다.②
    
    --①
    V_NUM   TBL_MEMBER.NUM%TYPE;
    --② 사용자 정의 예외에 대한 변수 선언 CHECK ~!!!
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지 아닌지의 여부를
    -- 가장 먼저 확인할 수 있도록 코드 구성
    -- 진행 X 이면, INSERT 구문 안돌아감.
    IF (V_CITY NOT IN ('서울','경기','대전'))
        -- 예외 발생 CHECK ~ !!!
        THEN RAISE USER_DEFINE_ERROR;       --예외발생시, 뒤에는 건너뛰고 예외처리구문으로 이동.
    END IF;
    
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM),0) + 1 INTO V_NUM
    FROM TBL_MEMBER;
    
    -- 쿼리문 구성 → INSERT
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES(V_NUM,V_NAME, V_TEL, V_CITY);
    
    -- 예외 처리 구문
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'서울,경기,대전만 입력이 가능합니다.');
                 ROLLBACK;
        WHEN OTHERS     --USER_DEFINE_ERROR가 아니면 ...
            THEN ROLLBACK;
            --RAISE_APPLICATION_ERROR()
            --20000번까지는 오라클의 에러
            --프로젝트하면서 규칙
            --ex) 클라이언트에러는 2100번대
            --    서버 에러는 2200번대...
    -- 커밋
    COMMIT;
END;
--==>>Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.

--RAISE USER_DEFINE_ERROR 이걸로 실행부에서 예외발생시,
--뒤에 쿼리 다 무시하고 예외처리로 직행, 롤백까지1!!!
--RAISE USER_DEFINE_ERROR이거 아닌 예외들은 일단 뒤에 구문 실행하고
--에러 발생되면 롤백!


--○ TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 변동
--   단, 출고번호는 입고번호와 마찬가지로 자동 증가.
--   또한, 출고수량이 재고수량보다 많은 경우....
--   출고 액션을 취소할 수 있도록 처리한다.(출고가 이루어지지 않도록...) → 예외처리
/*
실행 예)
EXEC PRC_출고_INSERT('H001',10,600);

-- 현재 상품 테이블의 바밤바 재고수량은 50개
EXEC PRC_출고_INSERT('H001',10,600);
--==>>에러 발생
--    재고부족
*/
CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
(V_상품코드     IN TBL_상품.상품코드%TYPE     
,V_출고수량     IN TBL_출고.출고수량%TYPE
,V_출고단가     IN TBL_출고.출고단가%TYPE
)
IS
    -- 선언부
    --추가 주요 변수 선언
    V_출고번호  TBL_출고.출고번호%TYPE;
    N_재고수량  TBL_상품.재고수량%TYPE;
    
    -- 예외 변수 선언.
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- 실행부
    SELECT 재고수량 INTO N_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    --예외발생
    IF (N_재고수량 < V_출고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT NVL(MAX(출고번호),0) + 1 INTO V_출고번호
    FROM TBL_출고;
    
    -- 출고 테이블 INSERT 쿼리문
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
    VALUES(V_출고번호,V_상품코드,V_출고수량,V_출고단가);
    
    -- 상품 테이블 UPDATE 쿼리문
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    --예외 처리
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'재고부족');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    --커밋
    COMMIT;
END;
--==>>Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------
--풀이
-- 프로시저에 값 넘겨주는 순서대로 인식(상품코드, 출고수량, 출고단가)
CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
(V_상품코드     IN TBL_상품.상품코드%TYPE
,V_출고수량     IN TBL_출고.출고수량%TYPE
,V_출고단가     IN TBL_출고.출고단가%TYPE
)
IS
    -- 주요 변수 선언
    V_재고수량  TBL_상품.재고수량%TYPE;
    V_출고번호  TBL_출고.출고번호%TYPE;
    
    -- 사용자 정의 예외 선언
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
        --쿼리문 수행 이전에 수행 여부를 확인하는 과정에서
        --재고 파악 → 기존 재고를 확인하는 과정이 선행되어야 한다.
        --그래야 프로시저 호출 시, 넘겨받는 출고수량과 비교가 가능하기 때문...
        SELECT 재고수량 INTO V_재고수량
        FROM TBL_상품
        WHERE 상품코드 = V_상품코드;
        
        -- 출고를 정상적으로 진행해 줄 것인지에 대한 여부 확인
        -- 위에서 파악한 재고수량보다 현재 프로시저에서 넘겨받은 출고수량이 많으면
        -- 예외발생~!!!!
        IF (V_출고수량 > V_재고수량)
            -- 예외 발생
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        -- 출고번호에 값 담아내기(편한대로 위에서 작성하면 리소스 낭비!)
        -- PL/SQL 에서는 코드의 순서 중요하다!
        -- 출고번호 얻어내기 → 위에서 선언한 변수에 값 담아내기
        SELECT NVL(MAX(출고번호),0) + 1 INTO V_출고번호
        FROM TBL_출고;
        
        --쿼리문 구성 → INSERT(TBL_출고)
        INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        VALUES(V_출고번호, V_상품코드, V_출고수량, V_출고단가);
        
        --쿼리문 구성 → UPDATE(TBL_상품)
        UPDATE TBL_상품
        SET 재고수량 = 재고수량 - V_출고수량
        WHERE 상품코드 = V_상품코드;
        
        -- 예외처리
        EXCEPTION
            WHEN USER_DEFINE_ERROR
                THEN RAISE_APPLICATION_ERROR(-20002,'재고 부족 ~!!!');
                    ROLLBACK;
            WHEN OTHERS
                THEN ROLLBACK;
        -- 커밋
        COMMIT;
END;
--==>>Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.

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
    IF(V_상품재고수량 <V_변경할수량 - V_기존출고수량)
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
    SET 재고수량 = 재고수량 - (V_변경할수량 - V_기존출고수량)
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



