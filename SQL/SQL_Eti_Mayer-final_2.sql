


/* ********************************************************** */
/* ********************************************************** */
/* *******      ANALYSIS                               ****** */
/* ********************************************************** */
/* ********************************************************** */

---- 2a. Number of students by Department

SELECT c.DepartmentName,COUNT(DISTINCT(a.StudentId)) as StudentCnt
FROM Classrooms a
INNER JOIN Courses b
	ON a.CourseId = b.CourseId
INNER JOIN Departments c
	ON c.DepartmentId=b.DepartmentId
GROUP BY c.DepartmentName

---- 2b. How many studenst has the English teacher by course and in total?

SELECT a.CourseName, COUNT(DISTINCT (b.StudentId)) AS StudentCnt
FROM Courses a
INNER JOIN Classrooms b 
	ON a.CourseId = b.CourseId
WHERE a.DepartmentId = 1
GROUP BY a.CourseName
UNION ALL
SELECT 'Total' AS CourseName, COUNT(DISTINCT(b.StudentId)) AS StudentCnt
FROM Courses a
INNER JOIN Classrooms b 
	ON a.CourseId = b.CourseId
WHERE a.DepartmentId = 1
GROUP BY a.DepartmentId



---- 2c. How many small (<22) and bigger (>=22) Classrooms has the Science Department?
SELECT (
		CASE WHEN (sci.classcnt <22) THEN ('Small Class')
			ELSE ('Big Class')
		END) AS class_size,
		COUNT (1) AS class_num
FROM ( SELECT a.CourseId,COUNT(DISTINCT b.StudentId) AS classcnt
FROM Courses a
INNER JOIN Classrooms b 
	ON a.CourseId = b.CourseId
WHERE a.DepartmentId=2
GROUP BY a.CourseId) AS sci
GROUP BY (
		CASE WHEN (sci.classcnt <22) THEN ('Small Class')
			ELSE ('Big Class')
		END)  

----- 2d. How many students are by Gender?

SELECT Gender, COUNT(DISTINCT (StudentId)) AS StudentCnt 
FROM Students
GROUP BY Gender

----- 2e. In which courses the percentage of males / females are higher than 70% ?

SELECT cls.CourseName, 
	   cls.Gender,
	   ((cls.StudentCnt*1.0/cls.Total*1.0)*100.0) AS pcnt
FROM 
(SELECT a.CourseId, 
	   c.CourseName,
	   b.Gender,
	   COUNT (1) AS StudentCnt,
	   (SELECT COUNT (1) FROM Classrooms WHERE CourseId = a.CourseId) AS Total
FROM Classrooms a
LEFT OUTER JOIN Students b
	ON a.StudentId = b.StudentId
LEFT OUTER JOIN Courses c
	ON a.CourseId = c.CourseId
GROUP BY a.CourseId,
		 c.CourseName,
		 b.Gender ) AS cls
WHERE (cls.StudentCnt*1.0/cls.Total*1.0)*100.0 >70.0

----- 2f. How many students (n and %) have a degree of 80+ by Department?

-- possibility 1: getting the number of students with at least one degree with more than 80 per department

SELECT cls.DepartmentName,
	   SUM (cls.grd80) AS StudentCnt,
	   COUNT (DISTINCT(cls.StudentId)) AS Total,
	   (SUM (cls.grd80)*1.0 / COUNT (DISTINCT(cls.StudentId))*100) AS pcnt
FROM ( 
SELECT DISTINCT c.DepartmentName,
				a.StudentId,
				CASE WHEN (a.degree>80) THEN (1) ELSE (0) END AS grd80
FROM classrooms a
INNER JOIN courses b
	ON a.CourseId = b.CourseId
INNER JOIN Departments c
	ON b.DepartmentId = c.DepartmentId
	)AS cls
GROUP BY cls.DepartmentName

-- possibility 2: getting the number of students with mean degree higher than 80 per department

SELECT cls.DepartmentName,
	   SUM (CASE WHEN (mean > 80) THEN (1) ELSE (0) END) AS StudentCnt,
	   COUNT (DISTINCT(cls.StudentId)) AS Total,
	   (SUM (CASE WHEN (mean > 80) THEN (1) ELSE (0) END)*1.0/ COUNT (DISTINCT(cls.StudentId))*100) AS pcnt
FROM ( 
SELECT DISTINCT c.DepartmentName,
				a.StudentId,
				AVG (a.degree) AS mean
FROM classrooms a
INNER JOIN courses b
	ON a.CourseId = b.CourseId
INNER JOIN Departments c
	ON b.DepartmentId = c.DepartmentId
GROUP BY c.DepartmentName, a.StudentId
	)AS cls
