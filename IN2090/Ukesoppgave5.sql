/* Oppgave 1 */

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

/* Oppgave 2 */

SELECT filmid, filmtype
FROM filmitem
WHERE filmid IN (
  SELECT filmid
  FROM film
  WHERE prodyear = '1894');

SELECT firstname
FROM person
WHERE person.gender LIKE '%F%' AND person.personid IN (
  SELECT personid
  FROM filmparticipation
  WHERE filmid = '357076' AND parttype LIKE '%cast%');

/* Oppgave 3 */

SELECT genre
FROM filmgenre NATURAL JOIN film
WHERE film.title LIKE '%Pirates of the Caribbean: The Legend of Jack Sparrow%';

SELECT genre
FROM filmgenre NATURAL JOIN film
WHERE film.filmid = 985057;

SELECT f.title, f.prodyear, fi.filmtype
FROM filmitem AS fi NATURAL JOIN film AS f
WHERE prodyear = 1894;

SELECT p.firstname, f.filmid
FROM person AS p NATURAL JOIN filmparticipation AS f
WHERE f.filmid = 357076 AND p.gender LIKE '%F%' AND f.parttype LIKE '%cast%';
