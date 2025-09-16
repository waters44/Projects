/*
Anika Rastogi, Rayna Arora, Lucy Waters, Meghan Spinazze
CNIT 27200 Spring 2025
Lab Time: Friday 1:30pm
Duration: 2 hours
*/
/*
******************************************************
Question 1
Author: Meghan Reviewer: Rayna
*/

SELECT STUDENTID, FIRSTNAME, LASTNAME, EMAIL
FROM STUDENT
WHERE FIRSTNAME LIKE ('E%');

/* Results:

STUDENTID  FIRSTNAME            LASTNAME                       EMAIL                                             
---------- -------------------- ------------------------------ --------------------------------------------------
1000000012 Elyzabeth            Waters                         ewaters@college.edu                               
1000000019 Eva                  Refeld’                        erefeld@college.edu’                              

/*
******************************************************
Question 2
Author: Meghan Reviewer: Rayna
*/

SELECT ENROLLMENTDATE, STUDENT_STUDENTID
FROM ENROLLMENT
WHERE ENROLLMENTDATE BETWEEN ('01-JAN-2024') AND ('31-DEC-2024');

/* Results:

ENROLLMEN STUDENT_ST
--------- ----------
01-APR-24 1000000011
01-JAN-24 1000000013
01-MAY-24 1000000014
01-APR-24 1000000016
01-MAY-24 1000000016

/*
******************************************************
Question 3
Author: Meghan Reviewer: Rayna
*/

SELECT COURSEID, DESCRIPTION
FROM COURSE
WHERE COURSEID LIKE ('IT%');

/* Results:

COURS DESCRIPTION                                                                                                                                                                                                                                                                                                                                                   
----- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IT215 This course will provide students with the knowledge and techniques of introductory web programming.                                                                                                                                                                                                                                                          
IT373 Examination of best practices in software interface development for a variety of platforms.                                                                                                                                                                                                                                                                   

/*
******************************************************
Question 4
Author: Meghan Reviewer: Rayna
*/

SELECT CLASSSIZE, CREDITSOFFERED, (CLASSSIZE*CREDITSOFFERED) AS TOTAL_CREDITS
FROM COURSE;

/* Results:

 CLASSSIZE CREDITSOFFERED TOTAL_CREDITS
---------- -------------- -------------
        32              3            96
       250              1           250
        25              3            75
        30              3            90
       130              2           260
        30              3            90
       150              3           450
        28              3            84
        70              3           210
        75              3           225

/*
******************************************************
Question 5
Author: Meghan Reviewer: Rayna
*/

SELECT BUILDING, ROOMNUMBER
FROM CLASSROOM
WHERE BUILDING NOT IN ('ARMST', 'KNOYH');

/* Results:

BUILD ROO
----- ---
SMITH 108
BEERI 194
STONE 217
BEERI 261
PHYSI 274

/*
******************************************************
Question 6
Author: Meghan Reviewer: Rayna
*/

SELECT NVL(ACCESSIBILITY, 'NO_ACCESSIBILITY') AS ACCESSIBILITY, LPAD(FACILITIES, 25, '#') AS FACILITIES
FROM CLASSROOM;

/* Results:

ACCESSIBILITY                                                               FACILITIES               
--------------------------------------------------------------------------- -------------------------
Ramp, Elevator, Subtitles, Wheelchair Accessible Seats                      #Computer Lab, TV Screens
Elevator                                                                    ################Projector
Ramp                                                                        Science Lab, Fume Hoods, 
Subtitles                                                                   ####Projector, Chalkboard
Ramp, Subtitles, Wheelchair Accessible Seats                                #Computer Lab, TV Screens
Ramp, Elevator                                                              ################Projector
Elevator                                                                    ################Projector
NO_ACCESSIBILITY                                                            ####Projector, Chalkboard
Elevator, Wheelchair Accessible Seats                                       #Computer Lab, TV Screens
Ramp, Elevator, Wheelchair Accessible Seats                                 ###Projector, Whiteboards

10 rows selected. 

/*
******************************************************
Question 7
Author: Meghan Reviewer: Rayna
*/

