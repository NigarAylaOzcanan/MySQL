use employees;
SELECT * FROM `employees`.`departments`;
SELECT * FROM `employees`.`dept_emp`;
SELECT * FROM `employees`.`dept_manager`; 
SELECT * FROM `employees`.`employees`;
SELECT * FROM `employees`.`salaries`;
SELECT * FROM `employees`.`titles`;

-- 1. List all employees in department D001.
-- D001 departmanındaki tüm çalışanları listele

select dept_emp.dept_no, employees.first_name, employees.last_name, employees.gender
from dept_emp 
left join employees on dept_emp.emp_no=employees.emp_no 
where dept_emp.dept_no='D001';

-- 2. List all employees in 'Human Resources' department. 
-- İnsan Kaynakları' departmanındaki tüm çalışanları listele.

select employees.first_name, employees.last_name, employees.gender, dept_emp.dept_no, departments.dept_name
from employees
left join dept_emp on employees.emp_no=dept_emp.emp_no
left join departments on dept_emp.dept_no=departments.dept_no
where departments.dept_name='Human Resources';

-- 3. Calculate the average salary of all employees
-- Tüm çalışanların ortalama maaşını hesapla.
-- 1 : 
select avg(salaries.salary) as avarage_salary
from employees
left join salaries on employees.emp_no=salaries.emp_no;

-- 2: 
select avg(salary) AS average_salary
FROM salaries;

-- 4. Calculate the average salary of all employees with gender "M"
-- "Erkek" cinsiyetindeki tüm çalışanların ortalama maaşını hesapla.
select avg(salaries.salary) as average_salary, employees.gender 
from employees
left join salaries on employees.emp_no=salaries.emp_no
where employees.gender='M';

-- 5. Calculate the average salary of all employees with gender "F"
-- "Kadın" cinsiyetindeki tüm çalışanların ortalama maaşını hesapla.
select avg(salaries.salary) as average_salary, employees.gender 
from employees
left join salaries on employees.emp_no=salaries.emp_no
where employees.gender='F';

-- 6. List all employees in the "Sales" department with a salary greater than 70,000.
-- Maaşı 70.000'den yüksek olan "Satış" departmanındaki tüm çalışanları listele.

select employees.first_name, employees.last_name, employees.gender, dept_emp.dept_no, departments.dept_name,salaries.salary
from employees
left join salaries on employees.emp_no = salaries.emp_no
left join dept_emp on employees.emp_no = dept_emp.emp_no
left join departments on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales' and salaries.salary > 70000
group by employees.first_name, employees.last_name, employees.gender, dept_emp.dept_no, departments.dept_name;

-- 7. This query retrieves employees who have salaries between 50000 and 100000.
-- Bu sorgu, maaşı 50.000 ile 100.000 arasında olan çalışanları getirir.

select employees.first_name, employees.last_name, employees.gender,salaries.salary
from employees
left join salaries on employees.emp_no = salaries.emp_no
left join dept_emp on employees.emp_no = dept_emp.emp_no
where salaries.salary between 50000 and 100000
group by employees.first_name, employees.last_name, employees.gender;

-- 8. Calculate the average salary for each department (by department number or department name)
-- Her departmanın ortalama maaşını hesapla (departman numarasına veya departman adına göre).

select dept_emp.dept_no, avg(salaries.salary) as average_salary
from dept_emp
left join salaries on dept_emp.emp_no=salaries.emp_no
left join departments on dept_emp.dept_no=departments.dept_no
group by dept_emp.dept_no 
order by dept_emp.dept_no asc;       -- ---->  *calculated by department number

-- 9. Calculate the average salary for each department, including department names
-- Departman adlarını da içeren her departmanın ortalama maaşını hesapla.

select departments.dept_name, avg(salaries.salary) as average_salary 
from departments
left join dept_emp on departments.dept_no=dept_emp.dept_no
left join salaries on dept_emp.emp_no=salaries.emp_no
group by departments.dept_name 
order by average_salary desc;  -- -------> calculated by department name

-- 10. Find all salary changes for employee with emp. no '10102'
-- '10102' iş numarasına sahip çalışanın tüm maaş değişikliklerini bul.

select * from salaries
where emp_no=10102;

-- 11. Find the salary increases for employee with employee number '10102' (using the to_date column in salaries)
-- Maaş numarası '10102' olan çalışanın maaş artışlarını bul ('to_date' sütununu kullanarak).

select emp_no, from_date, to_date, salary
from salaries
where emp_no=10102
order by from_date;

-- 12. Find the employee with the highest salary
-- En yüksek maaşa sahip çalışanı bul.

select salaries.emp_no, employees.first_name, employees.last_name, max(salary) as highestSalary
from salaries
left join employees on salaries.emp_no=employees.emp_no
group by salaries.emp_no order by highestSalary desc limit 1;

