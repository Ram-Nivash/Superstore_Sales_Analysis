-- 1 To check the dataset size.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT row_id) AS unique_row_ids,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT product_id) AS unique_products
FROM superstore;

-- 2 To check missing values.
SELECT
    COUNT(*) FILTER (WHERE row_id IS NULL) AS missing_row_id,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_date,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS missing_quantity
FROM superstore;

-- 3 To check duplicate row IDs.
SELECT
    row_id,
    COUNT(*) AS occurrences
FROM superstore
GROUP BY row_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

--4 To Validate the Dates.

SHOW datestyle;

SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,
    COUNT(*) FILTER (
        WHERE order_date IS NULL
    ) AS missing_order_dates,
    COUNT(*) FILTER (
        WHERE ship_date < order_date
    ) AS shipping_before_order
FROM superstore;
-- Now inspect a few dates in an unambiguour format.
SELECT
    order_id,
    TO_CHAR(order_date, 'YYYY-MM-DD') AS order_date,
    TO_CHAR(ship_date, 'YYYY-MM-DD') AS ship_date
FROM superstore
LIMIT 15;

--5 To check unusual sales and profit values.
SELECT
    COUNT(*) FILTER (WHERE sales < 0) AS negative_sales_rows,
    COUNT(*) FILTER (WHERE profit < 0) AS negative_profit_rows,
    COUNT(*) FILTER (WHERE quantity <= 0) AS nonpositive_quantity_rows,
    COUNT(*) FILTER (
        WHERE discount < 0 OR discount > 1
    ) AS unusual_discount_rows
FROM superstore;
-- Inspect the products with the largest losses:
SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 10;

-- Check actual column data types
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'superstore'
  AND column_name IN ('order_date', 'ship_date');

-- Check the date range and shipping logic
SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,
    COUNT(*) FILTER (
        WHERE ship_date < order_date
    ) AS shipping_before_order
FROM superstore;

-- Run the following query to check unusual values.
SELECT
    COUNT(*) FILTER (
        WHERE sales < 0
    ) AS negative_sales_rows,

    COUNT(*) FILTER (
        WHERE profit < 0
    ) AS negative_profit_rows,

    COUNT(*) FILTER (
        WHERE quantity <= 0
    ) AS nonpositive_quantity_rows,

    COUNT(*) FILTER (
        WHERE discount < 0 OR discount > 1
    ) AS unusual_discount_rows
FROM superstore;
