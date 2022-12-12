SELECT DISTINCT product.maker, laptop.speed 
FROM product, laptop
WHERE laptop.hd >=9 AND product.type = 'Laptop' AND product.model = laptop.model
ORDER BY product.maker DESC

SELECT product.model, price
FROM product, laptop
WHERE laptop.model = product.model AND product.maker = 'B'
UNION
(SELECT product.model, price
FROM product, pc
WHERE pc.model = product.model AND product.maker = 'B')
UNION
(SELECT product.model, price
FROM product, printer
WHERE printer.model = product.model AND product.maker = 'B')

SELECT maker
FROM product
WHERE type = 'Laptop' 
EXCEPT
SELECT maker
FROM product
WHERE type = 'PC'

SELECT DISTINCT p1.hd
FROM pc as p1, pc as p2
WHERE p1.hd = p2.hd AND p1.code != p2.code

SELECT DISTINCT pc1.model, pc2.model 
FROM pc as pc1, pc as pc2
WHERE pc1.model < pc2.model AND pc1.speed = pc2.speed AND pc1.ram = pc2.ram

SELECT DISTINCT p1.maker
FROM product p1, product p2, pc pc1, pc pc2
WHERE p1.type = 'PC' AND p2.type = 'PC' AND p1.maker = p2.maker AND pc1.code != pc2.code AND pc1.model = p1.model AND pc2.model = p2.model AND pc1.speed >= 400 AND pc2.speed >=400