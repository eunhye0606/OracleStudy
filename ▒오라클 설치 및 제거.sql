--■■■ 오라클 설치 ■■■--
실무 : 11g ex 버전을 씀.(호환성 제일 높은데 오라클에서 숨겨둬서 못찾음, 떼 돈벌라함)
      DB에 치중된 회사 → 전사용, 스탠다드용 사용.

--○ URL 요청 및 접근(21c express edition)
--   https://www.orcle.com (→ Orcle DataBase → 이전 버전은 숨겨둠)
--   https://www.orcle.com/database/technologies/xe-downloads/html
--   > Downloads > Orcle Database 21c Express Edition for Windows x64

--○ 설치 버전
--   Oracle 11g Express Edition
--          --- -------
--          8i  Standard Edition
--          9i  Enterprise Edition → 지원하는 범위가 가장 협소
--         10g  Standard Edition One  그래도 우리가 운용해야할 범위 안에선
--         19c  DataWare House        습득 가능 범위!
--         21c  -------------------
--         ---  어느 범위까지 지원되느냐...
--         문법적 지원
                  

시리얼 번호: 2018년도 부터는 그냥 년도를 번호로 땀.
             그 전에는 개발버전으로 번호를 땀.


-- ※ 기업체는 최신 버전이 나온 이후 안정적일 때 까지 사용하지 않는다.
--    또한, 버전을 교체하는 데에는 많은 비용이 소요된다.
--    이로 인해 11g가 가장 많이 사용되고 있으며, 그 다음이 19c, 10g 이다.


--○ 주요 버전 구분
--   · Express Edition
--      법적으로 완전 무료 버전이다.
--      기업체나 교육기관 등에서 무료로 사용이 가능한 버전이며,
--      프로그램 개발(C#.NET, ASP.NET, JAVA, JSP 등)용으로는 충분하지만
--	데이터베이스 서버용으로는 다소 부족한 기능을 가진 버전이라 할 수 있

--   · Standard Edition, Standard Edition One, Data Ware House, Enterprise Edition
-- 	다운로드는 가능하지만, 기업체나 교육기관 등에서 사용하게 되면
-- 	사용 중 검열 시 정식 라이센스를 제시할 수 있어야 한다.
--	프로그램 개발용 뿐 아니라, 데이터베이스 서버용으로도
--	충분한 기능을 가지고 있는 버전들이다.
--	Orcle Server 용으로 가장 충분한 기능을 가지고 있는 버전은
--	Enterprise Edition 이다.


--※ 현재 우리가 선택한 버전의 설치 과정은 기본적으로 까다롭지 않다.
--   (11g Express Edition)
--   기본 설치 경로 		: 『C:\orclexe\』 ex : express약자
--   SYS 계정 패스워드 설정	: 『java006$』
--   Port Number		: 기본 리스너 → 『1521』 오라클의 가장 상위 계정 SYS
--			 	  HTTP 리스너 → 『8080』 

--※ 참고
--   오라클 데이터베이스 파일 위치
--   오라클 관련 프로그램이 설치되는 경로와
--   관리되고 유지되는 데이터 파일의 위치는
--   물리적으로 다른 경로를 선택하는 것을 권장
--   오라클 관련 프로그램이 C 드라이브에 설치된다고 가정할 때
--   데이터베이스 파일의 위치는 D 드라이브로 설정하는 것이 바람직하다는 것이다.
--   (안정성과 성능 향상)


--■■■ 오라클 제거 ■■■--

-- 1. 제어판 > 앱(프로그램 및 기능) → Oracle Database 11g Express Edition 제거
-- 2. 실행창 호출(윈도우키 + r) → 『services.msc』→ 서비스창 호출
-- 3. 위 항목을 통해 확인하면 
--    『Oracle』로 시작하는 서비스가 여럿 확인된다.
--    즉, Oracle Server 는 서비스를 기반으로 동작한다는 것이다.
--    위의 『1.』 에서처럼 오라클 프로그램을 제거했다 하더라도
--    운영체제(os) 상에서 오라클은 서비스로 동작하기 때문에
--    이 오라클 서비스를 제거해 주어야 한다.


--    ※ 오라클 서비스를 제거하는 방법
--       · 실행창 호출(윈도우키 + r) > 『regedit』 입력 → 레지스트리 편집기 호출
--     	 · 『HKEY_LOCAL_MACHINE』 > 『SOFTWARE』 > 『ORACLE』항목 삭제
--     	 · 『HKEY_LOCAL_MACHINE』 >  『SYSTEM』 > 『CurremtControlSet』
--           > 『Services』 > 『Oracle』로 시작하는 모든 항목 삭제
	 · 『HKEY_LOCAL_MACHINE』 >  『SYSTEM』 > 『CurremtControlSet001』
--           > 『Services』 > 『Oracle』로 시작하는 모든 항목 삭제... 존재한다면 모두 삭제
	 · 『HKEY_LOCAL_MACHINE』 >  『SYSTEM』 > 『CurremtControlSet002』
--           > 『Services』 > 『Oracle』로 시작하는 모든 항목 삭제... 존재한다면 모두 삭제
	 · 『HKEY_LOCAL_MACHINE』 >  『SYSTEM』 > 『CurremtControlSet003』
--           > 『Services』 > 『Oracle』로 시작하는 모든 항목 삭제... 존재한다면 모두 삭제

※ CurremtControlSet001 ~ CurremtControlSet003은
   운영체제를 얼마나 오래 쓰고 있냐에 따라 다름.
   즉, 포맷했냐 안했냐.... 
   근데 003까지 누적되면 다시 001로 감.. 최대가 003임.
   
   CurremtControlSet → 현재 사용하고 있는 프로그램 정보들이 담겨있음!

--     ※ 변경된 레지스트리 정보가 적용되기 위해서는
--        반.드.시 재부팅을 해 주어야 한다.

-- 4. 재부팅 이후 탐색기에서 오라클 홈(오라홈)과 관련된 모든 항목을
--    물리적으로 삭제한다.(디렉터리 삭제)

-- 5. 또한, 데이터 파일 경로 및 설치 경로의 모든 디렉터리와 파일들을
--    물리적으로 삭제할 수 있도록 한다.

--==>> 여기까지 수행해야 Oracle 은 깨끗하게 제거된다.

