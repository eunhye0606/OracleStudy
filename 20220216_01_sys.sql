
--1줄 주석문 처리 (단일행 주석문 처리)

/*
여러줄
(다중행)
주석문
처리
*/

-- ○ 현재 오라클 서버에 접속한 자신의 계정 조회
show user
--==>> USER이(가) "SYS"입니다. (스크립트 출력에서 결과 얻음)
--> sqlplus 상태일 때 사용하는 명령어


-- 쿼리문
select user
from dual;
--==>> SYS(질의결과 탭에서 결과를 얻음)

SELECT USER
FROM DUAL;
--==>> SYS
-- from 뒤에를 메모리로 끌어 올리고...
-- dual : 어떤 테이블을 끌어 올리는게 아니라 select User 뒤에
-- 아무것도 없을 때
-- 즉, from 뒤에는 의미가 없고, user만 조회를 하고 싶을때!

SELECT 1 + 2
FROM DUAL;
--==>>3


SELECT                              2+4
FROM                    DUAL;
-->>6 
-- 문법적으로 만들어지는 키워드에 대한 구성만 신경쓰지
-- 공백같은거 크게 까다롭게 처리 안함.
-- 붙히며 문제돼.


SELECT 1+5
FROMDUAL;
--==>>에러 발생
--    ORA-00923: FROM keyword not found where expected
--    00923. 00000 -  "FROM keyword not found where expected"

SELECT 쌍용강북교육센터 F강의장 --이부분이 데이터유형처리가 잘못돼어 에러남.
FROM DUAL;
--==>> 에러 발생
--==>>ORA-00904: "쌍용강북교육센터": invalid identifier 유효하지 않은 정체성
--    00904. 00000 -  "%s: invalid identifier

-- 그래서 문자열로 처리해줘야 하는데 오라클에서는 조금 다름.


SELECT "쌍용강북교육센터 F강의장"
FORM DUAL;
--==>> 에러 발생
--    ORA-00972: identifier is too long
--    00972. 00000 -  "identifier is too long"


-- 오라클의 문자열 표현 ''
SELECT '쌍용강북교육센터 F강의장'
FROM DUAL;
--==>>쌍용강북교육센터 F강의장


SELECT '한 발 한 발 힘겨운.. .. 힘내자 오라클 수업!'
FROM DUAL;
--==>>한 발 한 발 힘겨운.. .. 힘내자 오라클 수업!

SELECT 3.14 + 3.14
FROM DUAL;
--==>>6.28

SELECT 10 * 5
FROM DUAL;
--==>>50

SELECT 10 * 5.0
FROM DUAL;
--==>>50

SELECT 4 / 2
FROM DUAL;
--==>>2

SELECT 4.0 / 2
FROM DUAL;
--==>>2

SELECT 4.0 / 2.0
FROM DUAL;
--==>>2

SELECT 5 /2
FROM DUAL;
--==>>2.5

SELECT 100 - 23
FROM DUAL;
--==>>77
