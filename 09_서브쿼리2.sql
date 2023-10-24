SELECT * FROM sns_like;

SELECT tbl2.*,  
    (SELECT COUNT(*) FROM sns_like WHERE bno = tbl2.bno) AS like_cnt
FROM
    (
    SELECT ROWNUM AS rn, tbl.*
    FROM
        (
        SELECT * FROM snsboard
        ORDER BY bno DESC
        ) tbl
    )tbl2
WHERE rn > 0
AND rn <= 3;

SELECT tbl2.*, NVL(s.like_cnt, 0) AS like_cnt
FROM
    (
    SELECT ROWNUM AS rn, tbl.*
    FROM
        (
        SELECT * FROM snsboard
        ORDER BY bno DESC
        ) tbl
    )tbl2
LEFT JOIN (SELECT COUNT(*) AS like_cnt, bno FROM sns_like GROUP BY bno) s
ON tbl2.bno = s.bno
WHERE rn > 0
AND rn <= 3;