SELECT MIN(ENROLLMENTDATE) AS OLDEST_ENROLLMENT
FROM ENROLLMENT;

/* Results:

OLDEST_EN
---------
01-JAN-24

/*
******************************************************
Question 8
Author: Meghan Reviewer: Rayna
*/

SELECT CREDITSOFFERED, COUNT(CREDITSOFFERED) AS TOTAL
FROM COURSE
GROUP BY CREDITSOFFERED;

/* Results:

CREDITSOFFERED      TOTAL
-------------- ----------
             1          1
             2          1
             3          8

*/
--9. Use the Sum function to add up a calculated column. For example: SUM(price*quantity) as TOTAL_ORDER.
--Author: Rayna Reviewer: Meghan

select professor_lecturerid ,sum(classsize*creditsoffered) as CourseDemandLoad from course group by professor_lecturerid having professor_lecturerid is not null;
/*
PROFESSOR_ COURSEDEMANDLOAD
---------- ----------------
1000000005              450
1000000007              210
1000000002              165
1000000004              260
1000000003               90
1000000000               96
1000000008              225
1000000001              250

8 rows selected. */

--10. Use the Average function on either a number or date in your database. Use Group by to group the average by one field in the result set. (ie, Average price of each equipment type)
--Author: Rayna Reviewer: Meghan

select department,avg(salary) from professor group by department;
/*
DEPARTMENT           AVG(SALARY)
-------------------- -----------
Civil Engineering          66000
Political Science          64500
IT                         68000
Software Engineering       61000
Art and Design             45000
Aviation                   66500

6 rows selected.  */

--11. Use HAVING to filter an aggregated function (use Count, Sum, Min, Max or Avg in a query)
--Author: Rayna Reviewer: Meghan

select department, min(salary),avg(salary) from professor group by department having min(salary)<avg(salary);
/*
DEPARTMENT           MIN(SALARY) AVG(SALARY)
-------------------- ----------- -----------
Civil Engineering          63000       66000
Political Science          54000       64500
Software Engineering       50000       61000
Aviation                   62000       66500 */

--12. Build a SQL statement that filters with both a WHERE clause and a HAVING clause.
--Author: Rayna Reviewer: Meghan

select building, count(*) from classroom where accessibility like '%Ramp%' or accessibility like '%Elevator%' group by building having count(*)>2;
/*
BUILD   COUNT(*)
----- ----------
KNOYH          3 */

--13. Build an INNER JOIN between just two tables. The chosen attributes in the Select clause shouldcome from both tables. Filter with at least two conditions in the WHERE clause.
--Author: Rayna Reviewer: Meghan

select courseid,classroom.building,classroom.roomnumber, round(((classsize/capacity)*100),2) as Utilization from classroom inner join course on classroom.building=course.classroom_building and classroom.roomnumber=course.classroom_roomnumber
where round(((classsize/capacity)*100),2)<85 and facilities like '%Computer Lab%';
/*
COURS BUILD ROO UTILIZATION
----- ----- --- -----------
AD113 KNOYH 274       71.43 */

--14. Build a query that has to pull from at least 4 different tables. The attributes in the Select clause should come from at least two of the tables. Include a date as one of your attributes and set the date format to report out like: Thursday, December 2, 2021.
--Author: Rayna Reviewer: Meghan

col student format a20;
col professor format a20;

