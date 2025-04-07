use ndap;

CREATE TABLE FarmersInsuranceData (
    rowID INT PRIMARY KEY,
    srcYear INT,
    srcStateName VARCHAR(255),
    srcDistrictName VARCHAR(255),
    Insurance_units INT,
    TotalFarmersCovered INT,
    ApplicationsLoaneeFarmers INT,
    ApplicationsNonLoaneeFarmers INT,
    InsuredLandArea FLOAT,
    FarmersPremiumAmount FLOAT,
    StatePremiumAmount FLOAT,
    GOVPremiumAmount FLOAT,
    GrossPremiumAmountToBePaid FLOAT,
    SumInsured FLOAT,
    PercentageMaleFarmersCovered FLOAT,
    PercentageFemaleFarmersCovered FLOAT,
    PercentageOthersCovered FLOAT,
    PercentageSCFarmersCovered FLOAT,
    PercentageSTFarmersCovered FLOAT,
    PercentageOBCFarmersCovered FLOAT,
    PercentageGeneralFarmersCovered FLOAT,
    PercentageMarginalFarmers FLOAT,
    PercentageSmallFarmers FLOAT,
    PercentageOtherFarmers FLOAT,
    YearCode INT,
    Year INT,
    Country VARCHAR(255),
    StateCode INT,
    DistrictCode INT,
    TotalPopulation INT,
    TotalPopulationUrban INT,
    TotalPopulationRural INT,
    TotalPopulationMale INT,
    TotalPopulationMaleUrban INT,
    TotalPopulationMaleRural INT,
    TotalPopulationFemale INT,
    TotalPopulationFemaleUrban INT,
    TotalPopulationFemaleRural INT,
    NumberOfHouseholds INT,
    NumberOfHouseholdsUrban INT,
    NumberOfHouseholdsRural INT,
    LandAreaUrban FLOAT,
    LandAreaRural FLOAT,
    LandArea FLOAT
);
select * from farmersinsurancedata;

-- ----------------------------------------------------------------------------------------------
-- SECTION 1. 
-- SELECT Queries [5 Marks]

-- 	Q1.	Retrieve the names of all states (srcStateName) from the dataset.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
-- <write your answers in the empty spaces given, the length of solution queries (and the solution writing space) can vary>


select srcStateName 
from FarmersInsuranceData group by srcStateName;

-- 	Q2.	Retrieve the total number of farmers covered (TotalFarmersCovered) 
-- 		and the sum insured (SumInsured) for each state (srcStateName), ordered by TotalFarmersCovered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName, 
SUM(TotalFarmersCovered) as Total_Farmers, 
round(SUM(SumInsured),2) as Total_Sum_Insured
from FarmersInsuranceData
group by srcStateName
order by Total_Farmers desc;


-- --------------------------------------------------------------------------------------
-- SECTION 2. 
-- Filtering Data (WHERE) [15 Marks]

-- 	Q3.	Retrieve all records where Year is '2020'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select *
from FarmersInsuranceData
where srcYear = 2020;

-- ###

-- 	Q4.	Retrieve all rows where the TotalPopulationRural is greater than 1 million and the srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
with Total_population as
( select*,
row_number () over ( partition by srcStateName order by TotalPopulationRural desc) as row_state_population
from FarmersInsuranceData 
where TotalPopulationRural > 1000000
and srcStateName = 'Himachal Pradesh')
select * from Total_population;


-- ###

-- 	Q5.	Retrieve the srcStateName, srcDistrictName, and the sum of FarmersPremiumAmount for each district in the year 2018, 
-- 		and display the results ordered by FarmersPremiumAmount in ascending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select
srcStateName, srcDistrictName,
sum(FarmersPremiumAmount) as sum_premium_farmer
from FarmersInsuranceData 
where srcYear = 2018
group by srcStateName, srcDistrictName
order by sum_premium_farmer;




-- ###

-- 	Q6.	Retrieve the total number of farmers covered (TotalFarmersCovered) and the sum of premiums (GrossPremiumAmountToBePaid) for each state (srcStateName) 
-- 		where the insured land area (InsuredLandArea) is greater than 5.0 and the Year is 2018.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select 
srcStateName,
sum(TotalFarmersCovered) as Total_farmer,
round(sum(GrossPremiumAmountToBePaid),2) as Total_gross
from FarmersInsuranceData
where InsuredLandArea > 5.0
and srcYear = 2018
group by srcStateName
order by Total_farmer;


-- ###
-- ------------------------------------------------------------------------------------------------

-- SECTION 3.
-- Aggregation (GROUP BY) [10 marks]

-- 	Q7. 	Calculate the average insured land area (InsuredLandArea) for each year (srcYear).
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW 

