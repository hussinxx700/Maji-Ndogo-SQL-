use md_water_services;
-- SET SQL_SAFE_UPDATES=0;
		-- ---------------------------------------------
        -- Rank Total people served per type
select         
	type_of_water_source,
	round(sum(number_of_people_served)) as Total_number_of_Served_people,
	round(sum(number_of_people_served) / 27628140 *100) as Pct_of_people_served,
    rank() over( order by round(sum(number_of_people_served))desc ) as "Rank"
	from
		water_source
	where 
		type_of_water_source != 'tap_in_home'
	group by
		type_of_water_source;

		-- ---------------------------------------------
        
select
	*,
    row_number() over (partition by type_of_water_source  order by number_of_people_served desc) as priority_rank
from 
	water_source
where 
		type_of_water_source != 'tap_in_home';
















