SELECT USER
FROM DUAL;
--==>>TEAM4

--------------------------------------------------------------------------------
-- 프로시저 명: PRC_TC_INSERT(이름, 주민번호)
-- 관리자가 프로시저를 실행시키면, 
-- 교수테이블에 데이터가 입력된다.
CREATE OR REPLACE PROCEDURE PRC_TC_INSERT
(V_NAME IN TEACHER_REGISTER.NAME%TYPE
,V_SSN  IN TEACHER_REGISTER.SSN%TYPE
)
IS
    V_TEACHER_CODE  TEACHER_REGISTER.TEACHER_CODE%TYPE;
    V_PASSWORD      TEACHER_REGISTER.PASSWORD%TYPE;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(TEACHER_CODE,2))),0)  + 1 INTO V_TEACHER_CODE
    FROM TEACHER_REGISTER;
    
    V_TEACHER_CODE := 'T' || TO_CHAR(V_TEACHER_CODE);
    
    V_PASSWORD := SUBSTR(V_SSN,7);
    
   INSERT INTO  TEACHER_REGISTER(TEACHER_CODE,PASSWORD,NAME,SSN)
   VALUES(V_TEACHER_CODE,V_PASSWORD, V_NAME, V_SSN);
    
END;
--==>>Procedure PRC_TC_INSERT이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
-- COURSE_OPEN 테이블에서 TEACHER_CODE가 NULL 값인 컬럼
-- 즉, TRG_TC_UPDATE로 인해서 TEACHER_CODE가 NULL값이 된 경우
-- 프로시저 명 : PRC_OP_COU_UPDATE 실행
-- 참조 관계이기 때문에 NULL값이거나 교수테이블에 있는 TEACHER_CODE만 
-- 프로시저 매개변수로 전달 가능.
/*
CREATE OR REPLACE PROCEDURE PRC_OP_COU_UPDATE
(V_TEACHER_CODE IN COURSE_OPEN.TEACHER_CODE%TYPE)
IS
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = V_TEACHER_CODE
    WHERE TEACHER_CODE IS NULL;
END;
*/ --삭제완료
--==>>Procedure PRC_OP_COU_UPDATE이(가) 컴파일되었습니다.


-- 부모테이블(TEACHER_REGISTER테이블에서 교수정보 삭제할 경우,
--            자식 테이블(COURSE_OPEN의 TEACHER_CODE를 NULL 값으로 수정)
-- 참조관계가 없는 경우는 바로 DELETE 가능!
CREATE OR REPLACE TRIGGER TRG_TC_DELETE
       BEFORE
       DELETE ON TEACHER_REGISTER
       FOR EACH ROW
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = NULL
    WHERE TEACHER_CODE = :OLD.TEACHER_CODE;
    --NULL값을 다른교수코드로 바꾸는 프로시저 호출
    -- 문제점 UPDATE의 WHERE 조건에 어떻게함.. 
END;

--==>>Trigger TRG_TC_UPDATE이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
--○ 프로시저 명 : PRC_OP_COU_INSERT(과정명, 시작날짜, 종료날짜, 강의실)
--   관리자가 과정을 개설한다.
CREATE OR REPLACE PROCEDURE PRC_OP_COU_INSERT
(N_NAME      IN COURSE.COURSE_NAME%TYPE                     --과정명
,N_SDATE    IN COURSE_OPEN.START_DATE%TYPE                  --시작날짜
,N_EDATE    IN COURSE_OPEN.END_DATE%TYPE                    --종료날짜
,N_CROOM      IN CLASSROOM_REGISTER.CLASSROOM_NAME%TYPE     --강의실이름. 
)
IS
    V_OP_COURSE_CODE    COURSE_OPEN.OP_COURSE_CODE%TYPE;    -- 과정개설코드
    V_COURSE_CODE       COURSE.COURSE_CODE%TYPE;       --과정명받은거 코드로 찾아서
    V_CLASSROOM_CODE    CLASSROOM_REGISTER.CLASSROOM_CODE%TYPE;    --강의실받은거 코드로 찾아서
BEGIN
    
    -- 과정개설코드 자동으로 부여
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_COURSE_CODE,3))),0) + 1 INTO V_OP_COURSE_CODE
    FROM COURSE_OPEN;
    
    V_OP_COURSE_CODE := 'CO' || V_OP_COURSE_CODE;
    
    
    -- 과정명 입력 받은걸 코드화하기
    SELECT COURSE_CODE INTO V_COURSE_CODE
    FROM COURSE
    WHERE COURSE_NAME = N_NAME;     --'자바과정'
    
    -- 강의실 입력 받은걸 코드화하기
    SELECT CLASSROOM_CODE INTO V_CLASSROOM_CODE
    FROM CLASSROOM_REGISTER
    WHERE CLASSROOM_NAME = N_CROOM; --'1501'
    
    INSERT INTO COURSE_OPEN
    (OP_COURSE_CODE ,COURSE_CODE ,CLASSROOM_CODE ,START_DATE ,END_DATE) 
    VALUES(V_OP_COURSE_CODE,  V_COURSE_CODE,  V_CLASSROOM_CODE, TO_DATE(N_SDATE,'YYYY-MM-DD') ,TO_DATE(N_EDATE,'YYYY-MM-DD'));
    
