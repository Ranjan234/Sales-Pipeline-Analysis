USE sales_funnel;

SELECT * FROM sales_pipeline;
SELECT * FROM accounts;
-- 1. Which office location used the lowest revenue?
SELECT office_location, SUM(revenue) AS Revenue
FROM accounts
GROUP BY office_location
ORDER BY 2;

-- 2.What is the gap, between the oldest and newest company in the book of business?
-- What are those companies?
-- SELECT MAX(year_established) -- MIN(year_established) AS age_gap
-- FROM accounts;
-- 1979, 2017
 
 SELECT account, year_established
 FROM accounts
 WHERE year_established in (1979, 2017);
 
-- 3. Which 5 accounts had the highest revenue?
SELECT a.account, COUNT(sp.opportunity_id) AS opportunity
FROM accounts a
LEFT JOIN sales_pipeline sp
ON a.account = sp.account
WHERE a.subsidiary_of != '' and sp.deal_stage = 'lost'
GROUP BY a.account
ORDER BY 2;

-- 4. Join the companies to their subsidaireies, which are used the  highest total revenue?
with company_parent AS(
SELECT account, CASE WHEN subsidiary_of='' THEN account ELSE subsidiary_of END as parent_company
FROM accounts
)
, won_deals AS (
SELECT sp.account, sp.close_value
FROM sales_pipeline sp
WHERE sp.deal_stage= 'won'
)

SELECT cp.parent_company, SUM(wd.close_value) AS  total_revenue
FROM company_parent cp
LEFT JOIN won_deals wd 
ON wd.account = cp.account
GROUP BY cp.parent_company
HAVING total_revenue > 100000
ORDER BY total_revenue DESC;