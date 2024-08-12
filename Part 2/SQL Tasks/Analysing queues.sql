use md_water_services;
-- SET SQL_SAFE_UPDATES=0;
		-- ---------------------------------------------

select
	*
from
	visits;
  
    		-- ---------------------------------------------
				-- how long the survey took
                
select
    min(time_of_record) as first_check,
    max(time_of_record) as last_check,
	DATEDIFF(max(time_of_record), min(time_of_record)) as time_period
from
	visits;
			-- ---------------------------------------------
				-- average time in queue

select
	
    round (avg((nullif(time_in_queue, 0 )))) as Avg_Time_queue
from
	visits;
    
			-- ---------------------------------------------
				-- average time in queue by the day of the week
select
	dayname(time_of_record) as day_of_the_week,
	round (avg((nullif(time_in_queue, 0 )))) as Avg_Time_queue
from
	visits
group by 
	day_of_the_week;
			
            -- ---------------------------------------------
				-- average time in queue by the hour of the day
select
	time_format(time(time_of_record),'%H:00')  as hour_of_the_week,
	round (avg((nullif(time_in_queue, 0 )))) as Avg_Time_queue
from
	visits
group by 
	hour_of_the_week;


			-- ---------------------------------------------
				-- pivot table test
	
SELECT
TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
DAYNAME(time_of_record) as day_name,
CASE
WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
ELSE NULL END AS Sunday
FROM
visits
WHERE
time_in_queue != 0; 

			-- ---------------------------------------
				-- pivot table (the average of time queue at the hour of the day )
                
                
SELECT
TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
-- Sunday 
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue ELSE NULL
END
),0) AS Sunday,
-- Monday 
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue ELSE NULL
END
),0) AS Monday,
    -- Tuesday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Tuesday' THEN time_in_queue ELSE NULL
END
),0) AS Tuesday,
    -- Wednesday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Wednesday' THEN time_in_queue ELSE NULL
END
),0) AS Wednesday,
	-- Thursday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Thursday' THEN time_in_queue ELSE NULL
END
),0) AS Thursday,
	-- Friday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Friday' THEN time_in_queue ELSE NULL
END
),0) AS Friday,
	-- Saturday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Saturday' THEN time_in_queue ELSE NULL
END
),0) AS Saturday
FROM
	visits
WHERE
    time_in_queue != 0 -- this excludes other sources with 0 queue times
GROUP BY
	hour_of_day
ORDER BY
    hour_of_day;
    
    					-- --------------------------------------

    