END;
--==>>Procedure PRC_OP_COU_INSERT이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
--2022-03-18 작업시작
--○ 트리거 명 수정
-- 부모테이블(TEACHER_REGISTER테이블에서 교수정보 삭제할 경우,
--            자식 테이블(COURSE_OPEN의 TEACHER_CODE를 NULL 값으로 수정)
-- 참조관계가 없는 경우는 바로 DELETE 가능!
CREATE OR REPLACE TRIGGER TRG_TC_DELETE
       BEFORE
       DELETE ON TEACHER_REGISTER
       FOR EACH ROW
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = NULL
    WHERE TEACHER_CODE = :OLD.TEACHER_CODE; 
END;
--==>>Trigger TRG_TC_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------
--○ 과정개설 프로시저 수정
--○ 프로시저 명 : PRC_OP_COU_INSERT(과정코드, 시작날짜, 종료날짜, 강의실코드)
--   관리자가 과정을 개설한다.
CREATE OR REPLACE PROCEDURE PRC_OP_COU_INSERT
(N_CODE      IN COURSE.COURSE_CODE%TYPE                     --과정코드
,N_SDATE    IN COURSE_OPEN.START_DATE%TYPE                  --시작날짜
,N_EDATE    IN COURSE_OPEN.END_DATE%TYPE                    --종료날짜
,N_CLACODE      IN CLASSROOM_REGISTER.CLASSROOM_CODE%TYPE     --강의실코드. 
)
IS
    V_OP_COURSE_CODE    COURSE_OPEN.OP_COURSE_CODE%TYPE;    -- 과정개설코드
    --V_COURSE_CODE       COURSE.COURSE_CODE%TYPE;       --과정명받은거 코드로 찾아서
    --V_CLASSROOM_CODE    CLASSROOM_REGISTER.CLASSROOM_CODE%TYPE;    --강의실받은거 코드로 찾아서
BEGIN
    
    -- 과정개설코드 자동으로 부여
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_COURSE_CODE,3))),0) + 1 INTO V_OP_COURSE_CODE
    FROM COURSE_OPEN;
    
    V_OP_COURSE_CODE := 'CO' || V_OP_COURSE_CODE;
    
    
    -- 과정명 입력 받은걸 코드화하기
    /*
    SELECT COURSE_CODE INTO V_COURSE_CODE
    FROM COURSE
    WHERE COURSE_NAME = N_NAME;     --'자바과정'
    
    -- 강의실 입력 받은걸 코드화하기
    SELECT CLASSROOM_CODE INTO V_CLASSROOM_CODE
    FROM CLASSROOM_REGISTER
    WHERE CLASSROOM_NAME = N_CROOM; --'1501'
    */
    INSERT INTO COURSE_OPEN
    (OP_COURSE_CODE ,COURSE_CODE ,CLASSROOM_CODE ,START_DATE ,END_DATE) 
    VALUES(V_OP_COURSE_CODE,  N_CODE,N_CLACODE, TO_DATE(N_SDATE,'YYYY-MM-DD') ,TO_DATE(N_EDATE,'YYYY-MM-DD'));
    
END;
--==>>Procedure PRC_OP_COU_INSERT이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
--○ 과목 입력 프로시저
--   프로시저명 : PRC_OP_SUB_INSERT
-- (과정개설코드, 과목코드, 시작날짜, 종료날짜, 교재코드, 교수코드)
-- 교수명(과정개설코드와 일치할때 거기 교수명과 일치하는지 판단)
-- 과목기간은 과정기간안에 속해야 한다.
-- 과목 기간은 겹쳐서는 안된다. 

