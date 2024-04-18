SELECT *
FROM projest1Schema.covidDeath cd 
ORDER BY 3,4

SELECT *
FROM projest1Schema.covidVaccinations cv 
ORDER BY 3,4

-- SELECT *
-- FROM projest1Schema.covidVaccinations cv 
-- ORDER BY 3,4
-- Select data that we are going to be using
SELECT location,date ,total_cases ,new_cases,total_deaths,population
FROM projest1Schema.covidDeath cd 
ORDER BY 1,2

-- --looking at total cases vs total deaths
-- --SHOWS THE LIKLIHOOD OF DYING IF YOU CONTRACT COVID IN YOUR COUNTRY
SELECT location,date ,total_cases ,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM projest1Schema.covidDeath cd 
WHERE location LIKE '%INDIA%'
ORDER BY 1,2
-- -- looking at the total cases v/s population 
-- --Shows what percentage of population thatgot covid
SELECT location,date ,total_cases ,population ,(total_cases /population)*100 as AffectedPercentage
FROM projest1Schema.covidDeath cd 
WHERE location LIKE '%INDIA%'
ORDER BY 1,2
 
-- --This is showing countires with the highest death count for the population
SELECT location,MAX(total_deaths) as TotalDeathCount
FROM projest1Schema.covidDeath cd 
-- --WHERE location LIKE '%INDIA%'
WHERE  continent IS NOT NULL 
GROUP BY location
ORDER BY TotalDeathCount DESC 

-- -- LETS BREAK THINGS DOWN BY CONTINENT 

-- --SHOWING THE CONTINENTS WITH THE HIGHEST DEATH COUNT PER population 
SELECT continent,MAX(total_deaths) as TotalDeathCount
FROM projest1Schema.covidDeath cd 
WHERE  continent IS not NULL 
GROUP BY continent 
ORDER BY TotalDeathCount DESC 
-- --GLOBAL NUMBERS 
SELECT SUM(new_cases) AS total_cases,SUM(CAST(new_deaths AS UNSIGNED)) AS total_deaths,(SUM(CAST(new_deaths AS UNSIGNED))/SUM(new_cases))*100 AS DEATH_PERCENTAGE
FROM projest1Schema.covidDeath cd2 
WHERE continent IS NOT NULL 
ORDER BY 1,2
-- -- lets talk about vaccination
-- -- Total population vs vaccinations
-- -- shows percentage of population that has recieved atleast one covid vaccine

SELECT  cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
sum(cast(cv.new_vaccinations as unsigned)) over (partition by cd.location order by cd.location,cd.`date`) as rollingPeopleVaccinated
 -- --(RollingPeopleVaccinated/population)*100
 FROM projest1Schema.covidDeath cd 
 JOIN projest1Schema.covidVaccinations cv 
 ON cd.location =cv.location
 and cd.date=cv.date
 where cd.continent is not NULL 
 order by 2,3
 
 
 
 

 
 -- -- using temp table to perform calculation on partitions by in previous query

 create table projest1Schema.percentpopulationvacciated
 (
 continent nvarchar(255),
 location nvarchar(255),
 date datetime,
 population numeric,
 new_vaccinations numeric,
 rollingpeoplevaccnated numeric
 )
 
 Insert ignore into projest1Schema.percentPopulationVacciated
 SELECT cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
 sum(cast(cv.new_vaccinations as unsigned)) over (partition by cd.location order by cd.location,cd.`date`) as rollingPeopleVaccinated
 -- --(ollingPeopleVaccinated/population)*100
 FROM projest1Schema.covidDeath cd 
 JOIN projest1Schema.covidVaccinations cv 
 ON cd.location =cv.location
 and cd.date=cv.date
 where cd.continent is not NULL 
 
 select * , (rollingpeoplevaccnated/population)*100
 from projest1Schema.percentpopulationvacciated p
 
 -- -- creating view to store data for later visualizations
 
 set sql_mode='';

 create View projest1Schema.popVaccinatedView
 as
 SELECT cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
 sum(cast(cv.new_vaccinations as unsigned)) over (partition by cd.location order by cd.location,cd.`date`) as rollingPeopleVaccinated
 -- --(ollingPeopleVaccinated/population)*100
 FROM projest1Schema.covidDeath cd 
 JOIN projest1Schema.covidVaccinations cv 
 ON cd.location =cv.location
 and cd.date=cv.date
 where cd.continent is not NULL ;

select * from projest1Schema.popvaccinatedview p
 
 
 
 
 
 
 
 
 