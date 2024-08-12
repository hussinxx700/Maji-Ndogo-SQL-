use md_water_services;
-- SET SQL_SAFE_UPDATES=0;
		-- ---------------------------------------------
select 
	*
from 
	location;
		-- -------------------------------
        -- How many town recorded
select
	town_name,
    count(location_id) as rec_per_town
from
	location
group by
	town_name
order by rec_per_town desc;
    
    -- -------------------------
    -- How many province recorded
		
    select
	province_name,
    count(location_id) as rec_per_province
from
	location
group by
	province_name
order by rec_per_province desc;
		 
	-- --------------------------
		-- How many town at province recorded
	select
    province_name,
    town_name,
    count(location_id) as rec_per_town
from
	location
group by
	province_name, town_name
order by province_name, rec_per_town desc;

		-- How many location type recorded
        
select
	location_type,
    count(location_id) as rec_per_location_type,
    count(location_id) / (15910 + 23740) * 100 as pct
	
from
	location
group by
	location_type
order by location_type desc;

			-- -------------------------------
            
            
            

            











