


CREATE VIEW vw_customer_total_revenue AS
 SELECT c.name AS customer_name, SUM(o.amount) AS total_revenue
FROM customers c
 JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
 GO

CREATE VIEW vw_customers_min_3_orders AS
 SELECT c.name AS customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
 HAVING COUNT(o.order_id) >= 3;
 GO

CREATE VIEW vw_customer_avg_order_value AS
 SELECT c.name AS customer_name, AVG(o.amount) AS average_amount
FROM customers c
 JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
 GO

CREATE VIEW vw_product_total_revenue AS
 SELECT p.product_name, SUM(o.amount) AS total_revenue
FROM products p
 JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name;
 GO


CREATE VIEW vw_product_total_quantity AS
 SELECT p.product_name, SUM(o.quantity) AS total_quantity_sold
FROM products p
 JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name;
 GO

CREATE VIEW vw_orders_per_day AS
 SELECT order_date, COUNT(order_id) AS order_count
FROM orders
 GROUP BY order_date;
 GO

CREATE VIEW vw_sales_per_day AS
 SELECT order_date, SUM(amount) AS daily_sales_amount
FROM orders
 GROUP BY order_date;
GO

CREATE VIEW vw_payments_by_method AS
 SELECT payment_method, SUM(payment_amount) AS total_collected
FROM payments
 GROUP BY payment_method;
 GO

CREATE VIEW vw_payments_per_day AS
 SELECT payment_date, SUM(payment_amount) AS total_payment_amount
FROM payments
 GROUP BY payment_date;
GO

CREATE VIEW vw_shipment_summary_by_carrier AS
 SELECT carrier, COUNT(shipment_id) AS shipment_count, MIN(shipping_date) AS first_shipping_date, MAX(shipping_date) AS last_shipping_date
FROM shipments
 GROUP BY carrier;
 GO

CREATE VIEW vw_orders_shipping_status AS
 SELECT o.order_id, c.name AS customer_name, o.order_date,
  CASE WHEN s.shipment_id IS NOT NULL THEN 'shipped' ELSE 'not_shipped' END AS shipped_status
FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN shipments s ON o.order_id = s.order_id;
 GO

CREATE VIEW vw_product_price_band AS
 SELECT product_name, price,
       CASE 
         WHEN price < 50 THEN 'budget'
          WHEN price BETWEEN 50 AND 200 THEN 'standard'
           ELSE 'premium'
            END AS price_band
  FROM products;
 GO