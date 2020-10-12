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

SELECT p.firstname, f.filmid, fi.title
FROM person AS p NATURAL JOIN filmparticipation AS f NATURAL JOIN film AS fi
WHERE f.filmid = 357076 AND p.gender LIKE '%F%' AND f.parttype LIKE '%cast%';

SELECT DISTINCT p.firstname, p.lastname
FROM person AS p INNER JOIN filmparticipation AS fp ON p.personid = fp.personid
INNER JOIN series AS s ON s.seriesid = fp.filmid
WHERE s.maintitle = 'South Park';

SELECT DISTINCT p.firstname, p.lastname
FROM person AS p, filmparticipation AS fp, series AS s
WHERE s.seriesid = fp.filmid AND s.maintitle = 'South Park'
AND p.personid = fp.personid;

SELECT DISTINCT p.firstname, p.lastname
FROM person as p NATURAL JOIN filmparticipation AS fp NATURAL JOIN series AS s
WHERE s.seriesid = fp.filmid AND s.maintitle = 'South Park'
AND p.personid = fp.personid;

/* NATURAL JOIN joiner automatisk på attributter med samme navn, som funker bra
mellom tabellen Person og Filmparticipation, men ikke mellom Filmparticipation
og Series. */

SELECT DISTINCT p.firstname, p.lastname, f.title, fp.parttype
FROM person as p NATURAL JOIN film as f NATURAL JOIN filmparticipation as fp
WHERE f.filmid = fp.filmid AND fp.parttype = 'cast'
AND f.title = 'Harry Potter and the Goblet of Fire';

SELECT DISTINCT p.firstname, p.lastname
FROM person as p NATURAL JOIN film as f NATURAL JOIN filmparticipation as fp
WHERE f.filmid = fp.filmid AND fp.parttype = 'cast'
AND f.title = 'Baile Perfumado';

SELECT f.title, fp.parttype
FROM film as f NATURAL JOIN filmparticipation as fp NATURAL JOIN filmcountry
as fc
WHERE fp.parttype = 'director' AND f.prodyear < 1960 AND fc.country
LIKE 'Norway';
