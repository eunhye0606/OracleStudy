SELECT USER
FROM DUAL;
--==>>SCOTT

--�� IF ��(���ǹ�)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL �� IF ������ �ٸ� ����� IF ���ǹ��� ���� �����ϴ�.
--    ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �ֵ��� �Ѵ�.
--    TRUE �̸� THEN �� ELSE ������ ������ �����ϰ�
--    FALSE �� NULL �̸� ELSE �� END IF; ������ ������ �����ϰ� �ȴ�.

-- 2. ���� �� ����
/*
�� �������� IF��
IF ����
    THEN ó����;
END IF;
*/
--------------------
/*
�� ELSE�� THEN�� ����.
IF ����
    THEN ó����;
ELSE
    ó����;
END IF;
*/
--------------------
/*
�� ELSEIF
IF ����
    THEN ó����;
ELSIF ����
    THEN ó����;
ELSIF ����
    THEN ó����;
THEN ó����;
END IF;
*/


/*
COL1 NUMBER �� NUMBER�� ���� �ּڰ� ~ �ִ�
COL2 CHAR   �� �ѱ��ڸ�!

NUMBER �� CHAR
CHAR : �����ϳ� ���� Ÿ��. ĳ����.
����Ŭ ���ο����� ���ڹ迭ó�� �����ؼ� CHAR(10) �� ����10��

*/
-- �ڹ�ó�� ���̽��� ���� �ʾƼ�
-- ���������� ��� �����ؼ� �������� ����ؾ� ��.
-- �׷��� IF, END IF �̷���!

SET SERVEROUTPUT ON;
--> �̰��ؾ��� PLSQL ����� �� �� ����!

--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    GRADE CHAR; -- ����� : GRADE ��� ������ �����Ұž�. CHAR��� ������!
BEGIN
    GRADE := 'C'; --����� : GRADE�� 'A'��� ���ڸ� ��ڴ�.
    --DBMS_OUTPUT.PUT_LINE(GRADE); --���
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'C'
        THEN DBMS_OUTPUT.PUT_LINE('COOL');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--> �����Ƽ� ���� ���� ����  ~ 

--�� CASE ��(���ǹ�)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1 THEN ���๮;
    WHEN ��2 THEN ���๮;
    ELSE ���๮;
END CASE;
*/


------
--�ܺ� �����͸� PLSQL �������� ���� �´�.
       ----
       --������ ����
           ------
           --����ڿ��� ���ڴ�.
-- ACCEPT�� �ڷ� �ּ� �޸� �±��� �о
-- ���� �߻�.
ACCEPT NUM PROMPT '����1 ����2 �Է��ϼ���';


DECLARE
    -- �ֿ� ���� ����
    SEL NUMBER := &NUM; -- NUM�� ����ִ� ���� ���η� ������� �� / TEMP�� &TEMP / INPUT�̸� &INPUT
    RESULT VARCHAR2(10) := '����';
BEGIN
    -- �׽�Ʈ
    --DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    -- ���� �� ó��
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Ȯ�κҰ�');
    END CASE;
    */
    
    CASE SEL
        WHEN 1
        THEN RESULT := '����';
        WHEN 2
        THEN RESULT := '����';
        ELSE
            RESULT := 'Ȯ�κҰ�';
    END CASE;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE('ó������� '||RESULT ||'�Դϴ�');
END;

-- �� �ܺ� �Է� ó��
-- ACCEPT ����
-- ACCEPT ������ PROMPT '�޼���';
--> �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
--  ��&�ܺκ����� ���·� �����ϰ� �ȴ�.

-- �� ���� 2���� �ܺηκ���(����ڷκ���) �Է¹޾�
--    �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

ACCEPT NUM1 PROMPT 'ù��° ������ �Է��ϼ��� :';
ACCEPT NUM2 PROMPT '�ι�° ������ �Է��ϼ��� :';

DECLARE
    NUM1 NUMBER := &NUM1;
    NUM2 NUMBER := &NUM2;
    SUMM NUMBER := 0;