select srcYear,
avg(InsuredLandArea) as avg_land_area
from FarmersInsuranceData
group by srcYear;




-- ###

-- 	Q8. 	Calculate the total number of farmers covered (TotalFarmersCovered) for each district (srcDistrictName) where Insurance units is greater than 0.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select srcDistrictName,
sum(TotalFarmersCovered) as sum_of_farmer
from FarmersInsuranceData
where InsuranceUnits > 0 
group by srcDistrictName;


-- ###

-- 	Q9.	For each state (srcStateName), calculate the total premium amounts (FarmersPremiumAmount, StatePremiumAmount, GOVPremiumAmount) 
-- 		and the total number of farmers covered (TotalFarmersCovered). Only include records where the sum insured (SumInsured) is greater than 500,000 (remember to check for scaling).
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select srcStateName,
sum(FarmersPremiumAmount) as total_farmer,
sum(StatePremiumAmount) as Total_state,
sum(GOVPremiumAmount) as Total_premium_amount,
sum(TotalFarmersCovered) as total_farmers_covered
from FarmersInsuranceData
where SumInsured > 200000.00
group by srcStateName;


-- ###

-- -------------------------------------------------------------------------------------------------
-- SECTION 4.
-- Sorting Data (ORDER BY) [10 Marks]

-- 	Q10.	Retrieve the top 5 districts (srcDistrictName) with the highest TotalPopulation in the year 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >


select srcDistrictName,TotalPopulation
from FarmersInsuranceData
where srcYear = 2020 
order by srcDistrictName desc 
limit 5;


-- ###

-- 	Q11.	Retrieve the srcStateName, srcDistrictName, and SumInsured for the 10 districts with the lowest non-zero FarmersPremiumAmount, 
-- 		ordered by insured sum and then the FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select srcStateName,
srcDistrictName,
FarmersPremiumAmount
from FarmersInsuranceData
where FarmersPremiumAmount >0
order by SumInsured ASC, FarmersPremiumAmount ASC
LIMIT 10;

###

-- 	Q12. 	Retrieve the top 3 states (srcStateName) along with the year (srcYear) where the ratio of insured farmers (TotalFarmersCovered) to the total population (TotalPopulation) is highest. 
-- 		Sort the results by the ratio in descending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select * from FarmersInsuranceData;

select srcStateName,
srcYear,
TotalFarmersCovered,
TotalPopulation,
(TotalFarmersCovered / TotalPopulation) Total_Ratio
From FarmersInsuranceData
where TotalPopulation > 0
order by Total_Ratio desc
limit 3;



-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 5.
-- String Functions [6 Marks]

-- 	Q13. 	Create StateShortName by retrieving the first 3 characters of the srcStateName for each unique state.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
Select * from FarmersInsuranceData;

With StateShortName as (
 select distinct srcStateName,
 left (srcStateName,3) as Short_Name
 from FarmersInsuranceData)
 select * from StateShortName;

-- ###

-- 	Q14. 	Retrieve the srcDistrictName where the district name starts with 'B'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
with srcDistrict as
(select distinct srcDistrictName
from FarmersInsuranceData
where srcDistrictName like 'B%')
select * from srcDistrict;


-- ###

-- 	Q15. 	Retrieve the srcStateName and srcDistrictName where the district name contains the word 'pur' at the end.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
With Combine_state as(
select distinct srcStateName,srcDistrictName
from FarmersInsuranceData
where srcDistrictName like '%pur')
select * from Combine_state;


-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 6.
-- Joins [14 Marks]

-- 	Q16. 	Perform an INNER JOIN between the srcStateName and srcDistrictName columns to retrieve the aggregated FarmersPremiumAmount for districts where the district’s Insurance units for an individual year are greater than 10.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >


select srcStateName, srcDistrictName,
round(sum(FarmersPremiumAmount),2) AS TotalPremium
from FarmersInsuranceData
where Insuranceunits > 10
group by srcStateName, srcDistrictName;


-- ###
-- 	Q17.	Write a query that retrieves srcStateName, srcDistrictName, Year, TotalPopulation for each district and the the highest recorded FarmersPremiumAmount for that district over all available years
-- 		Return only those districts where the highest FarmersPremiumAmount exceeds 20 crores.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select srcStateName, srcDistrictName, srcYear, TotalPopulation,
max(FarmersPremiumAmount) as Max_Premimum_amount
from FarmersInsuranceData
group by srcStateName, srcDistrictName, srcYear, TotalPopulation
having max(FarmersPremiumAmount)  >200000000.00;

-- ###

