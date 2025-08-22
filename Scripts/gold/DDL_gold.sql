/*
=============================================================
 Author      : Arsh
 Created On  : 2025-08-22
 Description : Script to create Gold Layer views for Data Warehouse.
               Includes:
                 - dim_products
                 - dim_customer
                 - fact_sales
 Database    : Datawarehouse
 Schema      : gold
=============================================================
 Change Log:
 Date        Author        Description
 ----------  ------------  ----------------------------------
 2025-08-22  Arsh          Initial version
=============================================================
*/

-------------------------------------------------------------
-- View: dim_products
-- Description: Dimension table for product details enriched
--              with category and subcategory from ERP data.
-------------------------------------------------------------
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT 
    ROW_NUMBER() OVER(ORDER BY pin.prd_start_dt, pin.prd_key) AS product_key,
    pin.prd_id          AS product_id,
    pin.prd_key         AS product_number,
    pin.prd_nm          AS product_name,
    pin.prd_cost        AS cost, 
    pin.prd_line        AS product_line,
    pin.cat_id          AS category_id,
    pc.CAT              AS category,
    pc.SUBCAT           AS subcategory,
    pc.maintenance,
    pin.prd_start_dt    AS start_date
FROM silver.crm_prd_info pin
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pin.cat_id = pc.ID
WHERE pin.prd_end_dt IS NULL;  -- Filter out inactive products

-------------------------------------------------------------
-- View: dim_customer
-- Description: Dimension table for customer details enriched
--              with ERP location and demographic data.
-------------------------------------------------------------
IF OBJECT_ID('gold.dim_customer', 'V') IS NOT NULL
    DROP VIEW gold.dim_customer;
GO

CREATE VIEW gold.dim_customer AS
SELECT
    ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
    ci.cst_id             AS customer_id,
    ci.cst_key            AS customer_number,
    ci.cst_firstname      AS first_name,
    ci.cst_lastname       AS last_name,
    cl.CNTRY              AS country,
    ci.cst_marital_status AS marital_status,
    CASE 
        WHEN ci.cst_gndr != 'NA' THEN ci.cst_gndr
        ELSE COALESCE(ca.gen, 'NA')
    END                   AS gender,
    ca.BDATE              AS birthdate,
    ci.cst_create_date    AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca 
    ON ci.cst_key = ca.CID
LEFT JOIN silver.erp_loc_a101 cl
    ON ci.cst_key = cl.CID;

-------------------------------------------------------------
-- View: fact_sales
-- Description: Fact table for sales transactions linked with
--              product and customer dimensions.
-------------------------------------------------------------
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT 
    sls_ord_num     AS order_number,
    pr.product_key,
    cu.customer_key,
    sls_order_dt    AS order_date, 
    sls_ship_dt     AS shipping_date,
    sls_due_dt      AS due_date,
    sls_sales       AS sales_amount,
    sls_quantity    AS quantity,
    sls_price       AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr 
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customer cu 
    ON sd.sls_cust_id = cu.customer_id;