BEGIN
    -- ����
    SUMM := NUM1 + NUM2;
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE('ù��° ���� : ' || NUM1);
    DBMS_OUTPUT.PUT_LINE('�ι�° ���� : ' || NUM2);
    DBMS_OUTPUT.PUT_LINE('���: ' || SUMM);
END;
--==>>
/*
ù��° ���� : 1
�ι�° ���� : 3
���: 4
*/

--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ������� �����Ͽ� ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.

/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/

ACCEPT INPUT PROMPT '�ݾ� �Է�';
DECLARE
    -- �� �ֿ� ���� ����
    MONEY   NUMBER := &INPUT;   -- ������ ���� �Է°��� ��Ƶ� ����
    MONEY2  NUMBER := &INPUT;   -- ��� ����� ���� �Է°��� ��Ƶ� ����
                                -- (MONEY ������ ������ ó���ϴ� �������� ���� �޶����� �����̴�.)
    
    M500    NUMBER;             -- 500�� ¥�� ������ ��Ƶ� ����
    M100    NUMBER;             -- 100�� ¥�� ������ ��Ƶ� ����
    M50     NUMBER;             --  50�� ¥�� ������ ��Ƶ� ����
    M10     NUMBER;             --  10�� ¥�� ������ ��Ƶ� ����
BEGIN
    -- �� ���� �� ó��
    -- MOMEY�� 500���� ������ ���� ���ϰ� �������� ������. �� 500���� ����
    M500 := TRUNC(MONEY/500);
    
    -- MONEY�� 500���� ������ ���� ������ �������� ���Ѵ�. �� 500���� ���� Ȯ���ϰ� ���� �ݾ�
    MONEY := MOD(MONEY,500);
    
    -- MONEY�� 100���� ������ ���� ���ϰ� �������� ������ �� 100���� ����
    M100 := TRUNC(MONEY/100);
    
    --MONEY�� 100���� ������ ���� ������ �������� ���Ѵ� �� 100���� ���� Ȯ���ϰ� ���� ���� Ȯ��
    MONEY := MOD(MONEY,100);
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ������. �� 50���� ����
    M50 := TRUNC(MONEY/50);
    
    -- MONEY�� 50���� ������ ���� ������ �������� ���Ѵ� �� 50���� ���� Ȯ���ϰ� ���� �ݾ� Ȯ��
    MONEY := MOD(MONEY,50);
    
    -- MONEY�� 10���� ������ ���� ���ϰ� �������� ������ �� 10���� ����
    M10 := TRUNC(MONEY/10);
    
    --�� ��� ���
    -- ���յ� ���(ȭ������� ����)�� ���Ŀ� �°� ���� ����Ѵ�.
    --    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� :990��');
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� :' || MONEY2||'��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� '|| M500
    ||', ��� ' ||M100
    ||', ���ʿ�'||M50
    ||', �ʿ� '||M10);
END;
--==>>
/*
�Է¹��� �ݾ� �Ѿ� :990��
ȭ����� : ����� 1, ��� 4, ���ʿ�1, �ʿ� 4
*/

--�� �⺻ �ݺ���
-- LOOP ~ END LOOP;

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP                -- (�ڹ� while(true))
    -- ���๮
    EXIT WHEN ����; -- ������ ���� ��� �ݺ����� ����������(�ڹ� break)
END LOOP;
*/

-- 1 ���� 10 ������ �� ���(LOOP �� Ȱ��)
DECLARE
    N NUMBER;          -- LOOP ���� ����
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N >= 10;

        N := N + 1;    -- �ڹ��� ��N++;��,��N+=1;��
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/

--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE�� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--    WHILE LOOP ������ ����Ѵ�.
--    ������ �ݺ��� ���۵Ǵ� ������ üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.


-- 2. ���� �� ����
/*
WHILE ���� LOOP   -- ������ ���� ��� �ݺ� ����
    -- ���๮;
END LOOP;
*/


--�� 
--  LOOP ~ END LOOP; �� ������ ���̸� �ݺ��� Ż��
--  WHILE LOOP ~ END LOOP; �� ������ ���̸� �ݺ��� ����


