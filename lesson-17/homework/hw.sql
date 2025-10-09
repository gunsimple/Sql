create database homework_17
 /

@@ -1,404 +1,404 @@
# Lesson-17: Practice

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

---

### 1.
WITH DistinctRegions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
DistinctDistributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
AllCombinations AS (
    SELECT
        r.Region,
        d.Distributor
    FROM
        DistinctRegions r
    CROSS JOIN
        DistinctDistributors d
)
SELECT
    ac.Region,
    ac.Distributor,
    COALESCE(rs.Sales, 0) AS Sales
FROM
    AllCombinations ac
LEFT JOIN
    #RegionSales rs
ON
    ac.Region = rs.Region AND ac.Distributor = rs.Distributor
ORDER BY
    ac.Region,
    ac.Distributor;

---

### 2. Find managers with at least five direct reports

**SQL Setup:**
```sql
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);
```

**Input:**
```
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
```

**Expected Output:**
```
+------+
| name |
+------+
| John |
+------+
```
WITH ManagerReports AS (
    SELECT
        managerId,
        COUNT(*) AS reportCount
    FROM
        Employee
    WHERE
        managerId IS NOT NULL
    GROUP BY
        managerId
    HAVING
        COUNT(*) >= 5
)
SELECT
    e.name
FROM
    Employee e
JOIN
    ManagerReports mr ON e.id = mr.managerId;

```
You cal also solve this puzzle in Leetcode: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/?envType=study-plan-v2&envId=top-sql-50
```

---

### 3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

**SQL Setup:**
```sql
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);
```

**Input:**
```
| product_id  | product_name          | product_category |
+-------------+-----------------------+------------------+
| 1           | Leetcode Solutions    | Book             |
| 2           | Jewels of Stringology | Book             |
| 3           | HP                    | Laptop           |
| 4           | Lenovo                | Laptop           |
| 5           | Leetcode Kit          | T-shirt          |
```



**Expected Output:**
```
| product_name       | unit  |
+--------------------+-------+
| Leetcode Solutions | 130   |
| Leetcode Kit       | 100   |
```
WITH FebOrders AS (
    SELECT
        product_id,
        SUM(unit) AS total_units
    FROM
        Orders
    WHERE
        order_date >= '2020-02-01' AND order_date < '2020-03-01'
    GROUP BY
        product_id
    HAVING
        SUM(unit) >= 100
)
SELECT
    p.product_name,
    f.total_units AS unit
FROM
    FebOrders f
JOIN
    Products p ON f.product_id = p.product_id;

---

### 4. Write an SQL statement that returns the vendor from which each customer has placed the most orders


**SQL Setup:**
```sql
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');
```

**Input:**
```
|Order ID   | Customer ID | Order Count|     Vendor     |
---------------------------------------------------------
|Ord195342  |     1001    |      12    |  Direct Parts  |
|Ord245532  |     1001    |      54    |  Direct Parts  |
|Ord344394  |     1001    |      32    |     ACME       |
|Ord442423  |     2002    |      7     |     ACME       |
|Ord524232  |     2002    |      16    |     ACME       |
|Ord645363  |     2002    |      5     |  Direct Parts  |
```

**Expected Output:**
```
| CustomerID | Vendor       |
|------------|--------------|
| 1001       | Direct Parts |
| 2002       | ACME         |
```
WITH OrderCounts AS (
    SELECT
        CustomerID,
        Vendor,
        COUNT(*) AS NumOrders
    FROM
        Orders
    GROUP BY
        CustomerID,
        Vendor
),
MaxOrders AS (
    SELECT
        CustomerID,
        MAX(NumOrders) AS MaxOrderCount
    FROM
        OrderCounts
    GROUP BY
        CustomerID
)
SELECT
    oc.CustomerID,
    oc.Vendor
FROM
    OrderCounts oc
JOIN
    MaxOrders mo ON oc.CustomerID = mo.CustomerID AND oc.NumOrders = mo.MaxOrderCount;

---

### 5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'

**Example Input:**
```sql
DECLARE @Check_Prime INT = 91;
-- Your WHILE-based SQL logic here
```

**Expected Output:**
```
This number is not prime(or "This number is prime")
```

---

### 6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

**SQL Setup:**
```sql
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');
```





**Expected Output:**
```
| Device_id | no_of_location | max_signal_location | no_of_signals |
|-----------|----------------|---------------------|---------------|
| 12        | 2              | Bangalore           | 6             |
| 13        | 2              | Secunderabad        | 5             |
```
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;  -- Assume prime until proven otherwise

IF @Check_Prime <= 1
BEGIN
    SET @IsPrime = 0;  -- Numbers <= 1 are not prime
END
ELSE
BEGIN
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0; -- Divisible by @i, not prime
            BREAK;
        END
        SET @i = @i + 1;
    END
END

SELECT CASE WHEN @IsPrime = 1 THEN 'This number is prime'
            ELSE 'This number is not prime'
       END AS Result;

---

### 7. Write a SQL  to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output

**SQL Setup:**
```sql
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);
```

**Expected Output:**
```
| EmpID | EmpName | Salary |
|-------|---------|--------|
| 1001  | Mark    | 60000  |
| 1004  | Peter   | 35000  |
| 1005  | John    | 55000  |
| 1007  | Donald  | 35000  |
```
WITH DeptAvg AS (
    SELECT DeptID, AVG(Salary) AS AvgSalary
    FROM Employee
    GROUP BY DeptID
)
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN DeptAvg d ON e.DeptID = d.DeptID
WHERE e.Salary > d.AvgSalary
ORDER BY e.EmpID;

---

### 8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers.  If a ticket has some but not all the winning numbers, you win $10.  If a ticket has all the winning numbers, you win $100.    Calculate the total winnings for today’s drawing.

**Winning Numbers:**
```
|Number|
--------
|  25  |
|  45  |
|  78  |

```


**Tickets:**
```
| Ticket ID | Number |
|-----------|--------|
| A23423    | 25     |
| A23423    | 45     |
| A23423    | 78     |
| B35643    | 25     |
| B35643    | 45     |
| B35643    | 98     |
| C98787    | 67     |
| C98787    | 86     |
| C98787    | 91     |

-- Step 1: Create the table
CREATE TABLE Numbers (
    Number INT
);

-- Step 2: Insert values into the table
INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);


-- Step 1: Create the Tickets table
CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);

-- Step 2: Insert the data into the table
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);

WITH WinningCount AS (
    -- Count total winning numbers
    SELECT COUNT(*) AS TotalWinningNumbers FROM Numbers
),
TicketMatches AS (
    -- Count how many winning numbers each ticket matched
    SELECT
        t.TicketID,
        COUNT(*) AS MatchedNumbers
    FROM Tickets t
    JOIN Numbers w ON t.Number = w.Number
    GROUP BY t.TicketID
),
Winnings AS (
    SELECT
        tm.TicketID,
        CASE
            WHEN tm.MatchedNumbers = wc.TotalWinningNumbers THEN 100
            WHEN tm.MatchedNumbers > 0 THEN 10
            ELSE 0
        END AS TicketWinnings
    FROM TicketMatches tm
    CROSS JOIN WinningCount wc
)
SELECT SUM(TicketWinnings) AS TotalWinnin

```

**Expected Output would be $110, as you have one winning ticket, and one ticket that has some but not all the winning numbers.**

---

### 9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.

## Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

**SQL Setup:**
```sql
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);
```

**Expected Output:**
```
| Row | Spend_date | Platform | Total_Amount | Total_users |
|-----|------------|----------|--------------|-------------|
| 1   | 2019-07-01 | Mobile   | 100          | 1           |
| 2   | 2019-07-01 | Desktop  | 100          | 1           |
| 3   | 2019-07-01 | Both     | 200          | 1           |
| 1   | 2019-07-01 | Mobile   | 200          | 2           |
| 2   | 2019-07-01 | Desktop  | 200          | 2           |
| 3   | 2019-07-01 | Both     | 400          | 3           |
| 4   | 2019-07-02 | Mobile   | 100          | 1           |
| 5   | 2019-07-02 | Desktop  | 100          | 1           |
| 6   | 2019-07-02 | Both     | 0            | 0           |
| 6   | 2019-07-02 | Both     | 200          | 2           |
```

---
WITH UserPlatform AS (
  SELECT
    Spend_date,
    User_id,
    -- Collect platform usage per user per day
    STRING_AGG(DISTINCT Platform, ',') WITHIN GROUP (ORDER BY Platform) AS Platforms,
    SUM(Amount) AS TotalAmountPerUser
  FROM Spending
  GROUP BY Spend_date, User_id
),
PlatformClassification AS (
  SELECT
    Spend_date,
    User_id,
    TotalAmountPerUser,
    CASE
      WHEN Platforms = 'Desktop' THEN 'Desktop'
      WHEN Platforms = 'Mobile' THEN 'Mobile'
      WHEN Platforms = 'Deskto'


### 10. Write an SQL Statement to de-group the following data.

**Input Table: 'Grouped'**
```
|Product  |Quantity|
--------------------
|Pencil   |   3    |
|Eraser   |   4    |
|Notebook |   2    |
```

**Expected Output:**
```
|Product  |Quantity|
--------------------
|Pencil   |   1    |
|Pencil   |   1    |
|Pencil   |   1    |
|Eraser   |   1    |
|Eraser   |   1    |
|Eraser   |   1    |
|Eraser   |   1    |
|Notebook |   1    |
|Notebook |   1    |
```

**SQL Setup:**
```sql
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

WITH Numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM Numbers WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT 
  g.Product,
  1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
ORDER BY g.Product;
