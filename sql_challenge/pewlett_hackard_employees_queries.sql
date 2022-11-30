-- 1) List the following details of each employee: employee number, last name, first name, sex, and salary.
Select
	e.emp_num as employ_num,
	e.first_name,
	e.last_name,
	e.gender,
	s.income
From
	employees e
	join salary s on e.emp_num= s.emp_num
ORDER BY
	s.income desc;


-- 2) List first name, last name, and hire date for employees who were hired in 1986.
Select
	e.last_name,
	e.first_name,
	e.start_date
From
	employees e
Where
	extract(year from e.start_date)=1986
order by
	e.start_date asc;
	
	
-- 3) List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

Select
	d.dep_num,
	d.dep_name,
	e.last_name,
	e.first_name
From
	departments d
	join dep_mngmt dm on d.dep_num=dm.dep_num
	join employees e on dm.emp_num=e.emp_num;




-- 4) List the department of each employee with the following information: employee number, last name, first name, and department name.
Select
	employees.emp_num,
	employees.last_name,
	employees.first_name,
	departments.dep_name
from
	employees
	join dep_emp on employees.emp_num=dep_emp.emp_num
	join departments on dep_emp.dep_num=departments.dep_num;


-- 5) List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
Select
	employees.first_name,
	employees.last_name,
	employees.gender
from 
	employees
where first_name='Hercules' AND last_name LIKE 'B%';


-- 6) List all employees in the Sales department, including their employee number, last name, first name, and department name.
Select
	employees.emp_num,
	employees.last_name,
	employees.first_name,
	departments.dep_name
From
	employees
	join dep_emp on employees.emp_num=dep_emp.emp_num
	join departments on dep_emp.dep_num=departments.dep_num

Where
	departments.dep_name='Sales';

-- 7) List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

Select
	employees.emp_num,
	employees.last_name,
	employees.first_name,
	departments.dep_name
from
	employees
	join dep_emp on employees.emp_num=dep_emp.emp_num
	join departments on dep_emp.dep_num=departments.dep_num
Where
	departments.dep_name='Sales'  OR departments.dep_name='Development';



-- 8) List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.

Select
	e.last_name,
	count(*) 
From
	employees e
group by
	e.last_name
order by 
	count(*) desc;
