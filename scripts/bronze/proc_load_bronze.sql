/*Stored Procedure: Carregar Bronze Layer (Source -> Bronze)
Essa stored procedure carrega dados de arquivos .csv dentro do esquema 'bronze' e coleta o tempo que demora para fazer cada uma das tabelas e de toda a procedure
Ela usa o Truncate para apagar todos os dados já inseridos e depois faz um BULK INSERT dentro das tabelas no esquema bronze

Para usar: 
EXEC bronze.load_bronze;

*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_procedure DATETIME , @end_time_procedure DATETIME
	BEGIN TRY
	SET @start_time_procedure = GETDATE();
		PRINT '=========================================================';
		PRINT 'Carregando Bronze Layer';
		PRINT '=========================================================';

		PRINT '---------------------------------------------------------';
		PRINT 'Carregando CRM Tables'
		PRINT '---------------------------------------------------------';

		
		SET @start_time = GETDATE();
		PRINT 'Trucating tabela: bronze.crm_cust_info '
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT 'Inserindo na tabela: bronze.crm_cust_info '
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\dalom.BRASISAL\OneDrive\Estudos\MyWarehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' seconds'
		PRINT '----------';


		SET @start_time = GETDATE();
		PRINT 'Trucating tabela: bronze.crm_prd_info '
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT 'Inserindo na tabela: crm_prd_info '
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\dalom.BRASISAL\OneDrive\Estudos\MyWarehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' seconds'
		PRINT '----------';

		SET @start_time = GETDATE();
		PRINT 'Trucating tabela: bronze.crm_sales_details '
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT 'Inserindo na tabela: bronze.crm_sales_details '
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\dalom.BRASISAL\OneDrive\Estudos\MyWarehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' seconds'
		PRINT '----------';


		PRINT '---------------------------------------------------------';
		PRINT 'Carregando ERP Tables'
		PRINT '---------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT 'Trucating tabela: bronze.crm_sales_details '
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT 'Inserindo na tabela: bronze.crm_sales_details '
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\dalom.BRASISAL\OneDrive\Estudos\MyWarehouse\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' seconds'
		PRINT '----------';

		SET @start_time = GETDATE();
		PRINT 'Trucating tabela: bronze.erp_loc_a101 '
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT 'Inserindo na tabela: bronze.erp_loc_a101 '
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\dalom.BRASISAL\OneDrive\Estudos\MyWarehouse\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' seconds'
		PRINT '----------';

		SET @start_time = GETDATE();
		PRINT 'Trucating tabela: bronze.erp_px_cat_g1v2 '
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT 'Inserindo na tabela: bronze.erp_px_cat_g1v2 '
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\dalom.BRASISAL\OneDrive\Estudos\MyWarehouse\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' seconds'
		PRINT '----------';
		SET @end_time_procedure = GETDATE();
		PRINT '>> Load Duration all procedure: ' + CAST(DATEDIFF(second, @start_time_procedure, @end_time_procedure)AS NVARCHAR) + ' seconds'
		PRINT '----------';
	END TRY

	BEGIN CATCH
		PRINT '================================'
		PRINT 'Erro durante o carregamento da Bronze Layer'
		PRINT 'Error Message' + ERROR_MESSAGE()
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS VARCHAR)

		PRINT '================================'
	END CATCH
END
