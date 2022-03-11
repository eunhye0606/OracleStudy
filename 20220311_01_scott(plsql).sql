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

--�� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν����� �ۼ�
--   ��, �� ���ν����� ���� �����͸� �Է��� ���
--   CITY(����) �׸� '����' , '���','����' �� �Է��� �����ϵ��� �����Ѵ�.
--   �� ���� ���� �ٸ� ������ ���ν��� ȣ���� ���� �Է��ϰ��� �ϴ� ���
--   (��, �Է��� �õ��ϴ� ���)
--   ���ܿ� ���� ó���� �Ϸ��� �Ѵ�.

/*
���� ��)
EXEC PRC_MEMBER_INSERT('�Ӽҹ�','010-1111-1111','����');
--==>> ������ �Է� O
EXEC PRC_MEMBER_INSERT('�̿���','010-2222-2222','�λ�');
--==>> ������ �Է� X
*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
(V_NAME         IN TBL_MEMBER.NAME%TYPE
,V_TEL          IN TBL_MEMBER.TEL%TYPE
,V_CITY         IN TBL_MEMBER.CITY%TYPE
)
IS
    --�����(�ֿ� ���� ����)
    --������  ������Ÿ��;
    -- ���� ������ ������ ������ ���� �ʿ��� ���� �����
    -- �� ����Ŭ������ ���ܵ� �����̴�.��
    
    --��
    V_NUM   TBL_MEMBER.NUM%TYPE;
    --�� ����� ���� ���ܿ� ���� ���� ���� CHECK ~!!!
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ���������� �ƴ����� ���θ�
    -- ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    -- ���� X �̸�, INSERT ���� �ȵ��ư�.
    IF (V_CITY NOT IN ('����','���','����'))
        -- ���� �߻� CHECK ~ !!!
        THEN RAISE USER_DEFINE_ERROR;       --���ܹ߻���, �ڿ��� �ǳʶٰ� ����ó���������� �̵�.
    END IF;
    
    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM),0) + 1 INTO V_NUM
    FROM TBL_MEMBER;
    
    -- ������ ���� �� INSERT
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES(V_NUM,V_NAME, V_TEL, V_CITY);
    
    -- ���� ó�� ����
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'����,���,������ �Է��� �����մϴ�.');
                 ROLLBACK;
        WHEN OTHERS     --USER_DEFINE_ERROR�� �ƴϸ� ...
            THEN ROLLBACK;
            --RAISE_APPLICATION_ERROR()
            --20000�������� ����Ŭ�� ����
            --������Ʈ�ϸ鼭 ��Ģ
            --ex) Ŭ���̾�Ʈ������ 2100����
            --    ���� ������ 2200����...
    -- Ŀ��
    COMMIT;
END;
--==>>Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.

--RAISE USER_DEFINE_ERROR �̰ɷ� ����ο��� ���ܹ߻���,
--�ڿ� ���� �� �����ϰ� ����ó���� ����, �ѹ����1!!!
--RAISE USER_DEFINE_ERROR�̰� �ƴ� ���ܵ��� �ϴ� �ڿ� ���� �����ϰ�
--���� �߻��Ǹ� �ѹ�!


--�� TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� ����
--   ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ����.
--   ����, �������� ���������� ���� ���....
--   ��� �׼��� ����� �� �ֵ��� ó���Ѵ�.(��� �̷������ �ʵ���...) �� ����ó��
/*
���� ��)
EXEC PRC_���_INSERT('H001',10,600);

-- ���� ��ǰ ���̺��� �ٹ�� �������� 50��
EXEC PRC_���_INSERT('H001',10,600);
--==>>���� �߻�
--    ������
*/
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
(V_��ǰ�ڵ�     IN TBL_��ǰ.��ǰ�ڵ�%TYPE     
,V_������     IN TBL_���.������%TYPE
,V_���ܰ�     IN TBL_���.���ܰ�%TYPE
)
IS
    -- �����
    --�߰� �ֿ� ���� ����
    V_����ȣ  TBL_���.����ȣ%TYPE;
    N_������  TBL_��ǰ.������%TYPE;
    
    -- ���� ���� ����.
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- �����
    SELECT ������ INTO N_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --���ܹ߻�
    IF (N_������ < V_������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT NVL(MAX(����ȣ),0) + 1 INTO V_����ȣ
    FROM TBL_���;
    
    -- ��� ���̺� INSERT ������
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES(V_����ȣ,V_��ǰ�ڵ�,V_������,V_���ܰ�);
    
    -- ��ǰ ���̺� UPDATE ������
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --���� ó��
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'������');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    --Ŀ��
    COMMIT;