select student.firstname || ' ' || student.lastname as Student, professor.firstname || ' ' || professor.lastname as Professor, to_char(meetingtime, 'Day, Month DD, YYYY HH:MI'),courseID,nvl((classroom_building|| '' || classroom_roomnumber),'NOT ASSIGNED') as location
from student inner join enrollment on student.studentid=enrollment.student_studentid 
inner join course on enrollment.course_courseid=course.courseid
inner join professor on course.professor_lecturerid=professor.lecturerid;
/*
STUDENT              PROFESSOR            TO_CHAR(MEETINGTIME,'DAY,MONTHDD,YY COURS LOCATION    
-------------------- -------------------- ----------------------------------- ----- ------------
Doetri Ghosh         John Smith           Tuesday  , April     01, 2025 08:00 SC101 NOT ASSIGNED
Rayna Aurora         Jane Doe             Tuesday  , April     01, 2025 09:30 PY234 BEERI194    
Elyzabeth Waters     Jake Brown           Tuesday  , April     01, 2025 10:30 AD213 STONE217    
Meghan Spinazze      Jake Brown           Tuesday  , April     01, 2025 10:30 AD213 STONE217    
Johanna Walther      Carlos Martinez      Tuesday  , April     01, 2025 12:30 AT223 SMITH108    
Doetri Ghosh         Emily Nguyen         Tuesday  , April     01, 2025 01:30 CE311 NOT ASSIGNED
Bea Cabot            Linda Kim            Tuesday  , April     01, 2025 02:00 IT215 ARMST101    
Rachel Sennot        Fatima Alvi          Tuesday  , April     01, 2025 03:00 AT327 ARMST674    
Eva Refeld’          Robert King          Tuesday  , April     01, 2025 05:30 PY343 KNOYH061    

9 rows selected.    */

--15. Use a nested subquery to find a pool of data and then the outer query is looking for records NOT IN the nested query. The inner query and outer query should be from different, but related, tables.
--Author: Rayna Reviewer: Meghan

select student.firstname || ' ' || student.lastname as Student from student 
where studentid not in (select student_studentid from enrollment where offeredterm='Spring2025');
/*
STUDENT             
--------------------
Anika Rastogi
Rayna Aurora
Johanna Walther
Bea Cabot
Florence Pugh */

--16. Use a subquery to find results that are greater than an average result in your nested query.
--Author: Rayna Reviewer: Meghan

select professor.firstname || ' ' || professor.lastname as Professor, salary from professor
where salary > (select avg(salary) from professor);
/*
PROFESSOR                SALARY
-------------------- ----------
Jane Doe                  75000
Carlos Martinez           71000
Linda Kim                 68000
Michael Zhao              72000
Fatima Alvi               69000
Sophia Clark              63000

6 rows selected. */

/*
17. Build an INNER JOIN between two tables and include an aggregate function in the Select clause.
Must also include the use of Group By.
Author: Lucy Reviewer: Anika
*/

SELECT c.courseid, c.description,
    COUNT(e.student_studentid) AS total_students
FROM course c
INNER JOIN enrollment e ON c.courseid = e.course_courseid
GROUP BY c.courseid, c.description;

/*
Results:
COURS DESCRIPTION                                                                                                                                                                                                                                                                                                                                                    TOTAL_STUDENTS
----- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------
AT327 This course addresses advanced aviation topics to include high speed aerodynamics, automated cockpit instrumentation, domestic/international flight operations, and global navigation.                                                                                                                                                                                      1
AD213 Introduction to drawing the human figure with emphasis upon structure and gesture.                                                                                                                                                                                                                                                                                          2
PY234 Contemporary political problems in the United States affecting the interpretation of democracy, human rights and welfare, social pressures, and intergovernmental relations.                                                                                                                                                                                                1
AT223 This course explores the fundamental concepts of single pilot and multi-crew human factors issues. It focuses on the physiological factors , human error, threat and error management.                                                                                                                                                                                      1
IT373 Examination of best practices in software interface development for a variety of platforms.                                                                                                                                                                                                                                                                                 1
PY343 A study of international legal theories, principles, and practices, with an emphasis on the role and utility of law in contemporary international relations.                                                                                                                                                                                                                1
SC101 This is a special projects course that will be used for special circumstances with individual study or for experimental courses, pointed toward students who are first- or second-year students.                                                                                                                                                                            1
IT215 This course will provide students with the knowledge and techniques of introductory web programming.                                                                                                                                                                                                                                                                        1
CE311 This course introduces energy efficiency, thermal comfort, indoor environmental quality and green building design concepts. The course covers engineering fundamentals required for the design and analysis of building systems.                                                                                                                                            1

9 rows selected. 
*/

