INSERT INTO PC VALUES(12,'1100', 2400,2048,500,'52x',299)
INSERT INTO product VALUES('C', '1100', 'PC')

DELETE FROM pc WHERE pc.model = '1100'

DELETE FROM laptop WHERE laptop.model IN (SELECT laptop.model FROM laptop, product p1, product p2 WHERE laptop.model = p1.model AND p1.maker != ALL(SELECT product.maker FROM product WHERE product.type = 'Printer'))

UPDATE product SET maker = 'A'
WHERE product.maker = 'B'

/*SELECT product.model
FROM product
WHERE product.maker = 'A'*/

UPDATE pc SET price = price/2
UPDATE pc SET hd = hd + 20

/*SELECT pc.model, pc.price, pc.hd
FROM pc
WHERE pc.model = '1260'*/

UPDATE laptop SET screen += 1 WHERE laptop.model IN (SELECT laptop.model FROM laptop, product WHERE laptop.model = product.model AND product.maker = 'B') 

SELECT laptop.model, laptop.screen
FROM laptop
WHERE laptop.model = '1321'

