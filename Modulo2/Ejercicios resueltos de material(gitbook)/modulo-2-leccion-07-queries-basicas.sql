-- p-modulo-2-leccion-07-queries-basicas


-- Ejercicio 4: Conociendo a las empleadas:

    El objetivo de cualquier buena jefa (o trabajadora) en una empresa debería ser conocer bien a sus compañeras. Para lograrlo, vamos a diseñar una consulta SQL para obtener una lista con los datos de las empleadas y empleados de la empresa Northwind. Esta consulta incluirá los campos `employee_id`, `last_name` y `first_name`.

SELECT employee_id, last_name, first_name 
FROM employees;

-- Ejercicio 5: Conociendo los productos más baratos:

SELECT  *
FROM products  
WHERE unit_price >= 0.0 AND unit_price <= 5.0;

-- Ejercicio 6: Conociendo los productos que no tienen precio:

SELECT *
FROM products 
WHERE unit_price IS NULL;

-- Ejercicio 7: Comparando productos:

SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE ProductID < 10 AND UnitPrice < 15;

-- Ejercicio 8: Cambiando de operadores:

SELECT ProductID, ProductName, UnitPrice  
FROM Products  
WHERE NOT UnitPrice > 15 AND NOT ProductID > 10;

-- Ejercicio 9:  Conociendo los paises a los que vendemos:

SELECT ShipCountry
FROM Orders;

-- Ejercicio 10:  Conociendo el tipo de productos que vendemos en Northwind:

SELECT product_id, product_name, unit_price
FROM products 
ORDER BY product_id
LIMIT 10;

-- Ejercicio 11: Ordenando los resultados:

SELECT product_id, product_name, unit_price  
FROM products  
ORDER BY ProductID DESC
LIMIT 10; 

-- Ejercicio 12: Que pedidos tenemos en nuestra BBDD:

SELECT DISTINCT order_id      
FROM order_details;

-- Ejercicio 13: Qué pedidos han gastado más:

SELECT order_id, (unit_price*quantity) AS DineroTotal  
FROM order_details   
ORDER BY DineroTotal DESC
LIMIT 3;

-- Ejercicio 14: Los pedidos que están entre las posiciones 5 y 10 de nuestro *ranking*: 

SELECT order_id, (unit_price*quantity) AS DineroTotal  
FROM order_details
ORDER BY DineroTotal DESC
LIMIT 6  
OFFSET 4;

-- Ejercicio 15: Qué categorías tenemos en nuestra BBDD:

SELECT category_name AS NombreDeCategoria  
FROM categories; 

-- Ejercicio 16: Selecciona envios con retraso:

SELECT order_id, order_date, shipped_date, DATE_ADD(shipped_date, INTERVAL 5 DAY) as FechaRetrasada 
FROM orders;

-- Ejercicio 17: Selecciona los productos más rentables:

SELECT product_id, product_name, unit_price 
FROM products  
WHERE unit_price BETWEEN 15 AND 50;

-- Ejercicio 18:  Selecciona los productos con unos precios dados:

SELECT *   
FROM products   
WHERE unit_price IN (20, 18, 19);