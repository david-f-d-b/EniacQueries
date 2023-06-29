use magist;
SELECT 
    product_category_name_english,
    CASE
    
    
        WHEN
            REGEXP_LIKE(LOWER(product_category_name_english),
                    'consoles_games|computers_accessories|pc_gamer|tablets_printing_image|audio|telephony|fixed_telephony|electronics|computers')
        THEN
            'relevant_tech'
        ELSE 'Others'
    END AS new_category
FROM
    product_category_name_translation
ORDER BY 2 DESC;

SELECT product_category_name_english, product_category_name,
CASE WHEN product_category_name_english IN ('consoles_games' , 'computers_accessories',
        'pc_gamer',
        'tablets_printing_image',
        'electronics',
        'audio',
        'telephony',
        'fixed_telephony',
        'music',
        'computers')
        THEN 'relevant_tech'
        ELSE 'other'
        END AS category
FROM product_category_name_translation
ORDER BY 3 DESC;


