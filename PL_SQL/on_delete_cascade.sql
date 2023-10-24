
-- ���ƿ� ���̺�
CREATE TABLE sns_like(
    lno NUMBER PRIMARY KEY,
    user_id VARCHAR2(50) NOT NULL,
    bno NUMBER NOT NULL
);

-- ON DELETE CASCADE
-- �ܷ� Ű(FK)�� ������ ��, �����ϴ� �����Ͱ� �����Ǵ� ���
-- �����ϰ� �ִ� �����͵� �Բ� ������ �����ϰڴ�.
ALTER TABLE sns_like ADD FOREIGN KEY(bno)
REFERENCES snsboard(bno)
ON DELETE CASCADE;

CREATE SEQUENCE sns_like_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100000
    NOCYCLE
    NOCACHE;
    
SELECT * FROM sns_like;