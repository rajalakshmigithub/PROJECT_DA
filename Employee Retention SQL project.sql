show databases;
create database Project;
use  Project;

select * from hr_1;
select count(*) from hr_1;

select * from hr_2;
SELECT count(*) FROM HR_2;

select * from hr;
SELECT count(*) FROM hr;

-- Create hr_1 table if it doesn't exist
CREATE TABLE IF NOT EXISTS hr_1 AS
SELECT 
  EmployeeNumber,
  MAX(Age) AS Age,
  MAX(Attrition) AS Attrition,
  MAX(BusinessTravel) AS BusinessTravel,
  MAX(DailyRate) AS DailyRate,
  MAX(Department) AS Department,
  MAX(DistanceFromHome) AS DistanceFromHome,
  MAX(Education) AS Education,
  MAX(EducationField) AS EducationField,
  MAX(EmployeeCount) AS EmployeeCount,
  MAX(EnvironmentSatisfaction) AS EnvironmentSatisfaction,
  MAX(Gender) AS Gender,
  MAX(HourlyRate) AS HourlyRate,
  MAX(JobInvolvement) AS JobInvolvement,
  MAX(JobLevel) AS JobLevel,
  MAX(JobRole) AS JobRole,
  MAX(JobSatisfaction) AS JobSatisfaction,
  MAX(MaritalStatus) AS MaritalStatus,
  MAX(ATTRITIONRATE) AS ATTRITIONRATE
FROM hr
GROUP BY EmployeeNumber;

-- Deleting table hr
drop table hr;


-- total empcount
select count(EmployeeCount) from hr_1;

-- total Attrition
select count(*) as total_Attrition
from hr_1
where ATTRITIONRATE = "1";

-- average Age
select avg(Age) from hr_1;

-- total no of males 
select count(*) as total_males
from hr_1
where gender = "Male";

-- total no of females
select count(*) as total_females
from hr_1
where gender= "Female";

-- Attrition rate
select 
sum(attritionrate) / sum(employeecount)* 100 as Attrition_Rate
from hr_1;

-- Active Employee
select sum(employeecount) - sum(AttritionRate)  as Active_Employee from hr_1; 

-- Job level status
select JobLevel, case
when joblevel = "1" then "Higher" 
when joblevel = "2" then "High"
when joblevel = "3" then "Medium"
when joblevel = "4" then "low"
else "lowest" 
end as Job_Level_status
from hr_1;

-- Job level status count 
SELECT
    Job_Level_status,
    COUNT(*) AS LevelCount
FROM (
    SELECT
        JobLevel,
        CASE
            WHEN JobLevel = '1' THEN 'Higher'
            WHEN JobLevel = '2' THEN 'High'
            WHEN JobLevel = '3' THEN 'Medium'
            WHEN JobLevel = '4' THEN 'Low'
            ELSE 'Lowest'
        END AS Job_Level_status
    FROM hr_1
) AS Subquery
GROUP BY Job_Level_status
order by Job_Level_status asc;

-- Attrition count By Jobe Role
select JobRole,
count(*) as Attrition_count
from hr_1
where ATTRITIONRATE ="1"
group by JobRole
order by Attrition_count asc;

-- Bussiness travel by employee count
select BusinessTravel,
count(*) as Bussiness_Travel_Employee
from hr_1
where EmployeeCount=1
group by BusinessTravel
order by Bussiness_Travel_Employee asc;

-- Attrition by gender
select Gender,
count(*) as Gender_Attrition
from hr_1
where ATTRITIONRATE = "1"
group by Gender;

-- Education field wise attrition
select EducationField,
count(*) as Education_Field_Attrition
from hr_1
where ATTRITIONRATE = "1"
group by EducationField 
order by Education_Field_Attrition desc;

-- Emp_id wise job saticfaction
select h.`Employee ID`, 
max(
case
when js.JobSatisfaction <=2 then "High"
when js.JobSatisfaction =3 then "Medium"
else "Low"
end) as Job_Saticfaction
 from hr_1 as js
 inner join hr_2 as h
on  h.`Employee ID` = js.EmployeeNumber
group by h.`Employee ID`;
    
-- Onduty vs DueToRetiered
select YearsAtCompany, case
when YearsAtCompany >= "22" then "Due_To_Retiered"	 
else "On_Duty"
end as Retirement from hr_2
group by YearsAtCompany
Order by Retirement;

-- employees wise performance rating
select `Employee ID`, PerformanceRating, case
when PerformanceRating <= "3" then "HighRating"
else "low_Rating"
end As Performance_rating from hr_2
order by `Employee ID`;

-- Unique dept wise job Role
select distinct(department), jobrole from hr_1 
inner join hr_2 on hr_1.EmployeeNumber = hr_2.`Employee ID`;

-- Department wise Attirition
SELECT
  Department,
  COUNT(*) AS total_employees,
  SUM( ATTRITIONRATE = '1') AS total_attrition,
  ROUND(SUM(ATTRITIONRATE = '1') / COUNT(*) * 100.0 , 2) AS attrition_percentage
FROM hr_1
GROUP BY Department
order by total_attrition asc;

-- job role vs worklife balance
SELECT
    hr_1.JobRole,
    AVG(hr_2.WorkLifeBalance) AS AverageWorkLifeBalance
FROM
    hr_1
JOIN
    hr_2 ON hr_1.JobRole = hr_2.WorkLifeBalance
GROUP BY
    hr_1.JobRole;
    
  -- count of department by gender
  select Department,Gender, 
count(*) as count
 from hr_1
  group by Department,Gender
  order by Department asc;
    
    