
--Standerdizing crm.cust_info table and loading it into silver layer 

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

