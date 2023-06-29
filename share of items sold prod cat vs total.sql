SELECT 
    #s.seller_id,
    p.product_category_name,
    /* CASE
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
        ELSE 'not_tech_top10' END AS category, */
    COUNT(oi.product_id) AS sales,  COUNT(oi.product_id) / 112650 * 100 AS share_total_sales
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
GROUP BY 1#,2
#HAVING sales > 0
ORDER BY 2 DESC;