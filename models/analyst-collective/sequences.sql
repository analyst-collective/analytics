-- inspired by https://discourse.looker.com/t/generating-a-numbers-table-in-mysql-and-redshift/482

CREATE TABLE int_sequence (i)
  DISTSTYLE ALL
  SORTKEY (i) AS
(
  SELECT
    p0.n
    + p1.n*2
    + p2.n * POWER(2,2)
    + p3.n * POWER(2,3)
    + p4.n * POWER(2,4)
    + p5.n * POWER(2,5)
    + p6.n * POWER(2,6)
    + p7.n * POWER(2,7)
    + p8.n * POWER(2,8)
    + p9.n * POWER(2,9)
    + p10.n * POWER(2,10)
    as i
  FROM
    (SELECT 0 as n UNION SELECT 1) p0,
    (SELECT 0 as n UNION SELECT 1) p1,
    (SELECT 0 as n UNION SELECT 1) p2,
    (SELECT 0 as n UNION SELECT 1) p3,
    (SELECT 0 as n UNION SELECT 1) p4,
    (SELECT 0 as n UNION SELECT 1) p5,
    (SELECT 0 as n UNION SELECT 1) p6,
    (SELECT 0 as n UNION SELECT 1) p7,
    (SELECT 0 as n UNION SELECT 1) p8,
    (SELECT 0 as n UNION SELECT 1) p9,
    (SELECT 0 as n UNION SELECT 1) p10
);

CREATE TABLE date_sequence ("date")
  DISTSTYLE ALL
  SORTKEY ("date") AS
(
  SELECT (current_date + (i || ' days')::interval)::date
    FROM int_sequence
  UNION
  SELECT (current_date - (i || ' days')::interval)::date
    FROM int_sequence
);
