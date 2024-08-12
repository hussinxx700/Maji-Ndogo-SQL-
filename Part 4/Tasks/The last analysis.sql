use md_water_services; -- use database


					-- /////////////////////////////////////////////////////////  PROVINCE  /////////////////////////////////////////////////////////


  -- CREATE TEMPORARY TABLE Province_aggregated_water_access
with province_totals as ( -- This CTE calculates the population of each province

	Select
		province_name,
		sum(number_of_people_served) as total_ppl_serv
	from 
		combined_analysis_table
	group by
		province_name
		) 								-- end of CTE
    
   -- Select * from province_totals;    -- The CTE view 
    
select  								-- calculate percentages of population for each type of source in eah province
	ct.province_name,
    
		-- These case statements create columns that calculate percentages of population for each type of source and the results are aggregated
	round((sum(case 
				when type_of_water_source = 'river'
					then number_of_people_served 
						else 0 end ) * 100.0 / pt.total_ppl_serv), 0) as River,
	round((sum(case 
				when type_of_water_source = 'shared_tap'
					then number_of_people_served
						else 0 end ) * 100.0 / pt.total_ppl_serv), 0) as Shared_Tab,
	round((sum(case
				when type_of_water_source = 'tap_in_home'
					then number_of_people_served 
						else 0 end ) * 100.0 / pt.total_ppl_serv), 0) as Tab_In_Home,
	round((sum(case
				when type_of_water_source = 'tap_in_home_broken'
					then number_of_people_served 
						else 0 end ) * 100.0 / pt.total_ppl_serv), 0) as Tab_In_Home_Broken,
	round((sum(case
				when type_of_water_source = 'well'
					then number_of_people_served 
						else 0 end ) * 100.0 / pt.total_ppl_serv), 0) as Well
from
	combined_analysis_table as ct
	
join 
	province_totals as pt
on ct.province_name = pt.province_name

group by 
	ct.province_name
order by 
	ct.province_name; 									-- end of query
    
-- select * from Province_aggregated_water_access;  	-- The Temp Table View
    
    
					-- /////////////////////////////////////////////////////////  TOWN  /////////////////////////////////////////////////////////
            
    
-- CREATE TEMPORARY TABLE town_aggregated_water_access   -- Create a Temporaray Table 
with Town_totals as ( 									 -- This CTE calculates the population of each province

	Select
		province_name,
		Town_name,
		sum(number_of_people_served) as total_ppl_serv
	from 
		combined_analysis_table
	group by
		province_name, Town_name
	order by province_name
		) -- end of CTE 
    
-- Select * from Town_totals;   -- The CTE view 

select  												 -- calculate percentages of population for each type of source in each Town
	ct.province_name,
    ct.town_name,
    
		-- These case statements create columns that calculate percentages of population for each type of source and the results are aggregated
	round((sum(case 
				when type_of_water_source = 'river'
					then number_of_people_served 
						else 0 end ) * 100.0 / tt.total_ppl_serv), 0) as River,
	round((sum(case 
				when type_of_water_source = 'shared_tap'
					then number_of_people_served
						else 0 end ) * 100.0 / tt.total_ppl_serv), 0) as Shared_Tab,
	round((sum(case
				when type_of_water_source = 'tap_in_home'
					then number_of_people_served 
						else 0 end ) * 100.0 / tt.total_ppl_serv), 0) as Tab_In_Home,
	round((sum(case
				when type_of_water_source = 'tap_in_home_broken'
					then number_of_people_served 
						else 0 end ) * 100.0 / tt.total_ppl_serv), 0) as Tab_In_Home_Broken,
	round((sum(case
				when type_of_water_source = 'well'
					then number_of_people_served 
						else 0 end ) * 100.0 / tt.total_ppl_serv), 0) as Well
from
	combined_analysis_table as ct
	
join 
	Town_totals as tt
on ct.province_name = tt.province_name and ct.town_name = tt.town_name

group by 
	ct.province_name, ct.town_name
   -- having Province_name = 'Amanzi'
order by 
	 ct.province_name, ct.town_name ;
	-- river desc; 
    -- Tab_In_Home_Broken desc;
    -- Shared_tab desc; 								-- end of query
        

-- select * from town_aggregated_water_access;  		-- The Temp Table View
  
  
SELECT 													--  Calculate the percentage of borken Tabs 
	province_name,
	town_name,
	ROUND(Tab_In_Home_Broken / (Tab_In_Home_Broken + Tab_In_Home) * 100,0) AS Pct_broken_taps
FROM
	town_aggregated_water_access;
  
  

 

    
    
    
    
   


    


    
    
    

        

    
		
					
                    
		
    



