UPDATE product
SET type ='No PC'
FROM product pr LEFT JOIN pc ON pr.model = pc.model
WHERE type ='PC' AND pc.model IS NULL;

SELECT DISTINCT *
FROM product 
WHERE type = 'PC' OR type = 'No PC';

SELECT * FROM PC;

UPDATE pc
SET pc.price = pc.price - (5/100)*pc.price
FROM product p1, product p2, pc, printer
WHERE p1.model = pc.model AND p2.model = printer.model AND p1.maker = p2.maker
AND (SELECT AVG(printer.price) FROM product p1, product p2, pc, printer
WHERE p1.model = pc.model AND p2.model = printer.model AND p1.maker = p2.maker) > 200;