-- 13. Find the latest salaries for each employee
-- Her çalışanın en son maaşlarını bul.
select salaries.emp_no, max(from_date) as latestDate, salaries.salary, employees.first_name, employees.last_name
from salaries
left join employees on salaries.emp_no=employees.emp_no
group by salaries.emp_no; 

-- 14. List the first name, last name, and highest salary of employees in the "Sales" department.
-- Order the list by highest salary descending and only show the employee with the highest salary.
-- "Satış" departmanındaki çalışanların adını, soyadını ve en yüksek maaşını listele.
-- Listeyi en yüksek maaşa göre azalan şekilde sırala ve sadece en yüksek maaşa sahip çalışanı göster.

select 
employees.first_name, 
employees.last_name, 
max(avsalaries.salary) as highestSalary
from employees
left join dept_emp on employees.emp_no=dept_emp.emp_no
left join departments on dept_emp.dept_no=departments.dept_no
left join salaries on dept_emp.emp_no=salaries.emp_no
where departments.dept_name='Sales'
group by employees.emp_no, employees.first_name, employees.last_name
order by highestSalary desc limit 1;


-- 15. Find the Employee with the Highest Salary Average in the Research Department
-- Araştırma Departmanındaki Ortalama En Yüksek Maaşlı Çalışanı Bul

select 
 employees.first_name,
 employees.last_name,
 avg(salaries.salary) as averageSalary
from employees
left join dept_emp on employees.emp_no=dept_emp.emp_no
left join departments on dept_emp.dept_no=departments.dept_no
left join salaries on dept_emp.emp_no=salaries.emp_no
where departments.dept_name='Research'
group by employees.emp_no, employees.first_name, employees.last_name
order by averageSalary desc limit 1; 


-- 16. For each department, identify the employee with the highest single salary ever recorded. List the
-- department name, employee's first name, last name, and the peak salary amount. Order the results by the peak salary in descending order.
-- Her departman için, kaydedilmiş en yüksek tek maaşı belirle. Departman adını, çalışanın adını, 
-- soyadını ve en yüksek maaş tutarını listele. Sonuçları en yüksek maaşa göre azalan şekilde sırala.

select 
 departments.dept_name,
 employees.first_name,
 employees.last_name,
 max(salaries.salary) as highestSalary
from employees
left join dept_emp on employees.emp_no=dept_emp.emp_no
left join departments on dept_emp.dept_no=departments.dept_no
left join salaries on dept_emp.emp_no=salaries.emp_no
group by departments.dept_name 
order by highestSalary desc;


-- 17. Identify the employees in each department who have the highest average salary. List the
-- department name, employee's first name, last name, and the average salary. Order the results by
-- average salary in descending order, showing only those with the highest average salary within their
-- department.
-- Her departmandaki en yüksek ortalama maaşa sahip çalışanları belirle. Departman adını,
-- çalışanın adını, soyadını ve ortalama maaşı listele. Sonuçları departmanlarına göre azalan şekilde
-- sırala, sadece kendi departmanlarında en yüksek ortalama maaşa sahip olanları göster.

SELECT d.dept_name AS department, e.first_name, e.last_name, AVG(s.salary) AS avg_salary
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
INNER JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY department
ORDER BY avg_salary DESC;


-- 18. List the names, last names, and hire dates in alphabetical order of all employees hired before
-- January 01, 1990.
-- 1990-01-01 tarihinden önce işe alınan tüm çalışanların adlarını, soyadlarını ve işe alınma
-- tarihlerini alfabetik sırayla listele.

select
 employees.first_name,
 employees.last_name, 
 employees.hire_date 
from employees
where employees.hire_date < '1990-01-01'
order by employees.first_name, employees.last_name;

-- 19. List the names, last names, hire dates of all employees hired between January 01, 1985 and
-- December 31, 1989, sorted by hire date.
-- 1985-01-01 ile 1989-12-31 tarihleri arasında işe alınan tüm çalışanların adlarını, soyadlarını ve işe
-- alınma tarihlerini işe alınma tarihine göre sıralı olarak listele.

select 
 employees.first_name,
 employees.last_name,
 employees.hire_date
from employees
where employees.hire_date 
between'1985-01-01'and '1989-12-31 '
order by employees.hire_date;

-- 20. List the names, last names, hire dates, and salaries of all employees in the Sales department who
-- were hired between January 01, 1985 and December 31, 1989, sorted by salary in descending order.
-- 1985-01-01 ile 1989-12-31 tarihleri arasında işe alınan Satış departmanındaki tüm çalışanların
-- adlarını, soyadlarını, işe alınma tarihlerini ve maaşlarını, maaşa göre azalan şekilde sıralı olarak listele.

