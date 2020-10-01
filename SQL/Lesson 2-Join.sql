1SELECT orders.*, accounts.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

SELECT orders.standard_qty, orders.gloss_qty,orders.poster_qty,
        accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

SELECT a.primary_poc,a.name,w.occurred_at,w.channel
FROM accounts AS a
JOIN web_events as w
ON w.account_id = a.id
WHERE a.name = 'Walmart'

SELECT r.name ranme, s.name sname, a.name aname
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

SELECT r.name region, a.name account,
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;


SELECT r.name Rname,s.name Sname, a.name Aname
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'

SELECT r.name Rname,s.name Sname, a.name Aname
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'AND s.name LIKE 'S%'
ORDER BY a.name

SELECT r.name Rname,s.name Sname, a.name Aname
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'AND s.name LIKE 'S%'
ORDER BY a.name

SELECT r.name Rname,s.name Sname, a.name Aname
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'AND s.name LIKE '% K%'
ORDER BY a.name

SELECT r.name Rname,a.name Aname, o.total_amt_usd/(o.total+0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIn orders o
ON o.account_id = a.id
WHERE standard_qty > 100

SELECT r.name Rname,a.name Aname, o.total_amt_usd/(o.total+0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIn orders o
ON o.account_id = a.id
WHERE standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price

SELECT DISTINCT w.channel,a.name
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
WHERE a.id = '1001'

SELECT DISTINCT w.occurred_at,a.name,o.total,o.total_amt_usd
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
JOIN orders o
ON o.account_id = a.id
WHERE w.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY w.occurred_at DESC
