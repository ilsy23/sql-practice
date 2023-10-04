/*
프로시저명 divisor_proc
숫자 하나를 전달받아 해당 값의 약수의 개수를 출력하는 프로시저를 선언합니다.
*/
CREATE OR REPLACE PROCEDURE divisor_proc
    (p_num IN NUMBER)
IS
    v_cnt NUMBER := 0;
BEGIN
    FOR i IN 1..p_num
    LOOP
        IF MOD(p_num, i) = 0 THEN
            v_cnt := v_cnt + 1;
        END IF;
    END LOOP;
    dbms_output.put_line(p_num || '의 약수의 개수: ' || v_cnt);
END;

EXEC divisor_proc(72);
/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
*/
CREATE OR REPLACE PROCEDURE depts_proc
    (p_dept_id IN depts.department_id%TYPE,
    p_dept_name IN depts.department_name%TYPE,
    p_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_dept_id;
    
    IF p_flag = 'I' THEN
        INSERT INTO depts
            (department_id, department_name)
        VALUES(p_dept_id, p_dept_name);
    ELSIF p_flag = 'U' THEN
        UPDATE depts
        SET department_name = p_dept_name
        WHERE department_id = p_dept_id;
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('삭제하고자 하는 부서가 존재하지 않습니다.');
            RETURN;
        END IF;
        
        DELETE FROM depts
        WHERE department_id = p_dept_id;
    ELSE
        dbms_output.put_line('해당 flag에 대한 동작이 준비되지 않았습니다.');
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('예외가 발생했습니다!');
        dbms_output.put_line('ERROR MSG: ' || SQLERRM);
        ROLLBACK;
END;

EXEC depts_proc(700, '영업부', 'D');

SELECT * FROM depts;
/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/
CREATE OR REPLACE PROCEDURE emp_check
    (p_emp_id IN employees.employee_id%TYPE,
    p_result OUT VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100);
BEGIN
    SELECT COUNT(*)
    INTO v_cnt
    FROM employees
    WHERE employee_id = p_emp_id;
    
    IF v_cnt = 0 THEN
        RAISE emp_not_exist;
    ELSE
        SELECT
            p_emp_id || '의 근속년수: ' || (sysdate - hire_date) /365 || '년'
        INTO v_result
        FROM employees
        WHERE employee_id = p_emp_id;
    END IF;
    
    EXCEPTION
        WHEN emp_not_exist THEN
            dbms_output.put_line('해당 사원이 존재하지 않습니다.');
        WHEN OTHERS THEN
            dbms_output.put_line('알 수 없는 예외 발생!');    
END;

DECLARE

BEGIN

END;

/*
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요

머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
프로시저가 전달받아야 할 값: 사번, last_name, email, hire_date, job_id
*/