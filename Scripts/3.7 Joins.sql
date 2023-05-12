--1) 
SELECT COUNT(CS.customer_id) AS customer_count, CT.country
FROM customer CS
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
GROUP BY country
ORDER BY customer_count DESC
LIMIT 10;

--2)
-- Top 10 Cities within Top 10 Counties
SELECT COUNT(CS.customer_id) AS customer_count, CT.country, CY.city
FROM customer CS
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
WHERE CT.country IN ('India','China','United States','Japan','Mexico','Brazil','Russian Federation',
					'Philippines','Turkey','Indonesia')
GROUP BY CT.country, CY.city
ORDER BY customer_count DESC
LIMIT 10;

--3)
-- Top 5 Customers in Top 10 Cities
SELECT CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city, SUM(PY.amount) AS amount_spent
FROM payment PY
INNER JOIN customer CS ON PY.customer_id = CS.customer_id
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
WHERE CY.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur','Shanwei','So Leopoldo',
				 'Tianjin','Cianjur')
GROUP BY CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city
ORDER BY SUM(PY.amount) DESC
LIMIT 5;



