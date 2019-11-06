-------------------------------2a-------------------------------
SELECT a. CourseName, a.CourseId, a.DepartmentID, b.StudentID
INTO dbo.Exc_2
	FROM dbo.Courses a
INNER JOIN  dbo.Classrooms b
	ON a.CourseId = b.CourseId


SELECT a.DepartmentId, a.DepartmentName, b.StudentId
INTO dbo.Exc_2a
	 FROM dbo.Departments a
INNER JOIN dbo.Exc_2 b
	ON a.DepartmentId = b.DepartmentID

SELECT * FROM dbo.Exc_2a

---Final answer for 2a
SELECT DepartmentName, COUNT (DISTINCT DepartmentName) AS Dep_cnt
FROM dbo.Exc_2a
GROUP BY DepartmentName
ORDER BY Dep_cnt DESC


---------------------------------------revised answer 2a
SELECT DepartmentName, COUNT (DISTINCT StudentId) AS Std_cnt
FROM dbo.Exc_2a
GROUP BY DepartmentName
ORDER BY Std_cnt DESC




-------------------------------2b-------------------------------

SELECT * FROM dbo.Exc_2

SELECT CourseId, CourseName, COUNT (DISTINCT StudentId) AS students_cnt
INTO dbo.Exc_2b
FROM dbo.Exc_2
	WHERE CourseId = 1 OR CourseId = 2 OR CourseId = 3
GROUP BY CourseId, CourseName
	 
--Total Students in each english course

SELECT * FROM dbo.Exc_2b
	ORDER BY CourseId

--Toatl students in English department

SELECT DepartmentName, COUNT (DepartmentName) AS Dep_cnt
FROM dbo.Exc_2a
WHERE DepartmentName = 'English'
GROUP BY DepartmentName


---------------------------------------revised answer 2b

SELECT CourseId, CourseName, COUNT (DISTINCT StudentId) AS students_cnt
INTO dbo.Exc_2b_revised
FROM dbo.Exc_2
	WHERE CourseId = 1 OR CourseId = 2 OR CourseId = 3
GROUP BY CourseId, CourseName
	 
--Total Students in each english course

SELECT * FROM dbo.Exc_2b_revised
	ORDER BY CourseId

--Toatl students in English department

SELECT DepartmentName, COUNT (DISTINCT StudentId) AS students_cnt
FROM dbo.Exc_2a
WHERE DepartmentName = 'English'
GROUP BY DepartmentName



-------------------------------2c-------------------------------

SELECT * FROM dbo.Exc_2

SELECT CourseId 
FROM dbo.Exc_2

SELECT CourseID,CourseName, COUNT (StudentId) AS students_cnt
INTO dbo.Exc_2c
FROM dbo.Exc_2
WHERE CourseId BETWEEN 4 AND 19
GROUP BY CourseId, CourseName

SELECT * FROM dbo.Exc_2c

SELECT CourseName, students_cnt,
		CASE 
			WHEN students_cnt < 22 THEN 'Small Class'
			ELSE 'Big Class'
		END AS Total_Students
INTO dbo.Exc_2c1
FROM dbo.Exc_2c
GROUP BY CourseName, students_cnt

SELECT * FROM dbo.Exc_2c1
ORDER BY students_cnt DESC

---Final answer for 2c
SELECT Total_Students, COUNT (Total_Students) AS Total_Classes
FROM dbo.Exc_2c1
GROUP BY Total_Students




---------------------------------------revised answer 2c

SELECT CourseID,CourseName, COUNT (DISTINCT StudentId) AS students_cnt
INTO dbo.Exc_2c_revised
FROM dbo.Exc_2
WHERE CourseId BETWEEN 4 AND 19
GROUP BY CourseId, CourseName

SELECT * FROM dbo.Exc_2c_revised

SELECT CourseName, students_cnt,
		CASE 
			WHEN students_cnt < 22 THEN 'Small Class'
			ELSE 'Big Class'
		END AS Total_Students
INTO dbo.Exc_2c1_revised
FROM dbo.Exc_2c
GROUP BY CourseName, students_cnt

SELECT * FROM dbo.Exc_2c1_revised
ORDER BY students_cnt DESC

