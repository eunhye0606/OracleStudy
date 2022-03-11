SELECT USER
FROM DUAL;
--==>>SCOTT

--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY,SUDANG
--   ���� ������ �÷� �� NUM �� ������
--   NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY,SUDANG
--   �� ������ �Է� ��
-- NUM �÷�(�����ȣ)�� ����
-- ���� �ο��� ��� ��ȣ�� ������ ��ȣ �� ���� ��ȣ�� �ڵ����� �Է� ó���� �� �ִ�
-- ���ν����� �����Ѵ�.
-- ���ν��� �� : PRC_INSA_INSERT()
/*
EXEC PRC_INSA_INSERT('������','970131-2234567',SYSDATE,'����',010-8624-4553'.'���ߺ�','�븮',2000000,2000000)
*/
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
V_NUM       TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MAX(NUM) INTO V_NUM      --SELECT�� ����ο� ���� ��, �򰥸��� ����!
    FROM TBL_INSA;
    
    V_NUM := V_NUM +1;
                
    INSERT INTO TBL_INSA(NUM,NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY,SUDANG)
    VALUES(V_NUM,V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY,V_SUDANG);
END;

--------------------------------------------------------------------------------
--Ǯ��
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM       TBL_INSA.NUM%TYPE;
BEGIN
    --�׷��Լ� : NULL ����
    --���̺� ������ �� �����Ǹ� ��ȸ�ϸ� NULL..
    --�׷��� ��ȸ���� ��, NULL�̸� ���̺� ������ ����
    --�׷��� NULL�϶� 0���� ��ȸ
    SELECT MAX(NVL(NUM,0)) + 1 INTO V_NUM
    FROM TBL_INSA;
    
    INSERT INTO TBL_INSA(NUM,NAME,SSN,IBSADATE,CITY,TEL,BUSEO,JIKWI,BASICPAY,SUDANG)
    VALUES(V_NUM,V_NAME,V_SSN,V_IBSADATE,V_CITY,V_TEL,V_BUSEO,V_JIKWI,V_BASICPAY,V_SUDANG);
    
    COMMIT; --CHECK~!!
END;
--==>>Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.

--�������� 4����.
--�Է�����, �������, ���������
--����� �����ݷ�
--�̹��� �Ѱ�ó�� ���̺� ������ �ϳ��� �������� ���ν��� ���ư� �� 
--�ֵ��� ó��!
--���ν��� ���� COMMIT;




--------------------------------------------------------------------------------
--�� TBL_��ǰ, TBL_�԰� ���̺��� �������
--   TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ���� ���ν����� �ۼ��Ѵ�.
--   ��, �� �������� �԰��ȣ�� �ڵ� ���� ó��(������ ��� X)
--   TBL_�԰� ���̺� ���� �÷�
--   :�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�
--   ���ν��� �� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)

--'H001', 30, 400
-- �� �԰����̺��� ������ �Է�(���ν��� �Ű������� ���޹��� ���� ������ �� �� �ڵ� �Է�)
-- �� ��ǰ���̺��� �ٹ�� ������ 30��
CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
(V_��ǰ�ڵ�     IN TBL_�԰�.��ǰ�ڵ�%TYPE
,V_�԰����     IN TBL_�԰�.�԰����%TYPE
,V_�԰�ܰ�     IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    --�԰����̺� ����
    V_�԰��ȣ      TBL_�԰�.�԰��ȣ%TYPE;     
    V_�԰�����      TBL_�԰�.�԰�����%TYPE;
    --��ǰ���̺� ����
    N_������      TBL_��ǰ.������%TYPE;
BEGIN
    --�԰����̺� ������ �Ҵ�.
    SELECT NVL(MAX(�԰��ȣ),0) +1 INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    V_�԰����� := SYSDATE;
    
    --�԰����̺� INSERT
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
    VALUES(V_�԰��ȣ, V_��ǰ�ڵ�, V_�԰�����, V_�԰����, V_�԰�ܰ�);
    
    --��ǰ���̺� ������ = �԰����
    N_������ := V_�԰����;
    
    --��ǰ���̺� ������ UPDATE
    UPDATE TBL_��ǰ
    SET ������ = ������ + N_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

END;

--==>>Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------
--Ǯ��

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
(V_��ǰ�ڵ�     IN TBL_��ǰ.��ǰ�ڵ�%TYPE         --�ߺ��Ǵ� �÷��� �θ����̺��� �÷��� ���� ���� ����!
,V_�԰����     IN TBL_�԰�.�԰����%TYPE
,V_�԰�ܰ�     IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    --�����
    --�Ʒ��� �������� �����ϱ� ���� �ʿ��� ���� �߰� ����
    V_�԰��ȣ  TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    -- ������ ������ �� ��Ƴ���
    -- SELECT ������ ����
    SELECT NVL(MAX(�԰��ȣ),0) INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    --INSERT ������ ����
    INSERT INTO TBL_�԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
    VALUES((V_�԰��ȣ)+1,V_��ǰ�ڵ�,SYSDATE,V_�԰����,V_�԰�ܰ�);      -- �ƴϸ� �԰����ڸ� �ƿ����ε�. ���̺� ������, 
                                                                -- �԰����ڸ� DEFULT SYSDATE �صּ�.
    --UPDATE ������ ����
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó��(INSERT�� �ϰ� ���� �ٿ���� �� ...
    --           �� �� �ϳ��� ���� �Ǿ��� ��,...
    --           ���⼭ ����� ��Ȳ�� �ƴ� �ٸ� ��Ȳ�� �߻����� ��..)
    EXCEPTION       --�ڹ��� try ~ catch
        WHEN OTHERS THEN ROLLBACK;
    --Ŀ��
    COMMIT;
END;
--==>>Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------
--���� ���ν��� �������� ���� ó�� ����--



