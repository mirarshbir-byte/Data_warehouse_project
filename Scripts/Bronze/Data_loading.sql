/***********************************************************************************************
    Author      : Arsh
    Created On  : 2025-08-19
    Object      : Stored Procedure [bronze].[load_bronze]
    Purpose     : Load CSV files into Bronze Layer tables using BULK INSERT.
    
    Description :
        - This procedure performs the following actions:
            1. Truncates the existing bronze layer tables to avoid duplicate data.
            2. Loads data from multiple CSV files using BULK INSERT.
            3. Logs progress messages for each step.
            4. Tracks load duration for each table and overall batch.
            5. Implements basic error handling using TRY...CATCH.

    Features:
        - BULK INSERT with FIRSTROW, FIELDTERMINATOR, and TABLOCK for performance.
        - Execution time calculation using GETDATE() and DATEDIFF().
        - Error capture with ERROR_MESSAGE(), ERROR_NUMBER(), and ERROR_STATE().

***********************************************************************************************/

CREATE OR ALTER PROCEDURE [bronze].[load_bronze]
AS
BEGIN
    DECLARE @start_time DATETIME, 
            @end_time DATETIME, 
            @batch_start_time DATETIME, 
            @batch_end_time DATETIME;

    BEGIN TRY
        PRINT '==============================================';
        PRINT '   Starting Bronze Layer Data Load';
        PRINT '==============================================';

        SET @batch_start_time = GETDATE();

        ------------------------------------------------------------
        -- CRM Tables Load
        ------------------------------------------------------------
        PRINT '----------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '----------------------------------------------';

        -- Load CRM Customer Info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Loading Table : bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\mir70\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '*********************************';

        -- Load CRM Product Info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Loading Table : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\mir70\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '*********************************';

        -- Load CRM Sales Details
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Loading Table : bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\mir70\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '*********************************';

        ------------------------------------------------------------
        -- ERP Tables Load
        ------------------------------------------------------------
        PRINT '----------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '----------------------------------------------';

        -- Load ERP Customer Data
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Loading Table : bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\mir70\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '*********************************';

        -- Load ERP Location Data
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Loading Table : bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\mir70\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '*********************************';

        -- Load ERP Price Category Data
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Loading Table : bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\mir70\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '*********************************';

        ------------------------------------------------------------
        -- Batch Summary
        ------------------------------------------------------------
        SET @batch_end_time = GETDATE();
        PRINT '>> Total Batch Duration : ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '==============================================';
        PRINT '   Bronze Layer Data Load Completed';
        PRINT '==============================================';

    END TRY

    BEGIN CATCH
        PRINT '==========================================';
        PRINT '   ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State  : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==========================================';
    END CATCH
END;

