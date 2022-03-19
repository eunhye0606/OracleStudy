SELECT USER
FROM DUAL;
--==>>SCOTT
--------------------------------------------------------------------------------
--���� AFTER ROW TRIGGER ��Ȳ �ǽ� ����--
-- �� ���� ���̺� ���� Ʈ����� ó��

-- TBL_�԰�, TBL_��ǰ, TBL_���

--�� TBL_�԰� ���̺��� ������ �Է� �� (��, �԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� ������� ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_IBGO

--��
/*
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        --UPDATE ON TBL_��ǰ
        INSERT ON TBL_�԰�        -- �԰����̺��� ���ڵ��Է½� �� Ʈ���� ������.
        FOR EACH ROW              -- ROW TRIGGER = �� TRIGGER
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� + �����԰��Ǵ��԰�����
             WHERE ��ǰ�ڵ� = �����԰��Ǵ� ��ǰ�ڵ�;
    END IF;
END;
*/

--��
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        --UPDATE ON TBL_��ǰ
        INSERT ON TBL_�԰�        -- �԰����̺��� ���ڵ��Է½� �� Ʈ���� ������.
        FOR EACH ROW              -- ROW TRIGGER = �� TRIGGER
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� + :NEW.�԰�����
             WHERE ��ǰ�ڵ� =:NEW.��ǰ�ڵ�;
    END IF;
END;
--==>>Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.

--�� TBL_�԰� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������� ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_IBGO
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_�԰�
        FOR EACH ROW
BEGIN
    
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� + :NEW.�԰�����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� - :OLD.�԰����� + :NEW.�԰�����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
                 SET ������� = ������� - :OLD.�԰�����
                 WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
                -- �峭�ϳ� �̹̻����Ǵϱ� :NEW��� �ϸ� �翬�� NULL�� �޾ƿ��� �Ѥ�
                -- ���������� ȫ����
    /*
        THEN INSERT INTO TBL_���(�����ȣ, ��ǰ�ڵ�)
        VALUES(1,:NEW.��ǰ�ڵ�);    -- CHECK ��ǰ�ڵ带 NULL�� ����. ��, ��ǰ�ڵ带 �ν� �Ұ�.  
    */
    /*
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� - OLD:�������                            --�̰� ��ü�� �ȵ�����.
             WHERE ��ǰ�ڵ� =  (SELECT ��ǰ�ڵ�
                                FROM TBL_�԰�
                                WHERE �԰���ȣ = :NEW.�԰���ȣ);                --���Ⱑ ������. ��ǰ�ڵ带 �Է¾��� DELETE�� �ۼ��Ҷ�.
    */
    /*
        THEN UPDATE TBL_��ǰ
        SET ������� = ������� - :OLD.�԰����� 
        WHERE ��ǰ�ڵ� = (SELECT ��ǰ�ڵ�
                          FROM TBL_�԰�
                          WHERE �԰���ȣ = :NEW.�԰���ȣ);
    */
    /*
    THEN UPDATE TBL_��ǰ
        SET ������� = ������� - :NEW.�԰����� 
        WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�; --�̷��� ��ǰ�ڵ尡 NULL�� �� �Ф� �񱳸� ����
    */
    END IF;
    
END;
--==>>Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------
--------------------------Ǯ��---------------------------------------
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_�԰�
        FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� + :NEW.�԰�����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
          THEN UPDATE TBL_��ǰ
          SET ������� = ������� - :OLD.�԰����� + :NEW.�԰�����
          WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
          --(NEW, OLD�� �� �Ǵµ� ��ǰ�ڵ带 UPDATE�� �ϴ� ���� �ƴϱ⿡)
    ELSIF (DELETING)
          THEN UPDATE TBL_��ǰ
          SET ������� = ������� - :OLD.�԰�����
          WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
END;
--==>>Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------

--�� TBL_��� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������� ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_CHULGO
CREATE OR REPLACE TRIGGER TRG_CHULGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_���
        FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������� = ������� - :NEW.�������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
          THEN UPDATE TBL_��ǰ
               SET ������� = ������� +:OLD.������� - :NEW.�������
               WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    ELSIF (DELETING)
          THEN UPDATE TBL_��ǰ
               SET ������� = ������� + :OLD.�������
               WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
END;
--==>>Trigger TRG_CHULGO��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------

--���� PACKAGE(��Ű��) ����--

-- 1.PL/SQL �� ��Ű���� ����Ǵ� Ÿ��, ���α׷� ��ü,
--   ���� ���α׷�(PROCUDURE, FUNCTION ��)��
--   ���������� ������� ������
--   ����Ŭ���� �����ϴ� ��Ű�� �� �ϳ��� �ٷ� ��DBMS_OUTPUT���̴�.

-- 2.��Ű���� ���� ������ ������ ���Ǵ� ���� ���� ���ν����� �Լ���
--   �ϳ��� ��Ű���� ����� ���������ν� ���� ���������� �����ϰ�
--   ��ü ���α׷��� ���ȭ �� �� �ִٴ� ������ �ִ�.

-- 3.��Ű���� ������(PACKAGE SPECIFICATION)��
--   ��ü��(PACKAGE BODY)�� �����Ǿ� ������
--   ���� �κп��� TYPE, CONSTRAINT, VARIABLE, EXCEPTION, CURSOR, SUBPROGRAM �� ����ǰ�
--   ��ü �κп��� �̵��� ���� ������ �����Ѵ�.
--   �׸���, ȣ���� ������ ����Ű����.���ν������� ������ ������ �̿��ؾ� �Ѵ�.

--4. ���� �� ����(������)
/*
CREATE [OR REPLACE] PACKAGE ��Ű����
IS
    �������� ����;
    Ŀ�� ����;
    ���� ����;
    �Լ� ����;
    ���ν��� ����;
    :
END ��Ű����;
*/

-- 5. ���� �� ����(��ü��)
/*
CREATE [OR REPLACE] PACKAGE BODY ��Ű����
IS
    FUNCTION �Լ���[(�μ�,...)]
    RETURN �ڷ���
    IS
        ���� ����;
    BEGIN
        �Լ� ��ü ���� �ڵ�;
        RETURN ��;
    END;
    
    PROCEDURE ���ν�����[(�μ�,...)]
    IS
        ���� ����;
    BEGIN
        ���ν��� ��ü ���� �ڵ�;
    END;
END ��Ű����;
*/


--�� ��Ű�� ��� �ǽ�

--�� ������ �ۼ�
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
END INSA_PACK;
--==>>Package INSA_PACK��(��) �����ϵǾ����ϴ�.

--�� ��ü�� �ۼ�
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT VARCHAR2(20);
    BEGIN
        IF (SUBSTR(V_SSN, 8 ,1) IN ('1','3'))
            THEN V_RESULT := '����';
        ELSIF (SUBSTR(V_SSN, 8, 1) IN('2','4'))
            THEN V_RESULT := '����';
        ELSE
            V_RESULT := 'Ȯ�κҰ�';
        END IF;
        
        RETURN V_RESULT;
    END;
END INSA_PACK;
--==>>Package Body INSA_PACK��(��) �����ϵǾ����ϴ�.


















