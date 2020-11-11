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
