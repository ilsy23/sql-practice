
-- WHILE문

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN
    WHILE v_count <= 10 --end
    LOOP
        v_num := v_num + v_count;
        v_count := v_count + 1; -- step
    END LOOP;
    dbms_output.put_line(v_num);
END;

-- 탈출문
DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN
    WHILE v_count <= 10 --end
    LOOP
        EXIT WHEN v_count = 5;
        
        v_num := v_num + v_count;
        v_count := v_count + 1; -- step
    END LOOP;
    dbms_output.put_line(v_num);
END;

-- FOR문
DECLARE
    v_num NUMBER := 4;
BEGIN
    FOR i IN 1..9 -- .을 두 개 작성해서 범위를 표현
    LOOP
        dbms_output.put_line(v_num || ' × ' || i || ' = ' || v_num * i);
    END LOOP;
END;

-- CONTINUE문
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 1..9 -- .을 두 개 작성해서 범위를 표현
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || ' × ' || i || ' = ' || v_num * i);
    END LOOP;
END;

-- 1. 모든 구구단을 출력하는 익명 블록을 만드세요. (2 ~ 9단)
-- 짝수단만 출력해 주세요. (2, 4, 6, 8)
-- 참고로 오라클 연산자 중에는 나머지를 알아내는 연산자가 없어요. (% 없음~)
BEGIN
    FOR i in 2..9
    LOOP
        CONTINUE WHEN MOD(i, 2) = 1;
        dbms_output.put_line('구구단 ' || i || '단');
        FOR j in 1..9
        LOOP
            dbms_output.put_line(i || ' × ' || j || ' = ' || i * j);
        END LOOP;
        dbms_output.put_line('--------------------------');
    END LOOP;
END;

-- 2. INSERT를 300번 실행하는 익명 블록을 처리하세요.
-- board라는 이름의 테이블을 만드세요. (bno, writer, title 컬럼이 존재합니다.)
-- bno는 SEQUENCE로 올려 주시고, writer와 title에 번호를 붙여서 INSERT 진행해 주세요.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....
CREATE TABLE board(
    bno NUMBER PRIMARY KEY,
    writer VARCHAR2(30),
    title VARCHAR2(30)
);

CREATE SEQUENCE b_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000
    NOCACHE
    NOCYCLE;

BEGIN
    FOR i IN 1..300
    LOOP
        INSERT INTO board
        VALUES(b_seq.NEXTVAL, 'test' || i, 'title' || i);
    END LOOP;
    COMMIT;
END;

SELECT * FROM board
ORDER BY bno DESC;