--출결,필기,실기배점은 NN값 가능. 추후입력? 업데이트?
--지금 하는 일 → 관리자가 과목개설 등록이기 때문에
-- 출결필기실기는 교수자 권한!

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
    V_OP_SUBJECT_CODE    SUBJECT_OPEN.OP_SUBJECT_CODE%TYPE; --과목개설코드
    
    V_TCCODE    TEACHER_REGISTER.TEACHER_CODE%TYPE; -- 과정의 교수담는 변수
    
    V_SUB_COUNT  NUMBER;  -- 과정안에 과목 몇개있는지 세는 변수.
    V_COU_SDATE COURSE_OPEN.START_DATE%TYPE;    --과정시작날짜
    V_COU_EDATE COURSE_OPEN.END_DATE%TYPE;      --과정종료날짜
    V_SUB_EDATE SUBJECT_OPEN.END_DATE%TYPE;     --과목종료날짜
    
    USER_DEFINE_ERROR1  EXCEPTION;  -- 20021 , 교수가 배정되지 않은상태
    USER_DEFINE_ERROR2  EXCEPTION;  -- 20022 , 입력정보의 교수와 해당과정의 교수가 다른상태
    USER_DEFINE_ERROR3  EXCEPTION;  --20023,'과목기간이 과정기간에 포함되지 않습니다.'
    USER_DEFINE_ERROR4  EXCEPTION;  --20024,'과목기간이 중복됩니다. 다시 확인해주세요'
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
    -- SUBJECT 코드 : SO1  
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(OP_SUBJECT_CODE,3))),0) + 1 INTO V_OP_SUBJECT_CODE
    FROM SUBJECT_OPEN;
    
    V_OP_SUBJECT_CODE := 'SO' || V_OP_SUBJECT_CODE;
    
    
    -- INSERT 쿼리문
    INSERT INTO SUBJECT_OPEN
    (OP_SUBJECT_CODE, SUBJECT_CODE, TEXTBOOK_CODE, OP_COURSE_CODE, START_DATE, END_DATE)
    VALUES(V_OP_SUBJECT_CODE, V_SUBJECT_CODE, V_TEXTBOOK_CODE, V_OP_COURSE_CODE, TO_DATE(V_START_DATE,'YYYY-MM-DD') ,TO_DATE(V_END_DATE,'YYYY-MM-DD') );

    --예외처리
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
        THEN RAISE_APPLICATION_ERROR(-20021, '개설된 과정에 교수가 배정되지 않았습니다. 교수를 과정에 배정한 뒤, 다시 입력해주세요.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR2
        THEN RAISE_APPLICATION_ERROR(-20022, '과정교수와 과목교수는 일치해야 합니다. 교수명을 다시 확인해주세요');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR3
        THEN RAISE_APPLICATION_ERROR(-20023,'과목기간이 과정기간에 포함되지 않습니다.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR4
        THEN RAISE_APPLICATION_ERROR(-20024,'과목기간이 중복됩니다. 다시 확인해주세요');
        ROLLBACK;
    --커밋
    COMMIT;
END;
--==>>Procedure PRC_OP_SUB_INSERT이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------
----------------------함수가 노답인데 .. 이거 일단 삭제
DROP FUNCTION FN_SUB_OP_DATE;
--==>>Function FN_SUB_OP_DATE이(가) 삭제되었습니다.
--○ 과목기간의 연속성 평가 함수
--   함수명 : FN_SUB_OP_DATE(과정코드,과목시작날짜,과목종료날짜)
/*
CREATE OR REPLACE FUNCTION FN_SUB_OP_DATE
--FN_SUB_OP_DATE(V_OP_COURSE_CODE,V_START_DATE,V_END_DATE)
(V_CODE COURSE_OPEN.OP_COURSE_CODE%TYPE   -- 과정코드
, V_SDATE SUBJECT_OPEN.START_DATE%TYPE   -- 과목시작날짜
, V_EDATE SUBJECT_OPEN.END_DATE%TYPE    -- 과목종료날짜
)
RETURN NUMBER
IS
    --주요변수선언
    V_COUNT NUMBER;    -- 해당과정에 과목몇개있는지
    V_FLAG  NUMBER;    -- 과목기간이 과정기간에 만족하는지, 과목기간은 연속하는지
    V_NUM   NUMBER;    -- 판단결과(0 유효한 날짜, 1 시작날짜 잘못기입, 2마지막날짜 잘못기입)
    
    V_SUB_END_DATE  SUBJECT_OPEN.END_DATE%TYPE; -- 과목종료날짜 담는 변수
    V_COU_START_DATE  COURSE_OPEN.START_DATE%TYPE;  -- 과정종료날짜 담는 변수
    V_COU_END_DATE  COURSE_OPEN.END_DATE%TYPE;  -- 과정종료날짜 담는 변수
BEGIN
    -- 같은 과정에서 과목이 몇개 있는지 확인. 
    SELECT COUNT(*) INTO V_COUNT
    FROM  COURSE_OPEN
    WHERE COURSE_CODE = V_CODE;
    
    -- 과정시작날짜, 과정종료날짜 변수에 담기 (V_COU_START_DATE, V_COU_END_DATE)
    SELECT START_DATE, END_DATE INTO V_COU_START_DATE, V_COU_END_DATE
    FROM COURSE_OPEN
    WHERE COURSE_CODE = V_CODE;
    
    -- 과목가장마지막 날짜 담기
    SELECT T.END_DATE INTO V_SUB_END_DATE
    FROM
    (
        SELECT END_DATE
        FROM SUBJECT_OPEN
        WHERE OP_COURSE_CODE = V_CODE
        ORDER BY END_DATE DESC
    )T 
    WHERE ROWNUM = 1;
    
    -- 0 에러 ㄴㄴ/ 1 에러발생
    -- 1. 0개 → 0 리턴
    --    과정시작날짜 != 과목시작날짜(1리턴)
    ----------------------------------------------------------------------------
    -- 2. 0개 초과. → 가장 마지막 날짜 != 과목시작날짜(넘겨받음) (시작날짜 다시 입력 1리턴)
    -- 3.              과정마지막날짜 > 과목종료날짜(넘겨받음) (마지막날짜 다시입력 2리턴)
    -- 4. 다 만족하면 0리턴 
    
    IF (V_COUNT = 0)
    THEN 
        IF (V_COU_START_DATE - V_SDATE = 0)
        THEN V_NUM := 0;
        ELSE V_NUM := 1;
        END IF;
    ELSIF (V_COUNT > 0)
    THEN 
        IF (V_SUB_END_DATE - V_SDATE != 0)
        THEN V_NUM := 1;
        ELSIF (V_COU_END_DATE - V_EDATE > 0)
        THEN V_NUM := 2;
        END IF;
    ELSE 
        V_NUM := 0;
    END IF;
    RETURN V_NUM;
END;
--==>>Function FN_SUB_OP_DATE이(가) 컴파일되었습니다.
*/

--------------------------------------------------------------------------------
--○ 성적출력 프로시저 생성
--   프로시저 명 : FN_SUNGJUK_PRINT(교수코드나 학생코드)
--             SUBSTR(교수코드,1,1) → T
--             SUBSTR(학생코드,1,1) → S
--   변수 = T OR S 담고
--   IF T 이면 교수성적정보 출력
--   ELSIF S 이면 학생성적정보 출력

--  교수와 학생이 겹치는 출력은 학생명, 과목명, 과목시작날짜, 과목종료날짜, 교재명, 출결, 실기, 필기, 총점, 등수
--  → 함수생성
--  FN_COMMON_PRINT(과목코드)
--  
--  교수만 : 중도탈락여부
--  학생만 : 과정명

--1. 교수일때
--   출력정보:과목명, 과목시작날짜, 과목종료날짜, 교재명, 학생명, 출결, 실기, 필기, 총점, 등수, 중도탈락여부
--   고려사항 1. 중도 탈락한 학생도 이미 수강한 과목에 대해서는 성적이 출력된다.
--   고려사항 2. 중도 탈락 사실 여부를 확인하도록 출력한다.
--2. 학생일때
--   출력정보: 학생명, 과정명, 과목명, 과목시작날짜, 과목종료날짜, 교재명, 출결, 실기,필기,총점, 등수
--   고려사항 1. 본인 성적 정보만 출력한다.
--   고려사항 2. 여러 과목이 끝난 경우 통합적으로 성적을 볼 수 있다.







