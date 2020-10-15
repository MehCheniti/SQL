/* Oppgave 1 */

/* Oppgave 2 */

/* a) */
SELECT *
FROM timelistelinje
WHERE timelistenr = 3;

/* b) */
SELECT COUNT(timelistenr) antalltimelister
FROM timeliste;

/* c) */
SELECT COUNT(timelistenr) antallubetaltetimelister
FROM timeliste;
WHERE status != 'utbetalt';

/* d) */
SELECT COUNT(timelistenr) timelistelinjer, COUNT(pause) pauser
FROM timelistelinje;

/* e) */
SELECT *
FROM timelistelinje
WHERE pause IS null;

/* Oppgave 3 */

/* a) */
SELECT (SUM(varighet) / 60) antallubetaltetimer
FROM varighet, timeliste
WHERE varighet.timelistenr = timeliste.timelistenr
AND timeliste.status != 'utbetalt';

/* b) */
SELECT DISTINCT t.timelistenr, t.beskrivelse
FROM timeliste AS t INNER JOIN timelistelinje AS tl
ON t.timelistenr = tl.timelistenr
WHERE tl.beskrivelse LIKE '%test%' OR tl.beskrivelse LIKE '%Test%';

/* c) */
SELECT ((SUM(varighet) / 60) * 200) antallbetaltetimer
FROM timeliste AS t INNER JOIN varighet AS v ON t.timelistenr = v.timelistenr
WHERE t.status = 'utbetalt';

/* Oppgave 4 */

/* a) */
/* Grunnen til at spørringene ikke gir likt svar er fordi INNER JOIN slår kun
sammen tabellene hvor timelistenr er ekvivalente, mens NATURAL JOIN slår sammen
alle identiske kolonner. */

/* b) */
/* Grunnen til at spørringene gir likt svar er fordi NATURAL JOIN slår sammen
identiske kolonner, som i dette tilfellet er det samme som INNER JOIN mellom
Timeliste og Varighet på timelistenr. */