/*
18. Build a query that utilizes a LEFT OUTER JOIN. The result set should have parents that do not
have children. (If you do not have this situation in your database, do an additional INSERT in
the parent table in order to make the task work)
Author: Lucy Reviewer: Anika
*/

SELECT p.lecturerid, p.firstname, p.lastname
FROM professor p
LEFT OUTER JOIN course c ON p.lecturerid = c.professor_lecturerid
WHERE c.courseid IS NULL;

/*
Results:
LECTURERID FIRSTNAME            LASTNAME                      
---------- -------------------- ------------------------------
1000000006 Michael              Zhao                          
1000000009 Sophia               Clark                         

*/

/*
19. Build a query that utilizes a RIGHT OUTER JOIN. The result set should have children that do not
have parents. (If you do not have this situation in your database, alter your database to allow a
child table to have NULL values in the foreign key field. Then do an additional INSERT in the
child table in order to make the task work).
Author: Lucy Reviewer: Anika
*/

-- Right Outer Join to get children (enrollment) that do not have parents (students)
SELECT 
    c.roomnumber,
    c.building,
    c.capacity,
    co.courseid,
    co.courseid
FROM 
    classroom c
RIGHT OUTER JOIN 
    course co
ON 
    c.roomnumber = co.classroom_roomnumber
WHERE 
    co.classroom_roomnumber IS NULL;

/*
Results:
ROO BUILD   CAPACITY COURS COURS
--- ----- ---------- ----- -----
                     SC101 SC101
                     CE311 CE311
*/

/*
20. Use UNION to join two tables together.
Author: Lucy Reviewer: Anika
*/

SELECT studentid AS personid FROM student
UNION
SELECT lecturerid AS personid FROM professor;

/*
Results:
PERSONID  
----------
1000000000
1000000001
1000000002
1000000003
1000000004
1000000005
1000000006
1000000007
1000000008
1000000009
1000000010

PERSONID  
----------
1000000011
1000000012
1000000013
1000000014
1000000015
1000000016
1000000017
1000000018
1000000019

20 rows selected.

*/

/*
21. Use INTERSECT to find common values between two tables.
Author: Lucy Reviewer: Anika
*/

SELECT studentid FROM student
INTERSECT
SELECT student_studentid FROM enrollment;

/*
Results:
STUDENTID 
----------
1000000011
1000000012
1000000013
1000000014
1000000015
1000000016
1000000018
1000000019

8 rows selected. 

*/

/*
22. Make an update to a single record in one of your tables. Explain the update and then perform
the task. Display the before, update, and after stmts/output.
Author: Lucy Reviewer: Anika
*/

SELECT * FROM student WHERE lastname = 'Pugh';

UPDATE student
SET lastname = 'Pugh-Smith'
WHERE rowid = (
  SELECT rowid FROM student
  WHERE lastname = 'Pugh'
  AND ROWNUM = 1
);

SELECT * FROM student WHERE lastname = 'Pugh-Smith';

/*
Results:
STUDENTID  FIRSTNAME            LASTNAME                       EMAIL                                              ADDRESS                                                                                                                                                                                                  EMERGENCYC
---------- -------------------- ------------------------------ -------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------
1000000017 Florence             Pugh                           fpugh@college.edu                                  714 Train Avenue                                                                                                                                                                                         1844173860

STUDENTID  FIRSTNAME            LASTNAME                       EMAIL                                              ADDRESS                                                                                                                                                                                                  EMERGENCYC
---------- -------------------- ------------------------------ -------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------
1000000017 Florence             Pugh-Smith                     fpugh@college.edu                                  714 Train Avenue                                                                                                                                                                                         1844173860

*/

/*
23. Update a set of records in one statement (more than one row should be updated). Explain the
update and then perform the task. Display the before, update, and after stmts/output.
Author: Lucy Reviewer: Anika
*/

