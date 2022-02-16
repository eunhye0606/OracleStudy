-- ■■■ 오라클 접속 및 구동 ■■■--

--(명령 프롬프트 상태에서...)
   

--○ 접속된 사용자 없이 단순히 SQL 프롬프트만 띄우도록 하겠다.
C:\>sqlplus/nolog
--==>>
/*
SQL*Plus: Release 11.2.0.2.0 Production on 화 2월 15 17:28:57 2022

Copyright (c) 1982, 2014, Oracle.  All rights reserved.

SQL>
*/


-- ※ 『sqlplus』는 SQL(Structed Query Language, 구조화된 질의어,쿼리문) 을 수행하기 위해 Oracle 에서 제공하는
--     도구(툴, 유틸리티)이다.
--     SQL로 Oracle과 소통한다.

-- ※ 『PATH=C:\oraclexe\app\oracle\product\11.2.0\server\bin;』
--    경로에 존재하는 『sqlplus.exe』
--    이미 이 경로가 환경변수 path 에 등록되어 있으므로
--    『C:\>sqlplus/nolog』와 같이 명령어 사용이 가능한 상태인 것이다.


SQL> ipconfig
--==>> SP2-0042: unknown command "ipconfig" - rest of line ignored.
SQL> dir
--==>> SP2-0042: unknown command "dir" - rest of line ignored.
SQL> cls
--==>> SP2-0042: unknown command "cls" - rest of line ignored.

-- ※ 일반적인 도스 명령어(윈도우 명령어)를 수행할 수 없다.
--    (즉, 수행할 수 있는 상태나 환경이 아니다.)

SQL> show user
--==>> USER is ""
--> 현재 접속한 사용자 계정을 조회하는 구문


nolog : 별도의 사용자로 접속한 것이 아니라서 USER is ""가 출력

================================================================================
--2일차

-- ○ 첫 번째 관리자 계정인 『sys』로 연결해 본다.

C:\>sqlpuls sys/java006$ as sysdba
--==>> 
/*
SQL*Plus: Release 11.2.0.2.0 Production on 수 2월 16 09:18:36 2022

--==>>Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
--==>>Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
*/

-- ○ 접속한 사용자 조회
SQL> show user
--==>>USER is "SYS"

-- ○ 다시 『sys』로 접속했던 구문 사용 → 도스 명령어 이용 X
SQL> sqlplus sys/java006$ as sysdba
--==>>SP2-0734: unknown command beginning "sqlplus sy..." - rest of line ignored.

-- ○ 접속한 사용자 조회
SQL> show user
--==>>USER is "SYS"

-- ○ 다시 『sys』로 접속
SQL> connect sys/java006$ as sysdba
--==>>Connected. 

-- ○다시 접속한 사용자 조회
SQL> show user
--==>>USER is "SYS
여
-- ○ 오라클 서버 인스턴스 상태 조회(사용가능상태 여부 확인)
--    전원의 on/off 여부 등 일반적으로 접속의 가능 여부를
--    확인할 때 사용하는 명령
SQL> select status from v$instance;
--==>>
/*
STATUS
------------------------
OPEN
--> 오라클 서버가 정상적으로 startup 되었음을 의미.
*/

-- ○ 두 번째로... 일반 사용자 계정인 『hr』로 연결 시도
SQL> connect hr/lion
--==>>
/*
ERROR:
ORA-28000: the account is locked


Warning: You are no longer connected to ORACLE.
*/
--> 일반 사용자 계정인 『hr』 은 잠겨있는 상태이므로
--  오라클 서버 접속이 불가능한 상태

-- ○ sys로 연결
SQL> conn sys/java006$ as sysdba
--==>>Connected.

-- ○ 접속 된 사용자 계정 확인
SQL> show user
--==>>USER is "SYS"

-- ○ 오라클 사요자 계정들의 상태 조회(확인) → sys 로 접속한 상태

