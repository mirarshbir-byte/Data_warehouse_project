/*
=============================================================
 Author      : Arsh
 Created On  : 2025-08-22
 Description : DDL script to create Silver Layer tables for
               CRM and ERP data in the Data Warehouse.
               Includes:
                 - CRM Customer Info
                 - CRM Product Info
                 - CRM Sales Details
                 - ERP Customer AZ12
                 - ERP Location A101
                 - ERP Price Category G1V2
 Database    : Datawarehouse
 Schema      : silver
=============================================================
 Change Log:
 Date        Author        Description
 ----------  ------------  ----------------------------------
 2025-08-22  Your Name     Initial version
=============================================================
*/


IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;

CREATE TABLE silver.crm_cust_info (
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
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;

CREATE TABLE silver.crm_prd_info (
    prd_id INT,
    cat_id nvarchar(50),
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost NVARCHAR(50),
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    dwh_create_date datetime2 default getdate()
);
GO

-- Sales Details
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;

CREATE TABLE silver.crm_sales_details (
    sls_ord_num NVARCHAR(20),
    sls_prd_key NVARCHAR(20),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT, 	
	dwh_create_date datetime2 default getdate()
);
GO

------------------------------------------------------------
-- ERP Tables
------------------------------------------------------------

-- ERP Customer AZ12
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;

CREATE TABLE silver.erp_cust_az12 (
    CID NVARCHAR(50),
    BDATE DATE,
    GEN NVARCHAR(10)
);
GO

-- ERP Location A101
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;

CREATE TABLE silver.erp_loc_a101 (
    CID NVARCHAR(20),
    CNTRY NVARCHAR(20)
);
GO

-- ERP Price Category G1V2
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;

CREATE TABLE silver.erp_px_cat_g1v2 (
    ID NVARCHAR(20),
    CAT NVARCHAR(20),
    SUBCAT NVARCHAR(20),
    MAINTENANCE NVARCHAR(10)
);
GO

