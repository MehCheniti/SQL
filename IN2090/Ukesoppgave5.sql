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

SELECT i.filmid
FROM filmitem i, film j
WHERE i.filmtype LIKE '%C%' AND j.title LIKE '%Love%';

SELECT f.title
FROM film f, filmlanguage l
WHERE l.language LIKE '%Norwegian%';
