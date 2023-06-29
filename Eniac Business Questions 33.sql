/*What’s the average time between the order being placed and the product being delivered?
2016-09	54.0000
2016-10	19.1170
2016-12	4.0000
2017-01	12.0882
2017-02	12.6098
2017-03	12.4111
2017-04	14.3672
2017-05	10.7665
2017-06	11.4983
2017-07	11.1541
2017-08	10.6848
2017-09	11.3961
2017-10	11.3928
2017-11	14.6988
2017-12	14.9375
2018-01	13.6388
2018-02	16.5035
2018-03	15.8939
2018-04	11.0576
2018-05	10.9601
2018-06	8.7820
2018-07	8.5153
2018-08	7.2804

Is there any pattern for delayed orders, e.g. big products being delayed more often?
*/


SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS year_month_date,
    AVG(TIMESTAMPDIFF(DAY,
        order_purchase_timestamp,
        order_delivered_customer_date)) AS avg_tdt
FROM
    orders AS o
WHERE
    order_status = 'delivered'
GROUP BY 1
ORDER BY 1;

/*
TIMESTAMPDIFF(DAY,order_purchase_timestamp, order_delivered_customer_date), 
TIMESTAMPDIFF(MONTH,MIN(order_purchase_timestamp), MAX(order_purchase_timestamp))
DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS year_month_date
SELECT * FROM orders LIMIT 3;
*/


/*
How many orders are delivered on time vs orders delivered with a delay?


*/

/*
SELECT * FROM orders LIMIT 3;
SELECT TIMESTAMPDIFF(hour, order_estimated_delivery_date, order_delivered_customer_date) FROM orders LIMIT 3;
TIMESTAMPDIFF(DAY,order_purchase_timestamp, order_delivered_customer_date);
*/
SELECT * FROM orders LIMIT 3;
SELECT COUNT(*),
CASE WHEN TIMESTAMPDIFF(hour,order_estimated_delivery_date, order_delivered_customer_date) < 0 THEN 'on_time'
WHEN TIMESTAMPDIFF(hour,order_estimated_delivery_date, order_delivered_customer_date) < 24 THEN 'within_1_day'
WHEN TIMESTAMPDIFF(hour,order_estimated_delivery_date, order_delivered_customer_date) < 48  THEN 'within_2_days'
ELSE 'over_2_days_delay' END AS 'delivery_hours'
FROM orders AS o
GROUP BY 2
ORDER BY 1 DESC;


/*Is there any pattern for delayed orders, e.g. big products being delayed more often?

SELECT p.product_weight,
(product_length_cm * product_height_cm * product_height_cm / 1000000) AS vol_m3

FROM orders AS o
LEFT JOIN order_items AS oi
ON o.order_id = oi.order_id
LEFT JOIN
products AS prepare
ON oi.product_id = p.product_id

*/

SELECT 
    p.product_weight_g / 1000 AS weight_kg,
    (product_length_cm * product_height_cm * product_height_cm / 1000000) AS vol_m3
FROM
    orders AS o
        LEFT JOIN
    order_items AS oi ON o.order_id = oi.order_id
        LEFT JOIN
    products AS p ON oi.product_id = p.product_id
LIMIT 5
;

SELECT 
    #(product_length_cm * product_height_cm * product_height_cm / 1000000) AS vol_m3,
    AVG(product_length_cm * product_height_cm * product_height_cm / 1000000) AS avg_vol,
    MIN(product_length_cm * product_height_cm * product_height_cm / 1000000) AS min_vol,
    MAX(product_length_cm * product_height_cm * product_height_cm / 1000000) AS max_vol,
    AVG(p.product_weight_g / 1000) AS avg_w_kg,
    MIN(p.product_weight_g / 1000) AS min_w_kg,
    MAX(p.product_weight_g / 1000) AS max_w_kg
    #MEDIAN(product_length_cm * product_height_cm * product_height_cm / 1000000) AS median,
    #COUNT(*) AS count
FROM
    orders AS o
        LEFT JOIN
    order_items AS oi ON o.order_id = oi.order_id
        LEFT JOIN
    products AS p ON oi.product_id = p.product_id
#LIMIT 5
;

/*

*/

SELECT 
    CASE
        WHEN
            TIMESTAMPDIFF(HOUR,
                order_estimated_delivery_date,
                order_delivered_customer_date) < 0
        THEN
            'on_time'
        WHEN
            TIMESTAMPDIFF(HOUR,
                order_estimated_delivery_date,
                order_delivered_customer_date) < 24
        THEN
            'within_1_day'
        WHEN
            TIMESTAMPDIFF(HOUR,
                order_estimated_delivery_date,
                order_delivered_customer_date) < 48
        THEN
            'within_2_days'
        ELSE 'over_2_days_delay'
    END AS 'delivery_hours',
    CASE
        WHEN (product_length_cm * product_height_cm * product_height_cm / 1000000) < 0 THEN 'invalid'
        WHEN (product_length_cm * product_height_cm * product_height_cm / 1000000) < 0.5 THEN 'lowervolume<0,5'
        ELSE 'highervolume>0,5'
    END AS 'delivery_size',
    CASE
        WHEN (p.product_weight_g / 1000) <0 THEN 'invalid'
        WHEN (p.product_weight_g / 1000) < 2 THEN 'under2kg'
        ELSE 'over2kg'
    END AS 'delivery_weight_kg',
    COUNT(*)
FROM
    orders AS o
        LEFT JOIN
    order_items AS oi ON o.order_id = oi.order_id
        LEFT JOIN
    products AS p ON oi.product_id = p.product_id
GROUP BY 1,2,3
ORDER BY 1,2,3 DESC;