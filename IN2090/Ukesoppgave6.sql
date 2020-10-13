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
