create database ecommerce;
use ecommerce;
select * from customers;
USE ecommerce;
SHOW TABLES;

SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM customer_summary;
SELECT COUNT(*) FROM order_items;


ALTER TABLE customers MODIFY customer_id VARCHAR(64);
ALTER TABLE customers ADD PRIMARY KEY (customer_id);

ALTER TABLE orders MODIFY order_id VARCHAR(64);
ALTER TABLE orders MODIFY customer_id VARCHAR(64);
ALTER TABLE orders ADD PRIMARY KEY (order_id);

ALTER TABLE products MODIFY product_id VARCHAR(64);
ALTER TABLE products ADD PRIMARY KEY (product_id);

ALTER TABLE order_items MODIFY order_id VARCHAR(64);
ALTER TABLE order_items MODIFY product_id VARCHAR(64);

ALTER TABLE orders ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE order_items ADD FOREIGN KEY (product_id) REFERENCES products(product_id);
ALTER TABLE orders MODIFY customer_unique_id VARCHAR(64);
DESCRIBE orders;


-- 1.Total orders
select count(distinct order_id) as total_orders from orders;

-- 2.Total customers
select count(distinct customer_unique_id) as total_customers from customers;

-- 3.Total products
select count(distinct product_id) as total_products from products;

-- 4.Total sellers
select count(distinct seller_id) as total_unique_sellers from sellers;

-- 5.Total sales
select round(sum(price),2) as total_revenue from order_items;

-- 6.Total freight
select round(sum(freight_value),2) as total_freight from order_items;

-- 7.Average Order Value

SELECT 
    ROUND(AVG(order_value), 2) AS average_order_value
FROM (
    SELECT 
        order_id,
        SUM(price) AS order_value
    FROM order_items
    GROUP BY order_id
) AS order_summary;


select sum(oi.price) / count(distinct(o.customer_id)) from order_items oi join orders o on oi.order_id=o.order_id;

-- 8.Average items per order
SELECT
    ROUND(
        COUNT(*) * 1.0 / COUNT(DISTINCT order_id),
        2
    ) AS average_items_per_order
FROM order_items;

-- 9.Average selling price
SELECT 
    ROUND(AVG(price), 2) AS average_selling_price
FROM order_items;

-- 10.Sales by Order Status
SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_sales 
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY total_sales DESC;

-- 11.Monthly sales
select year(order_purchase_timestamp) as year , month(order_purchase_timestamp) as month , 
round(sum(order_revenue),2) as sales from orders_delivered group by year,month order by year,month ;

-- all orders  
SELECT 
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    round(SUM(oi.price),2) AS sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year, month
ORDER BY year, month;

-- 12.Calculate Month-over-Month (MoM) sales growth
SELECT 
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    round(SUM(oi.price),2) AS sales, 
    lag(round(sum(price),2)) over(order by year(o.order_purchase_timestamp) ,month(o.order_purchase_timestamp)) as previous_month_revenue,
 round(  ( round(SUM(oi.price),2) - lag(round(sum(price),2)) over(order by year(o.order_purchase_timestamp) ,
 month(o.order_purchase_timestamp)))*100.0/
   lag(round(sum(price),2)) over(order by year(o.order_purchase_timestamp) ,month(o.order_purchase_timestamp)),2 ) as growth_pct
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year, month
ORDER BY year, month;


-- 13.Identify one-time vs repeat customers

select customer_unique_id,n_orders,case when n_orders =1 then 'one_time' else 'repeat' end as customer_type from customer_summary;

-- Repeat Customers
select count(customer_unique_id) as repeat_customers from customer_summary_all where n_orders >1 ;
-- New Customers
select count(customer_unique_id) as new_customers from customer_summary_all where n_orders =1 ;


-- 14.Find each customer's first purchase date
select customer_unique_id,min(first_order) as first_purchase_order from customer_summary group by customer_unique_id ;

-- 15.Find each customer's last purchase date
select customer_unique_id,max(last_order) as last_purchase_order from customer_summary group by customer_unique_id ;

-- 16.Build customer cohorts based on first purchase month
with customer_orders as 
(select c.customer_unique_id,o.order_id,o.order_purchase_timestamp,
date_format(min(o.order_purchase_timestamp) over(partition by c.customer_unique_id),'%Y-%m') as cohort_month,
date_format(o.order_purchase_timestamp,'%Y-%m') as purchase_month 
from orders o join customers c on o.customer_id=c.customer_id )

select cohort_month,purchase_month,count(distinct customer_unique_id) as customers from customer_orders 
group by cohort_month, purchase_month order by cohort_month,purchase_month;

