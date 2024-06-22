
-- 1. Productos más baratos y caros de nuestra BBDD: 

SELECT MIN(unit_price) AS SmallestPrice, MAX(unit_price) AS LargestPrice 
FROM products;

-- 2. Conociendo el numero de productos y su precio medio:

SELECT COUNT(product_id) AS NumProducts, AVG(unit_price) AS AVGPrice
FROM products;

-- 3. Sacad la máxima y mínima carga de los pedidos de UK:

SELECT MIN(freight) AS LowFreight, MAX(freight) AS HighFreight 
FROM orders WHERE ship_country = 'UK';

-- 4.  Qué productos se venden por encima del precio medio:

SELECT avg(unit_price) as PrecioMedio  
FROM products;

SELECT DISTINCT product_name, unit_price  
FROM products 
WHERE unit_price > (28.86)  
ORDER BY unit_price DESC;

-- 5. Qué productos se han descontinuado:

SELECT COUNT(product_name) 
FROM products
WHERE discontinued = 1;

-- 6. Detalles de los productos de la *query* anterior:

SELECT *  
FROM products 
WHERE discontinued = 0  
ORDER BY product_id DESC 
LIMIT 10;

-- 7. Relación entre número de pedidos y máxima carga:

SELECT COUNT(*), MAX(freight), employee_id 
FROM orders
GROUP BY employee_id; 

-- 8. Descartar pedidos sin fecha y ordénalos:

SELECT COUNT(*), MAX(freight), employee_id  
FROM orders 
WHERE shipped_date IS NOT NULL  
GROUP BY  employee_id  
ORDER BY employee_id; 

-- 9. Números de pedidos por día:

SELECT COUNT(*) AS OrderCount, DAY(order_date) AS OrderDay, MONTH(order_date) AS OrderMonth, YEAR(order_date) AS OrderYear  
FROM orders 
GROUP BY order_date  
ORDER BY order_date;  

-- 10. Número de pedidos por mes y año:

SELECT COUNT(*) AS OrderCount, MONTH(order_date) AS OrderMonth, YEAR(order_date) AS OrderYear  
FROM orders  
GROUP BY  order_date  
ORDER BY order_date;

-- 11. Seleccionad las ciudades con 4 o más empleadas:

SELECT city, COUNT(employee_id) AS NumEmpleadas
FROM employees
GROUP BY city
HAVING COUNT(employee_id) >= 4;

-- 12. Cread una nueva columna basándonos en la cantidad monetaria:

SELECT order_id, SUM(unit_price * quantity) AS CantidadDinero,
CASE WHEN  SUM(unit_price * quantity) < 2000 THEN "Bajo"
	ELSE "Alto"
	END AS costes
    FROM order_details
GROUP BY order_id;