-- 1���� 10������ �� ���(WHILE LOOP �� Ȱ��)
DECLARE
    N NUMBER;       -- LOOP ���� ����
BEGIN
    N := 0;         -- �ʱⰪ
    WHILE N<10 LOOP
        N := N + 1;     -- N�� 0~ 9����
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;
-- (�ڹ��� ���� for�� ����..)

-- 1. �����ۼ������� 1�� �����Ͽ�
--    ������������ �� �� ���� �ݺ� �����Ѵ�.

--2. ���� �� ����

/*
FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP
    -- ���๮;
END LOOP;
*/

-- 1���� 10������ �� ���(FOR LOOP �� Ȱ��)
DECLARE
    N   NUMBER;         --LOOP ���� ����.
BEGIN
    FOR N IN 1 .. 10 LOOP   -- N�� 1 ~ 10���� ���������� �����ž�
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� : 2
2 * 1 = 2
2 * 2 = 4
  :
2 * 9 = 18
*/

-- 1.LOOP ���� ���
ACCEPT INPUT PROMPT '���� �Է��ϼ���. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER := 1; --LOOP ���� ����
    
BEGIN
    LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N); 
    
    N := N +1;
    EXIT WHEN N >10;
    
    END LOOP;
    
END;
----------------------------���� Ǯ��-------------------------------------------
ACCEPT INPUT PROMPT '���� �Է��ϼ���. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
    
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N); 
        EXIT WHEN N >=9;
        N := N +1;
    END LOOP;
END;
--------------------------------------------------------------------------------
SET SERVEROUTPUT ON;


-- 2. WHILE LOOP ���� ���
ACCEPT INPUT PROMPT '���� �Է��ϼ���. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER := 1;
BEGIN
    WHILE N<=10 LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N); 
    N := N + 1;
    END LOOP;
END;
----------------------------���� Ǯ��-------------------------------------------
ACCEPT INPUT PROMPT '���� �Է��ϼ���. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
    
BEGIN
    N := 0;
    WHILE N<9 LOOP
        N := N +1;
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N); 
    END LOOP;
END;
--------------------------------------------------------------------------------
-- 3. FOR LOOP ���� ���
ACCEPT INPUT PROMPT '���� �Է��ϼ���. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
BEGIN
    FOR N IN 1.. 10 LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N);
    END LOOP;
END;
----------------------------���� Ǯ��-------------------------------------------
ACCEPT INPUT PROMPT '���� �Է��ϼ���. '; 
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
    
BEGIN
   FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '=' || DAN*N);
   END LOOP;
END;
--------------------------------------------------------------------------------

--�� ������ ��ü(2�� ~ 9��)�� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   ��, ���� �ݺ���(�ݺ����� ��ø)������ Ȱ���Ѵ�.
/*
���� ��)
==[ 2 �� ]==
2 * 1 = 2
   :
==[ 3 �� ]==
   :
==[ 9 �� ]==
*/
-- LOOP .ver
DECLARE
    DAN NUMBER := 2; 
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('==['||DAN||'��]==');
        LOOP 
            DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '==' || DAN * N);
            N := N + 1;
            EXIT WHEN N > 9;
        END LOOP;
        N := 1; -- N �ʱ�ȭ.
        DAN := DAN + 1;
        EXIT WHEN DAN > 9;
    END LOOP;
END;

-- WHILE LOOP .ver
DECLARE
    DAN NUMBER := 2;
    N NUMBER := 1;
BEGIN
    WHILE DAN < 10 LOOP
        DBMS_OUTPUT.PUT_LINE('==['||DAN||'��]==');
        WHILE N < 10 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '==' || DAN * N);
            N := N + 1;
        END LOOP;
        N := 1; -- N�� �ʱ�ȭ
        DAN := DAN + 1;
    END LOOP;
END;

-- FOR LOOP.ver
DECLARE
    DAN NUMBER; --LOOP ����(��) 2 ~ 9
    N NUMBER; -- LOOP����(��) 1 ~ 9
BEGIN
    FOR DAN IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==['||DAN||'��]==');
        FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || '==' || DAN * N);
        END LOOP;
    END LOOP;
END;