GROUP BY cls.DepartmentName

---- 2g. How many students (n and %) have a degree lower than 60 by Department?

-- possibility 1: getting the number of students with at least one degree with less than 60 per department
SELECT cls.DepartmentName,
	   SUM (cls.grd60) AS StudentCnt,
	   COUNT (DISTINCT(cls.StudentId)) AS Total,
	   (SUM (cls.grd60)*1.0 / COUNT (DISTINCT(cls.StudentId))*100) AS pcnt
FROM (
SELECT DISTINCT c.DepartmentName,
				a.StudentId,
				CASE WHEN (a.degree < 60) THEN (1) ELSE (0) END AS grd60
FROM Classrooms a
INNER JOIN Courses b
	ON a.CourseId = b.CourseId
INNER JOIN Departments c
	ON b.DepartmentId = c.DepartmentId
	) AS cls
GROUP BY cls.DepartmentName

-- possibility 2: getting the number of students with mean degree higher than 80 per department
SELECT cls.DepartmentName,
	   SUM (CASE WHEN (cls.mean < 60 ) THEN (1) ELSE (0) END) AS StudentCnt,
	   COUNT(DISTINCT (cls.StudentId)) AS Total,
	   (SUM (CASE WHEN (cls.mean < 60 ) THEN (1) ELSE (0) END) * 1.0 / COUNT(DISTINCT (cls.StudentId)) *100) AS pcnt
FROM (
SELECT DISTINCT c.DepartmentName,
				a.StudentId,
				AVG (a.degree) AS mean
FROM Classrooms a
INNER JOIN Courses b
	ON a.CourseId = b.CourseId
INNER JOIN Departments c
	ON b.DepartmentId = c.DepartmentId
GROUP BY c.DepartmentName,  a.StudentId
	) AS cls
GROUP BY cls.DepartmentName

---- 2h Rate in descending order the teachers by their student's mean degree.
SELECT (cls.FirstName + ' ' + cls.LastName) AS TeacherName,
	   cls.mean
FROM (
SELECT c.FirstName,
	   c.LastName,
	   AVG (a.degree) AS mean
FROM Classrooms a
INNER JOIN Courses b
	ON a.CourseId = b.CourseId
INNER JOIN Teachers c
	ON b.TeacherId = c.TeacherId
GROUP BY c.FirstName,c.LastName) AS cls
ORDER BY cls.mean DESC
----- 3a. Create a view that shows the courses, departments, teachers and number 
-----   of students on each
-- DROP VIEW ClassrommList_v

CREATE VIEW ClassroomList AS
SELECT a.CourseId,
	   a.CourseName,
	   b.DepartmentName,
	   d.FirstName,
	   d.LastName,
	   COUNT (DISTINCT (c.StudentID)) AS StudentCnt
FROM Courses a
LEFT OUTER JOIN Departments b
	ON a.DepartmentId = b.DepartmentId
LEFT OUTER JOIN Classrooms c
	ON c.CourseId = a.CourseId
LEFT OUTER JOIN Teachers d
	ON d.TeacherId = a.TeacherId
GROUP BY a.CourseId, a.CourseName, b.DepartmentName, d.FirstName, d.LastName

SELECT * FROM ClassroomList

----- 3b. Create a view that shows each student, the number of courses taken, 
-----   their mean degree by department and the total degree mean.

CREATE VIEW Student_Mean AS
SELECT a.StudentId, a.FirstName, a.LastName,
	   COUNT (DISTINCT (c.CourseId)) AS CoursesTaken,
	   AVG (CASE WHEN (c.DepartmentId = 1) THEN (b.degree) END) AS English_Class,
	   AVG (CASE WHEN (c.DepartmentId = 2) THEN (b.degree) END) AS Science_Class,
	   AVG (CASE WHEN (c.DepartmentId = 3) THEN (b.degree) END) AS Art_Class,
	   AVG (CASE WHEN (c.DepartmentId = 4) THEN (b.degree) END) AS Sport_Class,
	   AVG (b.degree) AS Genral_mean
FROM Students a
LEFT OUTER JOIN Classrooms b
	ON a.StudentId = b.StudentId
LEFT OUTER JOIN Courses c
	ON c.CourseId = b.CourseId
GROUP BY a.StudentId, a.FirstName, a.LastName

DROP VIEW Student_Mean
SELECT * FROM Student_Mean