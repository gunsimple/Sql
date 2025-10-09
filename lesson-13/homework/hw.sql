create database lesson_13
# Lesson 13 ----Practice: String Functions, Mathematical Functions, Date and time Functions
# Lesson 13 ----Practice: String Functions, Mathematical Functions


> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

## Easy Tasks

1. You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table. 
select * from Employees 
select concat(Employee_id, '-', First_name, '-', Last_name) as employee_info FROM Employees 
where Employee_id=100


2. Update the portion of the phone_number in the employees table, within the phone number the substring '124" will be replaced by '999 
Xodimlar jadvalidagi telefon_raqamining qismini yangilang, telefon raqami ichidagi "124" pastki qatori "999" bilan almashtiriladi.
select * from Employees
select *,replace (Phone_number,'124','999') from Employees


 
3. That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M. Give each column an appropriate label. Sort the results by the employees' first names.(Employees) 
Bu "A", "J" yoki "M" harflari bilan boshlangan barcha xodimlarning ismi va ismining uzunligini ko'rsatadi. Har bir ustunga tegishli belgini bering. Natijalarni xodimlarning ismlari bo'yicha tartiblang.(Xodimlar)

select * from Employees

select First_name as "First Name" from Employees
where First_name like 'A%' 
or First_name like 'J%' 
or First_name like'M%' 
order by First_name


4. Write an SQL query to find the total salary for each manager ID.(Employees table)  
Har bir menejer identifikatori uchun umumiy ish haqini topish uchun SQL sorovini yozing.(Xodimlar jadvali) 
select * from Employees 

select Manager_id, sum(salary) as manager_salary from Employees 
where Manager_id is not Null
group by Manager_id
order by manager_salary desc

5. Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table  

TestMax jadvalidagi har bir satr uchun Max1, Max2 va Max3 ustunlaridan yil va eng yuqori qiymatni olish uchun so‘rov yozing. 
select * from TestMax 

select Year1, 
case when max1>=max2 and max1>=max3 then max1 
when max2>=max1 and max2>=max3 then max2
else max3 end as YearTesx  from TestMax

6. Find me odd numbered movies and description is not boring.(cinema) 
Menga toq sonli filmlarni toping va tavsif zerikarli emas.(kino) 
select * from cinema  

SELECT *
FROM cinema
WHERE id % 2 = 1
  AND description <> 'boring';

7. You have to sort data based on the Id but Id with 0 should always be the last row. 
Now the question is can you do that with a single order by column.(SingleOrder) 
Siz malumotlarni Id asosida saralashingiz kerak, lekin 0 bilan Id har doim oxirgi qator bolishi kerak. 
Endi savol shuki, buni ustun boyicha bitta tartib bilan qila olasizmi.(SingleOrder)
select * from SingleOrder 

ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id 


8. Write an SQL query to select the first non-null value from a set of columns. 
If the first column is null, move to the next, and so on. If all columns are null, return null.(person) 
Ustunlar to'plamidan birinchi nol bo'lmagan qiymatni tanlash uchun SQL so'rovini yozing. 
Agar birinchi ustun null bo'lsa, keyingisiga o'ting va hokazo. Agar barcha ustunlar null bo'lsa, nullni qaytaring.(shaxs)

select * from Person 
SELECT 
    id,
    COALESCE(ssn, passportid, itin) AS first_non_null_id
FROM person;


9. Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
Kompaniyada 10 yildan ortiq, lekin 15 yildan kam ishlagan xodimlarni toping. 
Xodimning identifikatori, ismi, familiyasi, ishga qabul qilingan sanasi va ishlagan yillarini ko‘rsating 
(joriy sana va ishga qabul qilingan sana o‘rtasidagi yillar soni sifatida hisoblanadi).(Xodimlar)
select * from Employees  

select Employee_id,
First_name,
Last_name
Hire_date from Employees 
where datediff(year,Hire_date,getdate())>10 and datediff(year,Hire_date,getdate()) <15 



## Medium Tasks


1. Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table) 
To'liq ism ustunini 3 qismga bo'ling 
select * from Students  
 select * , 
 substring (FullName,1,Charindex (' ', FullName)-1) as first_name,
 substring (FullName, Charindex(' ', FullName,charindex (' ', FullName)+1)+1, len(FullName)) as last_name,
 substring (FullName, charindex(' ',FullName), charindex (' ', FullName, charindex (' ', FullName)+1)-charindex(' ',FullName)) as Middle_name
 from Students


2. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table) 
Kaliforniyaga yetkazib berilgan har bir mijoz uchun Texasga yetkazib berilgan mijoz buyurtmalarining natijasini taqdim eting. (Buyurtmalar jadvali)

select * from Orders

SELECT *
FROM Orders
WHERE DeliveryState = 'TX'
  AND CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
    WHERE DeliveryState = 'CA'
  );


3. Write an SQL statement that can group concatenate the following values.(DMLTable) 
Quyidagi qiymatlarni birlashtira oladigan SQL bayonotini yozing.(DMLTable) 
select * from DMLTable 