SELECT courseid, classsize, classroom_building FROM course WHERE classroom_building = 'KNOYH';

UPDATE course
SET classroom_building = 'PHYSI', classroom_roomnumber = '274'
WHERE classroom_building = 'KNOYH';

SELECT courseid, classsize, classroom_building FROM course WHERE classroom_building = 'PHYSI';

/*
Results:
COURS  CLASSSIZE CLASS
----- ---------- -----
AD113         45 KNOYH
PY343         75 KNOYH

COURS  CLASSSIZE CLASS
----- ---------- -----
AD113         45 PHYSI
PY343         75 PHYSI

*/
/*
*******************************************************************************
Question 24 
Author: Anika Reviewer: Lucy*/
--Before:

SELECT * FROM STUDENT;

--Insert:

INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000020', 'Nina', 'Patel', 'npatel@college.edu', '400 State Street', '7778889999');

INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000021', 'Leo', 'Nguyen', 'lnguyen@college.edu', '200 Hilltop Avenue', '1231231234');

--After:

SELECT * FROM STUDENT WHERE StudentID IN ('1000000020', '1000000021');
/* Results:
Before Result:

STUDENTID  FIRSTNAME            LASTNAME                       EMAIL                                              ADDRESS                                                                                                                                                                                                  EMERGENCYC
---------- -------------------- ------------------------------ -------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------
1000000010 Anika                Rastogi                        arastogi@college.edu                               123 College Street                                                                                                                                                                                       1234567890
1000000011 Rayna                Aurora                         raurora@college.edu                                123 Pete Drive                                                                                                                                                                                           1735296947
1000000012 Elyzabeth            Waters                         ewaters@college.edu                                456 Boiler Maker Street                                                                                                                                                                                  5629471549
1000000013 Meghan               Spinazze                       mspinazze@college.edu                              204 Ross Ade Drive                                                                                                                                                                                       1018395732
1000000014 Johanna              Walther                        jwalther@college.edu                               333 Purdue Street                                                                                                                                                                                        1526474908
1000000015 Doetri               Ghosh                          dghosh@college.edu                                 555 Krach Street                                                                                                                                                                                         2225627599
1000000016 Bea                  Cabot                          bcabot@college.edu                                 555 Krach Street                                                                                                                                                                                         1019462314
1000000017 Florence             Pugh                           fpugh@college.edu                                  714 Train Avenue                                                                                                                                                                                         1844173860
1000000018 Rachel               Sennot                         rsennot@college.edu                                829 Meredith South Drive                                                                                                                                                                                 9302745566
                                                                                                                                                                                                          1231231234
9 rows selected. 

Insert Result:
1 row inserted.


1 row inserted.

After Result:

STUDENTID  FIRSTNAME            LASTNAME                       EMAIL                                              ADDRESS                                                                                                                                                                                                  EMERGENCYC
---------- -------------------- ------------------------------ -------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------
1000000010 Anika                Rastogi                        arastogi@college.edu                               123 College Street                                                                                                                                                                                       1234567890
1000000011 Rayna                Aurora                         raurora@college.edu                                123 Pete Drive                                                                                                                                                                                           1735296947
1000000012 Elyzabeth            Waters                         ewaters@college.edu                                456 Boiler Maker Street                                                                                                                                                                                  5629471549
1000000013 Meghan               Spinazze                       mspinazze@college.edu                              204 Ross Ade Drive                                                                                                                                                                                       1018395732
1000000014 Johanna              Walther                        jwalther@college.edu                               333 Purdue Street                                                                                                                                                                                        1526474908
1000000015 Doetri               Ghosh                          dghosh@college.edu                                 555 Krach Street                                                                                                                                                                                         2225627599
1000000016 Bea                  Cabot                          bcabot@college.edu                                 555 Krach Street                                                                                                                                                                                         1019462314
1000000017 Florence             Pugh                           fpugh@college.edu                                  714 Train Avenue                                                                                                                                                                                         1844173860
1000000018 Rachel               Sennot                         rsennot@college.edu                                829 Meredith South Drive                                                                                                                                                                                 9302745566
1000000020 Nina                 Patel                          npatel@college.edu                                 400 State Street                                                                                                                                                                                         7778889999
1000000021 Leo                  Nguyen                         lnguyen@college.edu                                200 Hilltop Avenue                                                                                                                                                                                       1231231234

11 rows selected. 


*/
/*
*******************************************************************************
Question 25
Author: Anika Reviewer: Lucy*/

