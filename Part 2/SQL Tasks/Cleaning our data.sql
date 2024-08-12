use md_water_services;
SET SQL_SAFE_UPDATES=0;
		-- ---------------------------------------------
        
        
               -- check emails
SELECT
*,
concat(
	lower(replace(employee_name, ' ','.')),"@ndogowater.gov") as "New Email"
from 
	employee;
    
      -- update employee table with new mail
    
update 
	employee
set
	email = 
concat(
	lower(replace(employee_name, ' ','.')),"@ndogowater.gov");

-- ---------------------------------------------

SELECT
*,

	length(trim(phone_number)),
    length(phone_number)
from 
	employee;
				-- update phone number length

update 
	employee
set
	 phone_number = trim(phone_number);
		-- ---------------------------------------
        
select
	town_name,
    count(employee_name)
from 
	employee
group by 
	town_name;
    
    -- -------------------------------------
		-- number of employees visits
        
    select
		assigned_employee_id,
        count(visit_count) as number_of_visits
        
	from 
		visits
        group by 
			assigned_employee_id
		order by number_of_visits desc
        limit 3;
			-- Top 3 employees visits 
SELECT
	assigned_employee_id,
	employee_name,
	phone_number,
	email
from 
	employee
where
	assigned_employee_id in (1,30,34);










