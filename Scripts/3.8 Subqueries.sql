--1)
SELECT AVG(total_amount_paid) AS average
FROM (SELECT CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city, SUM(PY.amount) AS total_amount_paid
FROM payment PY
INNER JOIN customer CS ON PY.customer_id = CS.customer_id
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
WHERE CY.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur','Shanwei','So Leopoldo',
				 'Tianjin','Cianjur')
GROUP BY CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city
ORDER BY total_amount_paid DESC
LIMIT 5) AS total_amount_paid;

--2)
(SELECT CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city, SUM(PY.amount) AS amount_spent
FROM payment PY
INNER JOIN customer CS ON PY.customer_id = CS.customer_id
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
WHERE CY.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur','Shanwei','So Leopoldo',
				 'Tianjin','Cianjur')
GROUP BY CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city
ORDER BY SUM(PY.amount) DESC
LIMIT 5) 

--2b) 
/* Find out how many of the top 5 customers are based within each country ... along with that country's 
total customer count. 
This uses the FROM clause to further analyze the results of a complex query. Often used to peform further 
analysis on an inner query from code in the outer query refering back to the inner query.
*/


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





