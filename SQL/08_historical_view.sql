-- 1. Create a historical view.
CREATE OR REPLACE VIEW public.superstore_historical AS
SELECT *
FROM public.superstore
WHERE order_date <= CURRENT_DATE;

-- 2. Now verify the result:
SELECT
    COUNT(*) AS total_rows,
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM public.superstore_historical;

-- 3. Compare the two table's row count.
SELECT 'Original' AS dataset, COUNT(*) AS total_rows
FROM public.superstore

UNION ALL

SELECT 'Historical' AS dataset, COUNT(*) AS total_rows
FROM public.superstore_historical;
