use md_water_services; -- use md_water Database

select 
	location_id,
    true_water_source_score
from
	auditor_report;
    
    -- //////////////////////////////////// check locations and water scores from boths tables (visits and auditor)
    
    Select
		a.location_id as audit_location,
        a.true_water_source_score,
        v.location_id as visit_location,
        v.record_id,
        wq.subjective_quality_score
	from
		auditor_report as a
	join
		visits as v
	on 
		a.location_id = v.location_id
	join
		water_quality as wq
	on
		wq.record_id = v.record_id;
    
    -- /////////////////////////////////////// minimalize the last query for better view
    
     Select
		a.location_id,
        v.record_id,
        a.true_water_source_score as audit_score,
        wq.subjective_quality_score as employee_score
	from
		auditor_report as a
	join
		visits as v
	on 
		a.location_id = v.location_id
	join
		water_quality as wq
	on
		wq.record_id = v.record_id;
        
-- //////////////////////////////////////////////. All true records that auditor checked 94% is true 1518 rows // but 102 rows were false

Select
		a.location_id,
        v.record_id,
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
	where
		(wq.subjective_quality_score - a.true_water_source_score) = 0
	and 
		v.visit_count = 1;
        
-- ////////////////////////////////////// The wrong records 102 rows

Select
		a.location_id,
        v.record_id,
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
	where
		(wq.subjective_quality_score - a.true_water_source_score) != 0
	and 
		v.visit_count = 1;
        
-- ////////////////////////////////////// Check the Type of water sources accuarcy

Select
		a.location_id,
        v.record_id,
        a.type_of_water_source as auditor_source,
        ws.type_of_water_source as survey_source,
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
		water_source as ws
	on
		v.source_id = ws.source_id
	where
		(wq.subjective_quality_score - a.true_water_source_score) != 0
	and 
		v.visit_count = 1; -- there is no changes it is all clean here

        

		
        
    