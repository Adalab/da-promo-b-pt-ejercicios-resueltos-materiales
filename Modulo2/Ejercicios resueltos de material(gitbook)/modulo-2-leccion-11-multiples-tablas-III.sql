-- 1. Extraed los pedidos con el máximo "order_date" para cada empleado.

SELECT order_id, customer_id, employee_id, order_date, required_date
FROM orders AS O1
WHERE order_date =
  (SELECT MAX(order_date)
   FROM orders AS O2
   WHERE O2.employee_id = O1.employee_id);
   
-- 2. Extraed el precio unitario máximo (unit_price) de cada producto vendido.

select distinct a.product_id, 
       a.unit_price as Max_unit_price_sold
from order_details  as a
where a.unit_price = 
(
    select MAX(unit_price)
    from order_details  as b
    where a.product_id = b.product_id
)
order by a.product_id;

-- 3. Extraed información de los productos "Beverages".

SELECT product_id, product_name, category_id
FROM products
WHERE category_id IN (SELECT category_id
						FROM categories
						WHERE category_name = "Beverages");
                        
-- 4. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país.

SELECT DISTINCT country
 FROM customers
WHERE country NOT IN (SELECT DISTINCT country
                        FROM suppliers);
                        
-- 5. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread".alter

SELECT o.order_id, 
       o.customer_id
FROM orders AS o
WHERE 
(
    SELECT quantity 
    FROM order_details AS od
    WHERE o.order_id = od.order_id AND od.product_id = 6
) > 20;

SELECT o.order_id, 
       o.customer_id
FROM orders AS o
WHERE 
(
    SELECT quantity 
    FROM order_details AS od
    inner join products using(product_id)
    WHERE o.order_id = od.order_id AND product_name= "Grandma's Boysenberry Spread"
) > 20;

-- 6. Extraed los 10 productos más caros.

select * from( 
                select distinct product_name as Ten_Most_Expensive_Products, unit_price 
	from products 
	order by unit_price desc) 
as a limit 10;

-- 7. Qué producto es más popular.

SELECT SUM(quantity) AS Cantidad, product_name
FROM order_details
INNER JOIN products
ON order_details.product_id = products.product_id
GROUP BY product_name
HAVING Cantidad = (
	SELECT MAX(Cantidad)
	FROM 
		(SELECT product_id, SUM(quantity) AS Cantidad
		FROM order_details
		GROUP BY product_id) AS t);