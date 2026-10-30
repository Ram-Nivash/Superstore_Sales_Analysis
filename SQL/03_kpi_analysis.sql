-- 1 Total sales, profit and orders
SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit)
        / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore;

-- 2 Calculate average order value.
SELECT
    ROUND(
        SUM(sales)
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM superstore;

-- 3 Break down sales by category.
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit)
        / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;