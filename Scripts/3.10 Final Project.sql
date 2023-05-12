/*1) Which movies contributed most and least to revenue gain?*/
SELECT F.film_id, 
F.title, 
F.release_year, 
F.rental_duration, 
F.length, 
F.rental_rate,
SUM(PY.amount) AS revenue
FROM film F
INNER JOIN inventory I ON F.film_id = I.film_id
INNER JOIN rental R ON I.inventory_id = R.inventory_id
INNER JOIN payment PY ON R.rental_id = PY.rental_id
GROUP BY F.film_id, F.title, F.release_year, F.rental_duration, F.length, F.rental_rate
ORDER BY revenue DESC

-- How to find revenue by genre
WITH film_by_rev (film_id, title, release_year, rental_duration, rental_length, rental_rate) AS
(SELECT F.film_id, 
F.title, 
F.release_year, 
F.rental_duration, 
F.length, 
F.rental_rate,
SUM(PY.amount) AS revenue
FROM film F
INNER JOIN inventory I ON F.film_id = I.film_id
INNER JOIN rental R ON I.inventory_id = R.inventory_id
INNER JOIN payment PY ON R.rental_id = PY.rental_id
GROUP BY F.film_id, F.title, F.release_year, F.rental_duration, F.length, F.rental_rate
ORDER BY revenue DESC)
SELECT revenue, C.name, 
FROM film_by_rev
INNER JOIN film_category ON film_by_rev.film_id = film_category.film_id
INNER JOIN category C ON film_category.category_id = C.category_id
GROUP BY C.name, revenue
ORDER BY revenue DESC;

--2) Avg rental duation for all movies?
SELECT AVG(rental_duration)
FROM film;

--3) Which countries are customers based in?
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
ORDER BY all_customer_count DESC;
--4)
/* Where are customers with high lifetime value based? Where do the highest spending customers live, in 
terms of country and city?*/
-- Use query above to show cities of top 5 customers. 
SELECT CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city, SUM(PY.amount) AS amount_spent
FROM payment PY
INNER JOIN customer CS ON PY.customer_id = CS.customer_id
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
GROUP BY CS.customer_id, CS.first_name, CS.last_name, CT.country, CY.city
ORDER BY amount_spent DESC;


SELECT CT.country, CY.city, SUM(PY.amount) AS amount_spent
FROM payment PY
INNER JOIN customer CS ON PY.customer_id = CS.customer_id
INNER JOIN address AD ON CS.address_id = AD.address_id
INNER JOIN city CY ON AD.city_id = CY.city_id
INNER JOIN country CT ON CY.country_id = CT.country_id
GROUP BY CT.country, CY.city
ORDER BY amount_spent DESC;

