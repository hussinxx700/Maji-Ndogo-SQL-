use md_water_services;
-- SET SQL_SAFE_UPDATES=0;
		-- ---------------------------------------------
select 
	*
from 
	water_source;

		-- ---------------------------------------------
			-- How many people did we survey in total?
select
	sum(number_of_people_served)
from
	water_source;

		-- ---------------------------------------------
        -- how mant types of water sourcces 
        
	select 
		type_of_water_source,
        count(source_id) as number_of_types
	from
		water_source
	group by
		type_of_water_source;
        -- ---------------------------------------------
        -- average number of people that are served by each water source
        
select 
		type_of_water_source,
        round(avg(number_of_people_served)) as AVG_number_of_Served_people
	from
		water_source
	group by
		type_of_water_source;
        
         -- ---------------------------------------------
         -- how many people served per each type and percentage

select         
	type_of_water_source,
        round(sum(number_of_people_served)) as Total_number_of_Served_people,
        round(sum(number_of_people_served) / 27628140 *100) as Pct_of_people_served
	from
		water_source
	group by
		type_of_water_source
	order by
		Total_number_of_Served_people desc;
        
        
        
        
        
        
        
        
        
        
        