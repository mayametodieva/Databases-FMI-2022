SELECT model, speed as MHz, hd as GB
FROM pc
WHERE price < 1200

SELECT maker
FROM product
WHERE type = 'Printer'
GROUP BY maker

SELECT model, ram, screen
FROM laptop
WHERE price > 1000

SELECT code,model,color,type,price
from printer
WHERE color = 'y'

SELECT model, speed, hd
FROM pc
WHERE (cd = '12x' OR cd = '16x') AND price < 2000