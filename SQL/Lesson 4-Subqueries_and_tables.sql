SELECT channel,AVG(event_count) AS Avg_event_count
FROM (SELECT DATE_TRUNC('day', occurred_at) as day, channel, COUNT(*) AS event_count
FROM web_events
GROUP BY 1, 2) AS sub
GROUP BY 1
ORDER BY 2 DESC

SELECT AVG(gloss_qty) AS gloss, AVG(poster_qty) AS poster,
        AVG(standard_qty) AS standard, SUM(total_amt_usd) AS total
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
  (SELECT DATE_TRUNC('month', MIN(occurred_at))
    FROM orders)


SELECT t3.sales_rep_name, t3.region, t3.sales
FROM(SELECT region,MAX(sales) AS sales
      FROM (SELECT r.name AS region, sr.name AS sales_rep_name, SUM(o.total_amt_usd) AS sales
            FROM sales_reps AS sr
            JOIN accounts AS a
            ON sr.id = a.sales_rep_id
            JOIN orders AS o
            ON o.account_id = a.id
            JOIN region AS r
            ON r.id = sr.region_id
            GROUP BY 1,2) AS t1
      GROUP BY 1) AS t2
JOIN (SELECT r.name AS region, sr.name AS sales_rep_name, SUM(o.total_amt_usd) as sales
      FROM sales_reps AS sr
      JOIN accounts AS a
      ON sr.id = a.sales_rep_id
      JOIN orders AS o
      ON o.account_id = a.id
      JOIN region AS r
      ON r.id = sr.region_id
      GROUP BY 1,2) AS t3
ON t3.region = t2.region AND t3.sales = t2.sales


SELECT MAX(sales) AS sales
FROM (SELECT r.name AS region, SUM(o.total_amt_usd) AS sales
      FROM sales_reps AS sr
      JOIN accounts AS a
      ON sr.id = a.sales_rep_id
      JOIN orders AS o
      ON o.account_id = a.id
      JOIN region AS r
      ON r.id = sr.region_id
      GROUP BY 1) AS t1
GROUP BY 1

SELECT r.name AS region, COUNT(o.total) AS total_orders
      FROM sales_reps AS sr
      JOIN accounts AS a
      ON sr.id = a.sales_rep_id
      JOIN orders AS o
      ON o.account_id = a.id
      JOIN region AS r
      ON r.id = sr.region_id
      GROUP BY 1
      Having SUM(o.total_amt_usd) = (
        SELECT MAX(sales) AS sales
        FROM (SELECT r.name AS region, SUM(o.total_amt_usd) AS sales
              FROM sales_reps AS sr
              JOIN accounts AS a
              ON sr.id = a.sales_rep_id
              JOIN orders AS o
              ON o.account_id = a.id
              JOIN region AS r
              ON r.id = sr.region_id
              GROUP BY 1) AS t1
      )


SELECT a.name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > (SELECT total
                        FROM (SELECT a.name, SUM(o.standard_qty) AS total_standard, SUM(o.total) AS total
                              FROM accounts AS a
                              JOIN orders AS o
                              ON a.id = o.account_id
                              GROUP BY 1
                              ORDER BY 2 DESC
                              LIMIT 1) AS sub
                        )


SELECT a.name, w.channel, COUNT(*)
FROM web_events w
JOIN accounts a
ON a.id = w.account_id

WHERE a.name = (SELECT account_name
FROM (SELECT a.name AS account_name, SUM(o.total_amt_usd)
      FROM orders o
      JOIN accounts a
      ON o.account_id = a.id
      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 1) AS t1)
GROUP BY 1,2



SELECT  AVG(sales)
FROM (SELECT a.name AS account_name, SUM(o.total_amt_usd) AS sales
                  FROM orders o
                  JOIN accounts a
                  ON o.account_id = a.id
                  GROUP BY 1
                  ORDER BY 2 DESC
                  LIMIT 10) AS t1



SELECT AVG(avg_amt)
FROM (SELECT o.account_id, AVG(o.total_amt_usd) AS avg_amt
FROM orders o
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd)
                                FROM orders o))
