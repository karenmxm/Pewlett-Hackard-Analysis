-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
    emp_no INT NOT NULL,
    title VARCHAR(40) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no), 
    PRIMARY KEY (emp_no, title, from_date)
);

-- Create new table for current retiring employees born between Jan. 1, 1952 and Dec. 31, 1955.
SELECT e.emp_no, 
    e.first_name, 
	e.last_name,
	ti.title,
	ti.from_date,
	s.salary
INTO current_retirement_info
FROM employees AS e
    INNER JOIN dept_emp AS de
	    ON (e.emp_no = de.emp_no)
	LEFT JOIN titles AS ti
	    ON (e.emp_no = ti.emp_no)
	LEFT JOIN salaries AS s
	    ON (e.emp_no = s.emp_no)	
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;
-- Check the table
SELECT * FROM current_retirement_info;

-- Partition current retiring employees to show only most recent title per employee
SELECT emp_no,
    first_name,
	last_name,
	title,
	from_date,
	salary
INTO current_retirement_recent_title_info
FROM 
   (SELECT 
	cr.emp_no,
    cr.first_name,
	cr.last_name,
	cr.title,
	cr.from_date,
	cr.salary, 
	   ROW_NUMBER() OVER
      (PARTITION BY (emp_no)
      ORDER BY from_date DESC) rn
    FROM current_retirement_info AS cr) 
	  tmp WHERE rn = 1
ORDER BY emp_no;
-- Check the table
SELECT * FROM current_retirement_recent_title_info;

--Get number of emloyees retiring per title
SELECT COUNT (title) title_count, title
INTO current_retirement_per_title
FROM 
(SELECT emp_no,
    first_name,
	last_name,
	title,
	from_date,
	salary
FROM 
   (SELECT 
	cr.emp_no,
    cr.first_name,
	cr.last_name,
	cr.title,
	cr.from_date,
    cr.salary, 
	   ROW_NUMBER() OVER
      (PARTITION BY (emp_no)
      ORDER BY from_date DESC) rn
    FROM current_retirement_recent_title_info AS cr) 
	  tmp WHERE rn = 1
ORDER BY emp_no) AS sub
GROUP BY title
ORDER BY title_count DESC;
-- Check the table
SELECT * FROM current_retirement_per_title;

-- Get number of retiring titles
SELECT COUNT (ct.title_count) title_count
INTO retirement_title_count
FROM current_retirement_per_title AS ct;
-- Check the table
SELECT * FROM retirement_title_count;

-- Mentiorship Eligibility emploees by most recent title
SELECT emp_no,
    first_name,
	last_name,
	title,
	from_date,
	to_date
INTO current_mentor_info
FROM 
   (SELECT 
	e.emp_no,
    e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date,
	   ROW_NUMBER() OVER
       (PARTITION BY (e.emp_no)
       ORDER BY ti.from_date DESC) rn  
	   FROM titles AS ti
            INNER JOIN employees AS e
	            ON (e.emp_no = ti.emp_no)
	        INNER JOIN dept_emp AS de
	            ON (e.emp_no = de.emp_no)
       WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
       AND (de.to_date = '9999-01-01') )
	   tmp WHERE rn = 1
ORDER BY emp_no;
-- Check the table
SELECT * FROM current_mentor_info;



