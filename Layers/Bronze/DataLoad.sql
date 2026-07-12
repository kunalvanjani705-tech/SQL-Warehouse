CREATE or ALTER Procedure bronze.load_bronze as 
BEGIN
    Declare @start_time Datetime , @end_time Datetime
Begin Try
    print '================================';
    print       'Loading Bronze Layer';
    print '================================';


    print '----------------------------------';
    print 'Loading CRM Tables';
    print '----------------------------------';

    set @start_time = getdate();

    Truncate Table bronze.crm_cust_info

    BULK INSERT bronze.crm_cust_info
    from 'C:\Data WareHouse Project\Data\source_crm\cust_info.csv'
    with(
        firstrow = 2,
        fieldterminator = ',',
        tablock
    );

    Truncate Table bronze.crm_prd_info

    BULK INSERT bronze.crm_prd_info
    from 'C:\Data WareHouse Project\Data\source_crm\prd_info.csv'
    with(
        firstrow = 2,
        fieldterminator = ',',
        tablock
    );

    Truncate Table bronze.crm_sales_details

    BULK INSERT bronze.crm_sales_details
    from 'C:\Data WareHouse Project\Data\source_crm\sales_details.csv'
    with(
        firstrow = 2,
        fieldterminator = ',',
        tablock
    );
        set @end_time = getdate();
        print '>> Load Duration for CRM Tables: '+ cast(Datediff(second, @start_time, @end_time) as Nvarchar) +' seconds'

    print '----------------------------------';
    print 'Loading ERP Tables';
    print '----------------------------------';

    set @start_time = getdate();

    Truncate Table bronze.erp_cust_az12

    BULK INSERT bronze.erp_cust_az12
    from 'C:\Data WareHouse Project\Data\source_erp\cust_az12.csv'
    with(
        firstrow = 2,
        fieldterminator = ',',
        tablock
    );

    Truncate Table bronze.erp_loc_a101

    BULK INSERT bronze.erp_loc_a101
    from 'C:\Data WareHouse Project\Data\source_erp\loc_a101.csv'
    with(
        firstrow = 2,
        fieldterminator = ',',
        tablock
    );

    Truncate Table bronze.erp_px_cat_g1v2

    BULK INSERT bronze.erp_px_cat_g1v2
    from 'C:\Data WareHouse Project\Data\source_erp\px_cat_g1v2.csv'
    with(
        firstrow = 2,
        fieldterminator = ',',
        tablock
);
        set @end_time = getdate();
        print '>> Load Duration for ERP Tables: '+ cast(Datediff(second, @start_time, @end_time) as Nvarchar) +' seconds'
end try 
    begin Catch 
        print '--------------------------------------'
        print 'Error Occured while loading Bronze Layer'
        print 'Error Message'+ ERROR_Message()
        print 'Error Message'+ cast(Error_number() as Nvarchar)
        print 'Error Message'+ cast(Error_state() as Nvarchar)
    end Catch
END