---Final answer for 2c
SELECT Total_Students, COUNT ( Total_Students) AS Total_Classes
FROM dbo.Exc_2c1_revised
GROUP BY Total_Students




-------------------------------2d-------------------------------

SELECT Gender, COUNT (Gender) AS Total_Gender
FROM dbo.Students
GROUP BY Gender

--Incorrect Statement. More females! :)


-------------------------------2e-------------------------------

SELECT a. CourseName, a.CourseId, b.StudentID, c.Gender
INTO dbo.Exc_2e
	FROM dbo.Courses a
INNER JOIN  dbo.Classrooms b
	ON a.CourseId = b.CourseId
INNER JOIN dbo.Students c
	ON b.StudentId = c.StudentId

SELECT * FROM dbo.Exc_2e 


SELECT  CourseName,
	COUNT (Gender) AS Male
INTO dbo.M_students
FROM dbo.Exc_2e 
	WHERE Gender = 'M' 
GROUP BY CourseName


SELECT  CourseName,
	COUNT (Gender) AS F_Students
INTO dbo.F_students
FROM dbo.Exc_2e 
	WHERE Gender = 'F' 
GROUP BY CourseName

SELECT * FROM F_students
SELECT * FROM M_students
 

SELECT a.CourseName, 
	   a.Females, 
	   b.Male, 
	   a.Females + b.Male AS Total_students
INTO dbo.Total_Gender
	FROM dbo.F_students a
INNER JOIN dbo.M_students b
ON a.CourseName = b.CourseName

SELECT * FROM dbo.Total_Gender


---Final answer for 2e 
SELECT CourseName,
		(((Male * 1.0) / (Total_students * 1.0))*100.0) AS Ratio
FROM dbo.Total_Gender
WHERE (((Male * 1.0) / (Total_students * 1.0))*100.0) >70.0

SELECT CourseName,
		(((Females * 1.0) / (Total_students * 1.0))*100.0) AS Ratio
FROM dbo.Total_Gender
WHERE (((Females * 1.0) / (Total_students * 1.0))*100.0) >70.0




---------------------------------------revised answer 2e


SELECT a. CourseName, a.CourseId, b.StudentID, c.Gender
INTO dbo.Exc_2e_revised
	FROM dbo.Courses a
INNER JOIN  dbo.Classrooms b
	ON a.CourseId = b.CourseId
INNER JOIN dbo.Students c
	ON b.StudentId = c.StudentId

SELECT * FROM dbo.Exc_2e_revised


SELECT  CourseName,
	COUNT (Gender) AS Males
INTO dbo.M_students_revised
FROM dbo.Exc_2e 
	WHERE Gender = 'M' 
GROUP BY CourseName

SELECT * FROM M_students_revised

SELECT  CourseName,
	COUNT (Gender) AS Females
INTO dbo.F_students_revised
FROM dbo.Exc_2e 
	WHERE Gender = 'F' 
GROUP BY CourseName

SELECT * FROM F_students_revised
 

SELECT a.CourseName, 
	   a.Females, 
	   b.Males, 
	   a.Females + b.Males AS Total_students
INTO dbo.Total_Gender_revised
	FROM dbo.F_students_revised a
INNER JOIN dbo.M_students_revised b
ON a.CourseName = b.CourseName

SELECT * FROM dbo.Total_Gender_revised


---Final answer for 2e 
SELECT CourseName,
		(((Males * 1.0) / (Total_students * 1.0))*100.0) AS Ratio
FROM dbo.Total_Gender_revised
WHERE (((Males * 1.0) / (Total_students * 1.0))*100.0) >70.0

SELECT CourseName,
		(((Females * 1.0) / (Total_students * 1.0))*100.0) AS Ratio
FROM dbo.Total_Gender_revised
WHERE (((Females * 1.0) / (Total_students * 1.0))*100.0) >70.0






-------------------------------2f-------------------------------

SELECT a.DepartmentName, b.CourseId,c.StudentId, c. degree
INTO dbo.Exc_2f
	 FROM dbo.Departments a
INNER JOIN dbo. Courses b
	ON a.DepartmentId = b.DepartmentID
INNER JOIN dbo.Classrooms c 
	ON b.CourseId = c.CourseId

