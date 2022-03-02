SELECT USER
FROM DUAL;
--==>> SCOTT

--■■■ UNION / UNION ALL ■■■--

--○ 실습 테이블 생성(TBL_JUMUN)
CREATE TABLE TBL_JUMUN               -- 주문 테이블 생성
( JUNO      NUMBER                   -- 주문 번호
, JECODE    VARCHAR2(30)             -- 주문된 제품 코드
, JUSU      NUMBER                   -- 주문 수량
, JUDAY     DATE DEFAULT SYSDATE     -- 주문 일자
);
--==>> Table TBL_JUMUN이(가) 생성되었습니다.
--> 고객의 주문이 발생(접수)되었을 경우
--  주문 내용에 대한 데이터가 입력될 수 있는 테이블 

--○ 데이터 입력 → 고객의 주문 발생(접수)
INSERT INTO TBL_JUMUN VALUES
(1, '빼빼로', 20, TO_DATE('2001-11-01 09:10:12', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(2, '거언빵', 10, TO_DATE('2001-11-01 10:20:30', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(3, '모옹쉘', 30, TO_DATE('2001-11-01 11:10:05', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(4, '눈감자', 10, TO_DATE('2001-11-02 13:20:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(5, '나아쵸', 20, TO_DATE('2001-11-05 07:30:22', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(6, '홈런볼', 70, TO_DATE('2001-11-06 15:20:34', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(7, '고래밥', 50, TO_DATE('2001-11-07 11:10:13', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(8, '포카칩', 20, TO_DATE('2001-11-07 19:42:53', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(9, '포카칩', 20, TO_DATE('2001-11-08 19:42:53', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(10, '포카칩', 20, TO_DATE('2001-11-09 11:12:53', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(11, '고래밥', 50, TO_DATE('2001-11-10 12:12:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(12, '고래밥', 40, TO_DATE('2001-11-11 08:09:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(13, '홈런볼', 60, TO_DATE('2001-11-12 09:10:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(14, '나아쵸', 20, TO_DATE('2001-11-13 10:11:12', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(15, '홈런볼', 70, TO_DATE('2001-11-14 11:12:13', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(16, '홈런볼', 80, TO_DATE('2001-11-15 12:13:14', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(17, '홈런볼', 90, TO_DATE('2001-11-16 13:14:15', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(18, '빼빼로', 10, TO_DATE('2001-11-17 14:15:16', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(19, '빼빼로', 20, TO_DATE('2001-11-19 15:16:17', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(20, '빼빼로', 30, TO_DATE('2001-11-20 16:17:18', 'YYYY-MM-DD HH24:MI:SS'));
--==>>1 행 이(가) 삽입되었습니다.*20

--※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.

--○ 확인
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	빼빼로	20	2001-11-01 09:10:12
2	거언빵	10	2001-11-01 10:20:30
3	모옹쉘	30	2001-11-01 11:10:05
4	눈감자	10	2001-11-02 13:20:11
5	나아쵸	20	2001-11-05 07:30:22
6	홈런볼	70	2001-11-06 15:20:34
7	고래밥	50	2001-11-07 11:10:13
8	포카칩	20	2001-11-07 19:42:53
9	포카칩	20	2001-11-08 19:42:53
10	포카칩	20	2001-11-09 11:12:53
11	고래밥	50	2001-11-10 12:12:23
12	고래밥	40	2001-11-11 08:09:10
13	홈런볼	60	2001-11-12 09:10:11
14	나아쵸	20	2001-11-13 10:11:12
15	홈런볼	70	2001-11-14 11:12:13
16	홈런볼	80	2001-11-15 12:13:14
17	홈런볼	90	2001-11-16 13:14:15
18	빼빼로	10	2001-11-17 14:15:16
19	빼빼로	20	2001-11-19 15:16:17
20	빼빼로	30	2001-11-20 16:17:18
*/

--○커밋
COMMIT;
--==>>커밋 완료.

--○ 추가 데이터 입력 → 2001년 부터 시작된 주문이 현재(2022년)까지 계속 발생~!!!
INSERT INTO TBL_JUMUN VALUES(98764, '고래밥',10,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98765, '빼빼로',20,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98766, '맛동산',30,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98767, '홈런볼',40,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98768, '오감자',50,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98769, '웨하스',30,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98770, '고래밥',20,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98771, '맛동산',20,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98772, '웨하스',20,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98773, '빼빼로',90,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98774, '에이스',20,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98775, '꼬북칩',30,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	    빼빼로	20	2001-11-01 09:10:12
2	    거언빵	10	2001-11-01 10:20:30
3	    모옹쉘	30	2001-11-01 11:10:05
4	    눈감자	10	2001-11-02 13:20:11
5   	나아쵸	20	2001-11-05 07:30:22
6	    홈런볼	70	2001-11-06 15:20:34
7	    고래밥	50	2001-11-07 11:10:13
8	    포카칩	20	2001-11-07 19:42:53
9	    포카칩	20	2001-11-08 19:42:53
10	    포카칩	20	2001-11-09 11:12:53
11	    고래밥	50	2001-11-10 12:12:23
12	    고래밥	40	2001-11-11 08:09:10
13	    홈런볼	60	2001-11-12 09:10:11
14	    나아쵸	20	2001-11-13 10:11:12
15	    홈런볼	70	2001-11-14 11:12:13
16	    홈런볼	80	2001-11-15 12:13:14
17	    홈런볼	90	2001-11-16 13:14:15
18	    빼빼로	10	2001-11-17 14:15:16
19	    빼빼로	20	2001-11-19 15:16:17
20	    빼빼로	30	2001-11-20 16:17:18
                   :
98764	고래밥	10	2022-03-02 09:28:38
98765	빼빼로	20	2022-03-02 09:30:32
98766	맛동산	30	2022-03-02 09:31:09
98767	홈런볼	40	2022-03-02 09:31:32
98768	오감자	50	2022-03-02 09:31:58
98769	웨하스	30	2022-03-02 09:32:24
98770	고래밥	20	2022-03-02 09:33:10
98771	맛동산	20	2022-03-02 09:33:44
98772	웨하스	20	2022-03-02 09:33:58
98773	빼빼로	90	2022-03-02 09:34:21
98774	에이스	20	2022-03-02 09:34:40
98775	꼬북칩	30	2022-03-02 09:34:59
*/

--○ 커밋
COMMIT;
--==>>커밋 완료.

--※ 상기가 과자 쇼핑몰 운영 중...
--   TBL_JUMUN 테이블이 너무 무거워진 상황
--   어플리케이션과의 연동으로 인해 주문 내역을 다른 테이블에
--   저장될 수 있도록 만드는 것은 불가능한 상황.(→ 이건 프로그램 다 뜯어내야함.)
--   기존의 모든 데이터를 덮어놓고 지우는 것도 불가능한 상황
--   → 결과적으로...
--      현재까지 누적된 주문 데이터들 중
--      금일 발생한 주문 내역을 제외하고
--      나머지 데이터를 다른 테이블(TBL_JUMUNBACKUP)로 데이터 이관을 수행할 계획

CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY,'YYYY-MM-DD') != TO_CHAR(SYSDATE,'YYYY-MM-DD');
--                                          -------
--                                  2022-03-02 10:09:38
--                                  →2022-03-02

--==>>Table TBL_JUMUNBACKUP이(가) 생성되었습니다.
SELECT *
FROM TBL_JUMUNBACKUP;
--==>>
/*
1	빼빼로	20	2001-11-01
2	거언빵	10	2001-11-01
3	모옹쉘	30	2001-11-01
4	눈감자	10	2001-11-02
5	나아쵸	20	2001-11-05
6	홈런볼	70	2001-11-06
7	고래밥	50	2001-11-07
8	포카칩	20	2001-11-07
9	포카칩	20	2001-11-08
10	포카칩	20	2001-11-09
11	고래밥	50	2001-11-10
12	고래밥	40	2001-11-11
13	홈런볼	60	2001-11-12
14	나아쵸	20	2001-11-13
15	홈런볼	70	2001-11-14
16	홈런볼	80	2001-11-15
17	홈런볼	90	2001-11-16
18	빼빼로	10	2001-11-17
19	빼빼로	20	2001-11-19
20	빼빼로	30	2001-11-20
*/
--> TBL_JUMUN 테이블의 데이터들 중
--  금일 주문 내역 이외의 데이터는 모두 TBL_JUMUNBACKUP 테이블에
-- 백업을 마친 상태

--TBL_JUMUN 테이블의 데이터들 중
-- 백업을 마친 데이터들 삭제 → 즉, 금일 발생한 주문 내역이 아닌 데이터들 제거

DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY,'YYYY-MM-DD') != TO_CHAR(SYSDATE,'YYYY-MM-DD');
--==>>20개 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	고래밥	10	2022-03-02
98765	빼빼로	20	2022-03-02
98766	맛동산	30	2022-03-02
98767	홈런볼	40	2022-03-02
98768	오감자	50	2022-03-02
98769	웨하스	30	2022-03-02
98770	고래밥	20	2022-03-02
98771	맛동산	20	2022-03-02
98772	웨하스	20	2022-03-02
98773	빼빼로	90	2022-03-02
98774	에이스	20	2022-03-02
98775	꼬북칩	30	2022-03-02
*/

--○ 커밋
COMMIT;
--==>>커밋 완료.

--※ 아직 제품이 발송이 이루어지지 않은 금일 주문 데이터를 제외하고
--   이전의 모든 주문 데이터들이 삭제된 상황이므로
--   테이블은 행(레코드)의 갯수가 줄어들어 매우 가벼워진 상황이다.

-- TBL_JUMUN, TBL_JUMUNBACKUP
-- 테이블 구조 같음
-- UNION, UNION ALL 같은 결과 출력
SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	빼빼로	20	2001-11-01
2	거언빵	10	2001-11-01
3	모옹쉘	30	2001-11-01
4	눈감자	10	2001-11-02
5	나아쵸	20	2001-11-05
6	홈런볼	70	2001-11-06
7	고래밥	50	2001-11-07
8	포카칩	20	2001-11-07
9	포카칩	20	2001-11-08
10	포카칩	20	2001-11-09
11	고래밥	50	2001-11-10
12	고래밥	40	2001-11-11
13	홈런볼	60	2001-11-12
14	나아쵸	20	2001-11-13
15	홈런볼	70	2001-11-14
16	홈런볼	80	2001-11-15
17	홈런볼	90	2001-11-16
18	빼빼로	10	2001-11-17
19	빼빼로	20	2001-11-19
20	빼빼로	30	2001-11-20
98764	고래밥	10	2022-03-02
98765	빼빼로	20	2022-03-02
98766	맛동산	30	2022-03-02
98767	홈런볼	40	2022-03-02
98768	오감자	50	2022-03-02
98769	웨하스	30	2022-03-02
98770	고래밥	20	2022-03-02
98771	맛동산	20	2022-03-02
98772	웨하스	20	2022-03-02
98773	빼빼로	90	2022-03-02
98774	에이스	20	2022-03-02
98775	꼬북칩	30	2022-03-02
*/

-- 그런데, 지금까지 주문받은 내역에 대한 정보를
-- 제품별 총 주문량으로 나타내어야 할 상황이 발생하게 되었다.
-- 그렇다면, TBL_JUMUNBACKUP 테이블의 레코드(행)와
-- TBL_JUMNUN 테이블의 레코드(행)을 합쳐서
-- 하나의 테이블을 조회하는 것과 같은 결과를 확인할 수 있도록
-- 조회가 이루어져야 한다.

-- ※ 컬럼과 컬럼의 관계를 고려하여 테이블을 결합하고자 하는 경우
--    JOIN을 사용하지만
--    레코드와 레코드를 결합하고자 하는 경우
--    UNION / UNION ALL 을 사용할 수 있다.
SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;

-->UNION ALL 은 순서가 있다.

-- ※ UNION 은 항상 결과물의 첫 번째 컬럼 기준으로
--    오름차순 정렬을 수행한다.(여기서는 JUNO)
--    UNION ALL 은 결합된 순서대로(테이블을 쿼리문에서 명시한 순서대로)
--    조회한 결과를 반환한다.(즉, 정렬 기능 없음.)
--    이로 인해 UNION 이 부하가 더 크다.(리소스 소모가 더 크다.)
--    또한 UNION 은 결과물에 중복된 행이 존재할 경우
--    중복을 제거하고 1개 행만 조회된 결과를 반환하게 된다.
--    DISTINCT처럼...

--○ 지금까지 주문받은 데이터들 통해
--   제품별 총 주문량을 조회할 수 있는 쿼리문을 구성한다.

SELECT JECODE
FROM TBL_JUMUNBACKUP
UNION 
SELECT JECODE
FROM TBL_JUMUN;
--==>>JECODE 13개.

SELECT T.JECODE, SUM(T.JUSU)
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
)T
GROUP BY T.JECODE;
--==>>
/*
나아쵸	40
꼬북칩	30
눈감자	10
맛동산	50
웨하스	50
에이스	20
포카칩	60
오감자	50
거언빵	10
모옹쉘	30
빼빼로	190
홈런볼	410
고래밥	170
*/

--○ 데이터 추가 입력
INSERT INTO TBL_JUMUN VALUES(98776, '모옹쉘',30,SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
--○ 확인
SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	고래밥	10	2022-03-02
98765	빼빼로	20	2022-03-02
98766	맛동산	30	2022-03-02
98767	홈런볼	40	2022-03-02
98768	오감자	50	2022-03-02
98769	웨하스	30	2022-03-02
98770	고래밥	20	2022-03-02
98771	맛동산	20	2022-03-02
98772	웨하스	20	2022-03-02
98773	빼빼로	90	2022-03-02
98774	에이스	20	2022-03-02
98775	꼬북칩	30	2022-03-02
98776	모옹쉘	30	2022-03-02
*/
--○ 커밋
COMMIT;
--==>>커밋 완료.


--○ INTERSECT / MINUS (→ 교집합과 차집합)

-- TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서
-- 제품코드와 주문수량의 값이 똑같은 행만 추출하고자 한다.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
모옹쉘	30
빼빼로	20
*/

--○ TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블을 대상으로
--   제품코드와 주문량의 값이 똑같은 행의 정보를
--   주문번호, 제품코드, 주문량, 주문일자 항목으로 조회한다.

SELECT *
FROM TBL_JUMUN;

DESC TBL_JUMUN;

(SELECT JECODE"제품코드",JUSU"주문량"
FROM TBL_JUMUNBACKUP
INTERSECT 
SELECT JECODE"제품코드",JUSU"주문량"
FROM TBL_JUMUN);

SELECT
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T
WHERE 제품코드, 수량이 같은것;

SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T
WHERE (SELECT TB.JECODE,TB.JUSU
        FROM TBL_JUMUNBACKUP TB
        INTERSECT
        SELECT T.JECODE,T.JUSU
        FROM TBL_JUMUN T);

SELECT JECODE
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE
FROM TBL_JUMUN;
------------------------------------------------최종!
SELECT T.*
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T JOIN (SELECT JECODE,JUSU
         FROM TBL_JUMUNBACKUP
         INTERSECT
         SELECT JECODE,JUSU
         FROM TBL_JUMUN)T2
ON T2.JECODE = T.JECODE
    AND T2.JUSU = T.JUSU;
--==>>
/*
1	    빼빼로	20	2001-11-01
3	    모옹쉘	30	2001-11-01
19	    빼빼로	20	2001-11-19
98765	빼빼로	20	2022-03-02
98776	모옹쉘	30	2022-03-02
*/





















