# 1. Find Employees with Minimum Salary
Eng kam ish haqi bolgan xodimlarni toping
**Task: Retrieve employees who earn the minimum salary in the company.**
**Tables: employees (columns: id, name, salary)**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000); 

select * from employees 

select* from employees 
where salary =(select min(salary)from employees)

```

# 2. Find Products Above Average Price

**Task: Retrieve products priced above the average price.**
**Tables: products (columns: id, product_name, price)**
```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

select * from products
where price>(select avg(price)from products)

---
# Easy Tasks

1. Create a numbers table using a recursive query from 1 to 1000. 

declare @num int =1

while @num <= 1000
begin 
     print @num
	 set @num= @num+1
end

2. Write a query to find the total sales per employee using a derived table.(Sales, Employees) 
Olingan jadvaldan foydalanib, har bir xodimga to'g'ri keladigan jami sotishni topish uchun sorov yozing 
select * from Sales
select * from Employeess


select * from Sales
select * from Employeess

select Emp.EmployeeID, Emp.FirstName, Sal.total_sales from Employeess as Emp
join (select EmployeeID, sum(SalesAmount) as total_sales 
       from Sales
       group by EmployeeID) as Sal
	   on Emp.EmployeeID= Sal.EmployeeID  


3. Create a CTE to find the average salary of employees.(Employees) 
Xodimlarning ortacha ish haqini topish uchun CTE yarating

select * from Employeess 
where Salary>(select avg(salary) from Employeess)


4. Write a query using a derived table to find the highest sales for each product.(Sales, Products)  
Har bir mahsulot uchun eng yuqori sotuvni topish uchun olingan jadvaldan foydalanib sorov yozing.(Sotish, Mahsulotlar)
 select * from Sales
 select * from Productss 

 select * from Sales as sal
 join (select ProductID, max(Price) as produc_price from Productss 
 group by ProductID) as p
 on sal.ProductID=p.ProductID 
 
5. Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000. 
1 dan boshlab, har bir yozuv uchun raqamni ikki barobarga oshirish uchun bayonot yozing, maksimal qiymat 1000000 dan kam bolishi kerak. 
 

 declare @num int=1

 while @num<1000000
 begin
 print @num
 set @num=@num*2
 end

 
6. Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees) 
5 dan ortiq savdoni amalga oshirgan xodimlarning ismlarini olish uchun CTE dan foydalaning.(Sotish, Xodimlar) 

select e.EmployeeID,e.FirstName, s.sale_count 
from Employeess as e
join (
select EmployeeID, count(*) as sale_count 
from Sales
group by EmployeeID
)as s
on e.EmployeeID=s.EmployeeID 
where s.sale_count>5 ;

7. Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
7. Savdosi 500$ dan ortiq boʻlgan barcha mahsulotlarni topish uchun CTE yordamida soʻrov yozing.(Sotish, Mahsulotlar)
select * from Sales
select *from Productss 
SELECT p.product_id,p.product_name,s.total_sales FROM Products p
JOIN (SELECT product_id, SUM(sale_amount) AS total_sales FROM Sales
    GROUP BY product_id
) s ON p.product_id = s.product_id
WHERE s.total_sales > 500;

select P.ProductID,P.ProductName, S.total_sales from Productss as p 
join (select ProductID, sum (SalesAmount) as total_sales from Sales 
group by ProductID) as S
on P.ProductID=S.ProductID
where total_sales >500







8. Create a CTE to find employees with salaries above the average salary.(Employees)



# Medium Tasks
1. Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
2. Write a query using a derived table to find the sales per product category.(Sales, Products)
3. Write a script to return the factorial of each value next to it.(Numbers1)
4. This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
5. Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
6. Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)


# Difficult Tasks
1. This script uses recursion to calculate Fibonacci numbers
2. Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
3. Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
4. Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
5. Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

## Level 2: Nested Subqueries with Conditions

**3. Find Employees in Sales Department**
**Task: Retrieve employees who work in the "Sales" department.**
**Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)**
```sql
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);
```

CREATE TABLE Numbers1(Number INT)
# 4. Find Customers with No Orders

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)
**Task: Retrieve customers who have not placed any orders.**
**Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)**
```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);
```
---

## Level 3: Aggregation and Grouping in Subqueries

CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )
# 5. Find Products with Max Price in Each Category

**Task: Retrieve products with the highest price in each category.**
**Tables: products (columns: id, product_name, price, category_id)**
```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);
```

# 6. Find Employees in Department with Highest Average Salary

**Task: Retrieve employees working in the department with the highest average salary.**
**Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)**
```sql
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);
```
---

## Level 4: Correlated Subqueries

INSERT INTO Example VALUES('123456789'),('abcdefghi');
# 7. Find Employees Earning Above Department Average

**Task: Retrieve employees earning more than the average salary in their department.**
**Tables: employees (columns: id, name, salary, department_id)**
```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);
```

# 8. Find Students with Highest Grade per Course

CREATE TABLE Employeess (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2))
**Task: Retrieve students who received the highest grade in each course.**
**Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)**
```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE Employeess (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2))
INSERT INTO Employeess (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE)
INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);
```
---

## Level 5: Subqueries with Ranking and Complex Conditions

**9. Find Third-Highest Price per Category**
**Task: Retrieve products with the third-highest price in each category.**
**Tables: products (columns: id, product_name, price, category_id)**
```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
); 

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE)
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');
CREATE TABLE Productss (
    ProductID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    CategoryID INT
);
INSERT INTO Productss (ProductID, ProductName, Price, CategoryID) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

```

# 10. Find Employees whose Salary Between Company Average and Department Max Salary

**Task: Retrieve employees with salaries above the company average but below the maximum in their department.**
**Tables: employees (columns: id, name, salary, department_id)**
```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);
INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1); 






 Lesson-15: CTEs and Derived Tables
# Lesson-15: Subqueries and Exists

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.



## Level 1: Basic Subqueries

# 1. Find Employees with Minimum Salary
Eng kam ish haqi bolgan xodimlarni toping 

**Task: Retrieve employees who earn the minimum salary in the company.**
**Tables: employees (columns: id, name, salary)**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000); 

select * from employees 
where salary =(select min(salary) from employees)

```

# 2. Find Products Above Average Price

**Task: Retrieve products priced above the average price.**
**Tables: products (columns: id, product_name, price)**
```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300); 

select * from products 
where price >(select avg(price) from products)

```
---
# Easy Tasks

1. Create a numbers table using a recursive query from 1 to 1000. 
1 dan 1000 gacha bo'lgan rekursiv so'rov yordamida raqamlar jadvalini yarating. 


DECLARE @i INT = 1;

WHILE @i <= 1000
BEGIN
    PRINT @i;
    SET @i = @i + 1;
END


2. Write a query to find the total sales per employee using a derived table.(Sales, Employees) 
Olingan jadvaldan foydalanib, bir xodimga to'g'ri keladigan jami sotishni topish uchun sorov yozing.(Sotish, Xodimlar)  

select * from Employees
select * from Sales 


3. Create a CTE to find the average salary of employees.(Employees)
4. Write a query using a derived table to find the highest sales for each product.(Sales, Products)
5. Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
6. Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
7. Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
8. Create a CTE to find employees with salaries above the average salary.(Employees)


# Medium Tasks
1. Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
2. Write a query using a derived table to find the sales per product category.(Sales, Products)
3. Write a script to return the factorial of each value next to it.(Numbers1)
4. This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
5. Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
6. Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)


# Difficult Tasks
1. This script uses recursion to calculate Fibonacci numbers
2. Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
3. Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
4. Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
5. Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

## Level 2: Nested Subqueries with Conditions

**3. Find Employees_ in Sales Department** 
Savdo bolimida xodimlarni toping
**Task: Retrieve employees_ who work in the "Sales" department.**
**Tables: employees_ (columns: id, name, department_id), departments (columns: id, department_name)** 
select * from departments
select * from employees_ 

