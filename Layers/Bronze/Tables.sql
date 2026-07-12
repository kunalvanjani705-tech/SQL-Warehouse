if OBJECT_ID('bronze.crm_cust_info', 'U') is Not Null
    drop Table bronze.crm_cust_info

CREATE TABLE bronze.crm_cust_info(
    cst_id int,
    cst_key nvarchar(50),
    cst_firstname nvarchar(50),
    cst_lastname nvarchar(50),
    cst_marital_status nvarchar(50),
    cst_gender nvarchar(50),
    cst_create_date date,
);

if OBJECT_ID('bronze.crm_prd_info', 'U') is Not Null
    drop Table bronze.crm_prd_info

create table bronze.crm_prd_info(
    prd_id int,
    prd_key nvarchar(50),
    prd_name nvarchar(50),
    prd_cost int,
    prd_line nvarchar(50),
    prd_start_date date,
    prd_end_date date
);

if OBJECT_ID('bronze.crm_sales_details', 'U') is Not Null
    drop Table bronze.crm_sales_details

create table bronze.crm_sales_details(
    sls_ord_num nvarchar(20),
    sls_prd_key nvarchar(50),
    sls_cust_id int,
    sls_order_dt int,
    sls_ship_dt int,
    sls_due_dt int,
    sls_sales int,
    sls_quantity int,
    sls_price int
);

if OBJECT_ID('bronze.erp_cust_az12', 'U') is Not Null
    drop Table bronze.erp_cust_az12

create table bronze.erp_cust_az12(
    cid nvarchar(50),
    bdate Date,
    gen nvarchar(50)
);

if OBJECT_ID('bronze.erp_loc_a101', 'U') is Not Null
    drop Table bronze.erp_loc_a101

create table bronze.erp_loc_a101(
    cid nvarchar(50),
    cntry nvarchar(50)
);

if OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') is Not Null
    drop Table bronze.erp_px_cat_g1v2

create table bronze.erp_px_cat_g1v2(
    id nvarchar(50),
    cat nvarchar(50),
    subcat nvarchar(50),
    maintenance nvarchar(50)
);