--Before:
SELECT * FROM STUDENT WHERE StudentID = '1000000019';

--Delete:
DELETE FROM ENROLLMENT WHERE Student_StudentID = '1000000019';
DELETE FROM STUDENT WHERE StudentID = '1000000019';

--After:
SELECT * FROM STUDENT WHERE StudentID = '1000000019';

/* Results:

Before:
STUDENTID  FIRSTNAME            LASTNAME                       EMAIL                                              ADDRESS                                                                                                                                                                                                  EMERGENCYC
---------- -------------------- ------------------------------ -------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------
1000000019 Eva                  Refeld                         rsennot@college.edu                                829 Meredith South Drive                                                                                                                                                                                       1018395732

Delete:
1 row deleted.


1 row deleted.

After:
no rows selected
	
*/
/*
*******************************************************************************
Question 26 
Author: Anika Reviewer: Lucy*/

--Before:
DESCRIBE STUDENT;

--Alter:
ALTER TABLE STUDENT ADD Major VARCHAR2(50 CHAR);

--After:
DESCRIBE STUDENT;

/* Results:
Before:

Name             Null?    Type               
---------------- -------- ------------------ 
STUDENTID        NOT NULL CHAR(10 CHAR)      
FIRSTNAME                 VARCHAR2(20 CHAR)  
LASTNAME                  VARCHAR2(30 CHAR)  
EMAIL                     VARCHAR2(50 CHAR)  
ADDRESS                   VARCHAR2(200 CHAR) 
EMERGENCYCONTACT NOT NULL CHAR(10 CHAR)

Alter:

Table STUDENT altered.

After:

Name             Null?    Type               
---------------- -------- ------------------ 
STUDENTID        NOT NULL CHAR(10 CHAR)      
FIRSTNAME                 VARCHAR2(20 CHAR)  
LASTNAME                  VARCHAR2(30 CHAR)  
EMAIL                     VARCHAR2(50 CHAR)  
ADDRESS                   VARCHAR2(200 CHAR) 
EMERGENCYCONTACT NOT NULL CHAR(10 CHAR)      
MAJOR                     VARCHAR2(50 CHAR)  

*/
/*
*******************************************************************************
Question 27
Author: Anika Reviewer: Lucy*/

--Before:
SELECT StudentID, Major FROM STUDENT;

--Update:
UPDATE STUDENT SET Major = 'Undeclared';

--After:
SELECT StudentID, Major FROM STUDENT;

/* Results:

Before:
STUDENTID  MAJOR                                             
---------- --------------------------------------------------
1000000010                                                   
1000000011                                                   
1000000012                                                   
1000000013                                                   
1000000014                                                   
1000000015                                                   
1000000016                                                   
1000000017                                                   
1000000018                                                   
1000000020                                                   
1000000021                                                   

11 rows selected. 

Update:
11 rows updated.

After:
STUDENTID  MAJOR                                             
---------- --------------------------------------------------
1000000010 Undeclared                                        
1000000011 Undeclared                                        
1000000012 Undeclared                                        
1000000013 Undeclared                                        
1000000014 Undeclared                                        
1000000015 Undeclared                                        
1000000016 Undeclared                                        
1000000017 Undeclared                                        
1000000018 Undeclared                                        
1000000020 Undeclared                                        
1000000021 Undeclared                                        

11 rows selected. 
        
*/
/*
*******************************************************************************
Question 28 
Author: Anika Reviewer: Lucy*/

--Before:
SELECT StudentID, EmergencyContact FROM STUDENT WHERE StudentID = '1000000010';

