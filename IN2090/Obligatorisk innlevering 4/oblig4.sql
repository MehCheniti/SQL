-- Oppgave 1

SELECT filmcharacter, COUNT(filmcharacter)
FROM filmcharacter
GROUP BY filmcharacter
  HAVING COUNT(filmcharacter) > 2000
  ORDER BY COUNT(filmcharacter) DESC;

-- Oppgave 2

-- 2a)

SELECT title, prodyear
FROM filmparticipation
  INNER JOIN film ON filmparticipation.filmid = film.filmid
  INNER JOIN person ON filmparticipation.personid = person.personid
WHERE person.firstname = 'Stanley'
  AND person.lastname = 'Kubrick'
  AND filmparticipation.parttype = 'director';

-- 2b)

SELECT title, prodyear
FROM filmparticipation
  NATURAL JOIN film
  NATURAL JOIN person
WHERE person.firstname = 'Stanley'
  AND person.lastname = 'Kubrick'
  AND filmparticipation.parttype = 'director';

-- 2c)

SELECT title, prodyear
FROM filmparticipation, film, person
WHERE filmparticipation.filmid = film.filmid
  AND filmparticipation.personid = person.personid
  AND person.firstname = 'Stanley'
  AND person.lastname = 'Kubrick'
  AND filmparticipation.parttype = 'director';

-- Oppgave 3

SELECT p.personid, p.firstname || ' ' || p.lastname AS navn, f.title, fc.country
FROM filmparticipation fp
  INNER JOIN person p ON (fp.personid = p.personid)
  INNER JOIN filmcharacter fch ON (fp.partid = fch.partid)
  INNER JOIN filmcountry fc ON (fp.filmid = fc.filmid)
  INNER JOIN film f ON (fp.filmid = f.filmid)
WHERE p.firstname = 'Ingrid'
  AND fch.filmcharacter = 'Ingrid';

-- Oppgave 4

SELECT f.filmid, f.title, COUNT(fg.genre) as filmgenre
FROM film f
  LEFT JOIN filmgenre fg ON (f.filmid = fg.filmid)
WHERE title LIKE '%Antoine %'
  GROUP BY f.filmid, f.title;

-- Oppgave 5

SELECT f.title, fp.parttype, COUNT(fp.parttype) AS deltakere
FROM filmparticipation fp
  NATURAL JOIN film f
  NATURAL JOIN filmitem fi
WHERE f.title
  LIKE '%Lord of the Rings%'
  AND fi.filmtype LIKE 'C'
  GROUP BY (f.title , fp.parttype);

-- Oppgave 6

SELECT f.title, f.prodyear
FROM film f
WHERE prodyear =
  (SELECT MIN(prodyear)
  FROM film);

-- Oppgave 7

SELECT f.title, f.prodyear
FROM film f, filmgenre fgn, filmgenre fgc
WHERE f.filmid = fgn.filmid
  AND fgn.filmid = fgc.filmid
  AND fgn.genre = 'Film-Noir'
  AND fgc.genre = 'Comedy';

-- Oppgave 8

SELECT f.title, f.prodyear
FROM film f
WHERE prodyear =
  (SELECT MIN(prodyear)
  FROM film)
  UNION ALL
    (SELECT f.title, f.prodyear
    FROM film f, filmgenre fgn, filmgenre fgc
    WHERE f.filmid = fgn.filmid
      AND fgn.filmid = fgc.filmid
      AND fgn.genre = 'Film-Noir'
      AND fgc.genre = 'Comedy');

-- Oppgave 9

SELECT title, prodyear
FROM filmparticipation, film, person
WHERE filmparticipation.filmid = film.filmid
  AND filmparticipation.personid = person.personid
  AND person.firstname = 'Stanley'
  AND person.lastname = 'Kubrick'
  AND filmparticipation.parttype = 'director'
  INTERSECT
    (SELECT title, prodyear
    FROM filmparticipation, film, person
    WHERE filmparticipation.filmid = film.filmid
      AND filmparticipation.personid = person.personid
      AND person.firstname = 'Stanley'
      AND person.lastname = 'Kubrick'
      AND filmparticipation.parttype = 'cast');

-- Oppgave 10

SELECT s.maintitle, f.votes
FROM filmrating f
  INNER JOIN series s ON (f.filmid = s.seriesid)
WHERE f.votes > 1000
  AND f.rank =
    (SELECT MAX(f.rank)
    FROM filmrating f
    WHERE f.votes > 1000)
  GROUP BY (s.maintitle, f.votes);

-- Oppgave 11

SELECT DISTINCT fc.country
FROM filmcountry fc
GROUP BY fc.country
  HAVING COUNT(*) = 1;

-- Oppgave 12

WITH unikeRoller AS
  (SELECT *
  FROM
    (SELECT filmcharacter, COUNT(*)
    FROM filmcharacter
      GROUP BY filmcharacter
      HAVING COUNT(*) = 1)
  AS uchar, filmcharacter AS fchar
  WHERE uchar.filmcharacter = fchar.filmcharacter)
SELECT firstname || ' ' || lastname AS navn, COUNT(*) AS antallUnikeRollenavn
FROM person
  NATURAL JOIN filmparticipation
  NATURAL JOIN unikeRoller
GROUP BY navn
  HAVING COUNT(*) > 199
  ORDER BY antallUnikeRollenavn;

-- Oppgave 13

SELECT (firstname || ' ' || lastname) as navn
FROM film
  NATURAL JOIN filmrating
  NATURAL JOIN filmparticipation
  NATURAL JOIN person
WHERE parttype LIKE 'director'
  AND votes > 60000
GROUP BY navn
EXCEPT
  (SELECT (firstname || ' ' || lastname) as navn
  FROM film
    NATURAL JOIN filmrating
    NATURAL JOIN filmparticipation
    NATURAL JOIN person
  WHERE parttype LIKE 'director' AND votes > 60000 AND rank < 8
    GROUP BY navn);