SQL> set linesize 800
SQL> select username, account_status from dba_users;
--==>>
/*
USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
SYS                                                          OPEN
SYSTEM                                                       OPEN
ANONYMOUS                                                    OPEN
APEX_PUBLIC_USER                                             LOCKED
FLOWS_FILES                                                  LOCKED
APEX_040000                                                  LOCKED
OUTLN                                                        EXPIRED & LOCKED
DIP                                                          EXPIRED & LOCKED
ORACLE_OCM                                                   EXPIRED & LOCKED
XS$NULL                                                      EXPIRED & LOCKED
MDSYS                                                        EXPIRED & LOCKED

USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
CTXSYS                                                       EXPIRED & LOCKED
DBSNMP                                                       EXPIRED & LOCKED
XDB                                                          EXPIRED & LOCKED
APPQOSSYS                                                    EXPIRED & LOCKED
HR                                                           EXPIRED & LOCKED

16 rows selected.

SQL>


*/
--> 현재 hr 계정은 EXPIRED & LOCKED 인 상태

-- ○ 계정 잠금 / 해제(현재 sys로 연결된 상태...)
SQL> alter user hr account unlock;
--==>> User altered.

-- ○ 잠금 해제된 사용자 계정(hr)으로 오라클 접속 시도
SQL> conn hr/lion
--==>>
/*
ERROR:
ORA-01017: invalid username/password; logon denied


Warning: You are no longer connected to ORACLE.
*/
--> 사용자 계정 및 패스워드가 잘못되었기 때문에 로그온이 거부된 상황
--  즉, 유효하지 않은 계정 및 패스워드로 접근을 시도했다고 오라클이 안내하고 있는 상황


-- ○ 계정 정보 변경(패스워드 설정 변경) → sys로 접속...
SQL> conn sys/java006$ as sysdba
--==>>Connected.
SQL> show user
--==>>USER is "SYS"

SQL> alter user hr identified by lion;

--==>>User altered.
--> hr 계정의 패스워드를 lion 으로 설정하겠다.

-- ○ hr 계정 잠금을 해제하고, 패스워드를 재설정해서
--    유효한 계정상태로 만든 후...
--    다시 hr 계정으로 오라클 접속 시도
SQL> conn hr/lion
--==>Connected.

-- ○ 접속된 사용자 계정 확인
SQL> show user
--==>>USER is "HR"

-- ○ 현재 오라클 서버의 사용자 계정 상태에 대한 정보 조회(hr인 상태...)
SQL> select username, account_status from dba_users;
--==>>
/*
select username, account_status from dba_users
                                     *
ERROR at line 1:
ORA-00942: table or view does not exist
*/
--> hr 이라는 일반 사용자 계정을 통해서는
-- dba_users의 조회가 불가능한 상황임을 확인

-- ○ host 명령어
--    도스 명령 체계로 전환하거나
--    라인 단위에서 도스 명령어 입력이 가능하다.
--    유닉스 계열에서는 『host』명령어 뿐 아니라 『!』도 사용이 가능하다.
--    하지만, 윈도우 계열에서는 『host』 명령어만 사용이 가능하다.
--    host 상태에서 빠져나갈 경우 『exit』 명령어를 입력한다.
++++++++++++++++지금 cmd창에서 하는 짓 → admin part +++++++++++++++++++++++++++++++
cmd > sqlplus > host
 SQL> host
--==>>
/*
Microsoft Windows [Version 10.0.19042.1526]
(c) Microsoft Corporation. All rights reserved.
C:\>
*/

C:\>exit

SQL>

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SQL> exit
Disconnected from Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

C:\>sqlplus sys/aaaa as sysdba

SQL*Plus: Release 11.2.0.2.0 Production on 수 2월 16 12:08:38 2022

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

SQL> show user
USER is "SYS"
SQL>
=======================================================================================
CMD → SQL → CMD → SYS(비번 java006$ 아니여도 접속 가능 )

