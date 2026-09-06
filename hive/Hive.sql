
ALTER TABLE ecommerce_dw_test.fact_sales SET TBLPROPERTIES('EXTERNAL'='TRUE');

DESCRIBE FORMATTED ecommerce_dw_test.fact_sales;

ALTER TABLE ecommerce_dw_test.daily_sales SET TBLPROPERTIES('EXTERNAL'='TRUE');

ALTER TABLE ecommerce_dw_test.dim_customer SET TBLPROPERTIES('EXTERNAL'='TRUE');

ALTER TABLE ecommerce_dw_test.dim_product SET TBLPROPERTIES('EXTERNAL'='TRUE');

SELECT COUNT(*) FROM ecommerce_dw_test.fact_sales;
SELECT COUNT(*) FROM ecommerce_dw_test.daily_sales;

SELECT * FROM ecommerce_dw_test.fact_sales LIMIT 10;
SELECT * FROM ecommerce_dw_test.dim_customer LIMIT 10;
SELECT * FROM ecommerce_dw_test.dim_product LIMIT 10;




SELECT COUNT(*) 
FROM ecommerce_dw_test.fact_sales 
WHERE order_id IS NULL OR customer_id IS NULL;




SELECT year, month, day, total_sales, total_orders 
FROM ecommerce_dw_test.daily_sales 
ORDER BY total_sales DESC 
LIMIT 5;


SELECT category, SUM(sales_amount) AS total_revenue, SUM(quantity) AS total_units_sold
FROM ecommerce_dw_test.fact_sales
GROUP BY category
ORDER BY total_revenue DESC;


SELECT customer_id, customer_name, country, total_spending
FROM ecommerce_dw_test.dim_customer
ORDER BY total_spending DESC
LIMIT 10;

SELECT * 
FROM ecommerce_dw_test.fact_sales 
WHERE unit_price <= 0 OR quantity <= 0
LIMIT 5;


SELECT status, COUNT(*) AS status_count
FROM ecommerce_dw_test.fact_sales
GROUP BY status;
