SELECT DISTINCT product.maker, product.model, product.type
FROM product JOIN pc ON product.model != ALL(SELECT model FROM pc) AND product.type = 'PC'
UNION
SELECT DISTINCT product.maker, product.model, product.type
FROM product JOIN laptop ON product.model != ALL(SELECT model FROM laptop) AND product.type = 'laptop'
UNION
SELECT DISTINCT product.maker, product.model, product.type
FROM product JOIN printer ON product.model != ALL(SELECT model FROM printer) AND product.type = 'printer'

SELECT DISTINCT a.maker
FROM product a, product b, laptop, printer
WHERE a.model = laptop.model AND b.model = printer.model AND a.maker = b.maker

SELECT DISTINCT a.hd
FROM laptop a JOIN laptop b ON a.hd = b.hd AND a.model != b.model

SELECT pc.model
FROM pc JOIN product ON product.model = pc.model AND product.maker = NULL