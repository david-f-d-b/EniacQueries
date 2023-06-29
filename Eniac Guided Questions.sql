use magist; /*    */

/*How many orders are there in the dataset? 99441
The orders table contains a row for each order, 
so this should be easy to find out!
*/
SELECT COUNT(*) AS order_count
FROM orders;

/*Are orders actually delivered? most, but not all
Look at columns in the orders table: 
one of them is called order_status. 
Most orders seem to be delivered, but some aren’t. 
Find out how many orders are delivered and
how many are canceled, unavailable, or in any other status 
by grouping and aggregating this column.  

delivered	96478
shipped	    1107
canceled	625
unavailable	609
invoiced	314
processing	301
created	    5
approved	2  */

SELECT order_status, COUNT(*) AS count
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

/*  Is Magist having user growth?  YoY yes, but 2018/2017 was a mild uplift
2016	329
2017	45099
2018	54013

A platform losing users left and right 
isn’t going to be very useful to us. 
It would be a good idea to check for 
the number of orders grouped by year and month. 
Tip: you can use the functions YEAR() and MONTH() 
to separate the year and the month of 
the order_purchase_timestamp.  */

# this is for the monthly order volume
SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') as ym_d, COUNT(*)
FROM orders
GROUP BY 1
ORDER BY 1;

#this is for the YoY order growth
SELECT year(`order_purchase_timestamp`), count(*) #, month(`order_purchase_timestamp`))
FROM orders
GROUP BY 1
ORDER BY 1;

/* How many products are there on the products table? 32951
(Make sure that there are no duplicate products.)
   */
SELECT COUNT(DISTINCT product_id) FROM products;
   
   /* Which are the categories with the most products? 
   computers_accessories is 7th by count of products offered
bed_bath_table	3029
sports_leisure	2867
furniture_decor	2657
health_beauty	2444
housewares	2335
auto	1900
computers_accessories	1639
...
*/
   
SELECT 
    p.product_category_name, t.product_category_name_english, COUNT(DISTINCT product_id)
FROM
    products p
LEFT JOIN product_category_name_translation t
on p.product_category_name = t.product_category_name
GROUP BY 1
ORDER BY 3 DESC;


/* How many of those products were present in actual transactions?  out of 32951   */
SELECT COUNT(*)
FROM products
WHERE
product_id IN 
(SELECT DISTINCT product_id FROM order_items)
;

/* min and max price are 0.85	6735   */
SELECT MIN(price), MAX(Price) FROM order_items;

/* min and max payments are 0	13664.1  */
SELECT MIN(payment_value), MAX(payment_value) FROM order_payments;

 