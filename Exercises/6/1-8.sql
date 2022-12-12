SELECT MOVIE.TITLE, MOVIE.YEAR, MOVIE.LENGTH
FROM MOVIE
WHERE (MOVIE.LENGTH > 120 OR MOVIE.LENGTH IS NULL) AND MOVIE.YEAR < 2000

SELECT MOVIESTAR.NAME, MOVIESTAR.GENDER
FROM MOVIESTAR
WHERE (MOVIESTAR.NAME ='J%') AND MOVIESTAR.BIRTHDATE > 1948 
ORDER BY  MOVIESTAR.NAME DESC 

SELECT STUDIO.NAME, COUNT(DISTINCT STARSIN.STARNAME)
FROM STUDIO, MOVIE, STARSIN
WHERE MOVIE.STUDIONAME = STUDIO.NAME AND STARSIN.MOVIETITLE = MOVIE.TITLE
GROUP BY STUDIO.NAME

SELECT STARSIN.STARNAME, COUNT(MOVIE.TITLE)
FROM STARSIN, MOVIE
WHERE STARSIN.MOVIETITLE = MOVIE.TITLE
GROUP BY STARSIN.STARNAME

SELECT S.NAME, MOVIE.TITLE, MOVIE.YEAR
FROM STUDIO S, MOVIE
WHERE S.NAME = MOVIE.STUDIONAME AND MOVIE.YEAR >= ALL(SELECT YEAR FROM MOVIE WHERE MOVIE.STUDIONAME = S.NAME)

SELECT MOVIESTAR.NAME
FROM MOVIESTAR
WHERE MOVIESTAR.GENDER = 'M' AND MOVIESTAR.BIRTHDATE >= ALL(SELECT BIRTHDATE FROM MOVIESTAR WHERE MOVIESTAR.GENDER = 'M')

SELECT m.STUDIONAME, STARSIN.STARNAME, COUNT(*)
FROM MOVIE m, STARSIN
WHERE m.TITLE = STARSIN.MOVIETITLE
GROUP BY m.STUDIONAME, STARSIN.STARNAME
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
FROM MOVIE, STARSIN
WHERE MOVIE.TITLE = STARSIN.MOVIETITLE AND MOVIE.STUDIONAME = m.STUDIONAME
GROUP BY MOVIE.STUDIONAME, STARSIN.STARNAME)

SELECT m.STUDIONAME, STARSIN.STARNAME, COUNT(*)
FROM MOVIE m, STARSIN
WHERE m.TITLE = STARSIN.MOVIETITLE
GROUP BY m.STUDIONAME, STARSIN.STARNAME
HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM MOVIE, STARSIN WHERE MOVIE.TITLE = STARSIN.MOVIETITLE AND m.STUDIONAME = MOVIE.STUDIONAME GROUP BY MOVIE.STUDIONAME, STARSIN.STARNAME)

SELECT MOVIE.TITLE, MOVIE.YEAR, COUNT(STARSIN.MOVIETITLE)
FROM MOVIE, STARSIN
WHERE MOVIE.TITLE = STARSIN.MOVIETITLE
GROUP BY MOVIE.TITLE, MOVIE.YEAR
HAVING COUNT(STARSIN.MOVIETITLE) > 2
