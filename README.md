# Global-Covid-Data-Analysis-using-MySQL

Data Retrieval: The initial part of the code retrieves all columns from the covidDeath and covidVaccinations tables, ordering the results by specific columns. This step lays the foundation for subsequent analyses.

COVID-19 Death Statistics:

The code selects specific columns from the covidDeath table, focusing on location, date, total cases, new cases, total deaths, and population. Results are ordered by location and date. A specific query calculates and displays the death percentage for COVID-19 cases in India. Another query computes the percentage of the population affected by COVID-19 in India. Identification of countries with the highest death counts per population is performed. Continent-wise Analysis:

A section of the code delves into continent-wise analysis, focusing on death counts per population. Global COVID-19 statistics, including total cases, total deaths, and death percentage, are computed. Vaccination Data Analysis:

The code shifts its focus to vaccination data, calculating the rolling count of people vaccinated over time for each location. A temporary table (percentpopulationvacciated) is created to facilitate calculations on vaccination data. Data is inserted into the temporary table using an INSERT IGNORE statement. Data Storage for Visualization:

A view (popVaccinatedView) is created to store vaccination data for later visualizations. A final select statement is included to display the contents of the created view (popVaccinatedView). Conclusion: In conclusion, this code provides a comprehensive exploration of COVID-19 data, shedding light on death statistics, population impact, and vaccination trends. The use of temporary tables and views allows for efficient data processing and storage, setting the stage for further insights and visualizations.
