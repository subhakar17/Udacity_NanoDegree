SELECT SUM(poster_qty)
FROM orders

SELECT SUM(standard_qty)
FROM orders

SELECT SUM(total_amt_usd)
FROM orders

SELECT SUM(standard_amt_usd) AS standard_sum,
      SUM(gloss_amt_usd) AS gloss_sum
FROM orders

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS per_unit
FROM orders

SELECT MIN(occurred_at)
FROM orders

SELECT occurred_at
FROM orders

SELECT MIN(occurred_at)
FROM web_events

SELECT occurred_at
FROM web_events

SELECT AVG(standard_qty) AS sAvg,
      AVG(gloss_qty) AS gAvg,
      AVG(poster_qty) AS pAvg,
      AVG(standard_amt_usd),
      AVG(gloss_amt_usd),
      AVG(poster_amt_usd)
FROM orders

SELECT *
FROM (SELECT total_amt_usd
      FROM orders,
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2

SELECT o.occurred_at, a.name
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1

SELECT a.name, SUM(standard_amt_usd), SUM(gloss_amt_usd), SUM(poster_amt_usd)
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name

SELECT w.channel, a.name,w.occurred_at
FROM web_events AS w
JOIN accounts AS a
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1

SELECT w.channel, COUNT(*)
FROM web_events AS w
GROUP BY w.channel

SELECT a.primary_poc
FROM accounts AS a
JOIN web_events AS w
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1

SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts AS a
JOIN orders AS o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY smallest_order;

SELECT r.name,COUNT(*) num_reps
FROM region AS r
JOIN sales_reps AS sr
ON sr.region_id = r.id
GROUP BY r.name
ORDER BY num_reps

SELECT a.name, AVG(o.standard_amt_usd) AS stdAvg,
      AVG(o.gloss_amt_usd) AS glossAvg,
      AVG(o.poster_amt_usd) AS posterAVg
FROM accounts AS a
JOIN orders AS o
ON o.account_id = a.id
GROUP BY a.name

SELECT a.name, AVG(o.standard_amt_qty) AS stdAvg,
      AVG(o.gloss_amt_qty) AS glossAvg,
      AVG(o.poster_amt_qty) AS posterAVg
FROM accounts AS a
JOIN orders AS o
ON o.account_id = a.id
GROUP BY a.name

SELECT sr.name,w.channel,count(*) events
FROM sales_reps AS sr
JOIN accounts AS a
ON a.sales_rep_id = sr.id
JOIN web_events AS w
ON w.account_id = a.id
GROUP BY sr.name,w.channel
ORDER BY events DESC;

SELECT r.name,w.channel,count(*) events
FROM region as r
JOIN sales_reps AS sr
ON r.id = sr.region_id
JOIN accounts AS a
ON a.sales_rep_id = sr.id
JOIN web_events AS w
ON w.account_id = a.id
GROUP BY r.name,w.channel
ORDER BY events DESC;

SELECT  a.name,r.name
FROM region AS r
JOIN sales_reps as sr
ON r.id = sr.region_id
JOIN accounts as a
ON sr.id = a.sales_rep_id

SELECT a.sales_rep_id,count(*) AS acc
FROM accounts AS a
GROUP BY a.sales_rep_id
HAVING COUNT(*) > 5

SELECT a.name, o.account_id, count(*)
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.name,o.account_id
Having count(*) > 20

SELECT a.name,Count(*) number_orders
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.name,o.account_id
Having count(*) > 20
ORDER BY number_orders DESC
LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd) as total_spent
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

SELECT a.name, SUM(o.total_amt_usd) as total_spent
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;

SELECT a.name, SUM(o.total_amt_usd) as total_spent
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent
LIMIT 1;

SELECT a.name, COUNT(*) as ch
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
GROUP BY a.name,w.channel
HAVING Count(*) > 6 AND w.channel = 'facebook'

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;

SELECT DATE_TRUNC('year', o.occurred_at) AS year,
      SUM(total_amt_usd) AS total_dollars
FROM orders AS o
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_PART('month',o.occurred_at) AS month,
      SUM(total_amt_usd) AS total_dollars
FROM orders AS o
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_TRUNC('year', o.occurred_at) AS year,
      Count(*) AS total_orders
FROM orders AS o
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_PART('month',o.occurred_at) AS month,
      Count(*) AS total_orders
FROM orders AS o
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_TRUNC('month', o.occurred_at) AS year,a.name,
      SUM(total_amt_usd) AS total_amt
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 3 DESC

SELECT o.account_id, o.total_amt_usd,
      CASE WHEN o.total_amt_usd >= 3000 THEN 'LARGE'
      ELSE 'Small' END AS order_size
FROM orders AS o

SELECT CASE WHEN total >= 2000 THEN 'At Least 2000'
        WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
        WHEN total < 1000 THEN 'Less than 1000'
        END AS category, count(*)
FROM orders
GROUP BY 1

SELECT a.name AS name, SUM(o.total_amt_usd),
        CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'FIRST'
        WHEN SUM(o.total_amt_usd) >=200000 AND SUM(o.total_amt_usd) < 100000 THEN 'Second'
        ELSE 'Third' END AS level
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC

SELECT a.name AS name, SUM(o.total_amt_usd),
        CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'FIRST'
        WHEN SUM(o.total_amt_usd) >=200000 AND SUM(o.total_amt_usd) < 100000 THEN 'Second'
        ELSE 'Third' END AS level
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC

SELECT sr.name AS srName,Count(*) AS order_count,
        CASE WHEN COUNT(*) > 200 THEN'TOP'
        ELSE 'NOT' END
FROM orders
JOIN accounts AS a
ON a.id = orders.account_id
JOIN sales_reps AS sr
ON a.sales_rep_id = sr.id
GROUP BY 1
ORDER BY 2 DESC


SELECT sr.name AS srName,Count(*) AS order_count,
        SUM(total_amt_usd) as sales,
        CASE WHEN COUNT(*) > 200 AND SUM(total_amt_usd) > 750000 THEN'TOP'
        WHEN COUNT(*) > 150 AND SUM(total_amt_usd) > 50000 THEN 'middle'
        ELSE 'low' END
FROM orders
JOIN accounts AS a
ON a.id = orders.account_id
JOIN sales_reps AS sr
ON a.sales_rep_id = sr.id
GROUP BY 1
ORDER BY 3 DESC
