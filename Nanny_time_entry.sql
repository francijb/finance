--//Entry for times worked
--// enty type = 0 -- Hours - Start
--// enty type = 1 -- Hours - End


INSERT INTO raw_nanny_time_entry (entry_date,entry_type,entry_hour) VALUES ('2016-07-18',0,'08:30:00');
INSERT INTO raw_nanny_time_entry (entry_date,entry_type,entry_hour) VALUES ('2016-07-14',0,'08:30:00');
INSERT INTO raw_nanny_time_entry (entry_date,entry_type,entry_hour) VALUES ('2016-07-29',1,'17:30:00');


--//Entry for PTO
/* enty type = 4 -- Vacation
   enty type = 5 -- Sick Day
   enty type = 6 -- Holiday
   enty type = 7 -- Paid Off Day
   enty type = 8 -- Unpaid Day Off

*/
--
--INSERT INTO raw_nanny_pto (entry_date,entry_type,entry_hour) VALUES ('2016-07-01',7,9);
--INSERT INTO raw_nanny_pto (entry_date,entry_type,entry_hour) VALUES ('2016-07-04',6,9);
--INSERT INTO raw_nanny_pto (entry_date,entry_type,entry_hour) VALUES ('2016-07-05',5,3);


//Entry for expenses and credits
// enty type = 2 -- Expenses
// enty type = 3 -- Credit

--INSERT INTO raw_nanny_expenses (entry_date,entry_type,entry_desc,entry_amount) VALUES ('2016-07-16',2,'House Cleaning',80);
INSERT INTO raw_nanny_expenses (entry_date,entry_type,entry_desc,entry_amount) VALUES ('2016-07-22',3,'Rent Payment',333);

SELECT *
FROM fact_nanny_daily
WHERE day_date BETWEEN '2016-04-25' AND '2016-07-30'
;

SELECT week_date
        ,sum(hours_worked) AS hours_worked
        ,sum(vacation_hours) AS vacation_hours
        ,sum(sick_hours) AS sick_hours
        ,sum(holiday_hours) AS holiday_hours
        ,sum(paid_off_hours) AS paid_off_hours       
FROM fact_nanny_daily
WHERE day_date BETWEEN '2016-01-04' AND current_date
GROUP BY 1
;

SELECT CASE WHEN week_date BETWEEN '2016-01-04' AND '2016-01-31' THEN 'January'
            WHEN week_date BETWEEN '2016-02-01' AND '2016-02-28' THEN 'February'
            WHEN week_date BETWEEN '2016-02-29' AND '2016-04-04' THEN 'March'
            WHEN week_date BETWEEN '2016-04-04' AND '2016-05-01' THEN 'April'
            WHEN week_date BETWEEN '2016-05-02' AND '2016-05-29' THEN 'May'
            WHEN week_date BETWEEN '2016-05-30' AND '2016-07-03' THEN 'June'
            WHEN week_date BETWEEN '2016-07-04' AND '2016-07-31' THEN 'July'
            ELSE 'Other' END AS month            
        ,sum(hours)
FROM ( 
        SELECT week_date
                ,(sum(hours_worked)+sum(vacation_hours)+sum(sick_hours)+sum(holiday_hours))-45 AS hours
                ,sum(paid_off_hours) AS paid_off_hours       
        FROM fact_nanny_daily
        WHERE day_date BETWEEN '2016-01-04' AND '2016-07-30'
        GROUP BY 1
        ) a
GROUP BY 1
;
