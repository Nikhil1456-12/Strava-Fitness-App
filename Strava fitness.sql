USE fitness_project;
CREATE TABLE daily_activity (
    Id BIGINT,
    ActivityDay VARCHAR(20),
    TotalSteps INT,
    TotalDistance FLOAT,
    TrackerDistance FLOAT,
    LoggedActivitiesDistance FLOAT,
    VeryActiveDistance FLOAT,
    ModeratelyActiveDistance FLOAT,
    LightActiveDistance FLOAT,
    SedentaryActiveDistance FLOAT,
    VeryActiveMinutes INT,
    FairlyActiveMinutes INT,
    LightlyActiveMinutes INT,
    SedentaryMinutes INT,
    Calories INT
);
UPDATE daily_activity
SET ActivityDay = STR_TO_DATE(ActivityDay,'%m/%d/%Y');

ALTER TABLE daily_activity
MODIFY ActivityDay DATE;

SELECT * FROM daily_activity LIMIT 10;

SET SQL_SAFE_UPDATES = 0;

## remove Duplicates
DELETE d1
FROM daily_activity d1
JOIN daily_activity d2
ON d1.Id = d2.Id
AND d1.ActivityDay = d2.ActivityDay
AND d1.TotalSteps = d2.TotalSteps
AND d1.Calories = d2.Calories
AND d1.Id > d2.Id;

## checking of null values
SELECT *
FROM daily_activity
WHERE Id IS NULL
OR ActivityDay IS NULL;

## checking zero values
SELECT
COUNT(*) AS total_rows,
SUM(CASE WHEN SedentaryActiveDistance = 0 THEN 1 ELSE 0 END) AS zero_sedentary,
SUM(CASE WHEN LoggedActivitiesDistance = 0 THEN 1 ELSE 0 END) AS zero_logged
FROM daily_activity;

CREATE TABLE daily_calories(
    Id BIGINT,
    ActivityDay VARCHAR(20),
    Calories INT
);

UPDATE daily_calories
SET ActivityDay = STR_TO_DATE(ActivityDay,'%m/%d/%Y');

ALTER TABLE daily_calories
MODIFY ActivityDay DATE;

## removing of zero calories
DELETE FROM daily_calories
WHERE Calories = 0;

##Check duplicates
SELECT Id,ActivityDay,COUNT(*)
FROM daily_calories
GROUP BY Id,ActivityDay
HAVING COUNT(*) > 1;

CREATE TABLE daily_intensities (
    Id BIGINT,
    ActivityDay VARCHAR(20),
    SedentaryMinutes INT,
    LightlyActiveMinutes INT,
    FairlyActiveMinutes INT,
    VeryActiveMinutes INT,
    SedentaryActiveDistance FLOAT,
    LightActiveDistance FLOAT,
    ModeratelyActiveDistance FLOAT,
    VeryActiveDistance FLOAT
);

UPDATE daily_intensities
SET ActivityDay = STR_TO_DATE(ActivityDay,'%m/%d/%Y');

ALTER TABLE daily_intensities
MODIFY ActivityDay DATE;

##Remove Duplicates
DELETE d1
FROM daily_intensities d1
JOIN daily_intensities d2
ON d1.Id = d2.Id
AND d1.ActivityDay = d2.ActivityDay
AND d1.Id > d2.Id;

##Checking Null values
SELECT *
FROM daily_intensities
WHERE Id IS NULL
OR ActivityDay IS NULL;

CREATE TABLE daily_steps(
Id BIGINT,
ActivityDay varchar(20),
StepTotal INT
);

UPDATE daily_steps
SET ActivityDay = STR_TO_DATE(ActivityDay,'%m/%d/%Y');

ALTER TABLE daily_steps
MODIFY ActivityDay DATE;

##Remove Duplicates
DELETE d1
FROM daily_steps d1
JOIN daily_steps d2
ON d1.Id = d2.Id
AND d1.ActivityDay = d2.ActivityDay
AND d1.Id > d2.Id;

