/*  What categories of tech products does Magist have? */
SELECT 
    p.product_category_name, t.product_category_name_english, COUNT(DISTINCT product_id)
FROM
    products p
LEFT JOIN product_category_name_translation t
on p.product_category_name = t.product_category_name
WHERE 
#REGEXP_LIKE(lower(t.product_category_name_english), 'tech|computer|pc|game')
t.product_category_name_english IN ("consoles_games",	"electronics",	"audio",	"computers_accessories",	"pc_gamer",	"computers")
GROUP BY 1
ORDER BY 3 DESC;

SELECT * FROM product_category_name_translation;
/* tech sellers  */