END;
--==>>Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------
--Ǯ��
-- ���ν����� �� �Ѱ��ִ� ������� �ν�(��ǰ�ڵ�, ������, ���ܰ�)
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
(V_��ǰ�ڵ�     IN TBL_��ǰ.��ǰ�ڵ�%TYPE
,V_������     IN TBL_���.������%TYPE
,V_���ܰ�     IN TBL_���.���ܰ�%TYPE
)
IS
    -- �ֿ� ���� ����
    V_������  TBL_��ǰ.������%TYPE;
    V_����ȣ  TBL_���.����ȣ%TYPE;
    
    -- ����� ���� ���� ����
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
        --������ ���� ������ ���� ���θ� Ȯ���ϴ� ��������
        --��� �ľ� �� ���� ��� Ȯ���ϴ� ������ ����Ǿ�� �Ѵ�.
        --�׷��� ���ν��� ȣ�� ��, �Ѱܹ޴� �������� �񱳰� �����ϱ� ����...
        SELECT ������ INTO V_������
        FROM TBL_��ǰ
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
        
        -- ��� ���������� ������ �� �������� ���� ���� Ȯ��
        -- ������ �ľ��� ���������� ���� ���ν������� �Ѱܹ��� �������� ������
        -- ���ܹ߻�~!!!!
        IF (V_������ > V_������)
            -- ���� �߻�
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        -- ����ȣ�� �� ��Ƴ���(���Ѵ�� ������ �ۼ��ϸ� ���ҽ� ����!)
        -- PL/SQL ������ �ڵ��� ���� �߿��ϴ�!
        -- ����ȣ ���� �� ������ ������ ������ �� ��Ƴ���
        SELECT NVL(MAX(����ȣ),0) + 1 INTO V_����ȣ
        FROM TBL_���;
        
        --������ ���� �� INSERT(TBL_���)
        INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
        VALUES(V_����ȣ, V_��ǰ�ڵ�, V_������, V_���ܰ�);
        
        --������ ���� �� UPDATE(TBL_��ǰ)
        UPDATE TBL_��ǰ
        SET ������ = ������ - V_������
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
        
        -- ����ó��
        EXCEPTION
            WHEN USER_DEFINE_ERROR
                THEN RAISE_APPLICATION_ERROR(-20002,'��� ���� ~!!!');
                    ROLLBACK;
            WHEN OTHERS
                THEN ROLLBACK;
        -- Ŀ��
        COMMIT;
END;
--==>>Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--�� TBL_��� ���̺��� �������� ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_���_UPDATE()
/*
���� ��)
EXEC PRC_���_UPDATE(����ȣ, �����Ҽ���);
*/

CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
(V_����ȣ     IN TBL_���.����ȣ%TYPE
,V_�����Ҽ���   IN TBL_��ǰ.������%TYPE
)
IS
    --�ֿ� ���� ����
    V_��ǰ������  TBL_��ǰ.������%TYPE;
    V_����������  TBL_���.������%TYPE;
    
    --���ܺ���
    USER_DEFINE_ERROR1 EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
BEGIN
    --��ǰ���̺� ������ ��Ƴ���
    SELECT ������ INTO V_��ǰ������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = (SELECT ��ǰ�ڵ�
                      FROM TBL_���
                      WHERE ����ȣ = V_����ȣ);
                      
     --������̺� ���������� ��Ƴ���
     SELECT ������ INTO V_����������
     FROM TBL_���
     WHERE ����ȣ = V_����ȣ;
     
    --����ó��
    IF(V_��ǰ������ <V_�����Ҽ��� - V_����������)
        THEN RAISE USER_DEFINE_ERROR1;
    ELSIF (V_�����Ҽ��� = V_����������)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    --UPDASATE ������ �� TBL_���
    UPDATE TBL_���
    SET ������ = V_�����Ҽ���
    WHERE ����ȣ = V_����ȣ;
    
    --UPDASATE ������ �� TBL_��ǰ
    /*
    UPDATE (SELECT S.��ǰ�ڵ�, S.������, C.����ȣ,C.������
            FROM TBL_��ǰ S JOIN TBL_��� C
            ON S.��ǰ�ڵ� = C.��ǰ�ڵ�) T
    SET T.������ = T.������ - (V_�����Ҽ���-V_����������)
    WHERE T.����ȣ = V_����ȣ;
    */
    UPDATE TBL_��ǰ
    SET ������ = ������ - (V_�����Ҽ��� - V_����������)
    WHERE ��ǰ�ڵ� = (SELECT ��ǰ�ڵ�
                      FROM TBL_���
                      WHERE ����ȣ = V_����ȣ);
    
    --����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20003,'����������   ������ :'||V_��ǰ������);
                ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20004,'������׾���. ���������� :'||V_����������);
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    --Ŀ��
    --COMMIT;
END;
--==>>Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.



