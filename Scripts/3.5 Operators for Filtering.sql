--1a)
SELECT film_id, title, description FROM film 
WHERE title LIKE '%Uptown%';

--1b)
SELECT film_id, title, description, length, rental_rate FROM film
WHERE length > 120 AND rental_rate > 2.99;

--1c)
SELECT film_id, title, description, rental_duration FROM film
WHERE rental_duration >3 AND rental_duration <7;

--1d)
SELECT film_id, title, description, replacement_cost FROM film
WHERE replacement_cost < 14.99;

--1e)
SELECT film_id, title, description, rating FROM film
WHERE rating IN ('PG','G');

--3)
SELECT rating, COUNT(film_id), AVG(rental_rate), MIN(rental_duration), MAX(rental_duration) 
FROM film
WHERE rating IN ('PG','G')
GROUP BY rating
ORDER BY COUNT(film_id);

--4) 
SELECT rating, 
COUNT(film_id) AS count_of_movies, 
AVG(rental_rate) AS average_movie_rental_rate, 
MIN(rental_duration) AS minimum_rental_duration, 
MAX(rental_duration) AS maximum_rental_duration
FROM film
WHERE rating IN ('PG','G')
GROUP BY rating
ORDER BY COUNT(film_id);
