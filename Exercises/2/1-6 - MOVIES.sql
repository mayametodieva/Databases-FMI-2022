
SELECT STARNAME
FROM STARSIN, MOVIESTAR
WHERE MOVIESTAR.NAME = STARSIN.STARNAME AND GENDER = 'M' AND MOVIETITLE = 'The Usual Suspects'

SELECT STARNAME
FROM STARSIN, MOVIE
WHERE MOVIEYEAR = 1995 AND STARSIN.MOVIETITLE = MOVIE.TITLE AND MOVIE.STUDIONAME = 'MGM'

SELECT DISTINCT MOVIEEXEC.NAME
FROM MOVIEEXEC, MOVIE
WHERE MOVIEEXEC.CERT# = MOVIE.PRODUCERC# AND MOVIE.STUDIONAME = 'MGM'

/*SELECT TITLE
FROM MOVIE
WHERE LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Star Wars')*/

SELECT TITLE FROM MOVIE WHERE LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Star Wars');

SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'Stephen Spielberg') 

SELECT M1.NAME
FROM MOVIEEXEC AS M1, MOVIEEXEC AS M2
WHERE M1.NETWORTH > M2.NETWORTH AND M2.NAME = 'Stephen Spielberg'

SELECT TITLE
FROM MOVIEEXEC AS M1, MOVIEEXEC AS M2, MOVIE
WHERE M1.NETWORTH > M2.NETWORTH AND M2.NAME = 'Stephen Spielberg' AND MOVIE.PRODUCERC# = M1.CERT#