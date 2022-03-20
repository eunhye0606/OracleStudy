SELECT USER
FROM DUAL;
--==>>TEAM4
--------------------------------------------------------------------------------
-- [교수테이블에 데이터 넣는 프로시저]
--1.프로시저 명: PRC_TC_INSERT(이름, 주민번호)
--  프로시저 존재 이유 : TEACHER_REGISTER 테이블에 관리자가 교수정보 사전 등록
CREATE OR REPLACE PROCEDURE PRC_TC_INSERT
(V_NAME IN TEACHER_REGISTER.NAME%TYPE
,V_SSN  IN TEACHER_REGISTER.SSN%TYPE
)
IS
    V_TEACHER_CODE  TEACHER_REGISTER.TEACHER_CODE%TYPE; --T0001부터 시작.       
    V_PASSWORD      TEACHER_REGISTER.PASSWORD%TYPE;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(TEACHER_CODE,2))),0)  + 1 INTO V_TEACHER_CODE
    FROM TEACHER_REGISTER;
    
    V_TEACHER_CODE := 'T' || LPAD(TO_CHAR(V_TEACHER_CODE),4,0);
    
    V_PASSWORD := SUBSTR(V_SSN,7);
    
   INSERT INTO  TEACHER_REGISTER(TEACHER_CODE,PASSWORD,NAME,SSN)
   VALUES(V_TEACHER_CODE,V_PASSWORD, V_NAME, V_SSN);
    
END;
--------------------------------------------------------------------------------
--2. 관리자가 교수의 모든 정보를 출력하는 SELECT 쿼리     
-- [관리자가 교수정보 출력하는 프로시저]
-- 관리자는 등록된 모든 교수자의 정보를 출력하여 볼 수 있어야 한다
-- 프로시저 명 : PRC_TC_SELECT(매니저코드)
-- 프로시저 존재이유 : 관리자는 모든 교수 정보를 출력할 수 있다.
-- 고려사항
-- (1). 매니저만 교수정보를 출력할 수 있다.
-- (2). MANAGER_REGISTER에서 MANAGER_CODE와 일치하는지 확인 후, 출력 진행.
-- 출력 항목 : 교수명, 과목명, 과목시간(시작, 끝), 교재명, 강의실, 강의진행여부
CREATE OR REPLACE PROCEDURE PRC_TC_SELECT
(V_CODE     IN MANAGER_REGISTER.MANAGER_CODE%TYPE
)
IS  
    -- 커서 데이터 담는 변수 선언
    V_TC_NAME   TEACHER_REGISTER.NAME%TYPE;     --교수명
    V_SUB_NAME  SUBJECT.SUBJECT_NAME%TYPE;      --과목명
    V_SDATE     SUBJECT_OPEN.START_DATE%TYPE;   --과목시작시간
    V_EDATE     SUBJECT_OPEN.END_DATE%TYPE;     --과목종료시간
    V_TEXTBOOK  TEXTBOOK.TEXTBOOK_NAME%TYPE;    --교재명
    V_CLANAME   CLASSROOM_REGISTER.CLASSROOM_NAME%TYPE; -- 강의실명
    V_CHECK     VARCHAR2(20);                   --강의진행여부
    
    -- 커서 정의
    CURSOR CUR_TC_SELECT
    
    IS
    SELECT TC.NAME "교수명"
       ,S.SUBJECT_NAME "과목명"     --과목테이블
       ,SO.START_DATE "과목시작시간" --과목개설테이블
       ,SO.END_DATE "과목종료시간" --과목개설테이블
       ,T.TEXTBOOK_NAME "교재명"       --교재테이블
       ,CR.CLASSROOM_NAME"강의실"       --강의실테이블
       ,CASE WHEN CO.START_DATE - SYSDATE < 0 AND CO.END_DATE -SYSDATE >= 0
             THEN '강의중'
             WHEN CO.START_DATE - SYSDATE >= 0
             THEN '강의예정'
             WHEN CO.END_DATE - SYSDATE < 0 
             THEN '강의종료'
             ELSE '알수없음.'
             END "강의진행여부" 
    FROM TEACHER_REGISTER TC JOIN COURSE_OPEN CO
    ON TC.TEACHER_CODE = CO.TEACHER_CODE JOIN CLASSROOM_REGISTER CR
    ON CO.CLASSROOM_CODE = CR.CLASSROOM_CODE JOIN SUBJECT_OPEN SO
    ON CO.OP_COURSE_CODE = SO.OP_COURSE_CODE JOIN SUBJECT S
    ON SO.SUBJECT_CODE = S.SUBJECT_CODE JOIN TEXTBOOK T
    ON SO.TEXTBOOK_CODE = T.TEXTBOOK_CODE;
    
    --등록된 관리자인지 판단하는 임시변수 선언
    --해당 매니저가 없으면 V_TEMP에 0값 담김.
    V_TEMP  NUMBER; 
  
    -- 사용자 에러변수 선언 
    USER_DEFINE_ERROR1   EXCEPTION;  -- 20102,'관리자가 아닙니다. 교수정보출력은 관리자만 가능합니다'
    USER_DEFINE_ERROR2   EXCEPTION;  -- 20103,'등록된 관리자가 아닙니다.'

