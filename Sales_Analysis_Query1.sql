USE sales_funnel;

-- 1. Using: 'engage date', calculate the number of sales opportunities each month.
-- Which month had the highest?
SELECT * FROM sales_pipeline;
SELECT YEAR(engage_date),MONTH(engage_date), COUNT(*)
FROM sales_pipeline
GROUP BY YEAR(engage_date), month(engage_date)
ORDER BY COUNT(*) DESC;

-- 2.What was the average amount at time a deal was open from engage date to close date?
-- Did closed deals or won deals take longer?
SELECT AVG(DATEDIFF(close_date, engage_date)) FROM sales_pipeline;

SELECT deal_stage, AVG(DATEDIFF(close_date, engage_date))
          FROM sales_pipeline
GROUP BY deal_stage
ORDER by 2 DESC;          
-- 3.Calculate the percentage of deals by deal stage. What percentage were lost.
SELECT AVG(CASE WHEN deal_stage ='lost' THEN 1 ELSE 0 END) * 100 as loss_rate FROM sales_pipeline;

-- 4. What was the win rate for each product? which product had the highest win rate?
SELECT product,AVG(CASE WHEN deal_stage ='won' THEN 1 ELSE 0 END) * 100 as win_rate 
FROM sales_pipeline
GROUP BY product
ORDER BY 2 DESC;