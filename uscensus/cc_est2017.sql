drop table if exists us_census_demo;
drop table if exists cc_est2017_flex;
create flex table cc_est2017_flex();
COPY cc_est2017_flex FROM '/tmp/cc-est2017-alldata.csv' PARSER fcsvparser();
SELECT COMPUTE_FLEXTABLE_KEYS_AND_BUILD_VIEW('cc_est2017_flex');
CREATE TABLE us_census_demo AS SELECT
stname,
ctyname,
CASE year 
WHEN 1 THEN '4/1/2010 Census population'
WHEN 2 THEN '4/1/2010 population estimates base'
WHEN 3 THEN '7/1/2010 population estimate'
WHEN 4 THEN '7/1/2011 population estimate'
WHEN 5 THEN '7/1/2012 population estimate'
WHEN 6 THEN '7/1/2013 population estimate'
WHEN 7 THEN '7/1/2014 population estimate'
WHEN 8 THEN '7/1/2015 population estimate'
WHEN 9 THEN '7/1/2016 population estimate'
WHEN 10 THEN '7/1/2017 population estimate'
ELSE '' END
AS year,
CASE agegrp 
WHEN 0 THEN 'Total'
WHEN 1 THEN 'Age 0 to 4 years'
WHEN 2 THEN 'Age 5 to 9 years'
WHEN 3 THEN 'Age 10 to 14 years'
WHEN 4 THEN 'Age 15 to 19 years'
WHEN 5 THEN 'Age 20 to 24 years'
WHEN 6 THEN 'Age 25 to 29 years'
WHEN 7 THEN 'Age 30 to 34 years'
WHEN 8 THEN 'Age 35 to 39 years'
WHEN 9 THEN 'Age 40 to 44 years'
WHEN 10 THEN 'Age 45 to 49 years'
WHEN 11 THEN 'Age 50 to 54 years'
WHEN 12 THEN 'Age 55 to 59 years'
WHEN 13 THEN 'Age 60 to 64 years'
WHEN 14 THEN 'Age 65 to 69 years'
WHEN 15 THEN 'Age 70 to 74 years'
WHEN 16 THEN 'Age 75 to 79 years'
WHEN 17 THEN 'Age 80 to 84 years'
WHEN 18 THEN 'Age 85 years or older'
ELSE '' END
AS age_group,
tot_pop,
tot_male,
tot_female
FROM cc_est2017_flex_view
ORDER BY state asc, county asc, year asc, agegrp asc;