SELECT STRING_AGG(String, ' ') WITHIN GROUP (ORDER BY SequenceNumber) AS FullQuery
FROM DMLTable;


4. Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times. 
Ismlari (birinchi va oxirgi) kamida 3 marta "a" harfini oz ichiga olgan barcha xodimlarni toping.
 select * from employees  

select employee_id , first_name,last_name, len( concat(First_NAME, LAST_NAME ))-len (replace( concat(First_NAME, LAST_NAME),'a', '')) from employees
where len( concat(First_NAME, LAST_NAME ))-len (replace( concat(First_NAME, LAST_NAME),'a', ''))>=3

5. The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)

> -  If the employee has worked for 5 to 10 years → 'Mid-Level'

> -  If the employee has worked for 10 to 20 years → 'Senior'

> - If the employee has worked for more than 20 years → 'Veteran'(Employees) 
select * from Employees 
SELECT *,
case when datediff(year, hire_date, getdate()) < 1 then 'new hire'
when datediff(year, hire_date, getdate()) > 1 and datediff(year, hire_date, getdate()) < 5 then 'junior'
when datediff(year, hire_date, getdate()) > 5 and datediff(year, hire_date, getdate()) < 10 then 'mid-level'
when datediff(year, hire_date, getdate()) > 10 and datediff(year, hire_date, getdate()) < 20 then 'senior'
else 'veteran' end as status
from Employees; 

6. The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
Har bir bolimdagi xodimlarning umumiy soni va kompaniyada 3 yildan ortiq ishlagan xodimlarning ulushi (Xodimlar) 

select * from Employees 
	SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS total_employees,
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN DATEDIFF(YEAR, Hire_date, GETDATE()) > 3 THEN 1 
                ELSE 0 
            END
        ) / COUNT(*), 
        2
    ) AS percent_more_than_3_years
FROM 
    Employees
GROUP BY 
    DEPARTMENT_ID;


7. Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal) 
Ish ta'rifi bo'yicha eng kop va eng kam tajribaga ega Spaceman ID-ni aniqlaydigan SQL bayonotini yozing.(Shaxsiy)
select * from Personal   

select 

SELECT 
  p1.JobDescription,
  p1.SpacemanID AS MostExperiencedSpacemanID,
  p1.MissionCount AS MaxMissions,
  p2.SpacemanID AS LeastExperiencedSpacemanID,
  p2.MissionCount AS MinMissions
FROM 
  -- Max
  Personal p1
JOIN 
  (SELECT JobDescription, MAX(MissionCount) AS MaxCount
   FROM Personal
   GROUP BY JobDescription) maxT
ON 
  p1.JobDescription = maxT.JobDescription AND p1.MissionCount = maxT.MaxCount

JOIN 
  -- Min
  (SELECT JobDescription, MIN(MissionCount) AS MinCount
   FROM Personal
   GROUP BY JobDescription) minT
ON 
  p1.JobDescription = minT.JobDescription
JOIN 
  Personal p2
ON 
  p2.JobDescription = minT.JobDescription AND p2.MissionCount = minT.MinCount;

6. Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)


## Difficult Tasks
1. Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and 
other characters from the given string ''tf56sd#%OqH' into separate columns. 
Katta harflar, kichik harflar, raqamlar va raqamlarni ajratib turadigan SQL sorovini yozing. 
berilgan 'tf56sd#%OqH'qatoridagi boshqa belgilar alohida ustunlarga.  


2. Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table) 
2. Har bir satrni uning qiymati va oldingi satrlar qiymati yig‘indisi bilan almashtiruvchi SQL so‘rovini yozing. (Talabalar jadvali) 

select * from Students 

SELECT 
  S1.StudentID,
  S1.FullName,
  S1.Grade,
  SUM(S2.Grade) AS CumulativeGrade
FROM 
  Students S1
JOIN 
  Students S2 ON S2.StudentID <= S1.StudentID
GROUP BY 
  S1.StudentID, S1.FullName, S1.Grade
ORDER BY 
  S1.StudentID;

3. You are given the following table, which contains a VARCHAR column that contains mathematical equations. 
Sum the equations and provide the answers in the output.(Equations) 
Sizga matematik tenglamalarni o'z ichiga olgan VARCHAR ustunini o'z ichiga olgan quyidagi jadval berilgan. 
Tenglamalarni yiging va javoblarni chiqaring.(Tenglamalar) 



4. Given the following dataset, find the students that share the same birthday.(Student Table). 
Quyidagi maʼlumotlar toʻplamini hisobga olgan holda, tugʻilgan kuni bir xil boʻlgan talabalarni toping. (Talabalar jadvali).  

select * from Student

SELECT *
FROM Student
WHERE Birthday IN (
    SELECT Birthday
    FROM Student
    GROUP BY Birthday
    HAVING COUNT(*) > 1
);

