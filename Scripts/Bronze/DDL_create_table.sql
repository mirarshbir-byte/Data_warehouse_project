/***********************************************************************************************
    Author      : Arsh
    Created On  : 2025-08-19
    Purpose     : Create Bronze Layer tables in the data warehouse.
    
    Description :
        - This script creates all required tables in the Bronze Layer.
        - Drops the table if it already exists to ensure a clean creation.
        - Table names reflect source system and domain (CRM/ERP).
        - Columns and data types match the CSV source files.
        - Designed for ETL procedures like [bronze].[load_bronze].

***********************************************************************************************/

------------------------------------------------------------
-- CRM Tables
------------------------------------------------------------

-- Customer Info
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);
GO

-- Product Info
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost NVARCHAR(50),
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);
GO

-- Sales Details
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(20),
    sls_prd_key NVARCHAR(20),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);
GO

------------------------------------------------------------
-- ERP Tables
------------------------------------------------------------

-- ERP Customer AZ12
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
    CID NVARCHAR(50),
    BDATE DATE,
    GEN NVARCHAR(10)
);
GO

-- ERP Location A101
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101 (
    CID NVARCHAR(20),
    CNTRY NVARCHAR(20)
);
GO

-- ERP Price Category G1V2
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2 (
    ID NVARCHAR(20),
    CAT NVARCHAR(20),
    SUBCAT NVARCHAR(20),
    MAINTENANCE NVARCHAR(10)
);
GO