BEGIN
    -- 임시변수에 값 담기
    SELECT COUNT(*) INTO V_TEMP
    FROM MANAGER_REGISTER
    WHERE MANAGER_CODE = V_CODE;
    
    -- 관리자인지 확인. 관리자가 아니면 에러 발생.
    IF (SUBSTR(V_CODE,1,1) != 'M')
    THEN RAISE USER_DEFINE_ERROR1;
    -- 등록된 관리자가 아니면 에러 발생
    ELSIF (V_TEMP = 0)
    THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 커서 오픈
    OPEN CUR_TC_SELECT;
    
    -- 커서의 데이터 처리
    LOOP
        FETCH CUR_TC_SELECT INTO V_TC_NAME,V_SUB_NAME,V_SDATE,V_EDATE,V_TEXTBOOK,V_CLANAME,V_CHECK;
        
        EXIT WHEN CUR_TC_SELECT%NOTFOUND;
        
        --출력
        
        DBMS_OUTPUT.PUT_LINE('교수명:'||V_TC_NAME||CHR(10) 
                             ||'과목명'|| V_SUB_NAME||CHR(10)
                             ||'과목시작날짜'||V_SDATE||CHR(10)
                             ||'과목종료날짜'||V_EDATE||CHR(10)
                             ||'교재명'||V_TEXTBOOK||CHR(10)
                             ||'강의실명'||V_CLANAME||CHR(10)
                             ||'강의진행여부'||V_CHECK||CHR(10)||CHR(10)
                             ||'----------------------------------------'||CHR(10));
    END LOOP;
    
    -- 커서 클로즈
    CLOSE CUR_TC_SELECT;
    
    
    -- 예외처리
    EXCEPTION
    WHEN USER_DEFINE_ERROR1
    THEN RAISE_APPLICATION_ERROR(-20102, '관리자가 아닙니다. 교수정보출력은 관리자만 가능합니다.');
    ROLLBACK;
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20103,'등록된 관리자가 아닙니다.');
    ROLLBACK;
    
    --커밋
    COMMIT;
END;

