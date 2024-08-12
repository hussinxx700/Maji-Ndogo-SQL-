use md_water_services; -- use md_water Database

create view Incorrect_records_view as -- Create View that checking the wrong scores by the employess ID 
	Select
			a.location_id,
			v.record_id,
			e.employee_name,
			a.true_water_source_score as audit_score,
			wq.subjective_quality_score as employee_score,
            a.statements 
		from
			auditor_report as a
		join
			visits as v
		on 
			a.location_id = v.location_id
		join
			water_quality as wq
		on
			wq.record_id = v.record_id
		join 
			employee as e
		on
			e.assigned_employee_id = v.assigned_employee_id
		where
			(wq.subjective_quality_score - a.true_water_source_score) != 0
		and 
			v.visit_count = 1; -- end of view
            
	-- //////////////// Select The View
    select * 
		from
			incorrect_records_view; 
																-- //////////////////////////////////////////////////////////// -- 
                                                                
                                                                
            
	-- //// Steps to get the average nubmer by total employees mistakes

with error_count as (    -- Create CTE to Check how many mistakes each employee made from Incorrect_records view
    select                                   
		employee_name,
        count(employee_name) as number_of_mistakes
		from
			Incorrect_records_view
		group by
			employee_name
            ) -- end of error_count CTE
    
    -- //////// selet the CTE
    
	 /*
    select * 
        from error_count
	order by number_of_mistakes;
		-- */	
        
	-- //////////// Now we can get the average nubmer by total employees mistakes
    
    /*
    select 
		avg(number_of_mistakes)
	from
		error_count;
       -- */
        
        
	-- //////////////// Steps to get the Suspect list of employees and thier data
    
    
    
, suspect_list as(      -- Create CTE that retrives the employees that made mistakes above average
    select
		employee_name,
        number_of_mistakes
		from
			error_count
		where
			number_of_mistakes > (select avg(number_of_mistakes) from error_count) 
            )         -- end of suspect_list CTE
            
	-- //////////////////// selet the CTE

		  /*
		select * 
			from suspect_list;
			-- */	
	
    -- //////////////////////// now we can get the Suspect list of employees and thier data 
    
		select
			employee_name,
			location_id,
            statements
		from 
			incorrect_records_view
		where 
			employee_name in (select employee_name from suspect_list)
			-- and location_id in ('AkRu04508', 'AkRu07310', 'KiRu29639', 'AmAm09607')    -- filter records by spacific location id
			-- and statements like "%cash%"                                              -- Filter recored by word "Cash" in statements
            
	-- //////////////////////////// check if another employees menthion word "Cash" in their statement outside the suspect list 
														-- (Empety List) No other employees suspected
    
    /*
    select 
				employee_name
			from 
				incorrect_records_view
            where 
				employee_name not in (select employee_name from suspect_list) 
            and 
				statements like "%cash%";
	-- */ 
			
				
		
										
							

        














