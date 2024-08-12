use md_water_services; -- use database

-- drop table Project_progress;
CREATE TABLE Project_progress ( -- Create Table for the improvement plan
Project_id SERIAL PRIMARY KEY,
source_id VARCHAR(20) NOT NULL REFERENCES water_source(source_id) ON DELETE CASCADE ON UPDATE CASCADE, 
Address VARCHAR(50), 
Town VARCHAR(30),
Province VARCHAR(30),
Source_type VARCHAR(50),
Improvement VARCHAR(50), 	-- What the engineers should do at that place
Source_status VARCHAR(50) DEFAULT 'Backlog' CHECK (Source_status IN ('Backlog', 'In progress', 'Complete')),
/* Source_status −− We want to limit the type of information engineers can give us, so we limit Source_status.
− By DEFAULT all projects are in the "Backlog" which is like a TODO list.
− CHECK() ensures only those three options will be accepted. This helps to maintain clean data.
*/
Date_of_completion DATE, 	-- Engineers will add this the day the source has been upgraded.
Comments TEXT 				-- Engineers can leave comments. We use a TEXT type that has no limit on char length
);

							-- ///////////////////////////////////// Collect data We need /////////////////////////////////////
                            
                            
INSERT INTO Project_progress (Address, Town, Province, source_id, Source_type, Improvement)

SELECT
    location.address,
    location.town_name,
    location.province_name,
    water_source.source_id,
    water_source.type_of_water_source,
    
    CASE
		WHEN well_pollution.results = 'Contaminated: Biological' 
			THEN 'Install UV filter and Install RO filter'
            
		WHEN well_pollution.results = 'Contaminated: Chemical'
			THEN 'Install RO filter'
            
		WHEN water_source.type_of_water_source = 'river'
			THEN 'Drill well'
            
		WHEN water_source.type_of_water_source = 'shared_tap'
			THEN CONCAT('Install', FlOOR(visits.time_in_queue / 30), 'Tabs Nearby')
            
		WHEN water_source.type_of_water_source = 'tap_in_home_broken'
			THEN 'Diagnose local infrastructure'
		ElSE NULL END
			
FROM
    water_source
    
LEFT JOIN well_pollution
	 ON water_source.source_id = well_pollution.source_id
     
INNER JOIN visits
	 ON water_source.source_id = visits.source_id
     
INNER JOIN location
	 ON location.location_id = visits.location_id
     
WHERE 									-- Collect The Data Based on these Condations 
	visits.visit_count = 1
AND
	(
		well_pollution.results != 'Clean'
	OR
		water_source.type_of_water_source IN ('tap_in_home_broken', 'river')
	OR
		(water_source.type_of_water_source = 'shared_tap' AND visits.time_in_queue >= 30)
    );
    


    
 select * from Project_progress -- where Improvement = 'Install UV filter and Install RO filter'		-- View Table





