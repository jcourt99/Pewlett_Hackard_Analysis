--Create list with the titles for all retirement-eligible employees 
select e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date 
into ret_titles
from employees e 
join titles t 
on e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by emp_no 
;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title 
INTO unique_titles
FROM ret_titles rt 
WHERE rt.to_date = ('9999-01-01')
ORDER by emp_no, to_date  DESC;

--Write a query to count the number of retirement-eligible employees by most recent job title
select count(ut.emp_no), ut.title
into retiring_titles
from unique_titles ut 
group by title
order by count desc;

--Write a query to determine mentorship eligibility
select distinct on(emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
into mentorship_eligibility
from employees e 
inner join dept_emp de  
on (e.emp_no = de.emp_no)
inner join titles t 
on (e.emp_no = t.emp_no)
where de.to_date = ('9999-01-01')
and  (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by emp_no asc;