--------------------------------------------------------------------------------
--3. 트리거 명 : TRG_TC_DELETE
-- 트리거 존재이유 : 교수 정보 삭제 트리거
--                   부모테이블(TEACHER_REGISTER테이블에서 교수정보 삭제할 경우,
--                   자식 테이블(COURSE_OPEN의 TEACHER_CODE를 NULL 값으로 수정)
--                   참조관계가 없는 경우는 바로 DELETE 가능.
CREATE OR REPLACE TRIGGER TRG_TC_DELETE
       BEFORE
       DELETE ON TEACHER_REGISTER
       FOR EACH ROW
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = NULL
    WHERE TEACHER_CODE = :OLD.TEACHER_CODE; 
END;
--------------------------------------------------------------------------------
--[과정개설테이블에 데이터 넣는 프로시저]
--4. 프로시저 명 : (과정코드, 시작일자, 종료일자, 강의실코드)
--   프로시저 존재이유 : 관리자가 과정을 미리 등록한다.
CREATE OR REPLACE PROCEDURE PRC_OP_COU_INSERT
(N_CODE      IN COURSE.COURSE_CODE%TYPE                     --과정코드
,N_SDATE    IN COURSE_OPEN.START_DATE%TYPE                  --시작날짜
,N_EDATE    IN COURSE_OPEN.END_DATE%TYPE                    --종료날짜
,N_CLACODE      IN CLASSROOM_REGISTER.CLASSROOM_CODE%TYPE     --강의실코드. 
)
IS
    V_OP_COURSE_CODE    COURSE_OPEN.OP_COURSE_CODE%TYPE;    -- 과정개설코드   C1 C2 C2...
BEGIN
    
    -- 과정개설코드 자동으로 부여
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_COURSE_CODE,3))),0) + 1 INTO V_OP_COURSE_CODE
    FROM COURSE_OPEN;
    
    V_OP_COURSE_CODE := 'C' || V_OP_COURSE_CODE;
    
    INSERT INTO COURSE_OPEN
    (OP_COURSE_CODE ,COURSE_CODE ,CLASSROOM_CODE ,START_DATE ,END_DATE) 
    VALUES(V_OP_COURSE_CODE,  N_CODE,N_CLACODE, TO_DATE(N_SDATE,'YYYY-MM-DD') ,TO_DATE(N_EDATE,'YYYY-MM-DD'));
    
END;
--------------------------------------------------------------------------------
-- [과목개설테이블에 데이터넣는 프로시저]
--5.프로시저 명 :PRC_OP_SUB_INSERT(과정개설코드, 과목코드, 시작날짜, 종료날짜, 교재코드, 교수코드)
--  프로시저 존재이유 : 관리자는 여러개의 과목을 미리 등록할 수 있다.
--  고려사항
--  (1).교수명(과정개설코드와 일치할때 거기 교수명과 일치하는지 판단)
--  (2).과목기간은 과정기간안에 속해야 한다.
--  (3).과목 기간은 겹쳐서는 안된다. 

--  (4).출결,필기,실기배점은 NN값 가능
--  (5).교수가 출결, 필기, 실기 배점 UPDATE하는 프로시저                                             필요
--      (출결필기실기는 교수자 권한이다.)
CREATE OR REPLACE PROCEDURE PRC_OP_SUB_INSERT
(V_OP_COURSE_CODE   IN COURSE_OPEN.OP_COURSE_CODE%TYPE     --과정개설코드
,V_SUBJECT_CODE     IN SUBJECT.SUBJECT_CODE%TYPE           --과목코드
,V_START_DATE       IN SUBJECT_OPEN.START_DATE%TYPE        --시작날짜
,V_END_DATE         IN SUBJECT_OPEN.END_DATE%TYPE          --종료날짜
,V_TEXTBOOK_CODE    IN TEXTBOOK.TEXTBOOK_CODE%TYPE         --교재코드
,V_TEACHER_CODE     IN TEACHER_REGISTER.TEACHER_CODE%TYPE  --교수코드
)
IS
    --주요 변수 선언
    V_OP_SUBJECT_CODE    SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE; --과목개설코드 OSC1 OSC2 OSC3...
    
    V_TCCODE    TEACHER_REGISTER.TEACHER_CODE%TYPE; -- 과정의 교수담는 변수
    
    V_SUB_COUNT  NUMBER;  -- 과정안에 과목 몇개있는지 세는 변수.
    V_COU_SDATE COURSE_OPEN.START_DATE%TYPE;    --과정시작날짜
    V_COU_EDATE COURSE_OPEN.END_DATE%TYPE;      --과정종료날짜
    V_SUB_EDATE SUBJECT_OPEN.END_DATE%TYPE;     --과목종료날짜
    
    USER_DEFINE_ERROR1  EXCEPTION;  -- 20303, '담당 교수가 배정되지 않은 과목입니다.'                       
    USER_DEFINE_ERROR2  EXCEPTION;  -- 20304, '입력정보의 교수와 해당과정의 교수가 일치하지 않습니다.'
    USER_DEFINE_ERROR3  EXCEPTION;  -- 20305,'과목기간이 과정기간에 포함되지 않습니다.'
    USER_DEFINE_ERROR4  EXCEPTION;  -- 20306,'과목기간이 중복됩니다. 다시 확인해주세요'