SELECT DepartmentName, 
	   COUNT (degree) AS Total_Above80 , 
	   100.0* COUNT (degree)/SUM (COUNT(*)) OVER() AS [Percent_above80]
FROM Exc_2f
WHERE degree > 80.0
GROUP BY DepartmentName
;


---------------------------------------revised answer 2f
SELECT a.DepartmentName, b.CourseId,c.StudentId, c. degree
INTO dbo.Exc_2f_revised
	 FROM dbo.Departments a
INNER JOIN dbo. Courses b
	ON a.DepartmentId = b.DepartmentID
INNER JOIN dbo.Classrooms c 
	ON b.CourseId = c.CourseId


SELECT DepartmentName, 
	   COUNT (DISTINCT StudentId) AS Total_Std_Above80 , 
	   100.0* COUNT (degree)/SUM (COUNT(*)) OVER() AS [Percent_above80]
FROM Exc_2f_revised
WHERE degree > 80.0
GROUP BY DepartmentName

---2f -- Tomas Correction
SELECT DepartmentName,
  COUNT (DISTINCT StudentId) AS Total_Std_Above80 ,
SUM (COUNT(*)) OVER() AS denominator,
  100.0* COUNT (degree)/SUM (COUNT(*)) OVER() AS [Percent_above80]
FROM Exc_2f_revised
WHERE degree > 80.0
GROUP BY DepartmentName
;



-------------------------------2g-------------------------------

SELECT a.DepartmentName, b.CourseId,c.StudentId, c. degree
INTO dbo.Exc_2f
	 FROM dbo.Departments a
INNER JOIN dbo. Courses b
	ON a.DepartmentId = b.DepartmentID
INNER JOIN dbo.Classrooms c 
	ON b.CourseId = c.CourseId

SELECT DepartmentName, 
	   COUNT (degree) AS Total_Below60 , 
	   100.0* COUNT (degree)/SUM (COUNT(*)) OVER() AS [Percent_below60]
FROM Exc_2f
WHERE degree < 60.0
GROUP BY DepartmentName
;



---------------------------------------revised answer 2g

SELECT DepartmentName, 
	    COUNT (DISTINCT StudentId) AS Total_Below60 , 
	   100.0* COUNT (degree)/SUM (COUNT(*)) OVER() AS [Percent_below60]
FROM Exc_2f_revised
WHERE degree < 60.0
GROUP BY DepartmentName


---2g -- Tomas Correction
SELECT DepartmentName,
   COUNT (DISTINCT StudentId) AS Total_Below60 ,
SUM (COUNT(*)) OVER() AS denominator,
  100.0* COUNT (degree)/(SUM (COUNT(*)) OVER()) AS [Percent_below60]
FROM Exc_2f_revised
WHERE degree < 60.0
GROUP BY DepartmentName




-------------------------------2h-------------------------------


SELECT a.TeacherId, (d.FirstName + d.LastName) AS Teacher_Name, a.CourseId, C.degree
INTO dbo.Exc_2h
	FROM dbo.Courses a
INNER JOIN  dbo.Teachers b
	ON a.TeacherId = b.TeacherId
INNER JOIN dbo.Classrooms c
	ON a.CourseId = c.CourseId
INNER JOIN dbo.Teachers d
	ON a.TeacherId = d.TeacherId

SELECT * FROM dbo.Exc_2h

SELECT Teacher_Name, AVG (degree) AS Mean
FROM dbo.Exc_2h
GROUP BY Teacher_Name
ORDER BY Mean DESC


-------------------------------3a-------------------------------

CREATE VIEW Courses
AS SELECT a.courseName AS Course_name,
		  b.DepartmentName AS Dep_name,
		  c.Teacher_Name AS Teacher_Name,
		  d.StudentId AS Total_Students
FROM dbo.Courses a 
INNER JOIN dbo.Departments b 
	ON a.DepartmentID = b.DepartmentId
INNER JOIN dbo.Exc_2h c
	ON a.TeacherId = c.TeacherId
INNER JOIN dbo.Classrooms d
	ON a.CourseId = d.CourseId
GROUP BY courseName,DepartmentName,c.Teacher_Name, d.StudentId

SELECT * FROM Courses
SELECT 
	Course_name,
	Dep_name,
	Teacher_Name, 
	COUNT (Total_Students) as Total