CREATE TABLE hourly_calories (
    Id BIGINT,
    ActivityHour VARCHAR(50),
    Calories INT
);

UPDATE hourly_calories
SET ActivityHour = STR_TO_DATE(ActivityHour,'%m/%d/%Y %h:%i:%s %p');

ALTER TABLE hourly_calories
MODIFY ActivityHour DATETIME;

DELETE d1
FROM hourly_calories d1
JOIN hourly_calories d2
ON d1.Id = d2.Id
AND d1.ActivityHour = d2.ActivityHour
AND d1.Id > d2.Id;
 
 CREATE TABLE hourly_steps(
Id BIGINT,
ActivityHour varchar(50),
StepTotal INT
);

UPDATE hourly_steps
SET ActivityHour = STR_TO_DATE(ActivityHour,'%m/%d/%Y %h:%i:%s %p');

ALTER TABLE hourly_steps
MODIFY ActivityHour DATETIME;

DELETE FROM hourly_steps
WHERE (Id,ActivityHour,StepTotal) NOT IN
(
SELECT * FROM
(
SELECT Id,ActivityHour,StepTotal
FROM hourly_steps
GROUP BY Id,ActivityHour,StepTotal
) 
);

CREATE TABLE hourly_intensities(
Id BIGINT,
ActivityHour varchar(50),
TotalIntensity INT,
AverageIntensity FLOAT
);

UPDATE hourly_intensities
SET ActivityHour = STR_TO_DATE(ActivityHour,'%m/%d/%Y %h:%i:%s %p');

ALTER TABLE hourly_intensities
MODIFY ActivityHour DATETIME;

CREATE TABLE weight_log_info (
    Id BIGINT,
    Date VARCHAR(50),
    WeightKg FLOAT,
    WeightPounds FLOAT,
    Fat VARCHAR(20),
    BMI FLOAT,
    IsManualReport VARCHAR(10),
    LogId BIGINT
);

UPDATE weight_log_info
SET Date = STR_TO_DATE(Date,'%m/%d/%Y %h:%i:%s %p');

ALTER TABLE weight_log_info
MODIFY Date DATETIME;

CREATE TABLE sleep_day (
    Id BIGINT,
    SleepDay VARCHAR(50),
    TotalSleepRecords INT,
    TotalMinutesAsleep INT,
    TotalTimeInBed INT
);

CREATE TABLE minute_calories_wide (
Id BIGINT,
ActivityHour VARCHAR(50),

Calories00 INT,
Calories01 INT,
Calories02 INT,
Calories03 INT,
Calories04 INT,
Calories05 INT,
Calories06 INT,
Calories07 INT,
Calories08 INT,
Calories09 INT,

Calories10 INT,
Calories11 INT,
Calories12 INT,
Calories13 INT,
Calories14 INT,
Calories15 INT,
Calories16 INT,
Calories17 INT,
Calories18 INT,
Calories19 INT,

Calories20 INT,
Calories21 INT,
Calories22 INT,
Calories23 INT,
Calories24 INT,
Calories25 INT,
Calories26 INT,
Calories27 INT,
Calories28 INT,
Calories29 INT,

Calories30 INT,
Calories31 INT,
Calories32 INT,
Calories33 INT,
Calories34 INT,
Calories35 INT,
Calories36 INT,
Calories37 INT,
Calories38 INT,
Calories39 INT,

Calories40 INT,
Calories41 INT,
Calories42 INT,
Calories43 INT,
Calories44 INT,
Calories45 INT,
Calories46 INT,
Calories47 INT,
Calories48 INT,
Calories49 INT,

Calories50 INT,
Calories51 INT,
Calories52 INT,
Calories53 INT,
Calories54 INT,
Calories55 INT,
Calories56 INT,
Calories57 INT,
Calories58 INT,
Calories59 INT
);