-- 17.Calculate customer retention rate by cohort
with customer_orders  as 
(select c.customer_unique_id,o.order_id,o.order_purchase_timestamp,
date_format(min(o.order_purchase_timestamp) over(partition by c.customer_unique_id),'%Y-%m') as cohort_month,
date_format(o.order_purchase_timestamp,'%Y-%m') as purchase_month 
from orders o join customers c on o.customer_id=c.customer_id ),
cohort_counts as (
select cohort_month, purchase_month,count(distinct customer_unique_id) as customers from customer_orders 
group by cohort_month, purchase_month),

cohort_size as (select cohort_month,customers as cohort_customers from cohort_counts where cohort_month=purchase_month)
select cc.cohort_month,
cc.purchase_month,
cc.customers,
cs.cohort_customers,
 round(cc.customers*100.0/cs.cohort_customers,2) as retention_rate 
from cohort_counts cc join cohort_size cs on cc.cohort_month=cs.cohort_month order by cc.cohort_month,cc.purchase_month ;


-- 18.Calculate RFM scores (Recency, Frequency, Monetary)
 with rfm as (
 select c.customer_unique_id , datediff(
 (select max(order_purchase_timestamp)from orders),
 max(o.order_purchase_timestamp) )as recency ,
 count(distinct o.order_id) as frequency ,
 round(sum(oi.price),2) as monetary
 
 from orders o 
 join customers c on o.customer_id=c.customer_id
 join order_items oi on o.order_id=oi.order_id
 group by c.customer_unique_id )
 
 select * from rfm order by recency;


-- 19.Create RFM customer segments
with rfm as (
 select c.customer_unique_id , datediff(
 (select max(order_purchase_timestamp)from orders),
 max(o.order_purchase_timestamp) )as recency ,
 count(distinct o.order_id) as frequency ,
 round(sum(oi.price),2) as monetary
 
 from orders o 
 join customers c on o.customer_id=c.customer_id
 join order_items oi on o.order_id=oi.order_id
 group by c.customer_unique_id ) ,
 
 rfm_scores as (
 select customer_unique_id , recency,frequency,monetary ,
 6-ntile(5) over (order by recency) as r_score,
 ntile(5) over (order by frequency) as f_score,
 ntile(5) over (order by monetary) as m_score
 from rfm )
 
 select customer_unique_id,recency,frequency,monetary, r_score,f_score,m_score ,
 concat(r_score,f_score,m_score) as rfm_score
 ,
 case when r_score>=4 and f_score>=4 and m_score>=4 then 'Champions'
 when r_score>=4 and f_score>=3 then 'Loyal Customers'
 when r_score>=4 and f_score<=2  then 'New Customers'
 when r_score<=2 and f_score>=3 and m_score>=3 then 'At Risk'
 when r_score<=2 and f_score<=2 then 'Lost Customers' 
 else 'Potential Loyalists'
 end as customer_segment
 from rfm_scores order by recency
 ;
 
-- 20.Sales by Customer State
select c.customer_state , round(sum(oi.price),2) as total_sales from customers c join orders o on c.customer_id=o.customer_id 
join order_items oi on o.order_id=oi.order_id group by c.customer_state;
 
-- 21.Orders by Customer State 
select c.customer_state , count(o.order_id) as total_orders from customers c 
join orders o on c.customer_id=o.customer_id group by c.customer_state;

-- 22.Average Order Value by State
 with total_revenue as (select c.customer_state , round(sum(oi.price),2) as total_sales ,count(distinct o.order_id) as total_orders
 from customers c join orders o on c.customer_id=o.customer_id 
join order_items oi on o.order_id=oi.order_id group by c.customer_state)
select customer_state,total_sales,total_orders, round(total_sales/total_orders,2) as aov from total_revenue group by customer_state 
order by aov desc;

-- 23.Sales by Product Category
select p.product_category_name_english as category, round(sum(oi.price),2) as total_sales 
from products p join order_items oi on p.product_id=oi.product_id group by category order by total_sales desc;

-- 24.Top 10 Products by Revenue
select p.product_category_name_english as category, round(sum(oi.price),2) as total_sales 
from products p join order_items oi on p.product_id=oi.product_id group by p.product_id order by total_sales desc limit 10;

-- 25.Top Sellers by Revenue
select seller_id , round(sum(price),2) as revenue from order_items group by seller_id order by revenue desc limit 10;

-- 26.Relationship Between Review Score and Delivery Time
SELECT
    r.review_score,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                DAY,
                o.order_purchase_timestamp,
                o.order_delivered_customer_date
            )
        ), 2
    ) AS avg_delivery_days,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score;

-- 27. Delivery Performance
SELECT
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
            THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_status,
    COUNT(*) AS total_orders,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status;




 