FROM  
	Courses
GROUP BY 
	Course_name,Dep_name,Teacher_Name


---------------------------------------revised answer 3a

CREATE VIEW Courses_view
AS SELECT a.courseName,
		  b.DepartmentName,
		  c.Teacher_Name,
		  COUNT (DISTINCT d.StudentId) AS Sudent_Id
FROM dbo.Courses a 
INNER JOIN dbo.Departments b 
	ON a.DepartmentID = b.DepartmentId
INNER JOIN dbo.Exc_2h c
	ON a.TeacherId = c.TeacherId
INNER JOIN dbo.Classrooms d
	ON a.CourseId = d.CourseId
GROUP BY courseName,DepartmentName,Teacher_Name

SELECT * FROM Courses_view






-------------------------------3b-------------------------------
CREATE VIEW Students
AS SELECT a.StudentId AS Student_ID,
		  COUNT(a.CourseId) AS courses_taken,
		  a.degree AS Course_degree,
		  b. departmentID Dep_ID
FROM dbo.Classrooms a 
INNER JOIN dbo.Courses b
	ON a.CourseId = b.CourseId
GROUP BY a.StudentId, a.CourseId,a.degree, b.DepartmentID

SELECT * FROM Students

SELECT Student_ID
	  ,SUM (courses_taken) AS Courses_Taken
	  ,AVG (Course_degree) Mean_Degree
FROM Students
GROUP BY Student_ID

SELECT Student_ID
	,Dep_ID
	,AVG (Course_degree) as Dep_AVG
FROM
	Students
GROUP BY
	Student_ID, Dep_ID
ORDER BY 
	Student_ID 
	



------THIS IS MY UNSUCCESSFUL TRYING TO DO AN AGGREGATION IN THE VIEW - I DON'T KNOW WHY IT DOESN'T WORK PROPERLY :(

CREATE VIEW 
		  Students_Degree
AS SELECT a.StudentId AS Student_ID
		 ,SUM (COUNT(a.CourseId) 
			FROM (SELECT c.StudentId
						,d.CourseId
				  FROM dbo.Classrooms c
				  INNER JOIN dbo.Courses d
					ON c.CourseId = d.CourseId)) AS Courses_taken
		  ,a.degree AS Mean_Degree
		  ,b. departmentID AS Dep_ID
FROM dbo.Classrooms a 
INNER JOIN dbo.Courses b
	ON a.CourseId = b.CourseId
GROUP BY a.StudentId, a.CourseId,a.degree, b.DepartmentID

select * from Students_Degree

---------------------------------------revised answer 3b
CREATE VIEW Students_Degree_view 
AS SELECT a.StudentId
		 ,SUM (COUNT(a.CourseId) 
			IN (SELECT c.StudentId
						,d.CourseId
				  FROM dbo.Classrooms c
				  INNER JOIN dbo.Courses d
					ON c.CourseId = d.CourseId)) AS Courses_Taken
		  ,AVG (a.degree) AS Mean_Degree
		  ,b. departmentId
FROM dbo.Classrooms a 
INNER JOIN dbo.Courses b
	ON a.CourseId = b.CourseId
GROUP BY a.StudentId, a.CourseId,a.degree, b.DepartmentID



CREATE VIEW StudentList_v
AS
SELECT a.StudentId, a.FirstName, a.LastName,
       COUNT(DISTINCT b.CourseId) as num_courses,
       AVG(CASE WHEN (c.DepartmentId = 1 ) THEN (b.degree) END) as English_degree,
       AVG(CASE WHEN (c.DepartmentId = 2 ) THEN (b.degree) END) as Arts_degree,
       AVG(CASE WHEN (c.DepartmentId = 3 ) THEN (b.degree) END) as Science_degree,
       AVG(CASE WHEN (c.DepartmentId = 4 ) THEN (b.degree) END) as Sports_degree,
       AVG(b.degree) as General_degree
FROM Students a
LEFT OUTER JOIN Classrooms b
  ON a.StudentId = b.StudentId
LEFT OUTER JOIN Courses c
  ON b.CourseId = c.CourseId
GROUP BY a.StudentId, a.FirstName, a.LastName;

SELECT * FROM StudentList_v
