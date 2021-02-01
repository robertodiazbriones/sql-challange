/*Data Engineering*/
-- Create table titles
CREATE TABLE titles(
	title_id VARCHAR PRIMARY KEY,
	title VARCHAR
	) 

SELECT * FROM titles

-- Create table employees
CREATE TABLE employees(
	emp_no DEC PRIMARY KEY,
	emp_title_id VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
	)
	
SELECT * FROM employees

-- Create table salaries
CREATE TABLE salaries(
	emp_no DEC,
	salary DEC,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no) 
	)
	
SELECT * FROM salaries
	
-- Create table departmets
CREATE TABLE departments(
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
	)
	
SELECT * FROM departments
	
-- Create table dept_emp
CREATE TABLE dept_emp(
	emp_no DEC,
	dept_no VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	)
	
SELECT * FROM dept_emp
	
-- Create table dept_manger
CREATE TABLE dept_manager(
	dept_no VARCHAR,
	emp_no DEC,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	)
	
SELECT * FROM dept_manager

/*Data Analisis*/
--1.List the following details of each employee: employee number, last name, first name, sex, and salary 

SELECT e.emp_no, e.last_name, e.first_name,	e.sex, s.salary 
FROM employees e
JOIN salaries s
ON (e.emp_no=s.emp_no)

--2.List first name, last name, and hire date for employees who were hired in 1986

SELECT e.emp_no, e.first_name, e.last_name, e.hire_date 
FROM employees e
WHERE (e.hire_date >= '1986-01-01' AND e.hire_date <= '1986-12-31')

--3.List the manager of each department with the following information: department number, department name,
--the manager's employee number, last name, first name.
SELECT first_name, last_name
FROM employees
WHERE emp_no
IN (
   SELECT emp_no
    FROM dept_man
    WHERE dept_no
    IN (
        SELECT dept_no
        FROM departments
        WHERE dept_name
        IN (
              SELECT title_id
              FROM titles
              WHERE emp_title_id = 'Manager'
            )
        )
  );


SELECT dept_name
FROM departments
WHERE dept_no
IN (
   SELECT dept_no 
    FROM dept_manager
    WHERE emp_no
    IN (
        SELECT first_name     
		FROM employees 
        WHERE emp_title_id
        IN (
              SELECT title_id
              FROM titles
              WHERE title = 'Manager'
            )
        )
  )

SELECT dept_no 
FROM dept_manager
WHERE emp_no
IN (
	SELECT emp_no, first_name, last_name     
	FROM employees
	WHERE emp_no
	IN (
		SELECT 
    	
	)




SELECT emp_no,first_name, last_name      
FROM employees
WHERE emp_title_id
     IN (
              SELECT title_id
              FROM titles
              WHERE emp_title_id = 'Manager'
		 
--4 List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name,e.first_name, d.dept_name   
FROM employees AS e
INNER JOIN (SELECT dept_no, emp_no
	FROM dept_emp) de ON e.emp_no = de.emp_no
INNER JOIN (SELECT dept_no, dept_name
	FROM departments) d ON de.dept_no = d.dept_no
		 
--5 List first name, last name, and sex for employees whose first name is 
--"Hercules" and last names begin with "B."
SELECT first_name, last_name, sex       
FROM employees as e
WHERE e.first_name='Hercules' AND e.last_name LIKE '%B%'
		 
--6 List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name  
FROM employees AS e 
WHERE emp_no
IN (
    SELECT emp_no
    FROM dept_emp
    WHERE dept_no 
    IN (
		SELECT dept_no
		FROM departments
		WHERE dept_name='Sales'
		)
	)
		 
--7. List all employees in the Sales and Development departments,
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name  
FROM employees AS e 
WHERE emp_no
IN (
    SELECT emp_no
    FROM dept_emp
    WHERE dept_no 
    IN (
		SELECT dept_no
		FROM departments
		WHERE dept_name='Sales' OR dept_name='Development'
		)
	)

--8 In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT COUNT(emp_no), last_name
FROM employees AS e
GROUP BY e.last_name
ORDER BY COUNT(emp_no) DESC