CREATE TABLE minute_calories_narrow (
Id BIGINT,
ActivityMinute VARCHAR(50),
Calories INT
);
SET GLOBAL net_read_timeout = 600;
SET GLOBAL net_write_timeout = 600;
SET GLOBAL wait_timeout = 600;
SET GLOBAL interactive_timeout = 600;
SET GLOBAL max_allowed_packet = 1073741824;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/minuteCaloriesNarrow_merged.csv'
INTO TABLE minute_calories_narrow
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE minute_intensities_narrow (
Id BIGINT,
ActivityMinute VARCHAR(50),
Intensity INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/minuteIntensitiesNarrow_merged.csv'
INTO TABLE minute_intensities_narrow
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE minute_mets_narrow (
Id BIGINT,
ActivityMinute VARCHAR(50),
METs INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/minuteMETsNarrow_merged.csv'
INTO TABLE minute_mets_narrow
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE minute_steps_narrow (
Id BIGINT,
ActivityMinute VARCHAR(50),
Steps INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/minuteStepsNarrow_merged.csv'
INTO TABLE minute_steps_narrow
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE heartrate_seconds (
Id BIGINT,
Time VARCHAR(50),
Value INT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/heartrate_seconds_merged.csv'
INTO TABLE heartrate_seconds
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE minute_calories_wide (
Id BIGINT,
ActivityHour VARCHAR(50),

Calories00 INT, Calories01 INT, Calories02 INT, Calories03 INT, Calories04 INT,
Calories05 INT, Calories06 INT, Calories07 INT, Calories08 INT, Calories09 INT,

Calories10 INT, Calories11 INT, Calories12 INT, Calories13 INT, Calories14 INT,
Calories15 INT, Calories16 INT, Calories17 INT, Calories18 INT, Calories19 INT,

Calories20 INT, Calories21 INT, Calories22 INT, Calories23 INT, Calories24 INT,
Calories25 INT, Calories26 INT, Calories27 INT, Calories28 INT, Calories29 INT,

Calories30 INT, Calories31 INT, Calories32 INT, Calories33 INT, Calories34 INT,
Calories35 INT, Calories36 INT, Calories37 INT, Calories38 INT, Calories39 INT,

Calories40 INT, Calories41 INT, Calories42 INT, Calories43 INT, Calories44 INT,
Calories45 INT, Calories46 INT, Calories47 INT, Calories48 INT, Calories49 INT,

Calories50 INT, Calories51 INT, Calories52 INT, Calories53 INT, Calories54 INT,
Calories55 INT, Calories56 INT, Calories57 INT, Calories58 INT, Calories59 INT
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/minuteCaloriesWide_merged.csv'
INTO TABLE minute_calories_wide
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE minute_intensities_wide (
Id BIGINT,
ActivityHour VARCHAR(50),

Intensity00 INT, Intensity01 INT, Intensity02 INT, Intensity03 INT, Intensity04 INT,
Intensity05 INT, Intensity06 INT, Intensity07 INT, Intensity08 INT, Intensity09 INT,

Intensity10 INT, Intensity11 INT, Intensity12 INT, Intensity13 INT, Intensity14 INT,
Intensity15 INT, Intensity16 INT, Intensity17 INT, Intensity18 INT, Intensity19 INT,

Intensity20 INT, Intensity21 INT, Intensity22 INT, Intensity23 INT, Intensity24 INT,
Intensity25 INT, Intensity26 INT, Intensity27 INT, Intensity28 INT, Intensity29 INT,

Intensity30 INT, Intensity31 INT, Intensity32 INT, Intensity33 INT, Intensity34 INT,
Intensity35 INT, Intensity36 INT, Intensity37 INT, Intensity38 INT, Intensity39 INT,

Intensity40 INT, Intensity41 INT, Intensity42 INT, Intensity43 INT, Intensity44 INT,
Intensity45 INT, Intensity46 INT, Intensity47 INT, Intensity48 INT, Intensity49 INT,

Intensity50 INT, Intensity51 INT, Intensity52 INT, Intensity53 INT, Intensity54 INT,
Intensity55 INT, Intensity56 INT, Intensity57 INT, Intensity58 INT, Intensity59 INT
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/minuteIntensitiesWide_merged.csv'
INTO TABLE  minute_intensities_wide
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE minute_sleep (
Id BIGINT,
date VARCHAR(50),
value INT,
logId BIGINT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/minuteSleep_merged.csv'
INTO TABLE minute_sleep
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE minute_steps_wide (
Id BIGINT,
ActivityHour VARCHAR(50),

Steps00 INT, Steps01 INT, Steps02 INT, Steps03 INT, Steps04 INT,
Steps05 INT, Steps06 INT, Steps07 INT, Steps08 INT, Steps09 INT,

Steps10 INT, Steps11 INT, Steps12 INT, Steps13 INT, Steps14 INT,
Steps15 INT, Steps16 INT, Steps17 INT, Steps18 INT, Steps19 INT,

Steps20 INT, Steps21 INT, Steps22 INT, Steps23 INT, Steps24 INT,
Steps25 INT, Steps26 INT, Steps27 INT, Steps28 INT, Steps29 INT,

Steps30 INT, Steps31 INT, Steps32 INT, Steps33 INT, Steps34 INT,
Steps35 INT, Steps36 INT, Steps37 INT, Steps38 INT, Steps39 INT,

Steps40 INT, Steps41 INT, Steps42 INT, Steps43 INT, Steps44 INT,
Steps45 INT, Steps46 INT, Steps47 INT, Steps48 INT, Steps49 INT,

Steps50 INT, Steps51 INT, Steps52 INT, Steps53 INT, Steps54 INT,
Steps55 INT, Steps56 INT, Steps57 INT, Steps58 INT, Steps59 INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/minuteStepsWide_merged.csv'
INTO TABLE minute_steps_wide
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT
HOUR(ActivityHour) AS hour_of_day,
AVG(TotalIntensity) AS avg_intensity
FROM hourly_intensities
GROUP BY hour_of_day
ORDER BY avg_intensity DESC;

SELECT
Id,
SUM(TotalIntensity) AS total_intensity
FROM hourly_intensities
GROUP BY Id
ORDER BY total_intensity DESC
LIMIT 10;

SELECT
DAYNAME(ActivityHour) AS day_of_week,
AVG(TotalIntensity) AS avg_intensity
FROM hourly_intensities
GROUP BY day_of_week;

SELECT COUNT(*)
FROM hourly_intensities
WHERE TotalIntensity = 0;

##JOIN ANALYSIS
#Steps vs Calories
SELECT
d.Id,
d.ActivityDay,
d.TotalSteps,
c.Calories
FROM daily_activity d
JOIN daily_calories c
ON d.Id = c.Id
AND d.ActivityDay = c.ActivityDay;

#Steps vs Activity Minutes
SELECT
Id,
ActivityDay,
TotalSteps,
VeryActiveMinutes,
FairlyActiveMinutes
FROM daily_activity;

#Average daily steps
SELECT AVG(TotalSteps)
FROM daily_activity;

#Average calories burned
SELECT AVG(Calories)
FROM daily_activity;

#Most active day
SELECT
ActivityDay,
SUM(TotalSteps) AS total_steps
FROM daily_activity
GROUP BY ActivityDay
ORDER BY total_steps DESC
LIMIT 1;

#BMI Categories
SELECT
CASE
WHEN BMI < 18.5 THEN 'Underweight'
WHEN BMI BETWEEN 18.5 AND 24.9 THEN 'Normal'
WHEN BMI BETWEEN 25 AND 29.9 THEN 'Overweight'
ELSE 'Obese'
END AS BMI_Category,
COUNT(*) AS TotalUsers
FROM weight_log_info
GROUP BY BMI_Category;

#activity vs sleep
SELECT a.Id, s.Id
FROM daily_activity a
JOIN sleep_day s
ON a.Id = s.Id
LIMIT 10;

# avg sleep time
SELECT
AVG(TotalMinutesAsleep)/60 AS AvgSleepHours
FROM sleep_day;

#Sedentary vs Active Minutes
SELECT
AVG(SedentaryMinutes) AS AvgSedentary,
AVG(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes) AS AvgActive
FROM daily_activity;
