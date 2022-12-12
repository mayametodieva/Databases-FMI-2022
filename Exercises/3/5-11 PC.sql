SELECT DISTINCT maker
FROM product, pc
WHERE product.model = pc.model AND pc.speed > 500 

SELECT code, model, price
FROM printer
WHERE price >= ALL(SELECT price FROM printer)

SELECT laptop.code, laptop.hd, laptop.model, laptop.price, laptop.ram, laptop.screen, laptop.speed
FROM laptop
WHERE laptop.speed < all(SELECT speed FROM pc)

SELECT t.model, t.price 
FROM ( SELECT model, price FROM pc UNION SELECT model, price FROM laptop UNION SELECT model, price FROM printer) t 
WHERE t.price >= all(SELECT price FROM pc UNION SELECT price FROM laptop UNION SELECT price FROM printer);

SELECT maker
FROM product, printer
WHERE product.model = printer.model AND printer.color = 'y' AND printer.price <= ALL(SELECT price FROM printer WHERE color = 'y')

SELECT DISTINCT maker
FROM product, pc p
WHERE product.model = p.model AND p.ram <= ALL(SELECT ram FROM pc) AND p.speed >= ALL(SELECT speed FROM pc WHERE p.ram = ram)