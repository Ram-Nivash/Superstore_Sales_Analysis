CREATE TABLE superstore (
    row_id         INTEGER,
    order_id       TEXT,
    order_date     DATE,
    ship_date      DATE,
    ship_mode      TEXT,
    customer_id    TEXT,
    customer_name  TEXT,
    segment        TEXT,
    country_region TEXT,
    city           TEXT,
    state_province TEXT,
    postal_code    TEXT,
    region         TEXT,
    product_id     TEXT,
    category       TEXT,
    sub_category   TEXT,
    product_name   TEXT,
    sales          NUMERIC(12, 2),
    quantity       INTEGER,
    discount       NUMERIC(8, 4),
    profit         NUMERIC(12, 4)
);

SELECT * FROM superstore;
ALTER TABLE superstore ALTER COLUMN sales TYPE NUMERIC(12, 3);
ALTER DATABASE sales_dashboard SET datestyle = 'ISO, MDY';
SHOW datestyle;