select 
employees.first_name,
employees.last_name,
employees.hire_date,
salaries.salary 
from employees
left join salaries on employees.emp_no=salaries.emp_no
left join dept_emp on salaries.emp_no=dept_emp.emp_no
left join departments on dept_emp.dept_no=departments.dept_no
where departments.dept_name='Sales' and employees.hire_date between '1985-01-01' and '1989-12-31'
order by salaries.salary desc;


-- 21. a: Find the count of male employees (179973)
-- Erkek çalışanların sayısını bulun (179973)
-- b: Determine the count of female employees (120050)
-- Kadın çalışanların sayısını belirleyin (120050)
-- c: Find the number of male and female employees by grouping:
-- Gruplandırarak erkek ve kadın çalışanların sayısını bulun:
-- d: Calculate the total number of employees in the company (300023)
-- Şirketteki toplam çalışan sayısını hesaplayın (300023)

select 
(select count(*) from employees where employees.gender='M' ) as maleCount,
(select count(*) from employees where employees.gender='F' ) as femaleCount,
employees.gender, count(*) as employeeCount,
(select count(*) from employees ) as totalCount
from employees group by employees.gender;


-- 22. a: Find out how many employees have unique first names (1275)
-- Kaç çalışanın benzersiz ilk adı olduğunu bulun (1275)
-- b: Identify the number of distinct department names (9)
-- Farklı bölüm adlarının sayısını belirleyin (9)

select
 count(distinct employees.first_name) as uniqueNamesCount,
 count(distinct departments.dept_name) as distinctDeptNameCount
 from employees
 left join dept_emp on employees.emp_no=dept_emp.emp_no
 left join departments on dept_emp.dept_no=departments.dept_no;
 
	
-- 23. List the number of employees in each department
-- Her bölümdeki çalışan sayısını listele

select  departments.dept_name, count(*) as employeesCount
from employees
left join dept_emp on employees.emp_no=dept_emp.emp_no
left join departments on dept_emp.dept_no=departments.dept_no
group by departments.dept_name
union
select 'Total Count', count(*) from employees;


-- 24. List all employees hired within the last 5 years from February 20, 1990
-- 1990-02-20 tarihinden sonraki son 5 yıl içinde işe alınan tüm çalışanları listele

select 
 employees.first_name,
 employees.last_name, 
 employees.hire_date
from employees 
where employees.hire_date between '1990-02-20' and '1995-02-20' ;

-- 25. List the information (employee number, date of birth, first name, last name, gender, hire date) of
-- the employee named "Annemarie Redmiles".
-- "Annemarie Redmiles" adlı çalışanın bilgilerini (çalışan numarası, doğum tarihi, ilk adı, soyadı,
-- cinsiyet, işe alınma tarihi) listele.

select 
employees.emp_no,
employees.birth_date,
employees.first_name,
employees.last_name,
employees.gender,
employees.hire_date
from employees
where employees.first_name='Annemarie' and employees.last_name='Redmiles';

-- 26. List all information (employee number, date of birth, first name, last name, gender, hire date,
-- salary, department, and title) for the employee named "Annemarie Redmiles".
-- "Annemarie Redmiles" adlı çalışanın tüm bilgilerini (çalışan numarası, doğum tarihi, ilk adı,
-- soyadı, cinsiyet, işe alınma tarihi, maaş, departman ve unvan) listele.

select 
employees.emp_no,
employees.birth_date,
employees.first_name,
employees.last_name,
employees.gender,
employees.hire_date,
salaries.salary,
departments.dept_name,
titles.title
from employees
left join dept_emp on employees.emp_no=dept_emp.emp_no 
left join departments on dept_emp.dept_no=departments.dept_no 
left join titles on employees.emp_no=titles.emp_no 
left join salaries on employees.emp_no=salaries.emp_no
where employees.first_name='Annemarie'
 and  employees.last_name='Redmiles'; 


select 
employees.emp_no,
employees.birth_date,
employees.first_name,
employees.last_name,
employees.gender,
employees.hire_date,
salaries.salary,
departments.dept_name,
titles.title
from employees
left join dept_emp on employees.emp_no=dept_emp.emp_no 
left join departments on dept_emp.dept_no=departments.dept_no 
left join (select emp_no,title, max(from_date) as maxfrom_date 
from titles group by emp_no) as latest_titles on employees.emp_no = latest_titles.emp_no
left join titles on latest_titles.emp_no = titles.emp_no and latest_titles.maxfrom_date = titles.from_date
left join salaries on employees.emp_no=salaries.emp_no
where employees.first_name='Annemarie'
 and  employees.last_name='Redmiles'; 

