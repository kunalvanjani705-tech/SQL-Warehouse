/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

--Standerdizing crm.cust_info table and loading it into silver layer 
print '-------------------------------------'
print '>>>> Truncating Table silver.crm_cust_info <<<<'
print '-------------------------------------'
Truncate Table silver.crm_cust_info

PRINT '>> Inserting Data Into: silver.crm_cust_info';
Insert into silver.crm_cust_info (
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gender,
    cst_create_date
    )
select 
    cst_id,
    cst_key,
    Trim(cst_firstname) as cst_firstname,
    Trim(cst_lastname) as cst_lastname,
    Case 
        when Upper(Trim(cst_marital_status)) ='M' then 'Married'
        when Upper(Trim(cst_marital_status)) ='S' then 'Single'
        else 'Unknown'
    end as cst_marital_status ,
    Case 
        when Upper(Trim(cst_gender)) ='M' then 'Male'
        when Upper(Trim(cst_gender)) ='F' then 'Female'
        else 'Unknown'
    end as cst_gender ,
    cst_create_date

from(
    select *,
    row_number() Over(Partition by cst_id Order by cst_create_date) as flag_last
    from bronze.crm_cust_info
    where cst_id is Not Null
)t 
where flag_last = 1

--Standerdizing the crm_prd_info table and loading it into silver layer 

print '-------------------------------------'
print '>>>> Truncating Table Silver.crm_prd_info <<<<'
print '-------------------------------------'
Truncate Table Silver.crm_prd_info

PRINT '>> Inserting Data Into: Silver.crm_prd_info';
insert into Silver.crm_prd_info(
    prd_id,
    cat_id,
    prd_key,
    prd_name,
    prd_cost,
    prd_line,
    prd_start_date,
    prd_end_date
)
select 
    prd_id,
    replace(SUBSTRING(prd_key, 1,5),'-','_') as cat_id,
    SUBSTRING(prd_key,7, LEN(prd_key)) as prd_key ,
    prd_name,
    isnull(prd_cost, 0) as prd_cost,
case upper(trim(prd_line))
    when 'M' then 'Mountain'
    when 'R' then 'Road'
    when 'T' then 'Touring'
    when 'S' then 'Other Sales'
    else 'Unknown'
end as prd_line,
    prd_start_date ,
    DATEADD(Day, -1, lead(prd_start_date) Over(PARTITION BY prd_key Order by prd_start_date))  as prd_end_date
from bronze.crm_prd_info