SQL 에서 도스창으로 옮긴뒤 다시 sys로 접할때
비번 아무거나 쳐도 들어와짐!


■■■오라클 2일차■■■

admin : 윈도우 최고 관리자
SYS   : 오라클 최고 관리자


C:\>sqlpuls sys/java006$ as sysdba	→ sys에게 넘겨 줄 값들/비번 맨 마지막 Roll



C:\> sqlplus sys/java006$ as sysdba → 일반 도스 명령어로 접속 수행

SQL> connect sys/java006$ as sysdba → SQL에서 sys로 접속하는 방법

오라클에 연결하면서 종합적인 상태를 확인하는 명령어
SQL> select status from v$instance;

STATUS
------------------------
OPEN → 접속 가능하다.

sys → password : java006$(우리가 설정)

express exadition 깔면! 디비건들기 전에 사전에 테스트하는 계정이 있음.
오라클의 암묵적인 룰.
hr /password : lion


standard 이상에서부터 있어서 우리가 만들거임
scott /password : tiger
이 계정이 있음.

C:\>sqlpuls sys/java006$ as sysdba
	    hr/line

SQL> connect sys/java006$ as sysdba
     connect hr/lion
     conn hr/lion

======================================================================================
자바에서 중요한 내용 class
오라클에서 중요한 내용 TABLE - (일단 표라고 생각...)

표 ▶ 테이블
가입회원 ▶ 테이블명
회원번호	회원명		전화번호 ▶ 항목명 : 칼럼명
6234		이호석		010- 1234..
1414		최문정		010- 1431..
4134		김정용		010- 5432..	

데이터 : 레코드
즉, 레코드가 3개 이다.
가로 - 행/ 세로 - 열


TABLESPACE (TABLE1, TABLE2, TABLE3...) : 테이블 모아둠..!

select username, account_status from dba_users;
       ------------------------      ---------
            항목, 칼럼 		      테이블

일반 계정에서 저 쿼리를 짜니 ...
ORA-00942: table or view does not exist
오라클 : "그런거 없는데?"
(있는거 안보여준다는거도 아니고 없다함. → 이게 오라클의 보안 방식)

==========================================================================
윈도우 최고 관리자 Windows - Adimistrator > Administrators 그룹
		   -------
ORACLE - sys > sysdba

		   계정 - (내계정밑에 관리자가 있음 그래서 난 에러안뜬거)
			   난 ...
			   오라클이 건물안에 세들면
			   건물주는 오라클사무실에 들어갈수있음..

기본적으로 Administrators 그룹 안에 ORACLE이 포함됨. 그래서 가능.(비번이 달라도)
건물주가 입장할떄는 pass를 제대로 확인하지 않고 들여보냄.

즉,

-- ※ Adiministrator(SIST(각자 이름계정) → 윈도우 사용자 계정)가
--    ORA_DBA(→ 윈도우 사용자 그룹)에 포함되어 있을 경우
--    취약한 보안정책으로 인해
--    실무에서는 정말 특별한 경우가 아니고서는 이를 제외시키고 사용해야 한다.
--==>> ORA_DBA 사용자 그룹에서 윈도우 관리자 계정 제거~!!!


-- ※ 제거 이후..
--    sys 의 계정 및 패스워드가 일치하지 않으면
--    오라클 서버에 접속할 수 없는 상태가 된다.

<<[윈도우 키 + R]을 눌러 실행창을 열고 lusrmgr.msc를 입력>>
<<윈도우 10 로컬 사용자 및 그룹이 없는 경우>>

-- ○ hr 사용자 계정에 sysdba 권한(롤) 부여하기 → sys가...
SQL> exit
--==>>Disconnected from Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

C:\>sqlplus sys/java006$ as sysdba
--==>>
/*
SQL*Plus: Release 11.2.0.2.0 Production on 수 2월 16 14:19:28 2022

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
*/
SQL> show user
--==>>USER is "SYS"