--Update:
UPDATE STUDENT
SET EmergencyContact = '765' || SUBSTR(EmergencyContact, 4)
WHERE StudentID = '1000000010';

--After:
SELECT StudentID, EmergencyContact FROM STUDENT WHERE StudentID = '1000000010';

/* Results:
Before:

STUDENTID  EMERGENCYC
---------- ----------
1000000010 1234567890

Update:

1 row updated.

After:

STUDENTID  EMERGENCYC
---------- ----------
1000000010 7654567890
*/
/*
*******************************************************************************
Question 29 
Author: Anika Reviewer: Lucy*/

--View:
CREATE VIEW student_summary AS
SELECT StudentID, FirstName, LastName, Major FROM STUDENT;

--Alternate Key:
ALTER TABLE STUDENT ADD CONSTRAINT student_email_uk UNIQUE (Email);

--Inverted Key:
CREATE INDEX idx_major ON STUDENT (Major DESC);

--Metadata Query:
SELECT view_name FROM user_views;
SELECT index_name, table_name FROM user_indexes WHERE table_name = 'STUDENT';

/*
Results:

View:

View STUDENT_SUMMARY created.

Alternate Key:

Table STUDENT altered.

Inverted Key:

Index IDX_MAJOR created.

Metadata Query:

VIEW_NAME                                                                                                                       
--------------------------------------------------------------------------------------------------------------------------------
STUDENT_SUMMARY


INDEX_NAME                                                                                                                       TABLE_NAME                                                                                                                      
-------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------
STUDENT_EMAIL_UK                                                                                                                 STUDENT                                                                                                                         
IDX_MAJOR                                                                                                                        STUDENT                                                                                                                         
STUDENT_PK                                                                                                                       STUDENT                                                                                                                         

*/
/*
*******************************************************************************
Question 30
Author: Anika Reviewer: Lucy*/

SELECT s.FirstName, s.LastName, c.Description, e.Grade
FROM STUDENT s
JOIN ENROLLMENT e ON s.StudentID = e.Student_StudentID
JOIN COURSE c ON e.Course_CourseID = c.CourseID
WHERE e.Grade IS NOT NULL
ORDER BY s.LastName;
/*
*******************************************************************************

Results:

FIRSTNAME            LASTNAME                       DESCRIPTION                                                                                                                                                                                                                                                                                                                                                    GR
-------------------- ------------------------------ -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --
Rayna                Aurora                         Contemporary political problems in the United States affecting the interpretation of democracy, human rights and welfare, social pressures, and intergovernmental relations.                                                                                                                                                                                   B+
Bea                  Cabot                          Examination of best practices in software interface development for a variety of platforms.                                                                                                                                                                                                                                                                    C 
Bea                  Cabot                          This course will provide students with the knowledge and techniques of introductory web programming.                                                                                                                                                                                                                                                           A+
Doetri               Ghosh                          This is a special projects course that will be used for special circumstances with individual study or for experimental courses, pointed toward students who are first- or second-year students.                                                                                                                                                               A 
Doetri               Ghosh                          This course introduces energy efficiency, thermal comfort, indoor environmental quality and green building design concepts. The course covers engineering fundamentals required for the design and analysis of building systems.                                                                                                                               B-
Rachel               Sennot                         This course addresses advanced aviation topics to include high speed aerodynamics, automated cockpit instrumentation, domestic/international flight operations, and global navigation.                                                                                                                                                                         B+
Meghan               Spinazze                       Introduction to drawing the human figure with emphasis upon structure and gesture.                                                                                                                                                                                                                                                                             A-
Johanna              Walther                        This course explores the fundamental concepts of single pilot and multi-crew human factors issues. It focuses on the physiological factors , human error, threat and error management.                                                                                                                                                                         C+
Elyzabeth            Waters                         Introduction to drawing the human figure with emphasis upon structure and gesture.                                                                                                                                                                                                                                                                             B 

9 rows selected. 
       
*/




