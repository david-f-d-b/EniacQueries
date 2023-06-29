/*  What categories of tech products does Magist have?

product_category_name IN ('eletronicos' , 'audio',
        'consoles_games',
        'informatica_acessorios',
        'musica',
        'pc_gamer',
        'pcs',
        'tablets_impressao_imagem',
        'telefonia',
        'telefonia_fixa')  */

/*  How many products of these tech categories have been sold at which avg price?

not_tech_top10	95413	122.52
tech_top10		17237	110.33  

What percentage 15,3%

*/
  
  
/*
How many products of these tech categories have been sold 

*/
SELECT product_category_name,
    CASE
        WHEN
            product_category_name IN ('eletronicos' , 'audio',
                'consoles_games',
                'informatica_acessorios',
                'musica',
                'pc_gamer',
                'pcs',
                'tablets_impressao_imagem',
                'telefonia',
                'telefonia_fixa')
        THEN
            'tech_top10'
        ELSE 'not_tech_top10'
    END AS category,
    CASE WHEN price > 400 THEN 'Eniac_price_range'
    ELSE 'cheap' END AS price_category,
       COUNT(oi.product_id) AS sales,
    ROUND(AVG(price),2)
FROM
    products AS p
RIGHT JOIN order_items AS oi
ON p.product_id = o.product_id
WHERE product_category_name IN ('eletronicos' , 'audio',
                'consoles_games',
                'informatica_acessorios',
                'musica',
                'pc_gamer',
                'pcs',
                'tablets_impressao_imagem',
                'telefonia',
                'telefonia_fixa')
#GROUP BY 1,3
#ORDER BY 4 DESC
;


/* 
What’s the average price of the products being sold? 
all cat 120€ / avg basket value 150€
tech cat 110€
*/
SELECT AVG(price) FROM order_items;
SELECT AVG(payment_value) FROM order_payments;

SELECT AVG(price) FROM order_items AS oi
LEFT JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.product_category_name IN ('eletronicos' , 'audio',
                'consoles_games',
                'informatica_acessorios',
                'musica',
                'pc_gamer',
                'pcs',
                'tablets_impressao_imagem',
                'telefonia',
                'telefonia_fixa')
                ;
                
                
SELECT COUNT(product_id)
FROM order_items;


/*  772 days, 25 months, a little over 2 years */
SELECT MIN(order_purchase_timestamp), MAX(order_purchase_timestamp), TIMESTAMPDIFF(DAY,MIN(order_purchase_timestamp), MAX(order_purchase_timestamp)), TIMESTAMPDIFF(MONTH,MIN(order_purchase_timestamp), MAX(order_purchase_timestamp))
FROM orders;

/*  number of sellers: 3095*/
SELECT COUNT(*) FROM sellers;

/* 
SELECT 
s.sellers,
p.product_category_name,
COUNT(oi.product_id)


products AS p
order_items AS oi
sellers AS s

ON 

p.product_id = oi.product_id

oi.seller_id = s.seller_id

WHERE 
techtop10
*/

/* 
number of tech sellers with sales > 0: 499 (16%)
number of tech sellers with sales > 100: 40 (1,2%)

*/
WITH sub AS (
SELECT 
    s.seller_id,
    #p.product_category_name,
    CASE
        WHEN
            product_category_name IN ('eletronicos' , 'audio',
                'consoles_games',
                'informatica_acessorios',
                'musica',
                'pc_gamer',
                'pcs',
                'tablets_impressao_imagem',
                'telefonia',
                'telefonia_fixa')
        THEN
            'tech_top10'
        ELSE 'not_tech_top10' END AS category,
    COUNT(oi.product_id) AS sales
FROM
    order_items AS oi
        LEFT JOIN
    products AS p ON oi.product_id = p.product_id
        LEFT JOIN
    sellers AS s ON oi.seller_id = s.seller_id
WHERE
    product_category_name IN ('eletronicos' , 'audio',
        'consoles_games',
        'informatica_acessorios',
        'musica',
        'pc_gamer',
        'pcs',
        'tablets_impressao_imagem',
        'telefonia',
        'telefonia_fixa')
GROUP BY 1,2
#HAVING sales > 0
ORDER BY 3 DESC)
SELECT COUNT(*)
FROM sub;

# 112650 sales total
SELECT COUNT(product_id) AS items_sold
FROM order_items;

/*sidetask
*/
SELECT DISTINCT product_id, SUM(price), price, SUM(price)/price, COUNT(product_id)
FROM order_items
GROUP BY 1,3
ORDER BY 2 DESC;

/*
Can you work out the average monthly income of all sellers? 
Can you work out the average monthly income of Tech sellers?
*/

#average monthly income of all sellers

/*
SELECT 
DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS year_month_date,
SUM(op.payment_value),
SUM(oi.price)
FROM orders AS o
LEFT JOIN order_payments AS op
ON o.order_id = op.order_payments
LEFT JOIN order_items AS oi
ON o.order_id = oi.order_id


/* What is the total amount earned by all sellers? 
2017-01	120
2017-02	246
2017-03	381
2017-04	361
2017-05	527
2017-06	444
2017-07	514
2017-08	580
2017-09	645
2017-10	678
2017-11	1022
2017-12	753
2018-01	959
2018-02	862
2018-03	995
2018-04	1005
2018-05	1007
2018-06	905
2018-07	893
2018-08	874
*/


SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS year_month_date,
    ROUND(SUM(oi.price) / 1000, 0) AS rev_k
FROM
    orders AS o
        LEFT JOIN
    order_payments AS op ON o.order_id = op.order_id
        LEFT JOIN
    order_items AS oi ON o.order_id = oi.order_id
    LEFT JOIN products AS p
    ON oi.product_id = p.product_id
WHERE
    o.order_status = 'delivered'
        AND p.product_category_name IN ('eletronicos' , 'audio',
        'consoles_games',
        'informatica_acessorios',
        'musica',
        'pc_gamer',
        'pcs',
        'tablets_impressao_imagem',
        'telefonia',
        'telefonia_fixa')
GROUP BY 1
ORDER BY 1;

/* What is the total amount earned by tech sellers? 
2016-10	6
2017-01	13
2017-02	29
2017-03	53
2017-04	38
2017-05	69
2017-06	59
2017-07	68
2017-08	95
2017-09	140
2017-10	129
2017-11	139
2017-12	91
2018-01	134
2018-02	152
2018-03	151
2018-04	118
2018-05	116
2018-06	102
2018-07	111
2018-08	111
*/
#average monthly income of Tech sellers
