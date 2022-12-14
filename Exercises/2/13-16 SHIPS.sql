SELECT NAME
FROM SHIPS, CLASSES
WHERE SHIPS.CLASS = CLASSES.CLASS AND CLASSES.DISPLACEMENT > 50000

SELECT DISTINCT SHIPS.NAME, DISPLACEMENT, NUMGUNS
FROM SHIPS, CLASSES, OUTCOMES
WHERE OUTCOMES.SHIP = SHIPS.NAME AND OUTCOMES.BATTLE = 'Guadalcanal' AND SHIPS.CLASS = CLASSES.CLASS

SELECT c1.COUNTRY
FROM CLASSES c1, CLASSES c2
WHERE c1.COUNTRY = c2.COUNTRY AND c1.TYPE = 'bb' AND c2.TYPE = 'bc'

SELECT o1.SHIP
FROM OUTCOMES o1, OUTCOMES o2, BATTLES b1, BATTLES b2
WHERE b1.DATE < b2.DATE AND o1.SHIP = o2.SHIP AND o1.BATTLE = b1.NAME AND o2.BATTLE = b2.NAME