-- 	Q18.	Perform a LEFT JOIN to combine the total population statistics with the farmers’ data (TotalFarmersCovered, SumInsured) for each district and state. 
-- 		Return the total premium amount (FarmersPremiumAmount) and the average population count for each district aggregated over the years, where the total FarmersPremiumAmount is greater than 100 crores.
-- 		Sort the results by total farmers' premium amount, highest first.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select * from FarmersInsuranceData;

select f.srcStateName, f.srcDistrictName,
round(sum(f.FarmersPremiumAmount),2) as TotalFarmersPremium,
round(avg(f.TotalPopulation),2)as AvgPopulation
from FarmersInsuranceData f
left join FarmersInsuranceData p 
on f.srcStateName = p.srcStateName and f.srcDistrictName = p.srcDistrictName
group by f.srcStateName, f.srcDistrictName
having TotalFarmersPremium > 10000
order by  TotalFarmersPremium desc;
-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 7.
-- Subqueries [10 Marks]

-- 	Q19.	Write a query to find the districts (srcDistrictName) where the TotalFarmersCovered is greater than the average TotalFarmersCovered across all records.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select srcDistrictName, srcStateName,TotalFarmersCovered
from FarmersInsuranceData
where TotalFarmersCovered >(
select avg(TotalFarmersCovered)
from FarmersInsuranceData);


-- ###

-- 	Q20.	Write a query to find the srcStateName where the SumInsured is higher than the SumInsured of the district with the highest FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select srcStateName,SumInsured
from FarmersInsuranceData
where SumInsured >(
select SumInsured
from FarmersInsuranceData
order by FarmersPremiumAmount desc
limit 1
);


-- ###

-- 	Q21.	Write a query to find the srcDistrictName where the FarmersPremiumAmount is higher than the average FarmersPremiumAmount of the state that has the highest TotalPopulation.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select srcDistrictName,FarmersPremiumAmount
from FarmersInsuranceData
where FarmersPremiumAmount >(
select avg (FarmersPremiumAmount)
from FarmersInsuranceData
where srcStateName = (
select srcStateName
from FarmersInsuranceData
order by TotalPopulation desc
limit 1)
);

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 8.
-- Advanced SQL Functions (Window Functions) [10 Marks]

-- 	Q22.	Use the ROW_NUMBER() function to assign a row number to each record in the dataset ordered by total farmers covered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcStateName,
srcDistrictName,
TotalFarmersCovered,
row_number() over (order by TotalFarmersCovered desc) as row_num
from FarmersInsuranceData;

-- ###

-- 	Q23.	Use the RANK() function to rank the districts (srcDistrictName) based on the SumInsured (descending) and partition by alphabetical srcStateName.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,
srcDistrictName,
SumInsured,
rank() over (partition by srcStateName order by SumInsured desc) as State_rank
from FarmersInsuranceData;




-- ###

-- 	Q24.	Use the SUM() window function to calculate a cumulative sum of FarmersPremiumAmount for each district (srcDistrictName), ordered ascending by the srcYear, partitioned by srcStateName.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

with Farmer_amount as(
select srcStateName, srcDistrictName, srcYear,FarmersPremiumAmount,
sum(FarmersPremiumAmount) over (partition by srcStateName, srcDistrictName order by srcYear) as sum_farmers_premium
from FarmersInsuranceData)
select * from Farmer_amount;


-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 9.
-- Data Integrity (Constraints, Foreign Keys) [4 Marks]

-- 	Q25.	Create a table 'districts' with DistrictCode as the primary key and columns for DistrictName and StateCode. 
-- 		Create another table 'states' with StateCode as primary key and column for StateName.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >


create table states (
    StateCode int Primary key,
    StateName varchar(100)
);

create table disctricts (
DistrictCode int Primary key,
DistrictName varchar (100),
statecode int,
foreign key (StateCode) references states(StateCode)
);

-- ###

-- 	Q26.	Add a foreign key constraint to the districts table that references the StateCode column from a states table.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
Alter table districts
add constraint fk_statecode
foreign key (statecode)
references states(statecode);

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 10.
-- UPDATE and DELETE [6 Marks]

-- 	Q27.	Update the FarmersPremiumAmount to 500.0 for the record where rowID is 1.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

update FarmersInsuranceData
set FarmersPremiumAmount = 500.0
where rowID = 1;

-- ###

-- 	Q28.	Update the Year to '2021' for all records where srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

update FarmersInsuranceData
set srcyear = '2021'
where srcStateName = 'HIMACHAL PRADESH';

-- ###

-- 	Q29.	Delete all records where the TotalFarmersCovered is less than 10000 and Year is 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
delete from FarmersInsuranceData
where TotalFarmersCovered < 10000
and srcYear = 2020;

-- ###