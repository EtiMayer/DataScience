
#### On Linux server:
library(DBI)
con <- dbConnect(odbc::odbc(), .connection_string = "Driver={ODBC Driver 17 for SQL Server};server=192.168.1.1;
database=COLLEGE;uid=dsuser02;
pwd=DSuser02!", timeout = 10)

#### On Windows:
library(DBI)
con <- dbConnect(odbc::odbc(), "College;Trusted_connection=yes;")

## Get the whole table:

students <- dbGetQuery(con, "SELECT * FROM College.dbo.Students")
courses <-dbGetQuery(con, "SELECT * FROM College.dbo.Courses")
departments <-dbGetQuery(con, "SELECT * FROM College.dbo.Departments")
classrooms <-dbGetQuery(con, "SELECT * FROM College.dbo.Classrooms")
teachers <-dbGetQuery(con, "SELECT * FROM College.dbo.Teachers")

library(dplyr)

## Questions

##############
## Q1. Count the number of students on each department¶
##############

Q1 <- Reduce(function(classrooms,courses) merge(classrooms,courses, all=TRUE), list(classrooms,courses,departments))

Q1 %>%  group_by(DepartmentName)  %>% summarise(StudentCnt=n_distinct(StudentId))

##############
## Q2. How many students have each course of the English department and the 
##     total number of students in the department?
##############

English_Courses <- Q1 %>% filter(DepartmentId %in% c(1)) %>%
                          group_by(CourseName) %>%
                          summarise(StudentCnt=n_distinct(StudentId))

English_Department<- Q1 %>% filter(DepartmentId %in% c(1)) %>%
                            group_by(DepartmentName) %>%
                            summarise(StudentCnt=n_distinct(StudentId))
colnames(English_Department) <- c('CourseName','StudentCnt')

bind_rows(English_Courses,English_Department)

##############
## Q3. How many small (<22 students) and large (22+ students) classrooms are 
##     needed for the Science department?
##############
Q3 <- Q1 %>% filter(between(CourseId,4,19)) %>%
             group_by(DepartmentName,CourseName) %>%
             summarise(StudentCnt=n_distinct(StudentId))
colnames(Q3) <- c('DepartmentName','Course','StudentCnt')

ClassSize <- Q3 %>% mutate(Class = ifelse(StudentCnt < 22, "Small Class","Big Class"))%>%
                    group_by(Class) %>%
                    summarise(count=n())

ClassSize
##############
## Q4. A feminist student claims that there are more male than female in the 
##     College. Justify if the argument is correct
##############

students %>% group_by(Gender) %>% summarise(count=n())

##############
## Q5. For which courses the percentage of male/female students is over 70%?
##############
Q5 <- Reduce(function(classrooms,courses) merge(classrooms,courses, all=TRUE), list(classrooms,courses,students))

over_70per <- Q5 %>% count(CourseName,Gender) %>% mutate(percent=(count(Gender)/sum(n)*100))

over_70per %>% filter(percent <0.7)


##############
## Q6. For each department, how many students passed with a grades over 80?
##############

Student80 <- Q1 %>% filter(between(degree,80,100)) %>%
                   group_by(DepartmentName) %>%
                   summarise(StudentCnt=n_distinct(StudentId))

TotalStudents <- Q1 %>% group_by(DepartmentName) %>%
                       summarise(Total=n_distinct(StudentId))


Above80_pct <- merge(Student80, TotalStudents, by="DepartmentName") %>%
               mutate(percent = (StudentCnt/Total)*100)
Above80_pct  
##############
## Q7. For each department, how many students passed with a grades under 60?
##############
Student60 <- Q1 %>% filter(between(degree,0,60)) %>%
  group_by(DepartmentName) %>%
  summarise(StudentCnt=n_distinct(StudentId))

Under60_pct <- merge(Student60, TotalStudents, by="DepartmentName") %>%
  mutate(percent = (StudentCnt/Total)*100)
Under60_pct

##############
## Q8. Rate the teachers by their average student's grades (in descending order).
##############
Q8 <- Reduce(function(classrooms,courses) merge(classrooms,courses, all=TRUE), list(classrooms,courses,teachers))
Q8 %>% group_by(FirstName,LastName) %>%
  summarise(Mean= mean(degree)) %>%
  arrange(desc(Mean))

##############
## Q9. Create a dataframe showing the courses, departments they are associated with, 
##     the teacher in each course, and the number of students enrolled in the course 
##     (for each course, department and teacher show the names).
##############
Q9 <- Reduce(function(classrooms,courses) merge(classrooms,courses, all=TRUE), list(classrooms,courses,teachers,departments))

Q9 %>% group_by(CourseId,CourseName,DepartmentName,FirstName,LastName) %>%
       summarise(StudentCnt = n_distinct(StudentId))


##############
## Q10. Create a dataframe showing the students, the number of courses they take, 
##      the average of the grades per class, and their overall average (for each student 
##      show the student name).
##############
Q10 <- Reduce(function(students,classrooms) merge(students,classrooms, all=TRUE), list(students,classrooms,courses))


Overall_Average <- Q10 %>% group_by(StudentId,FirstName,LastName) %>%
                           summarise(CoursesTaken = n_distinct(CourseId),Mean= mean(degree))

Courses_Average <- Q10 %>% group_by(StudentId) %>%
                           mutate(Deparatment_Name = ifelse(DepartmentId == 1, "English",
                                                     ifelse(DepartmentId == 2, "Science",
                                                     ifelse(DepartmentId == 3 , "Art", "Sport"))))
