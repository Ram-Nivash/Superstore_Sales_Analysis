-- 0. just a final verification
SELECT
    COUNT(*) FILTER (
        WHERE order_date > CURRENT_DATE
    ) AS future_order_rows,

    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,

    COUNT(*) FILTER (
        WHERE order_date >= DATE '2026-01-01'
          AND order_date < DATE '2026-02-01'
    ) AS january_2026_rows
FROM superstore;

-- 1. This will show the months contributing to those 945 future-dated rows and the associated sales and profit.
SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    COUNT(*) AS order_rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
WHERE order_date > CURRENT_DATE
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;

-- 2. check whether any individual orders have dates after today:
SELECT
    order_id,
    order_date,
    ship_date,
    customer_name,
    product_name,
    sales,
    profit
FROM superstore
WHERE order_date > CURRENT_DATE
ORDER BY order_date
LIMIT 20;