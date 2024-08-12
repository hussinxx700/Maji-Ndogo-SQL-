use md_water_services; -- use database


		-- Joinig Location, Water Source and Well Pollution Tables via Visits Table 

-- CREATE VIEW combined_analysis_table AS    -- Create a view for this query 
      
	select 
		l.province_name,
		l.town_name,
		-- v.visit_count,
		-- v.location_id,
		ws.type_of_water_source,
		ws.number_of_people_served,
		l.location_type,
		v.time_in_queue,
		wp.results
	from
		location as l
	join                                  -- join Location with Visits
		visits as v 
	on l.location_id = v.location_id
		
	join                                  -- join Water Source and Vistis
		water_source as ws
	on v.source_id = ws.source_id
		
	left join                             -- Left join Well Pollution with Visits
		well_pollution as wp
	on v.source_id = wp.source_id
		
	where
		v.visit_count = 1; -- end of query
        
        

        

    
    





	