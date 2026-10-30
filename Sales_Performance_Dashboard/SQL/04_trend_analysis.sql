-- 1. Monthly sales and profit.
SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit)
        / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;

-- 2. Annual performance.
SELECT
    EXTRACT(YEAR FROM order_date)::INTEGER AS sales_year,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit)
        / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY sales_year;

-- 3. Find the best and worst months.
SELECT
    TO_CHAR(sales_month, 'YYYY-MM') AS sales_month,
    total_sales,
    total_profit,
    profit_margin_pct
FROM (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS sales_month,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        ROUND(
            100.0 * SUM(profit)
            / NULLIF(SUM(sales), 0),
            2
        ) AS profit_margin_pct
    FROM superstore
    GROUP BY DATE_TRUNC('month', order_date)
) AS monthly
ORDER BY total_sales DESC --(To find the lowest, use ASC inplace of DESC)
LIMIT 5;