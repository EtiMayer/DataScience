-------------------------------2a-------------------------------
SELECT a. CourseName, a.CourseId, a.DepartmentID, b.StudentID
INTO dbo.Exc_2
	FROM dbo.Courses$ a
INNER JOIN  dbo.Classrooms$ b
	ON a.CourseId = b.CourseId


SELECT a.DepartmentId, a.DepartmentName, b.StudentId
INTO dbo.Exc_2a
	 FROM dbo.Departments$ a
INNER JOIN dbo.Exc_2 b
	ON a.DepartmentId = b.DepartmentID

SELECT * FROM dbo.Exc_2a

---Final answer for 2a
SELECT DepartmentName, COUNT (DepartmentName) AS Dep_cnt
FROM dbo.Exc_2a
GROUP BY DepartmentName
ORDER BY Dep_cnt DESC

-------------------------------2b-------------------------------

SELECT * FROM dbo.Exc_2

SELECT CourseId, CourseName, COUNT (StudentId) AS students_cnt
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


-------------------------------2d-------------------------------

SELECT Gender, COUNT (Gender) AS Total_Gender
FROM dbo.Students$
GROUP BY Gender

--Incorrect Statement. More females! :)


-------------------------------2e-------------------------------

SELECT a. CourseName, a.CourseId, b.StudentID, c.Gender
INTO dbo.Exc_2e
	FROM dbo.Courses$ a
INNER JOIN  dbo.Classrooms$ b
	ON a.CourseId = b.CourseId
INNER JOIN dbo.Students$ c
	ON b.StudentId = c.StudentId

SELECT * FROM dbo.Exc_2e 

SELECT CourseName, 
	   COUNT (gender)  
FROM Exc_2e
WHERE (COUNT (gender) = 'm' /SUM (COUNT (Gender) OVER () = 'f') > 70
GROUP BY CourseName

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
 

SELECT a.CourseName, 
	   a.Females, 
	   b.Male, 
	   a.Females + b.Male AS Total_students
INTO dbo.Total_Gender
	FROM dbo.F_students a
INNER JOIN dbo.M_students b
ON a.CourseName = b.CourseName

SELECT * FROM dbo.Total_Gender

SELECT CourseName,
		(((Male * 1.0) / (Total_students * 1.0))*100.0) AS Ratio
FROM dbo.Total_Gender
WHERE (((Male * 1.0) / (Total_students * 1.0))*100.0) >70.0

SELECT CourseName,
		(((Females * 1.0) / (Total_students * 1.0))*100.0) AS Ratio
FROM dbo.Total_Gender
WHERE (((Females * 1.0) / (Total_students * 1.0))*100.0) >70.0


-------------------------------2f-------------------------------

SELECT a.DepartmentName, b.CourseId,c.StudentId, c. degree
INTO dbo.Exc_2f
	 FROM dbo.Departments$ a
INNER JOIN dbo. Courses$ b
	ON a.DepartmentId = b.DepartmentID
INNER JOIN dbo.Classrooms$ c 
	ON b.CourseId = c.CourseId

SELECT DepartmentName, 
	   COUNT (degree) AS Total_Above80 , 
	   100.0* COUNT (degree)/SUM (COUNT(*)) OVER() AS [Percent_above80]
FROM Exc_2f
WHERE degree > 80.0
GROUP BY DepartmentName
;


-------------------------------2g-------------------------------

SELECT a.DepartmentName, b.CourseId,c.StudentId, c. degree
INTO dbo.Exc_2f
	 FROM dbo.Departments$ a
INNER JOIN dbo. Courses$ b
	ON a.DepartmentId = b.DepartmentID
INNER JOIN dbo.Classrooms$ c 
	ON b.CourseId = c.CourseId

SELECT DepartmentName, 
	   COUNT (degree) AS Total_Below60 , 
	   100.0* COUNT (degree)/SUM (COUNT(*)) OVER() AS [Percent_below60]
FROM Exc_2f
WHERE degree < 60
GROUP BY DepartmentName
;

-------------------------------2h-------------------------------


SELECT a.TeacherId,a.CourseId, C.degree
INTO dbo.Exc_2h
	FROM dbo.Courses$ a
INNER JOIN  dbo.Teachers$ b
	ON a.TeacherId = b.TeacherId
INNER JOIN dbo.Classrooms$ c
	ON a.CourseId = c.CourseId

SELECT * FROM dbo.Exc_2h

SELECT TeacherId, AVG (degree) AS Mean
FROM dbo.Exc_2h
GROUP BY TeacherId
ORDER BY Mean DESC


-------------------------------3a-------------------------------

CREATE VIEW Courses
AS SELECT a.courseName AS Course_name,
		  b.DepartmentName AS Dep_name,
		  c.TeacherId AS Teacher_ID,
		  d.StudentId AS Total_Students
FROM dbo.Courses$ a 
INNER JOIN dbo.Departments$ b 
	ON a.DepartmentID = b.DepartmentId
INNER JOIN dbo.Teachers$ c
	ON a.TeacherId = c.TeacherId
INNER JOIN dbo.Classrooms$ d
	ON a.CourseId = d.CourseId
GROUP BY courseName,DepartmentName,c.TeacherId, d.StudentId

SELECT 
	Course_name,
	Dep_name,
	Teacher_ID, 
	COUNT (Total_Students) as Toatl
FROM  
	Courses
GROUP BY 
	Course_name,Dep_name,Teacher_ID


-------------------------------3b-------------------------------
CREATE VIEW Students
AS SELECT a.StudentId AS Student_ID,
		  a.CourseId AS courses_taken,
		  a.degree AS Course_degree,
		  b. departmentID Dep_ID
FROM dbo.Classrooms$ a 
INNER JOIN dbo.Courses$ b
	ON a.CourseId = b.CourseId

GROUP BY a.StudentId, a.CourseId,a.degree, b.DepartmentID


SELECT 
	Student_ID,
	COUNT (courses_taken) AS Total_courses_taken,
	AVG (Course_degree) AS Course_Mean
FROM  
	Students
GROUP BY 
	Student_ID

SELECT 
	Student_ID,
	Dep_ID,
	AVG (Course_degree) as Dep_AVG
FROM
	Students
GROUP BY
	Student_ID,
	Dep_ID
ORDER BY 
	Student_ID 
	