BEGIN  
    -- 해당 과정의 교수코드를 받아서 변수값에 담는다.
    SELECT TEACHER_CODE INTO V_TCCODE
    FROM COURSE_OPEN
    WHERE OP_COURSE_CODE = V_OP_COURSE_CODE;
   
    -- 교수코드가 NULL 이면 에러발생.
    IF (V_TCCODE IS NULL)
    THEN RAISE USER_DEFINE_ERROR1;
    -- 교수코드가 개설과정의 교수코드와 다르면 에러발생.
    ELSIF (V_TEACHER_CODE != V_TCCODE)
    THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 과정기간 내에 과목기간이 포함되어야 한다.
    -- 1. 과정시작날짜, 종료날짜 변수값 담기.
    SELECT START_DATE, END_DATE INTO V_COU_SDATE, V_COU_EDATE
    FROM COURSE_OPEN
    WHERE OP_COURSE_CODE = V_OP_COURSE_CODE;
    
    -- 에러발생경우
    -- 과정기간의 시작날짜 - 과목기간의 시작날짜  > 0
    -- 과목기간의 종료날짜 - 과정기간의 종료날짜 > 0
    IF (V_COU_SDATE - V_START_DATE > 0 OR V_END_DATE - V_COU_EDATE > 0)
    THEN RAISE USER_DEFINE_ERROR3;
    END IF;
      
    -- 과목기간끼리는 중복돼서는 안된다.
    -- 해당 과정에 가장 마지막인 종료날짜를 변수값에 담는다.
    -- 과정에 과목이 없으면 V_SUB_EDATE에는 NULL값이 담긴다.
    SELECT MAX(END_DATE) INTO V_SUB_EDATE
    FROM SUBJECT_OPEN
    WHERE OP_COURSE_CODE = V_OP_COURSE_CODE;
    -- 있다면 → 가장 최근의 END_DATE - 입력되는 시작날짜 > 0
    IF (V_SUB_EDATE IS NOT NULL AND (V_SUB_EDATE - V_START_DATE > 0))
    THEN RAISE USER_DEFINE_ERROR4;
    END IF;
    -- 없다면 → 입력되는 값이 첫번째 과목이 된다.
   
    -- 과목개설코드에 값 담아내기
    -- SUBJECT 코드 : OSC1, OSC2,.... 
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_SUBJECT_CODE,3))),0) + 1 INTO V_OP_SUBJECT_CODE
    FROM SUBJECT_OPEN;
    
    V_OP_SUBJECT_CODE := 'OSC' || V_OP_SUBJECT_CODE;
    
    
    -- INSERT 쿼리문
    INSERT INTO SUBJECT_OPEN
    (OP_SUBJECT_CODE, SUBJECT_CODE, TEXTBOOK_CODE, OP_COURSE_CODE, START_DATE, END_DATE)
    VALUES(V_OP_SUBJECT_CODE, V_SUBJECT_CODE, V_TEXTBOOK_CODE, V_OP_COURSE_CODE, TO_DATE(V_START_DATE,'YYYY-MM-DD') ,TO_DATE(V_END_DATE,'YYYY-MM-DD') );

    --예외처리
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
        THEN RAISE_APPLICATION_ERROR(-20303, '담당 교수가 배정되지 않은 과목입니다.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR2
        THEN RAISE_APPLICATION_ERROR(-20304, '입력정보의 교수와 해당과정의 교수가 일치하지 않습니다.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR3
        THEN RAISE_APPLICATION_ERROR(-20305,'과목기간이 과정기간에 포함되지 않습니다.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR4
        THEN RAISE_APPLICATION_ERROR(-20306,'과목기간이 중복됩니다. 다시 확인해주세요');
        ROLLBACK;
    --커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--6.[관리자가 과목정보 출력하는 프로시저]
-- 관리자는 등록된 모든 과목의 정보를 출력하여 볼 수 있어야 한다. 
-- 프로시저 명 : PRC_SUB_OP_SELECT(매니저코드)
-- 프로시저 존재이유 : 관리자는 개설된 모든 과목 정보를 출력할 수 있다.
-- 고려사항
-- (1). 매니저만 교수정보를 출력할 수 있다.
-- (2). MANAGER_REGISTER에서 MANAGER_CODE와 일치하는지 확인 후, 출력 진행.
-- 출력 항목 : 과정명, 강의실, 과목명, 과목기간, 교재명, 교수자명
CREATE OR REPLACE PROCEDURE PRC_SUB_OP_SELECT
(V_CODE     IN MANAGER_REGISTER.MANAGER_CODE%TYPE
)
IS  
    -- 커서 데이터 담는 변수 선언
    V_CNAME     COURSE.COURSE_NAME%TYPE;        --과정명
    V_CLANAME   CLASSROOM_REGISTER.CLASSROOM_NAME%TYPE; -- 강의실명
    V_SUB_NAME  SUBJECT.SUBJECT_NAME%TYPE;      --과목명
    V_SDATE     SUBJECT_OPEN.START_DATE%TYPE;   --과목시작날짜
    V_EDATE     SUBJECT_OPEN.END_DATE%TYPE;     --과목종료날짜
    V_TEXTBOOK  TEXTBOOK.TEXTBOOK_NAME%TYPE;    --교재명
    V_TC_NAME   TEACHER_REGISTER.NAME%TYPE;     --교수명
    
    -- 커서 정의
    CURSOR CUR_SUB_OP_SELECT
    IS
    SELECT T2.과정명, T2.강의실명, T1.과목명
       ,T1.과목시작날짜,T1.과목종료날짜
       ,T1.교재명, T2.교수자명
    FROM
    (
        SELECT SO.START_DATE "과목시작날짜"
               ,SO.END_DATE "과목종료날짜"
               ,S.SUBJECT_NAME "과목명"
               ,T.TEXTBOOK_NAME "교재명"
               ,SO.OP_COURSE_CODE "과정개설코드"
        FROM SUBJECT_OPEN SO JOIN SUBJECT S
        ON SO.SUBJECT_CODE = s.SUBJECT_CODE JOIN TEXTBOOK T
        ON SO.TEXTBOOK_CODE = T.TEXTBOOK_CODE
    )T1 JOIN
    (
        SELECT C.COURSE_NAME "과정명"
               ,CR.CLASSROOM_NAME "강의실명"
               ,CO.OP_COURSE_CODE "과정개설코드"
               ,TR.NAME "교수자명"
        FROM COURSE_OPEN CO JOIN COURSE C 
        ON CO.COURSE_CODE = C.COURSE_CODE JOIN CLASSROOM_REGISTER CR 
        ON CO.CLASSROOM_CODE = CR.CLASSROOM_CODE JOIN TEACHER_REGISTER TR
        ON CO.TEACHER_CODE = TR.TEACHER_CODE
    )T2
    ON T1.과정개설코드 = T2.과정개설코드;
    
    --등록된 관리자인지 판단하는 임시변수 선언
    --해당 매니저가 없으면 V_TEMP에 0값 담김.
    V_TEMP  NUMBER; 
  
    -- 사용자 에러변수 선언 
    USER_DEFINE_ERROR1   EXCEPTION;  -- 20102,'관리자가 아닙니다. 교수정보출력은 관리자만 가능합니다'
    USER_DEFINE_ERROR2   EXCEPTION;  -- 20103,'등록된 관리자가 아닙니다.'

BEGIN
    -- 임시변수에 값 담기
    SELECT COUNT(*) INTO V_TEMP
    FROM MANAGER_REGISTER
    WHERE MANAGER_CODE = V_CODE;
    
    -- 관리자인지 확인. 관리자가 아니면 에러 발생.
    IF (SUBSTR(V_CODE,1,1) != 'M')
    THEN RAISE USER_DEFINE_ERROR1;
    -- 등록된 관리자가 아니면 에러 발생
    ELSIF (V_TEMP = 0)
    THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 커서 오픈
    OPEN CUR_SUB_OP_SELECT;
    
    -- 커서의 데이터 처리
    /*
        V_CNAME     COURSE.COURSE_NAME%TYPE;        --과정명
    V_CLANAME   CLASSROOM_REGISTER.CLASSROOM_NAME%TYPE; -- 강의실명
    V_SUB_NAME  SUBJECT.SUBJECT_NAME%TYPE;      --과목명
    V_SDATE     SUBJECT_OPEN.START_DATE%TYPE;   --과목시작날짜
    V_EDATE     SUBJECT_OPEN.END_DATE%TYPE;     --과목종료날짜
    V_TEXTBOOK  TEXTBOOK.TEXTBOOK_NAME%TYPE;    --교재명
    V_TC_NAME   TEACHER_REGISTER.NAME%TYPE;     --교수명
    */
    LOOP
        FETCH CUR_SUB_OP_SELECT INTO V_CNAME,V_CLANAME,V_SUB_NAME,V_SDATE,V_EDATE,V_TEXTBOOK,V_TC_NAME ;
        
        EXIT WHEN CUR_SUB_OP_SELECT%NOTFOUND;
        
        --출력
        
        DBMS_OUTPUT.PUT_LINE('과정명:'||V_CNAME||CHR(10) 
                             ||'강의실명'|| V_CLANAME||CHR(10)
                             ||'과목명'||V_SUB_NAME||CHR(10)
                             ||'과목시작날짜'||V_SDATE||CHR(10)
                             ||'과목종료날짜'||V_EDATE||CHR(10)
                             ||'교재명'||V_TEXTBOOK||CHR(10)
                             ||'교수명'||V_TC_NAME||CHR(10)||CHR(10)
                             ||'----------------------------------------'||CHR(10));
    END LOOP;
    
    -- 커서 클로즈
    CLOSE CUR_SUB_OP_SELECT;
    
    
    -- 예외처리
    EXCEPTION
    WHEN USER_DEFINE_ERROR1
    THEN RAISE_APPLICATION_ERROR(-20102, '관리자가 아닙니다. 교수정보출력은 관리자만 가능합니다.');
    ROLLBACK;
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20103,'등록된 관리자가 아닙니다.');
    ROLLBACK;
    
    --커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--[로그인 기능]
-- 프로시저 명 : PRC_LOGIN(아이디,비밀번호)
-- 프로시저 존재 이유 : ID, PW 가 일치하는지 확인한다.
CREATE OR REPLACE PROCEDURE PRC_LOGIN
--관리자PK, 학생PK, 교수PK 모두 VARCHAR2(10)
--관리자PW, 학생PW, 교수PW 모두 VARCHAR2(30)
( V_CODE  IN MANAGER_REGISTER.MANAGER_CODE%TYPE
, V_PW    IN MANAGER_REGISTER.PASSWORD%TYPE
)
IS
    V_CHECKID NUMBER;   --일치1, 불일치0
    V_CHECKPW NUMBER;   --일치1, 불일치0
    
    USER_DEFINE_ERROR1   EXCEPTION;           -- ID 불일치 에러
    USER_DEFINE_ERROR2   EXCEPTION;           -- PW 불일치 에러
    
BEGIN
    V_CHECKID := FN_ID_CHECK(V_CODE);
    V_CHECKPW := FN_PW_CHECK(V_PW);
   
    -- 로그인 IF문
    IF (V_CHECKID = 0 AND V_CHECKPW = 1)
    THEN RAISE USER_DEFINE_ERROR1;
    ELSIF (V_CHECKPW = 0 AND V_CHECKID = 1)
    THEN RAISE USER_DEFINE_ERROR2;
    ELSE
        DBMS_OUTPUT.PUT_LINE('로그인 성공~!!!');
    END IF;
    
    -- 로그인 실패 예외 처리
    EXCEPTION
       WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20100, '아이디가 일치하지 않습니다.');
                ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20103, '비밀번호가 일치하지 않습니다.');
                ROLLBACK;

    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--[아이디일치 함수]
