

-- 1. Pedidos por empresa en UK:

SELECT customers.company_name AS NombreEmpresa, customers.customer_id AS Identificador, COUNT(orders.order_id) AS NumeroPedidos
FROM customers INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK' 
GROUP BY customers.company_name, customers.customer_id;

-- 2. Productos pedidos por empresa en UK por año:

SELECT customers.company_name as NombreEmpresa, YEAR(orders.order_date) AS Año, SUM(order_details.quantity) AS NumObjetos
FROM customers  
    INNER JOIN orders ON customers.customer_id = orders.customer_id
    INNER JOIN order_details ON orders.order_id = order_details.order_id
WHERE customers.country = 'UK'
GROUP BY customers.company_name, YEAR(orders.order_date)
ORDER BY customers.company_name, YEAR(orders.order_date);

-- 3.  Mejorad la *query* anterior:

SELECT C.company_name AS NombreEmpresa, 
        YEAR(O.order_date) AS Año, 
        SUM(OD.quantity) AS NumObjetos, 
        SUM(OD.quantity * OD.unit_price * (1-OD.discount)) AS DineroTotal
FROM customers AS C INNER JOIN orders AS O 
ON C.customer_id = O.customer_id
INNER JOIN order_details AS OD 
ON O.order_id = OD.order_id
WHERE C.country = 'UK'
GROUP BY C.company_name, YEAR(O.order_date)
ORDER BY C.company_name, YEAR(O.order_date);

-- 4. **BONUS:** Pedidos que han realizado cada compañía y su fecha: 

SELECT orders.order_id, customers.company_name, orders.order_date
FROM customers INNER JOIN orders 
ON customers.customer_id = orders.customer_id;

-- 5. **BONUS:** Tipos de producto vendidos:


SELECT DISTINCT cat.category_id, cat.category_name, prod.product_name, sum(round(ord_det.unit_price * ord_det.quantity * (1 - ord_det.discount), 2)) as ProductSales
FROM order_details AS ord_det 
INNER JOIN orders AS ord 
ON ord.order_id = ord_det.order_id
INNER JOIN products AS prod 
ON prod.product_id = ord_det.product_id
INNER JOIN categories AS cat 
ON cat.category_id = prod.category_id
GROUP BY cat.category_id, cat.category_name, prod.product_name
ORDER BY cat.category_id, prod.product_name, ProductSales;

-- 6. Qué empresas tenemos en la BBDD Northwind:

FROM customers LEFT JOIN orders
ON customers.customer_id = orders.customer_id; 

-- 7. Pedidos por cliente de UK:

SELECT customers.company_name AS NombreCliente, COUNT(orders.order_id) AS NumeroPedidos 
FROM customers LEFT JOIN orders 
ON customers.customer_id = orders.customer_id  
WHERE customers.country = 'UK' 
GROUP BY customers.company_name; 

-- 8. Empresas de UK y sus pedidos:

SELECT orders.order_id, customers.company_name AS NombreCliente, orders.order_date AS FechaPedido 
FROM orders RIGHT JOIN customers   
ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK';

-- 9. Empleadas que sean de la misma ciudad:

SELECT e1.city, e1.first_name AS NombreEmpleado, e1.last_name AS ApellidoEmpleado, 
	   e2.city, e2.first_name AS NombreJefe, e2.last_name AS ApellidoJefe
FROM employees AS e1, employees AS e2
WHERE e1.reports_to = e2.employee_id
ORDER BY e1.city, e2.city;

-- 10. **BONUS: FULL OUTER JOIN** Pedidos y empresas con pedidos asociados o no:

 SELECT orders.order_id, customers.company_name AS NombreCliente, orders.order_date AS FechaPedido  
FROM orders RIGHT JOIN customers   
ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK'  
UNION  
SELECT orders.order_id, customers.company_name AS NombreCliente, orders.order_date AS FechaPedido  
FROM orders LEFT JOIN customers  
ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK';