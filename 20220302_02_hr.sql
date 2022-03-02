SELECT USER
FROM DUAL;
--==>>HR

--■■■ 정규화(Normalization) ■■■--

--○ 정규화란?

--   한 마디로 데이터베이스 서버의 메모리 낭비를 막기 위해
--   어떤 하나의 테이블을.... 식별자를 가지는 여러 개의 테이블로
--   나누는 과정을 말한다.
--   정규화를 한마디로 말하자면 ? 테이블 쪼개기.

--ex) 호석이가...옥장판을 판매한다.
--    고객 리스트 → 거래처 직원 명단이 적혀있는 수첩의 정보를
--                   데이터베이스화 하려고 한다.

-- 테이블명 : 거래처직원
/*
--------------------------------------------------------------------------------
거래처회사명 SELECT USER
FROM DUAL;
SELECT SNAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = 1001
    10Byte       10Byte       10Byte        10Byte    10Byte   10Byte       10Byte
 거래처회사명  회사주소      회사전화    거래처직원명  직급   이메일      휴대폰
--------------------------------------------------------------------------------
    LG       서울여의도    02-345-6789   양윤정   부장    yyj@na..    010-1234-1...
    LG       서울여의도    02-345-6789   최선하   과장    csh@da..    010-2345-2...
    LG       서울여의도    02-345-6789   최문정   대리    cmj@da..    010-3456-3...    
    LG       서울여의도    02-345-6789   홍은혜   부장    heh@gm..    010-5678-5...
    SK       서울소공동    02-987-6543   박현수   부장    phs@na..    010-8585-8...    
    LG       부산동래구    051-5511-5511 오이삭   대리    oys@te..    010-9900-9...
    SK       서울소공동    02-987-6543 정은정   대리    jej@na..    010-2450-8...

가정) 서울 여의도 LG 라는 회사에 근무하는 거래처 직원 명단이
      총 100만 명이라고 가정한다.
      (한 행(레코드)은 70 Byte 이다.)

*/