5. You have a table with two players (Player A and Player B) and their scores. 
If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. 
Write an SQL query to calculate the total score for each unique player pair(PlayerScores) 
Sizda ikkita o'yinchi (A va B o'yinchisi) va ularning ballari bo'lgan stol bor. 
Agar bir juft o'yinchida bir nechta yozuvlar bo'lsa, ularning ballarini har bir noyob o'yinchi juftligi uchun bitta qatorga jamlang. 
Har bir noyob o'yinchi juftligi uchun umumiy ballni hisoblash uchun SQL so'rovini yozing (PlayerScores) 
select * from PlayerScores

SELECT 
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
  CASE WHEN PlayerA > PlayerB THEN PlayerA ELSE PlayerB END AS Player2,
  SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
  CASE WHEN PlayerA > PlayerB THEN PlayerA ELSE PlayerB END;






```sql
select * from Employees 
drop table Employees 

Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
Kompaniyada 10 yildan ortiq, lekin 15 yildan kam ishlagan xodimlarni toping. 
Xodimning identifikatori, ismi, familiyasi, ishga qabul qilingan sanasi va ishlagan yillarini ko‘rsating 
(joriy sana va ishga qabul qilingan sana o‘rtasidagi yillar soni sifatida hisoblanadi).(Xodimlar)

The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)


create table Employees (EMPLOYEE_ID int, FIRST_NAME varchar(50), LAST_NAME varchar(50),EMAIL varchar(255), PHONE_NUMBER varchar(50),HIRE_DATE date,JOB_ID varchar(50),SALARY float,COMMISSION_PCT float, MANAGER_ID int, DEPARTMENT_ID int)

insert into Employees values
(         100,trim('Steven      '),trim('King        '), trim('SKING    '),trim('515.123.4567       '),'1987-06-17',trim('AD_PRES    '),24000.00,0.00,   0,90)
,(         101,trim('Neena       '),trim('Kochhar     '), trim('NKOCHHAR '),trim('515.123.4568       '),'1987-06-18',trim('AD_VP      '),17000.00,0.00, 100,     90)
,(         102,trim('Lex         '),trim('De Haan     '), trim('LDEHAAN  '),trim('515.123.4569       '),'1987-06-19',trim('AD_VP      '),17000.00,0.00, 100,     90)
,(         103,trim('Alexander   '),trim('Hunold      '), trim('AHUNOLD  '),trim('590.423.4567       '),'1987-06-20',trim('IT_PROG    '), 9000.00,0.00, 102,     60)
,(         104,trim('Bruce       '),trim('Ernst       '), trim('BERNST   '),trim('590.423.4568       '),'1987-06-21',trim('IT_PROG    '), 6000.00,0.00, 103,     60)
,(         105,trim('David       '),trim('Austin      '), trim('DAUSTIN  '),trim('590.423.4569       '),'1987-06-22',trim('IT_PROG    '), 4800.00,0.00, 103,     60)
,(         106,trim('Valli       '),trim('Pataballa   '), trim('VPATABAL '),trim('590.423.4560       '),'1987-06-23',trim('IT_PROG    '), 4800.00,0.00, 103,     60)
,(         107,trim('Diana       '),trim('Lorentz     '), trim('DLORENTZ '),trim('590.423.5567       '),'1987-06-24',trim('IT_PROG    '), 4200.00,0.00, 103,     60)
,(         108,trim('Nancy       '),trim('Greenberg   '), trim('NGREENBE '),trim('515.124.4569       '),'1987-06-25',trim('FI_MGR     '),12000.00,0.00, 101,    100)
,(         109,trim('Daniel      '),trim('Faviet      '), trim('DFAVIET  '),trim('515.124.4169       '),'1987-06-26',trim('FI_ACCOUNT '), 9000.00,0.00, 108,    100)
,(         110,trim('John        '),trim('Chen        '), trim('JCHEN    '),trim('515.124.4269       '),'1987-06-27',trim('FI_ACCOUNT '), 8200.00,0.00, 108,    100)
,(         111,trim('Ismael      '),trim('Sciarra     '), trim('ISCIARRA '),trim('515.124.4369       '),'1987-06-28',trim('FI_ACCOUNT '), 7700.00,0.00, 108,    100)
,(         112,trim('Jose Manuel '),trim('Urman       '), trim('JMURMAN  '),trim('515.124.4469       '),'1987-06-29',trim('FI_ACCOUNT '), 7800.00,0.00, 108,    100)
,(         113,trim('Luis        '),trim('Popp        '), trim('LPOPP    '),trim('515.124.4567       '),'1987-06-30',trim('FI_ACCOUNT '), 6900.00,0.00, 108,    100)
,(         114,trim('Den         '),trim('Raphaely    '), trim('DRAPHEAL '),trim('515.127.4561       '),'1987-07-01',trim('PU_MAN     '),11000.00,0.00, 100,     30)
,(         115,trim('Alexander   '),trim('Khoo        '), trim('AKHOO    '),trim('515.127.4562       '),'1987-07-02',trim('PU_CLERK   '), 3100.00,0.00, 114,     30)
,(         116,trim('Shelli      '),trim('Baida       '), trim('SBAIDA   '),trim('515.127.4563       '),'1987-07-03',trim('PU_CLERK   '), 2900.00,0.00, 114,     30)
,(         117,trim('Sigal       '),trim('Tobias      '), trim('STOBIAS  '),trim('515.127.4564       '),'1987-07-04',trim('PU_CLERK   '), 2800.00,0.00, 114,     30)
,(         118,trim('Guy         '),trim('Himuro      '), trim('GHIMURO  '),trim('515.127.4565       '),'1987-07-05',trim('PU_CLERK   '), 2600.00,0.00, 114,     30)
,(         119,trim('Karen       '),trim('Colmenares  '), trim('KCOLMENA '),trim('515.127.4566       '),'1987-07-06',trim('PU_CLERK   '), 2500.00,0.00, 114,     30)
,(         120,trim('Matthew     '),trim('Weiss       '), trim('MWEISS   '),trim('650.123.1234       '),'1987-07-07',trim('ST_MAN     '), 8000.00,0.00, 100,     50)
,(         121,trim('Adam        '),trim('Fripp       '), trim('AFRIPP   '),trim('650.123.2234       '),'1987-07-08',trim('ST_MAN     '), 8200.00,0.00, 100,     50)
,(         122,trim('Payam       '),trim('Kaufling    '), trim('PKAUFLIN '),trim('650.123.3234       '),'1987-07-09',trim('ST_MAN     '), 7900.00,0.00, 100,     50)
,(         123,trim('Shanta      '),trim('Vollman     '), trim('SVOLLMAN '),trim('650.123.4234       '),'1987-07-10',trim('ST_MAN     '), 6500.00,0.00, 100,     50)
,(         124,trim('Kevin       '),trim('Mourgos     '), trim('KMOURGOS '),trim('650.123.5234       '),'1987-07-11',trim('ST_MAN     '), 5800.00,0.00, 100,     50)
,(         125,trim('Julia       '),trim('Nayer       '), trim('JNAYER   '),trim('650.124.1214       '),'1987-07-12',trim('ST_CLERK   '), 3200.00,0.00, 120,     50)
,(         126,trim('Irene       '),trim('Mikkilineni '), trim('IMIKKILI '),trim('650.124.1224       '),'1987-07-13',trim('ST_CLERK   '), 2700.00,0.00, 120,     50)
,(         127,trim('James       '),trim('Landry      '), trim('JLANDRY  '),trim('650.124.1334       '),'1987-07-14',trim('ST_CLERK   '), 2400.00,0.00, 120,     50)
,(         128,trim('Steven      '),trim('Markle      '), trim('SMARKLE  '),trim('650.124.1434       '),'1987-07-15',trim('ST_CLERK   '), 2200.00,0.00, 120,     50)
,(         129,trim('Laura       '),trim('Bissot      '), trim('LBISSOT  '),trim('650.124.5234       '),'1987-07-16',trim('ST_CLERK   '), 3300.00,0.00, 121,     50)
,(         130,trim('Mozhe       '),trim('Atkinson    '), trim('MATKINSO '),trim('650.124.6234       '),'1987-07-17',trim('ST_CLERK   '), 2800.00,0.00, 121,     50)
,(         131,trim('James       '),trim('Marlow      '), trim('JAMRLOW  '),trim('650.124.7234       '),'1987-07-18',trim('ST_CLERK   '), 2500.00,0.00, 121,     50)
,(         132,trim('TJ          '),trim('Olson       '), trim('TJOLSON  '),trim('650.124.8234       '),'1987-07-19',trim('ST_CLERK   '), 2100.00,0.00, 121,     50)
,(         133,trim('Jason       '),trim('Mallin      '), trim('JMALLIN  '),trim('650.127.1934       '),'1987-07-20',trim('ST_CLERK   '), 3300.00,0.00, 122,     50)
,(         134,trim('Michael     '),trim('Rogers      '), trim('MROGERS  '),trim('650.127.1834       '),'1987-07-21',trim('ST_CLERK   '), 2900.00,0.00, 122,     50)
,(         135,trim('Ki          '),trim('Gee         '), trim('KGEE     '),trim('650.127.1734       '),'1987-07-22',trim('ST_CLERK   '), 2400.00,0.00, 122,     50)
,(         136,trim('Hazel       '),trim('Philtanker  '), trim('HPHILTAN '),trim('650.127.1634       '),'1987-07-23',trim('ST_CLERK   '), 2200.00,0.00, 122,     50)
,(         137,trim('Renske      '),trim('Ladwig      '), trim('RLADWIG  '),trim('650.121.1234       '),'1987-07-24',trim('ST_CLERK   '), 3600.00,0.00, 123,     50)
,(         138,trim('Stephen     '),trim('Stiles      '), trim('SSTILES  '),trim('650.121.2034       '),'1987-07-25',trim('ST_CLERK   '), 3200.00,0.00, 123,     50)
,(         139,trim('John        '),trim('Seo         '), trim('JSEO     '),trim('650.121.2019       '),'1987-07-26',trim('ST_CLERK   '), 2700.00,0.00, 123,     50)
,(         140,trim('Joshua      '),trim('Patel       '), trim('JPATEL   '),trim('650.121.1834       '),'1987-07-27',trim('ST_CLERK   '), 2500.00,0.00, 123,     50)
,(         141,trim('Trenna      '),trim('Rajs        '), trim('TRAJS    '),trim('650.121.8009       '),'1987-07-28',trim('ST_CLERK   '), 3500.00,0.00, 124,     50)
,(         142,trim('Curtis      '),trim('Davies      '), trim('CDAVIES  '),trim('650.121.2994       '),'1987-07-29',trim('ST_CLERK   '), 3100.00,0.00, 124,     50)
,(         143,trim('Randall     '),trim('Matos       '), trim('RMATOS   '),trim('650.121.2874       '),'1987-07-30',trim('ST_CLERK   '), 2600.00,0.00, 124,     50)
,(         144,trim('Peter       '),trim('Vargas      '), trim('PVARGAS  '),trim('650.121.2004       '),'1987-07-31',trim('ST_CLERK   '), 2500.00,0.00, 124,     50)
,(         145,trim('John        '),trim('Russell     '), trim('JRUSSEL  '),trim('011.44.1344.429268 '),'1987-08-01',trim('SA_MAN     '),14000.00,0.40, 100,     80)
,(         146,trim('Karen       '),trim('Partners    '), trim('KPARTNER '),trim('011.44.1344.467268 '),'1987-08-02',trim('SA_MAN     '),13500.00,0.30, 100,     80)
,(         147,trim('Alberto     '),trim('Errazuriz   '), trim('AERRAZUR '),trim('011.44.1344.429278 '),'1987-08-03',trim('SA_MAN     '),12000.00,0.30, 100,     80)
,(         148,trim('Gerald      '),trim('Cambrault   '), trim('GCAMBRAU '),trim('011.44.1344.619268 '),'1987-08-04',trim('SA_MAN     '),11000.00,0.30, 100,     80)
,(         149,trim('Eleni       '),trim('Zlotkey     '), trim('EZLOTKEY '),trim('011.44.1344.429018 '),'1987-08-05',trim('SA_MAN     '),10500.00,0.20, 100,     80)
,(         150,trim('Peter       '),trim('Tucker      '), trim('PTUCKER  '),trim('011.44.1344.129268 '),'1987-08-06',trim('SA_REP     '),10000.00,0.30, 145,     80)
,(         151,trim('David       '),trim('Bernstein   '), trim('DBERNSTE '),trim('011.44.1344.345268 '),'1987-08-07',trim('SA_REP     '), 9500.00,0.25, 145,     80)
,(         152,trim('Peter       '),trim('Hall        '), trim('PHALL    '),trim('011.44.1344.478968 '),'1987-08-08',trim('SA_REP     '), 9000.00,0.25, 145,     80)
,(         153,trim('Christopher '),trim('Olsen       '), trim('COLSEN   '),trim('011.44.1344.498718 '),'1987-08-09',trim('SA_REP     '), 8000.00,0.20, 145,     80)
,(         154,trim('Nanette     '),trim('Cambrault   '), trim('NCAMBRAU '),trim('011.44.1344.987668 '),'1987-08-10',trim('SA_REP     '), 7500.00,0.20, 145,     80)
,(         155,trim('Oliver      '),trim('Tuvault     '), trim('OTUVAULT '),trim('011.44.1344.486508 '),'1987-08-11',trim('SA_REP     '), 7000.00,0.15, 145,     80)
,(         156,trim('Janette     '),trim('King        '), trim('JKING    '),trim('011.44.1345.429268 '),'1987-08-12',trim('SA_REP     '),10000.00,0.35, 146,     80)
,(         157,trim('Patrick     '),trim('Sully       '), trim('PSULLY   '),trim('011.44.1345.929268 '),'1987-08-13',trim('SA_REP     '), 9500.00,0.35, 146,     80)
,(         158,trim('Allan       '),trim('McEwen      '), trim('AMCEWEN  '),trim('011.44.1345.829268 '),'1987-08-14',trim('SA_REP     '), 9000.00,0.35, 146,     80)
,(         159,trim('Lindsey     '),trim('Smith       '), trim('LSMITH   '),trim('011.44.1345.729268 '),'1987-08-15',trim('SA_REP     '), 8000.00,0.30, 146,     80)
,(         160,trim('Louise      '),trim('Doran       '), trim('LDORAN   '),trim('011.44.1345.629268 '),'1987-08-16',trim('SA_REP     '), 7500.00,0.30, 146,     80)
,(         161,trim('Sarath      '),trim('Sewall      '), trim('SSEWALL  '),trim('011.44.1345.529268 '),'1987-08-17',trim('SA_REP     '), 7000.00,0.25, 146,     80)
,(         162,trim('Clara       '),trim('Vishney     '), trim('CVISHNEY '),trim('011.44.1346.129268 '),'1987-08-18',trim('SA_REP     '),10500.00,0.25, 147,     80)
,(         163,trim('Danielle    '),trim('Greene      '), trim('DGREENE  '),trim('011.44.1346.229268 '),'1987-08-19',trim('SA_REP     '), 9500.00,0.15, 147,     80)
,(         164,trim('Mattea      '),trim('Marvins     '), trim('MMARVINS '),trim('011.44.1346.329268 '),'1987-08-20',trim('SA_REP     '), 7200.00,0.10, 147,     80)
,(         165,trim('David       '),trim('Lee         '), trim('DLEE     '),trim('011.44.1346.529268 '),'1987-08-21',trim('SA_REP     '), 6800.00,0.10, 147,     80)
,(         166,trim('Sundar      '),trim('Ande        '), trim('SANDE    '),trim('011.44.1346.629268 '),'1987-08-22',trim('SA_REP     '), 6400.00,0.10, 147,     80)
,(         167,trim('Amit        '),trim('Banda       '), trim('ABANDA   '),trim('011.44.1346.729268 '),'1987-08-23',trim('SA_REP     '), 6200.00,0.10, 147,     80)
,(         168,trim('Lisa        '),trim('Ozer        '), trim('LOZER    '),trim('011.44.1343.929268 '),'1987-08-24',trim('SA_REP     '),11500.00,0.25, 148,     80)
,(         169,trim('Harrison    '),trim('Bloom       '), trim('HBLOOM   '),trim('011.44.1343.829268 '),'1987-08-25',trim('SA_REP     '),10000.00,0.20, 148,     80)
,(         170,trim('Tayler      '),trim('Fox         '), trim('TFOX     '),trim('011.44.1343.729268 '),'1987-08-26',trim('SA_REP     '), 9600.00,0.20, 148,     80)
,(         171,trim('William     '),trim('Smith       '), trim('WSMITH   '),trim('011.44.1343.629268 '),'1987-08-27',trim('SA_REP     '), 7400.00,0.15, 148,     80)
,(         172,trim('Elizabeth   '),trim('Bates       '), trim('EBATES   '),trim('011.44.1343.529268 '),'1987-08-28',trim('SA_REP     '), 7300.00,0.15, 148,     80)
,(         173,trim('Sundita     '),trim('Kumar       '), trim('SKUMAR   '),trim('011.44.1343.329268 '),'1987-08-29',trim('SA_REP     '), 6100.00,0.10, 148,     80)
,(         174,trim('Ellen       '),trim('Abel        '), trim('EABEL    '),trim('011.44.1644.429267 '),'1987-08-30',trim('SA_REP     '),11000.00,0.30, 149,     80)
,(         175,trim('Alyssa      '),trim('Hutton      '), trim('AHUTTON  '),trim('011.44.1644.429266 '),'1987-08-31',trim('SA_REP     '), 8800.00,0.25, 149,     80)
,(         176,trim('Jonathon    '),trim('Taylor      '), trim('JTAYLOR  '),trim('011.44.1644.429265 '),'1987-09-01',trim('SA_REP     '), 8600.00,0.20, 149,     80)
,(         177,trim('Jack        '),trim('Livingston  '), trim('JLIVINGS '),trim('011.44.1644.429264 '),'1987-09-02',trim('SA_REP     '), 8400.00,0.20, 149,     80)
,(         178,trim('Kimberely   '),trim('Grant       '), trim('KGRANT   '),trim('011.44.1644.429263 '),'1987-09-03',trim('SA_REP     '), 7000.00,0.15, 149,      0)
,(         179,trim('Charles     '),trim('Johnson     '), trim('CJOHNSON '),trim('011.44.1644.429262 '),'1987-09-04',trim('SA_REP     '), 6200.00,0.10, 149,     80)
,(         180,trim('Winston     '),trim('Taylor      '), trim('WTAYLOR  '),trim('650.507.9876       '),'1987-09-05',trim('SH_CLERK   '), 3200.00,0.00, 120,     50)
,(         181,trim('Jean        '),trim('Fleaur      '), trim('JFLEAUR  '),trim('650.507.9877       '),'1987-09-06',trim('SH_CLERK   '), 3100.00,0.00, 120,     50)
,(         182,trim('Martha      '),trim('Sullivan    '), trim('MSULLIVA '),trim('650.507.9878       '),'1987-09-07',trim('SH_CLERK   '), 2500.00,0.00, 120,     50)
,(         183,trim('Girard      '),trim('Geoni       '), trim('GGEONI   '),trim('650.507.9879       '),'1987-09-08',trim('SH_CLERK   '), 2800.00,0.00, 120,     50)
,(         184,trim('Nandita     '),trim('Sarchand    '), trim('NSARCHAN '),trim('650.509.1876       '),'1987-09-09',trim('SH_CLERK   '), 4200.00,0.00, 121,     50)
,(         185,trim('Alexis      '),trim('Bull        '), trim('ABULL    '),trim('650.509.2876       '),'1987-09-10',trim('SH_CLERK   '), 4100.00,0.00, 121,     50)
,(         186,trim('Julia       '),trim('Dellinger   '), trim('JDELLING '),trim('650.509.3876       '),'1987-09-11',trim('SH_CLERK   '), 3400.00,0.00, 121,     50)
,(         187,trim('Anthony     '),trim('Cabrio      '), trim('ACABRIO  '),trim('650.509.4876       '),'1987-09-12',trim('SH_CLERK   '), 3000.00,0.00, 121,     50)
,(         188,trim('Kelly       '),trim('Chung       '), trim('KCHUNG   '),trim('650.505.1876       '),'1987-09-13',trim('SH_CLERK   '), 3800.00,0.00, 122,     50)
,(         189,trim('Jennifer    '),trim('Dilly       '), trim('JDILLY   '),trim('650.505.2876       '),'1987-09-14',trim('SH_CLERK   '), 3600.00,0.00, 122,     50)
,(         190,trim('Timothy     '),trim('Gates       '), trim('TGATES   '),trim('650.505.3876       '),'1987-09-15',trim('SH_CLERK   '), 2900.00,0.00, 122,     50)
,(         191,trim('Randall     '),trim('Perkins     '), trim('RPERKINS '),trim('650.505.4876       '),'1987-09-16',trim('SH_CLERK   '), 2500.00,0.00, 122,     50)
,(         192,trim('Sarah       '),trim('Bell        '), trim('SBELL    '),trim('650.501.1876       '),'1987-09-17',trim('SH_CLERK   '), 4000.00,0.00, 123,     50)
,(         193,trim('Britney     '),trim('Everett     '), trim('BEVERETT '),trim('650.501.2876       '),'1987-09-18',trim('SH_CLERK   '), 3900.00,0.00, 123,     50)
,(         194,trim('Samuel      '),trim('McCain      '), trim('SMCCAIN  '),trim('650.501.3876       '),'1987-09-19',trim('SH_CLERK   '), 3200.00,0.00, 123,     50)
,(         195,trim('Vance       '),trim('Jones       '), trim('VJONES   '),trim('650.501.4876       '),'1987-09-20',trim('SH_CLERK   '), 2800.00,0.00, 123,     50)
,(         196,trim('Alana       '),trim('Walsh       '), trim('AWALSH   '),trim('650.507.9811       '),'1987-09-21',trim('SH_CLERK   '), 3100.00,0.00, 124,     50)
,(         197,trim('Kevin       '),trim('Feeney      '), trim('KFEENEY  '),trim('650.507.9822       '),'1987-09-22',trim('SH_CLERK   '), 3000.00,0.00, 124,     50)
,(         198,trim('Donald      '),trim('OConnell    '), trim('DOCONNEL '),trim('650.507.9833       '),'1987-09-23',trim('SH_CLERK   '), 2600.00,0.00, 124,     50)
,(         199,trim('Douglas     '),trim('Grant       '), trim('DGRANT   '),trim('650.507.9844       '),'1987-09-24',trim('SH_CLERK   '), 2600.00,0.00, 124,     50)
,(         200,trim('Jennifer    '),trim('Whalen      '), trim('JWHALEN  '),trim('515.123.4444       '),'1987-09-25',trim('AD_ASST    '), 4400.00,0.00, 101,     10)
,(         201,trim('Michael     '),trim('Hartstein   '), trim('MHARTSTE '),trim('515.123.5555       '),'1987-09-26',trim('MK_MAN     '),13000.00,0.00, 100,     20)
,(         202,trim('Pat         '),trim('Fay         '), trim('PFAY     '),trim('603.123.6666       '),'1987-09-27',trim('MK_REP     '), 6000.00,0.00, 201,     20)
,(         203,trim('Susan       '),trim('Mavris      '), trim('SMAVRIS  '),trim('515.123.7777       '),'1987-09-28',trim('HR_REP     '), 6500.00,0.00, 101,     40)
,(         204,trim('Hermann     '),trim('Baer        '), trim('HBAER    '),trim('515.123.8888       '),'1987-09-29',trim('PR_REP     '),10000.00,0.00, 101,     70)
,(         205,trim('Shelley     '),trim('Higgins     '), trim('SHIGGINS '),trim('515.123.8080       '),'1987-09-30',trim('AC_MGR     '),12000.00,0.00, 101,    110)
,(         206,trim('William     '),trim('Gietz       '), trim('WGIETZ   '),trim('515.123.8181       '),'1987-10-01',trim('AC_ACCOUNT '), 8300.00,0.00, 205,    110)

select * from Students
drop table Students
 Write an SQL query that replaces each row with the sum of its value and the previous rows value. (Students table) 

create table Students(
  StudentID int,
  FullName varchar(100),
  Grade decimal(5,2)
)

insert into Students values 
(1,'James Alexander Hamilton',98.5),
(2,'Arthur George Mason',78.2),
(3,'Lily B Peters',81),
(4,'Kayne Thomas Derek',87.3),
(5,'April Dukane Paris',79.1),
(6,'Payton Carl Johnson',97.1)

Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:

> - If the employee has worked for less than 1 year → 'New Hire'  

select * from Employee
CREATE TABLE Employee
(
EmployeeID  INTEGER PRIMARY KEY,
ManagerID   INTEGER NULL,
JobTitle    VARCHAR(100) NOT NULL
);
GO

INSERT INTO Employee (EmployeeID, ManagerID, JobTitle) VALUES
(1001,NULL,'President'),(2002,1001,'Director'),
(3003,1001,'Office Manager'),(4004,2002,'Engineer'),
(5005,2002,'Engineer'),(6006,2002,'Engineer');
GO

For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table) 

CREATE TABLE Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);
GO

INSERT INTO Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);
GO

Write an SQL statement that can group concatenate the following values.(DMLTable) 


CREATE TABLE DMLTable
(
SequenceNumber  INTEGER PRIMARY KEY,
String          VARCHAR(100) NOT NULL
);
GO

INSERT INTO DMLTable (SequenceNumber, String) VALUES
(1,'SELECT'),
(2,'Product,'),
(3,'UnitPrice,'),
(4,'EffectiveDate'),
(5,'FROM'),
(6,'Products'),
(7,'WHERE'),
(8,'UnitPrice'),
(9,'> 100');
GO

You are given the following table, which contains a VARCHAR column that contains mathematical equations. 
Sum the equations and provide the answers in the output.(Equations) 

select * from Equations
CREATE TABLE Equations
(
Equation  VARCHAR(200) PRIMARY KEY,
TotalSum  INTEGER NULL
);
GO

INSERT INTO Equations (Equation) VALUES
('123'),('1+2+3'),('1+2-3'),('1+23'),('1-2+3'),('1-2-3'),('1-23'),('12+3'),('12-3');
GO
 Given the following dataset, find the students that share the same birthday.(Student Table). 

CREATE TABLE Student
(
StudentName  VARCHAR(50) PRIMARY KEY,
Birthday     DATE
);
GO

INSERT INTO Student (StudentName, Birthday) VALUES
('Susan', '2015-04-15'),
('Tim', '2015-04-15'),
('Jacob', '2015-04-15'),
('Earl', '2015-02-05'),
('Mike', '2015-05-23'),
('Angie', '2015-05-23'),
('Jenny', '2015-11-19'),
('Michelle', '2015-12-12'),
('Aaron', '2015-12-18');
GO 

Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table  

CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
)

INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91) 

	Find me odd numbered movies and description is not boring
CREATE TABLE cinema (
    id INT PRIMARY KEY,
    movie VARCHAR(50),
    description VARCHAR(255),
    rating DECIMAL(3, 1)
);

INSERT INTO cinema (id, movie, description, rating) VALUES
(1, 'War', 'great 3D', 8.9),
(2, 'Science', 'fiction', 8.5),
(3, 'Irish', 'boring', 6.2),
(4, 'Ice song', 'Fantacy', 8.6),
(5, 'House card', 'Interesting', 9.1);

You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder) 

CREATE TABLE SingleOrder
(
	 Id INT
	,Vals VARCHAR(10)
)
GO

INSERT INTO SingleOrder VALUES
(0,'All'),
(1,'Pawan'),
(2,'Avtaar'),
(3,'Kishan'),
(4,'Vaibhav'),
(5,'Ashutosh')
GO

SELECT * FROM SingleOrder
GO

Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person) 

CREATE TABLE person (
    id INT,
    ssn VARCHAR(13),
    passportid VARCHAR(10),
    itin VARCHAR(10)
);

INSERT INTO person VALUES 
(1, '111-11-1111', 'aa155', '123itin'),
(2, NULL, 'aa156', '124itin'),
(3, NULL, NULL, '125itin'),
(4, NULL, NULL, NULL),
(5, '222-22-2222', NULL, '126itin'),
(6, '333-33-3333', 'aa157', NULL);

You have a table with two players (Player A and Player B) and their scores. 
If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. 
Write an SQL query to calculate the total score for each unique player pair(PlayerScores) 

CREATE TABLE PlayerScores
(
PlayerA  INTEGER,
PlayerB  INTEGER,
Score    INTEGER NOT NULL,
PRIMARY KEY (PlayerA, PlayerB)
);
GO

INSERT INTO PlayerScores (PlayerA, PlayerB, Score) VALUES
(1001,2002,150),(3003,4004,15),(4004,3003,125);
GO

CREATE TABLE Personal
(
SpacemanID      INTEGER PRIMARY KEY,
JobDescription  VARCHAR(100) NOT NULL,
MissionCount    INTEGER NOT NULL
);
GO

INSERT INTO Personal (SpacemanID, JobDescription, MissionCount) VALUES
(1001,'Astrogator',6),(2002,'Astrogator',12),(3003,'Astrogator',17),
(4004,'Geologist',21),(5005,'Geologist',9),(6006,'Geologist',8),
(7007,'Technician',13),(8008,'Technician',2),(9009,'Technician',7);
