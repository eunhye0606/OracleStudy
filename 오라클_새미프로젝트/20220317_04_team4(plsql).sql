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
CREATE OR REPLACE PROCEDURE PRC_OP_COU_UPDATE
(V_TEACHER_CODE IN COURSE_OPEN.TEACHER_CODE%TYPE)
IS
BEGIN
    UPDATE COURSE_OPEN
    SET TEACHER_CODE = V_TEACHER_CODE
    WHERE TEACHER_CODE IS NULL;
END;
--==>>Procedure PRC_OP_COU_UPDATE이(가) 컴파일되었습니다.


-- 부모테이블(TEACHER_REGISTER테이블에서 교수정보 삭제할 경우,
--            자식 테이블(COURSE_OPEN의 TEACHER_CODE를 NULL 값으로 수정)
-- 참조관계가 없는 경우는 바로 DELETE 가능!
CREATE OR REPLACE TRIGGER TRG_TC_UPDATE
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



--------------------------------------------------------------------------------















