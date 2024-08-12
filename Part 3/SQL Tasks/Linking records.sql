use md_water_services; -- use md_water Database



-- ////////////////// check the wrong scores by the employess Name

Select
		a.location_id,
        v.record_id,
        -- e.assigned_employee_id,
        e.employee_name,
        a.true_water_source_score as audit_score,
        wq.subjective_quality_score as employee_score
        -- (wq.subjective_quality_score - a.true_water_source_score) as Diff_score
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
		v.visit_count = 1;
        
	-- ////////////////////////
   
   with Incorrect_records as ( -- //////////////////////////// Create a CTE for The last query
   
	   Select
			a.location_id,
			v.record_id,
			-- e.assigned_employee_id,
			e.employee_name,
			a.true_water_source_score as audit_score,
			wq.subjective_quality_score as employee_score
			-- (wq.subjective_quality_score - a.true_water_source_score) as Diff_score
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
			v.visit_count = 1
        ) -- end of the CTE
        
	select                                   -- Check how many mistakes each employee made
		distinct employee_name,
        count(employee_name)
		from
			Incorrect_records
		group by
			employee_name;
            
	
        
        
        
        
        
        
        
        
        
        
        