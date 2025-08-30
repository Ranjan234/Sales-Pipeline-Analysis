USE sales_funnel;

SELECT * FROM sales_pipeline;
SELECT * FROM products;

-- 1. Which product was the top seller by revenue for deals that closed in March?
-- IS there a diffrence from the winner by units sold?
SELECT product, SUM(close_value) AS revenue, COUNT(*) AS Units_sold
FROM sales_pipeline
WHERE MONTH(close_date) = 3 and deal_stage='won'
GROUP BY product
ORDER BY 2 DESC;
-- 2. What was the average diffrence between the sales_price and close_value for each product in deals won?
-- IS there an issue with the data here?
SELECT sp.product, AVG(p.sales_price - sp.close_value) AS Difference,
AVG(sp.close_value / p.sales_price)AS Discount
FROM sales_pipeline sp
LEFT JOIN products p 
on sp.product = p.product
WHERE sp.deal_stage = 'won'
GROUP BY product
ORDER BY Difference DESC; 

-- 3.What was the total revenue by product series? 
SELECT p.series, SUM(sp.close_value) AS revenue
FROM products p
LEFT JOIN sales_pipeline sp on p.product =sp.product
WHERE sp.deal_stage = 'won'
GROUP BY p.series
ORDER BY 2 DESC;