-- 함수 명 : FN_ID_CHECK(ID)
-- 반환 : 일치하는 ID가 있으면 1, 없으면 0
CREATE OR REPLACE FUNCTION FN_ID_CHECK(ID MANAGER_REGISTER.MANAGER_CODE%TYPE)
RETURN NUMBER 
IS
    V_M NUMBER;
    V_T NUMBER;
    V_S NUMBER;
    V_RESULT    NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_T
    FROM TEACHER_REGISTER
    WHERE TEACHER_CODE = ID;
    
    SELECT COUNT(*) INTO V_M
    FROM MANAGER_REGISTER
    WHERE MANAGER_CODE = ID;
    
    SELECT COUNT(*) INTO V_S
    FROM STUDENT_REGISTER
    WHERE STUDENT_CODE = ID;
    
    IF (SUBSTR(ID,1,1) = 'M')
    THEN V_RESULT := V_M;
    ELSIF (SUBSTR(ID,1,1) = 'T')
    THEN V_RESULT := V_T;
    ELSIF (SUBSTR(ID,1,1) = 'S')
    THEN V_RESULT := V_S;
    ELSE
        V_RESULT := 0;
    END IF;
 
    RETURN V_RESULT;
END;

--------------------------------------------------------------------------------    
--[비밀번호일치 함수]
-- 함수 명 : FN_PW_CHECK(PW)
-- 반환 : 일치하는 PW가 있으면 1, 없으면 0
CREATE OR REPLACE FUNCTION FN_PW_CHECK(PW MANAGER_REGISTER.PASSWORD%TYPE)
RETURN NUMBER 
IS
    V_M NUMBER;
    V_T NUMBER;
    V_S NUMBER;
    V_RESULT    NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_T
    FROM TEACHER_REGISTER
    WHERE PASSWORD = PW;
    
    SELECT COUNT(*) INTO V_M
    FROM MANAGER_REGISTER
    WHERE PASSWORD = PW;
    
    SELECT COUNT(*) INTO V_S
    FROM STUDENT_REGISTER
    WHERE PASSWORD = PW;
    
    IF (V_M = 1 AND V_T = 0 AND V_S = 0)
    THEN V_RESULT := V_M;
    ELSIF (V_T = 1 AND V_M = 0 AND V_S = 0)
    THEN V_RESULT := V_T;
    ELSIF (V_S = 1 AND V_M = 0 AND V_T = 0)
    THEN V_RESULT := V_S;
    ELSE
        V_RESULT := 0;
    END IF;
 
    RETURN V_RESULT;
END;
--------------------------------------------------------------------------------