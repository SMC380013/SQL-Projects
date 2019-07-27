DROP TABLE departments;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;

CREATE TABLE departments (
    dept_no VARCHAR PRIMARY KEY,
    dept_name VARCHAR NOT NULL);

CREATE TABLE dept_emp (
    emp_no INTEGER,
    dept_no VARCHAR NOT NULL,
    from_date VARCHAR NOT NULL,
    to_date VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR,
    emp_no INTEGER,
    from_date VARCHAR NOT NULL,
    to_date VARCHAR NOT NULL
);

CREATE TABLE employees (
    emp_no INTEGER PRIMARY KEY,
    birth_date VARCHAR NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    gender VARCHAR NOT NULL,
    hire_date VARCHAR NOT NULL
);

CREATE TABLE salaries (
    emp_no INTEGER PRIMARY KEY,
    salary INTEGER NOT NULL,
    from_date VARCHAR NOT NULL,
    to_date VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles (
    emp_no INTEGER,
    title VARCHAR NOT NULL,
    from_date VARCHAR NOT NULL,
    to_date VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

-- (1) List the following details of each employee: 
--employee number, last name, first name, gender, and salary.

SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no=s.emp_no;

-- (2) List employees who were hired in 1986.

SELECT e.emp_no, e.first_name, e.last_name, e.hire_date
FROM employees AS e
WHERE hire_date LIKE '1986%';

-- (3) List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.

SELECT d.dept_no, d.emp_no, d.from_date, d.to_date, e.first_name, 
e.last_name, de.dept_name
FROM dept_manager AS d
INNER JOIN employees AS e ON
d.emp_no=e.emp_no
INNER JOIN departments AS de ON
d.dept_no=de.dept_no;

-- (4) List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, de.dept_name
FROM employees AS e 
INNER JOIN dept_emp AS d ON
e.emp_no=d.emp_no
INNER JOIN departments AS de ON
d.dept_no=de.dept_no;

-- (5) List all employees whose first name is "Hercules" 
-- and last names begin with "B."

SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- (6) List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, de.dept_name
FROM employees AS e 
INNER JOIN dept_emp AS d ON
e.emp_no=d.emp_no
INNER JOIN departments AS de ON
d.dept_no=de.dept_no
WHERE dept_name = 'Sales';

-- (7) List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, de.dept_name
FROM employees AS e 
INNER JOIN dept_emp AS d ON
e.emp_no=d.emp_no
INNER JOIN departments AS de ON
d.dept_no=de.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- (8) In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP By last_name
ORDER BY "Last Name Count" DESC;

