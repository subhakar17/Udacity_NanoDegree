SELECT domains, COUNT(*)
FROM (SELECT RIGHT(website,3) AS domains
      FROM accounts) AS T1
GROUP BY 1

SELECT LEFT(name,1) AS first_letter, COUNT (*) AS counter
FROM accounts
GROUP BY 1
ORDER BY 2 DESC
