> #### Note: 10/09/2023 - this project is under development
> Backlog:
> - finish correlation part in sample article
> - complete visualisations - create interactive dashboard
> - when tables wont need any modification, implement 'update/upsert/merge/insert only new' mechanism to increase performance
> - fix SSIS package - bat files not run
> - fix backup proccess - it would be more handy if it was 1 file per db, not object
> - fix step_goal algorithm
> - *I have old google activity records stored as json lines in db. Create etl to append data to the current activity tables.


# Garmin Data ETL Project 
by Patryk Rostkowski

## Project Proposal
Based upon the precompiled data, the purpose of this project is to transform, explore, and analyze Garmin health and activity data. This will be done by extracting data from SQLite databases, migrating it to a SQL Server, transforming it (backing up SQL objects and pushing into GitHub repo in the meantime), and then write an analysis using visuals created in POWER BI.
## Finding Data
All data used in the project were generated based on my personal activity since February 2023. The first task was to figure out ways to extract the data from my watch. Scanning through the developer pages, I found that Garmin doesn't provide any tool to extract personal data unless you request for access as a business developer. But I came across on [GarminDB](https://github.com/tcgoetz/GarminDB), which is what I looked for.  

## Project Description
The precompiled data is being stored in 5 SQlite databases:
- `garmin`             - contains resting heart rate data, sleep and stress tables on daily dimension
- `garmin_activities`   - contains data relating with measured activities, along with health data and steps
- `garmin_monitoring`   - contains precise data of steps, intense of activity, floors climbed and respiratory rate
- `garmin_summary`      - contains summary tables
- `summary`
  
There will be used 4 of them, except the last one, wchich is pretty much identical as garmin_summary
## Transformation
In order to transform the data and use it in our study, the following were performed:
- create linked servers to connect SQLite databases
- SQL procedure that creates staging views dynamically according to given schema and table name (that match SQLite table names) from config table
- SQL procedure that creates and populates staging tables
- SQL procedure that creates and populates summary tables
- some SQL views with combination of specified data for visuals purpose

<p align="center">
  <img width="500" height="400" src="https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/X_raw_files/etl_flow_diagram.png">
</p>


The whole process (from getting Garmin's data to all sql transformations) was wrapped up in an [SSIS package and deployed into the SQL Integration Service Catalog](https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/X_raw_files/SSIS_package.png)

## Data Cleanup and Analysis
### Data preparation and transformation 
To be able to choose which tables we want to load, config table [(example)](https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/X_raw_files/config_table.png) contains the full list of tables, the schema they will be created in, and an indicator pointing which table we want to see in the final output
- src - schema created for staging objects (by 'staging', I mean object loaded in the original structure as they were in the SQLite database)
- dbo - schema created for transformed objects
- some columns were removed, cause it doesnt collect any/important data
- time columns were converted to store only minutes as int
- all transformation steps is beeing stored in `garmin` db, using cross database queries if needed.

### Analysis
Here are some ideas I wanted to explore in further analysis
- create dashboard summarizing my daily activity
- create steps heatmap across the week and time of the day
- dashboard summarizing my activity over time
- check if/how sports activity impacts on resting heart rate level
- count activity types over months
- stress, weekday and active minutes correlation
- how intense exercices during the day or before sleep impacts sleep phases
  
### [HERE YOU CAN READ MY HEALTH ARTICLE](https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/4.Sample_analysis/Analysis.md)

## End notes
This data analysis is based on a limited set of data points and should not be extrapolated to the masses. Please consider it as a fun read.
The backup of database objects was made through my own script, based on [Microsoft backup solution](https://github.com/microsoft/mssql-scripter).
For training purposes, all summary tables were recalculated manually, slightly customized, and used further. 
There were some limitations to calculate some columns due to no raw data (e.g.sweat_loss data), so some of them were taken from default summary tables.