-- ○ 확인 → hr 계정으로 접속 → as sysdba로 연결
SQL> grant sysdba to hr;
--==>>Grant succeeded.
SQL> conn hr/lion as sysdba
--==>>Connected.
SQL> show user
--==>>USER is "SYS"

SQL> select username, account_status from dba_users;

USERNAME
------------------------------------------------------------
ACCOUNT_STATUS
----------------------------------------------------------------
SYS
OPEN

SYSTEM
OPEN

ANONYMOUS
OPEN


USERNAME
------------------------------------------------------------
ACCOUNT_STATUS
----------------------------------------------------------------
HR
OPEN

APEX_PUBLIC_USER
LOCKED

FLOWS_FILES
LOCKED


USERNAME
------------------------------------------------------------
ACCOUNT_STATUS
----------------------------------------------------------------
APEX_040000
LOCKED

OUTLN
EXPIRED & LOCKED

DIP
EXPIRED & LOCKED


USERNAME
------------------------------------------------------------
ACCOUNT_STATUS
----------------------------------------------------------------
ORACLE_OCM
EXPIRED & LOCKED

XS$NULL
EXPIRED & LOCKED

MDSYS
EXPIRED & LOCKED


USERNAME
------------------------------------------------------------
ACCOUNT_STATUS
----------------------------------------------------------------
CTXSYS
EXPIRED & LOCKED

DBSNMP
EXPIRED & LOCKED

XDB
EXPIRED & LOCKED


USERNAME
------------------------------------------------------------
ACCOUNT_STATUS
----------------------------------------------------------------
APPQOSSYS
EXPIRED & LOCKED


16 rows selected.
--==>> 가능해짐.

-- ○ 권한 박탈(권한 회수)

SQL> revoke sysdba from hr;

--==>>Revoke succeeded.


SQL> conn hr/lion as sysdba
Connected.

SQL> conn dfafsa/fadsasdfafa as sysdba
Connected.

위 두개가 같음. admin그룹안에 오라클이 있어서 sysdba권한으로 로그인하는
모든 계정이 가능한 것!.

-- ※ 오라클 서버 구동 / 중지 (admin part는 실무 X, final 프로젝트 구동을 
			       학원 피시로 할거라 알아야함!!)

--    구동 : startup
--    중지 : shutdown[immediate] → 즉각적으로 멈춰야할 때가 많기때문에


-- ○ 일반 사용자 계정 hr 로 오라클 서버 중지 명령 시도

SQL> conn hr/lion
--==>>Connected.

SQL> show user
--==>>USER is "HR"

(sysdba 권한 박탈당한 상태.....)

SQL> shutdown
--==>>ORA-01031: insufficient privileges
--		 (권한 불충분 에러)
--> 일반 사용자 계정으로는 오라클 서버를 중지시킬 수 없다.



-- ○ sys로 접속하여 오라클 서버 중지 명령 시도
SQL> conn sys/java006$ as sysdba 	▶ sysdba 권한을 가진 sys에 연결
--==>>Connected.
SQL> show user				▶ 현재 접속 유저 확인
--==>>USER is "SYS"
SQL> shutdown				▶ 서버 중지 명령
--==>>
/*
Database closed.			▷ 데이터베이스 닫힘
Database dismounted.			▷ 데이터베이스 마운트 해제
ORACLE instance shut down.		▷ 오라클 인스턴스 셧다운
*/

-- ※ 오라클 서버(startup)를 시작 / 중지(shutdown)하는 명령은
--    『as sysdba』 또는 『as sysoper』 로 연결했을 때만 가능하다.
--    ------------         -----------
--       관리자	             운영자



SQL> conn sys/java006$ as sysdba
--==>>Connected.
SQL> show user
--==>>USER is "SYS"
SQL> shutdown
--==>>
/*
Database closed.
Database dismounted.
ORACLE instance shut down.
*/
SQL> show user
--==>>USER is "SYS"

