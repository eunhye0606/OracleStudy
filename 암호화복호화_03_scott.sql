SELECT USER
FROM DUAL;
--==>>SCOTT

--■■■ 암호화 복호화 확인 실습 ■■■--

--○ 테이블 생성
CREATE TABLE TBL_EXAM
(
    ID  NUMBER
,   PW  VARCHAR2(20)
);
--==>>Table TBL_EXAM이(가) 생성되었습니다.


--○ 데이터 입력
INSERT INTO TBL_EXAM(ID,PW) VALUES(1,'abcd1234');
--==>>1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_EXAM;
--==>>1	abcd1234


--○ 롤백
ROLLBACK;
--==>>롤백 완료.

--○ 다시 데이터 입력(암호화)
INSERT INTO TBL_EXAM(ID,PW) VALUES(1,CRYPTPACK.ENCRYPT('abcd1234','0518'));
--==>>1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_EXAM;
--==>>1	"$F��"


--○ 데이터 조회(복호화)
SELECT ID,CRYPTPACK.DECRYPT(PW,'1111')
FROM TBL_EXAM;
--==>>1	�a!L
-- 복호화 키 잘못주면 복호화안됨.

SELECT ID,CRYPTPACK.DECRYPT(PW,'0518')
FROM TBL_EXAM;
--==>>1	abcd1234