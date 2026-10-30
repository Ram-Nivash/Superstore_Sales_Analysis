-- 1. Compare regions.
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit)
        / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- 2. Find the strongest and weakest states by profit.
SELECT
    state_province,
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit)
        / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY state_province, region
ORDER BY total_profit DESC;