-- 27. List all employees and managers in the D005 department
-- D005 bölümündeki tüm çalışanları ve yöneticileri listele
select 
 employees.emp_no,
 employees.first_name,
 employees.last_name,
 departments.dept_name,
 employees.gender
 from employees
 inner join dept_emp on employees.emp_no=dept_emp.emp_no
 inner join departments on dept_emp.dept_no=departments.dept_no
 inner join dept_manager on dept_emp.dept_no=dept_manager.dept_no
 where dept_emp.dept_no='d005';


-- 28. List all employees hired after '1994-02-24' and earning more than 50,000
-- '1994-02-24' tarihinden sonra işe alınan ve 50.000'den fazla kazanan tüm çalışanları listele

select 
 employees.emp_no,
 employees.first_name,
 employees.last_name, 
 employees.hire_date
from employees 
left join salaries on employees.emp_no=salaries.emp_no
where employees.hire_date > '1994-02-24' 
and salaries.salary >'50000'
group by employees.emp_no,
 employees.first_name,
 employees.last_name, 
 employees.hire_date;

-- 29. List all employees working in the "Sales" department with the title "Manager"
-- "Satış" bölümünde "Yönetici" unvanıyla çalışan tüm çalışanları listele

select
 employees.emp_no,
 employees.first_name,
 employees.last_name, 
 titles.title,
 departments.dept_name
from employees
left join dept_emp on employees.emp_no=dept_emp.emp_no
left join departments on dept_emp.dept_no=departments.dept_no
left join titles on employees.emp_no=titles.emp_no
where departments.dept_name='Sales'
and titles.title='Manager';
 

-- 30. Find the department where employee with '10102' has worked the longest
-- '10102' numaralı çalışanın en uzun süre çalıştığı departmanı bul


-- 31. Find the highest paid employee in department D004
-- D004 bölümünde en yüksek maaş alan çalışanı bulun
select 
  employees.emp_no,
  employees.first_name,
  employees.last_name, 
  departments.dept_name,
  max(salaries.salary) as highestSalary
 from employees
 left join dept_emp on employees.emp_no=dept_emp.emp_no
 left join salaries on employees.emp_no=salaries.emp_no
 left join departments on dept_emp.dept_no=departments.dept_no
 where departments.dept_no='d004'
 group by
  employees.emp_no,
  employees.first_name,
  employees.last_name 
 order by highestSalary desc limit 1;

-- 32. Find the entire position history for employee with emp. no '10102'
-- '10102' numaralı çalışanın tüm pozisyon geçmişini bulun
 select titles.emp_no, titles.title, titles.from_date, titles.to_date
 from titles 
 where titles.emp_no='10102' order by titles.from_date;
 
-- 33. Finding the average "employee age"
-- Ortalama "çalışan yaşını" bulma

select (2024-(avg(left(birth_date,4)))) as ageAverage from employees ;

-- 2. yol 
select (year(current_date())-(avg(year(birth_date)))) as ageAverage from employees ;

-- 34. Finding the number of employees per department
-- Bölüm başına çalışan sayısını bulma

select dept_no, COUNT(*) as employee_count
from dept_emp
group by dept_no;

-- 35. Finding the managerial history of employee with ID (emp. no) 110022
-- 110022 numaralı çalışanın yönetim geçmişini bulma

select employees.first_name, employees.last_name, dept_manager.from_date, dept_manager.to_date
from employees
left join dept_manager on employees.emp_no = dept_manager.emp_no
where employees.emp_no = '110022';

-- 36. Find the duration of employment for each employee
-- Her çalışanın istihdam süresini bulma


-- 37. Find the latest title information for each employee
-- Her çalışanın en son unvan bilgisini bulma

select employees.emp_no, employees.first_name, employees.last_name, titles.title
from employees
left join titles on employees.emp_no = titles.emp_no
where titles.to_date = (select max(to_date) from titles where titles.emp_no = employees.emp_no);

-- 38. Find the first and last names of managers in department 'D005'
-- 'D005' bölümünde yöneticilerin adını ve soyadını bulma

select employees.first_name, employees.last_name
from employees
left join dept_manager on employees.emp_no = dept_manager.emp_no
where dept_manager.dept_no = 'd005';

-- 39. Sort employees by their birth dates
-- Çalışanları doğum tarihlerine göre sıralama
select *  from employees order by birth_date;

-- 40. List employees hired in April 1992
-- Nisan 1992'de işe alınan çalışanları listeleme
select * from employees
where hire_date between '1992-04-01' and '1992-04-30';

-- 41. Find all departments that employee '10102' has worked in.
-- '10102' numaralı çalışanın çalıştığı tüm bölümleri bulma.

select dept_no
from dept_emp
where emp_no = '10102';

-- 2.yol
select departments.dept_name
from dept_emp
inner join departments on dept_emp.dept_no = departments.dept_no
where dept_emp.emp_no = '10102';
