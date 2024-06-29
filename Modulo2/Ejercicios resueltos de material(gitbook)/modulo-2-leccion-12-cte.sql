-- 1. Extraer en una CTE todos los nombres de las compa�ias y los id de los compradores. 


WITH myCTE (CustID, CompanyName) AS
  (SELECT customer_id,
          company_name
   FROM customers)
SELECT CustID,
       CompanyName
FROM myCTE;

-- 2. Selecciona solo los de que vengan de "Germany" 
WITH myCTE2 (CustID, CompanyName, Country) AS
  (SELECT customer_id,
          company_name, 
          country 
   FROM customers
   where country = 'Germany')
SELECT CustID,
       CompanyName
FROM myCTE2;

-- 3. Extraed el id de las facturas y su fecha de cada cliente. 


WITH myCTE AS
  (SELECT c.customer_id,
          c.company_name,
          o.order_id,
          o.order_date
   FROM customers c
   INNER JOIN orders o ON c.customer_id = o.customer_id)
SELECT customer_id,
       company_name,
       order_id,
       order_date
FROM myCTE
order by customer_id ;

-- 4. Contad el n�mero de facturas por cliente

WITH myCTE AS
  (SELECT c.customer_id,
          c.company_name,
          o.order_id,
          o.order_date
   FROM customers c
   INNER JOIN orders o ON c.customer_id = o.customer_id)
SELECT customer_id,
       company_name, 
       count(order_id)
FROM myCTE
group by customer_id;

/* 5. Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraet la suma de las cantidades por cada producto y calcular la media*/

WITH total_productos
AS (
	SELECT product_id, SUM(quantity) AS pedidos_company_cantidad
	FROM order_details
    GROUP BY product_id)
SELECT AVG (pedidos_company_cantidad) AS cantidad_media
FROM pedidos_company;



/* 6. Necesitamos saber el nombre de la categoría, su precio medio, máximo y mínimo.
*/


with tabla as(select c.*, p.unit_price from products as p 
inner join categories as c
on p.category_id = c.category_id)
select category_name, round(avg(unit_price),2) as media, max(unit_price) as max, min(unit_price) as min
from tabla
group by category_name ;

/* 6. La empresa nos ha pedido que busquemos el nombre de cliente, 
su teléfono y el número de pedidos que ha hecho cada uno de ellos
*/

with tabla as (select * from orders as o
natural join customers as c)
select count(*), contact_name, phone, year(order_date)
from tabla
group by contact_name, phone, year(order_date);

select count(*), contact_name, phone
 from (with tabla as (select * from orders as o
natural join customers as c)
select *
from tabla) as tabla2
group by contact_name, phone;

SELECT
    COUNT(*) AS count_per_contact,
    c.contact_name,
    c.phone
FROM
    orders AS o
JOIN
    customers AS c ON o.customer_id = c.customer_id
GROUP BY
    c.contact_name,
    c.phone;

/*7. Modifica la cte del ejercicio anterior, úsala en una subconsulta para saber el nombre 
del cliente y su teléfono, para aquellos clientes que hayan hecho más de 6 pedidos en
el año 1998
*/

select contact_name, phone
from customers
where contact_name in (
with tabla as (select * from orders as o
natural join customers as c
where year(order_date) = 1998)
select contact_name
from tabla
group by contact_name
having count(contact_name)>6);

/* 8.
*/

with tabla as (select count(*) as num_suppliers, country
from suppliers
group by country)
select t.*,  e.first_name, e.last_name, e.city
from tabla as t
inner join employees as e
on t.country = e.country;

/* 9. 
*/

with tabla as(SELECT order_id, (unit_price*quantity)*(1-discount) as total
FROM northwin.order_details)
select tabla.order_id, round(sum(total),2) as total, o.customer_id
from tabla 
inner join orders as o
on o.order_id=tabla.order_id
group by order_id
order by total
	desc;