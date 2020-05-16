# Pewlett-Hackard-Analysis
## Project Objectives

Pewlett-Hackard is a big company with a large size of employees. As baby boomers begin to retire at a rapid rate, Pewlett-Hackard is looking toward the future in two ways:
  - Offering retiring pacakge for those who meets certain criteria.
  - Getting information about which positions needed to be filled in near future.
  
Based on these needs, we analized Pewlett-Hackard's employee data to provide information on:
  - Who will be retiring in the next few years.
  - Which positions and how may positions will Pewlett-Hackard needs to fill.
  - Mentorship eligible employees to train new employees.

## Analysis Procedure

### Tools
  - Postgres for creating a database
  - pgAdmin4 for working with the data imported
  - QuickDBD for Entity Relationship Diagrams(ERD)

### Procedure
  - Identify data relationships and create Entity Relationship Diagrams. 
  - Lauch pgAdmin4 and create database.
  - Create tables in SQL.
  - Import six data sets into tables created in SQL in last step.
  - Query current retiring employees born between Jan. 1, 1952 and Dec. 31, 1955.
    - Use INNER JOIN and LEFT JOIN to merge data sets: employee, dept_emp, titles and salaries.
    - Use WHERE and AND to query current retiring employees.
    - Use PARTITION BY to query only the most recent title of each employee.  
  - Query how many empoyees are retiring for each title.
    - Use COUNT() function, PARTITION BY and GROUP BY to query the number of employees per title.
  - Query how many titles have retiring employees.
    - Use COUNT() function to count the number of titles that have retiring employees. 
  - Query how many employees are eligible for mentiorship for new employees.
    - Use INNER JOIN to merge data sets: employee, dept_emp, titles and salaries.
    - Use WHERE and AND to query current employees who have a date of birth that falls between January 1, 1965 and December 31, 1965 to be eligible to participate in the mentorship program.
    - Use PARTITION BY to query only the most recent title of each employee.  
    
 ## Results and Analysis
 
   - Results
     - EDA image shows data relationships.
     <p align="center">
     <img src="https://github.com/karenmxm/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png">
     </p>
     
       * [EmployeeDB](https://github.com/karenmxm/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png)
     - There are 72,458 employees are retiring in near future.
        - [Retiring Employees](https://github.com/karenmxm/Pewlett-Hackard-Analysis/blob/master/Data/current_retirement_info.csv)
        - [Retiring Employees Most Current Title](https://github.com/karenmxm/Pewlett-Hackard-Analysis/blob/master/Data/current_retirement_recent_title_info.csv)
     - There are 7 titles have retiring employees: 
       - [Retiring Employees per Title](https://github.com/karenmxm/Pewlett-Hackard-Analysis/blob/master/Data/current_retirement_per_title.csv)
         - Senior Engineer (25916) 
         - Senior Staff (24926) 
         - Engineer (9285) 
         - Staff(7636) 
         - Technique Leader (3603)
         - Assistant Engineer (1090)
         - Manager (2)
     - There are 1,549 employees are available for mentor roles. The employees are available for mentor roles are in the following 6 titles: 
       - [Mentor Eligible Employees](https://github.com/karenmxm/Pewlett-Hackard-Analysis/blob/master/Data/current_mentor_info.csv)
         - Staff
         - Senior Staff 
         - Engineer 
         - Senior Engineer
         - Technique Leader
         - Assistant Engineer

- Analysis
  - The number of retiring engineers (36,291) in three different ranks is the largest among all the titles that have retiring employees.
  - The number of retiring staffs (32,562) in two diffferent ranks is the second largest among all positions that have retiring employees.
  - The number of retring Techique Leaders (3,063), although much smaller than Engineer and Staff, is still needed to prepare to fill in.
  - Although there are only 2 retiring Managers, this is 22% of the managers since there are only 9 departments in Pewlett-Hackard.
  - There is a large shortage of available employees who are eligible for mentor roles. 
    - Total retiring employees (72,458) vs. mentorship eligible employees (1,549).
  
- Recommendations
  - The top three positions, Engineer, Staff and Technique Leader are on the top of the list to fill in.
  - Managers in Sales and Research departments need to be filled in near future.
  - Pewlett-Hackard need set new criteria for mentorship eligibility to increase the number of employees that are eligible for mentorship.
