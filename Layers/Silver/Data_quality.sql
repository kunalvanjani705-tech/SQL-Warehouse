--Check for nulls or duplicates in primary key
--result Expectations: No Result

select 
    cst_id,
    count(*) as Duplicacy
from bronze.crm_cust_info
group by cst_id
Having 
    count(*) > 1
    or cst_id is NULL

--Check for unwanted Spaces in first name 

select cst_firstname
from bronze.crm_cust_info
where cst_firstname != Trim(cst_firstname)

--we see there are unwanted spaces , we will go and remove all these in our silver layer 


--Check for unwanted Spaces in Last name 

select cst_lastname
from bronze.crm_cust_info
where cst_lastname != Trim(cst_lastname)
--we see there are unwanted spaces , we will go and remove all these in our silver layer 

--Checking for cardanility in Catogorical columns

select Distinct cst_marital_status 
from bronze.crm_cust_info

--we see there are some null values present in our Marital status column, we will replace 
--these with unknown in silver layer

select Distinct cst_gender 
from bronze.crm_cust_info
--we see there are some null values present in our gender column, we will replace 
--these with unknown in silver layer