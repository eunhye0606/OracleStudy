SELECT USER
FROM DUAL;
--==>>SYS

--------------------------------------------------------------------------------
--① C드라이브에 디렉토리 생성 
--   디렉토리 명 :TEAM4_ORACLE

--② 테이블 스페이스 생성
CREATE TABLESPACE TBS_TEAM4
DATAFILE 'C:\TEAM4_ORACLE\TBS_TEAM4.DBF'
SIZE 4M  
EXTENT MANAGEMENT LOCAL             
SEGMENT SPACE MANAGEMENT AUTO;
--==>>TABLESPACE TBS_TEAM4이(가) 생성되었습니다.


--③ 계정생성
CREATE USER team4 IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_TEAM4;
--==>>User TEAM4이(가) 생성되었습니다.


--④ 권한부여
GRANT CREATE SESSION TO team4;
--==>>Grant을(를) 성공했습니다.
GRANT CREATE TABLE TO team4;
--==>>Grant을(를) 성공했습니다.


--⑤ 할당량 부여(무제한)
ALTER USER team4
QUOTA UNLIMITED ON TBS_TEAM4;
--==>>User TEAM4이(가) 변경되었습니다.


--⑥ 권한조회
SELECT *
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'TEAM4';
--==>>
/*
TEAM4	CREATE TABLE	NO
TEAM4	CREATE SESSION	NO
*/

--⑦ 왼쪽에서 초록『+』눌러서 계정 만들기

