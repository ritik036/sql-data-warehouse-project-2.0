/*
============================================================================================

Stored Procedure: Load Bronze Layer (Source -> Bronze)

============================================================================================

Script Purpose:

    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:

    - Truncates the bronze tables before loading data.

    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.


Parameters:

    None.

    This stored procedure does not accept any parameters or return any values.


Usage Example:

    EXEC bronze.load_bronze;

============================================================================================
*/



create or alter procedure bronze.load_bronze as 
begin 
	declare @start_time datetime, @end_time datetime;
	begin try 
		print '================================='
		print ' loading bronze layer '
		print '================================='


		set @start_time = getdate();
		print ' ========= loading CRM tables ==========' 
		truncate table bronze.crm_cust_info;
		bulk insert bronze.crm_cust_info
		from 'C:\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);

		truncate table bronze.crm_prd_info 
		bulk insert bronze.crm_prd_info
		from 'C:\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2, 
			fieldterminator = ',',
			tablock
			);

		truncate table bronze.crm_sales_details
		bulk insert bronze.crm_sales_details 
		from 'C:\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2, 
			fieldterminator = ',',
			tablock
			);
		print ' ===== CRM LOADING DONE =========='
		PRINT ' =================================' 

		PRINT ' ===========LOADING ERP TABLES ================ '

		truncate table bronze.erp_cust_az12
		bulk insert bronze.erp_cust_az12 
		from 'C:\datasets\source_erp\cust_az12.csv'
		with (
			firstrow = 2, 
			fieldterminator = ',',
			tablock
			);

		truncate table bronze.erp_loc_a101
		bulk insert bronze.erp_loc_a101
		from 'C:\datasets\source_erp\loc_a101.csv'
		with (
			firstrow = 2, 
			fieldterminator = ',',
			tablock
			);

		truncate table bronze.erp_px_cat_g1v2 
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\datasets\source_erp\px_cat_g1v2.csv'
		with (
			firstrow = 2, 
			fieldterminator = ',',
			tablock
			);
			PRINT '=====================LOADING ERP TABLES DONE ================='
			PRINT ' =========== LOADING BRONZE LAYER DONE ======================='
			PRINT '=============================================================='
			set @end_time = getDate();
			print '>> loading time duration : ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds'
	end try 
	begin catch
		print '============ERROR OCCURED ====================='
		PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==============================================='
	end catch
end;


