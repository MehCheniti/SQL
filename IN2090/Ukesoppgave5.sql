SELECT *
FROM Genre;

SELECT filmid, title
FROM film
WHERE prodyear = 1892;

SELECT filmid, title
FROM film
WHERE filmid BETWEEN 2000 AND 2030;

SELECT filmid, title
FROM film
WHERE title LIKE '%Star Wars%';

SELECT firstname, lastname
FROM person
WHERE personid = 465221;

SELECT DISTINCT parttype
FROM Filmparticipation;

SELECT title, prodyear
FROM film
WHERE title LIKE '%Rush Hour%';

SELECT filmid, title, prodyear
FROM film
WHERE title LIKE '%Norge%';

SELECT filmid
FROM filmitem NATURAL JOIN film
WHERE filmitem.filmtype LIKE '%C%' AND film.title = 'Love';

SELECT title
FROM film NATURAL JOIN filmlanguage
WHERE filmlanguage.language LIKE '%Norwegian%';
