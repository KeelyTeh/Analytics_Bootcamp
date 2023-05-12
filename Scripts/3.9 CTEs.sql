
WITH top_5_cte (customer_id, first_name, last_name, country, city, total_paid) AS 
(SELECT CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city, SUM(PY.amount) AS total_paid
FROM payment PY
INNER JOIN customer CS ON PY.customer_id = CS.customer_id
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
WHERE CY.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur','Shanwei','So Leopoldo',
				 'Tianjin','Cianjur')
GROUP BY CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city
ORDER BY total_paid DESC
LIMIT 5)
SELECT AVG(total_paid)
FROM top_5_cte;


-- 2)

SELECT CT.country, 
COUNT(DISTINCT CS.customer_id) AS all_customer_count, 
COUNT(DISTINCT top_5_customers.customer_id) AS top_customer_count
FROM customer CS
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
LEFT JOIN(SELECT CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city, SUM(PY.amount) AS total_amount_paid
FROM payment PY
INNER JOIN customer CS ON PY.customer_id = CS.customer_id
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
WHERE CY.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur','Shanwei','So Leopoldo',
				 'Tianjin','Cianjur')
GROUP BY CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city
ORDER BY total_amount_paid DESC
LIMIT 5) AS top_5_customers
ON CT.country = top_5_customers.country
GROUP BY CT.country, top_5_customers.country
ORDER BY top_customer_count DESC
LIMIT 5;

-- Step 2: CTE

WITH top_5_cte (customer_id, first_name, last_name, country, city, total_paid) AS 
(SELECT CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city, SUM(PY.amount) AS total_paid
FROM payment PY
INNER JOIN customer CS ON PY.customer_id = CS.customer_id
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
WHERE CY.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur','Shanwei','So Leopoldo',
				 'Tianjin','Cianjur')
GROUP BY CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city
ORDER BY total_paid DESC
LIMIT 5)
SELECT CT.country, COUNT(DISTINCT CS.customer_id) AS all_customer_count, COUNT(DISTINCT top_5_cte.customer_id) 
AS top_customer_count
FROM customer CS 
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
LEFT JOIN top_5_cte ON CT.country = top_5_cte.country
GROUP BY CT.country
ORDER BY top_customer_count DESC
LIMIT 5;


/*tot_customer_cte AS(SELECT CT.country, COUNT(DISTINCT CS.customer_id) AS all_customer_count,
COUNT(DISTINCT top_5_cte.customer_id) AS top_customer_count										 
FROM customer CS
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
GROUP BY country)
SELECT CT.country, tot_customer_cte.all_customer_count, top_5_cte.top_customer_count
FROM customer CS
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
LEFT JOIN top_5_cte ON CT.country = top_5_cte.country
GROUP BY CT.country
ORDER BY top_customer_count DESC
LIMIT 5;*/



/*SELECT country, 
COUNT(DISTINCT CS.customer_id) AS all_customer_count, 
COUNT(DISTINCT top_5_cte.customer_id) AS top_customer_count
FROM customer CS
LEFT JOIN top_5_cte ON CS.customer_id = top_5_cte.customer_id
GROUP BY top_5_cte.country
ORDER BY top_customer_count DESC
LIMIT 5;*/