SQL> startup (중지됐을 때, 일반 계정으로 가면 접근 어쩌고 sysdba로 접속해서 구동)
--==>>
/*
ORACLE instance started.

Total System Global Area 1068937216 bytes
Fixed Size                  2260048 bytes
Variable Size             616563632 bytes
Database Buffers          444596224 bytes
Redo Buffers                5517312 bytes
Database mounted.
Database opened.
*/

-- ○ hr 사용자 계정에 『sysoper』 권한 부여하기 → sys가...

SQL> conn sys/java006$ as sysdba
--==>>Connected.
SQL> show user
--==>>USER is "SYS"
SQL> grant sysoper to hr;
--==>>Grant succeeded.

-- ○ sysoper 권한을 가진 hr 계정으로 오라클 서버 접속 및
--    서버 중지 명령 수행
SQL> conn hr/lion as sysoper
--==>>Connected.
SQL> show user
--==>>USER is "PUBLIC" ▶ 공공연하게 공동체 질서를 위해 있는 계정 권한이다..
SQL> shutdown immediate
--==>>
/*
Database closed.
Database dismounted.
ORACLE instance shut down.
*/
-- ○ 다시 오라클 서버 구동
SQL> show user
--==>>
/*
USER is "PUBLIC"
SQL> startup
ORACLE instance started.
Database mounted.
Database opened.
*/


-- ○ sysoper 권한을 가진 hr 계정으로
--    현재 오라클 서버에 존재하고 있는 사용자 계정 정보 상태 조회
SQL> select username,account_status from dba_users;
--==>>
/*
select username,account_status from dba_users
                                    *
ERROR at line 1:
ORA-00942: table or view does not exist
*/

-- ■■■ 오라클 서버 연결 모드의 3가지 방법 ■■■--

관리자계정(sysdba) : 구동,중지, 상태 조회
운영자계정(sysoper): 구동,중지
일반 계정(normal) : X

-- 1. as sysdba
--> as sysdba 로 연결하면 오라클 서버의 『관리자』로 연결되는 것이다.
--  user 명은 sys로 확인된다.
--  오라클 섯버 관리자로 연결되는 것이기 때문에
--  오라클에서 제공하는 모든 기능을 전부 활용할 수 있다.
--  오라클 서버가 startup 또는 shutdown 되어도 연결이 가능하다.
--  → 일반적인 연결은 『conn 계정/패스워드 as sysdba』 형태로 연결하게 된다.

-- 2. as sysoper
--> as sysoper 로 연결하면 오라클 서버의 『운영자』로 연결되는 것이다.
--  user 명은 public으로 확인 된다.
--  사용자 계정 정보 테이블에 접근하는 것은 불가능하다.
--  오라클 서버의 구동 및 중지 명령 수행이 가능하다.
--  오라클 서버가 startup 또는 shutdown 되어도 연결이 가능하다.
--  → 일반적인 연결은 『conn 계정/패스워드 as sysoper』 형태로 연결하게 된다.

-- 3. normal
--> 오라클 서버에 존재하는 『일반적인 사용자』로 연결되는 것이다.
--  오라클 서버가 구동중인 상태에서만 연결이 가능하고
--  오라클 서버가 구동 중지 상태일 경우 연결이 불가능하다.
--  관리자가 부여해준 권한(또는 롤)을 통해서만 사용이 가능하다.
-- → 일반적인 연결은 『conn 계정/패스워드』 형태로 연결하게 된다.

//로그인 
SQL> conn hr
Enter password: ▶ 몇자리인지도 안나옴
Connected.
SQL> disconn
Disconnected from Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production



SQL> conn sys as sysdba
Enter password: ▶ 몇자리인지도 안나옴 
Connected.
SQL> show user
USER is "SYS"
 













