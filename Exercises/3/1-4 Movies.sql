
SELECT MOVIESTAR.NAME
FROM MOVIESTAR, MOVIEEXEC
WHERE MOVIEEXEC.NAME = MOVIESTAR.NAME AND MOVIESTAR.GENDER = 'F' AND MOVIEEXEC.NETWORTH > 10000000

SELECT  DISTINCT MOVIESTAR.NAME
FROM MOVIESTAR, MOVIEEXEC
WHERE MOVIEEXEC.NAME != MOVIESTAR.NAME

SELECT TITLE
FROM MOVIE
WHERE MOVIE.LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Star Wars')

SELECT TITLE, MOVIEEXEC.NAME
FROM MOVIE, MOVIEEXEC
WHERE MOVIEEXEC.CERT# = MOVIE.PRODUCERC# AND MOVIEEXEC.NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'Merv Griffin')