SELECT e.id, e.name
FROM employees_ e
JOIN departments d ON e.department_id = d.id
WHERE d.department_name = 'Sales';


```sql 
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees_ (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees_ (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);
```

CREATE TABLE Numbers1(Number INT)
# 4. Find Customers with No Orders 
Buyurtmasiz mijozlarni toping 

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)
**Task: Retrieve customers who have not placed any orders.**
**Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)**
select * from customers
select * from orders  

select *,(select name from customers where customers.customer_id= orders.order_id) from orders 
select * from customers


```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);
```
---

## Level 3: Aggregation and Grouping in Subqueries

CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )
# 5. Find Products_ with Max Price in Each Category
Har bir turkumda maksimal narxga ega mahsulotlarni toping 

**Task: Retrieve products_ with the highest price in each category.**
**Tables: products_ (columns: id, product_name, price, category_id)** 
select * from products_
 
 select * from products_
 where price= (select max(price) from products_) 


```sql
CREATE TABLE products_ (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products_ (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);
```

# 6. Find Employees in Department with Highest Average Salary
Bolimda eng yuqori o'rtacha ish haqi bo'lgan xodimlarni toping
**Task: Retrieve employees working in the department with the highest average salary.**
**Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)** 

select * from departments_
select * from employees_e 

SELECT e.name, e.salary, d.department_name
FROM employees_e e
JOIN departments_ d ON e.department_id = d.id
WHERE e.department_id = (
    SELECT top 1 department_id
    FROM employees_e
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

```sql 
CREATE TABLE departments_ (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees_e (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments_ (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees_e (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2); 


CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL

```
---

## Level 4: Correlated Subqueries

INSERT INTO Example VALUES('123456789'),('abcdefghi');
# 7. Find Employees Earning Above Department Average
Bo'lim o'rtachasidan yuqori daromad oladigan xodimlarni toping 

**Task: Retrieve employees earning more than the average salary in their department.**
**Tables: employees (columns: id, name, salary, department_id)**
```sql 
\  
select * from emp_loyees 

select emp_loyees.name, emp_loyees.salary, emp_loyees.department_id from emp_loyees
where emp_loyees.salary > (select avg(salary) from emp_loyees where emp_loyees.department_id = emp_loyees.department_id)

CREATE TABLE emp_loyees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO emp_loyees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);
```

# 8. Find Students with Highest Grade per Course 
Har bir kurs uchun eng yuqori bahoga ega talabalarni toping 

**Task: Retrieve students who received the highest grade in each course.**
**Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)** 

select * from students
select * from grades 

SELECT 
    g.course_id,
    s.student_id,
    s.name,
    g.grade
FROM grades g
JOIN (
    SELECT course_id, MAX(grade) AS max_grade
    FROM grades
    GROUP BY course_id
) mg ON g.course_id = mg.course_id AND g.grade = mg.max_grade
JOIN students s ON g.student_id = s.student_id;

select grades.course_id, students.student_id, name,grades.grade from grades 
join (select course_id, max(grade) as max_grade from grades group by course_id) 
max_grade on grades.course_id = max_grade.course_id and grades.grade= max_grade.grade 
join students 
on grades.student_id = students.student_id


```sql 
Find Students with Highest Grade per Course

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);
```
---

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'Garc?a', 77000.00),
(10, 1, 'William', 'Mart?nez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE

	INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE


## Level 5: Subqueries with Ranking and Complex Conditions

**9. Find Third-Highest Price per Category**
**Task: Retrieve products with the third-highest price in each category.**
**Tables: products (columns: id, product_name, price, category_id)**
```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);
```

# 10. Find Employees whose Salary Between Company Average and Department Max Salary

**Task: Retrieve employees with salaries above the company average but below the maximum in their department.**
**Tables: employees (columns: id, name, salary, department_id)**
```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);
INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);
