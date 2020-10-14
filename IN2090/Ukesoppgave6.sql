/* Oppgave 1 */

CREATE TABLE kunde(
  kundenummer int PRIMARY KEY,
  kundenavn text NOT NULL,
  kundeadresse text,
  postnr int,
  poststed text
);

CREATE TABLE prosjekt(
  prosjektnummer int PRIMARY KEY,
  prosjektleder int,
  prosjektnavn text NOT NULL,
  kundenummer int,
  status text CHECK (status = 'planlagt' OR status = 'aktiv'
    OR status = 'ferdig'),
  FOREIGN KEY (kundenummer) REFERENCES kunde(kundenummer),
  FOREIGN KEY (prosjektleder) REFERENCES ansatt(ansattnr)
);

CREATE TABLE ansatt(
  ansattnr int PRIMARY KEY,
  navn text NOT NULL,
  fødselsdato date,
  ansattDato date
);

CREATE TABLE ansattDeltarIProsjekt(
  ansattnr int UNIQUE NOT NULL,
  prosjektnr int UNIQUE NOT NULL,
  PRIMARY KEY (ansattnr, prosjektnr),
  FOREIGN KEY (prosjektnr) REFERENCES prosjekt(prosjektnummer),
  FOREIGN KEY (ansattnr) REFERENCES ansatt(ansattnr)
);

/* Oppgave 2 */

/*
Primærnøkkelen i relasjonen Ansatt er ansattnr, og enten ansattnr eller
prosjektnr i relasjonen ansattDeltarIProsjekt.
Nøkkelattributtene er ansattnr, og ansattnr, prosjektnr.
ansatt sin kandidatnøkkel er ansattnr.
Supernøklene i relasjonen ansatt er alle kombinasjoner som inneholder ansattnr.
*/

/* Oppgave 3 */

INSERT INTO kunde
VALUES (17, 'Mehdi Cheniti', 'Trimveien 6', 0372, 'Oslo');

INSERT INTO prosjekt
VALUES (17, 1720, 'Fiery Jet', 17, 'aktiv');

INSERT INTO ansatt
VALUES (1720, 'Mehdi Cheniti', '1997-04-18', '2020-04-18');

INSERT INTO ansattDeltarIProsjekt
VALUES (1720, 17);

/* Å prøve å putte inn et ansattnummer og prosjektnummer som ikke finnes i
ansattDeltarIProsjekt gir en foreign key error. prosjektnr i
ansattDeltarIProsjekt må være den samme som prosjektnummer i prosjekt. */

/* Oppgave 4 */

SELECT kundenummer, kundenavn, kundeadresse
FROM kunde;

SELECT DISTINCT navn
FROM prosjekt, ansatt
WHERE prosjekt.prosjektleder = ansatt.ansattnr;

SELECT ansatt.ansattnr
FROM ansattDeltarIProsjekt, ansatt, prosjekt
WHERE ansattDeltarIProsjekt.ansattnr = ansatt.ansattnr
AND prosjekt.prosjektnummer = ansattDeltarIProsjekt.prosjektnr
AND prosjekt.prosjektnavn = 'Ruter app';

SELECT navn
FROM ansattDeltarIProsjekt, ansatt, prosjekt, kunde
WHERE prosjekt.prosjektnummer = ansattDeltarIProsjekt.prosjektnr
AND ansattDeltarIProsjekt.ansattnr = ansatt.ansattnr
AND prosjekt.kundenummer = kunde.kundenummer AND kunde.kundenavn = 'NSB';

/* Oppgave 5 */

UPDATE kunde
SET kundenavn = 'Mehdi Cheniti SSJ4'
WHERE kundenummer = 17;

INSERT INTO kunde
VALUES (20, 'Cheniti Mehdi', '6 Trimveien', 2730, 'Oslo');
DELETE FROM kunde
WHERE kundenummer = 20;
