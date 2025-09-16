/*
Anika Rastogi, Rayna Arora, Lucy Waters, Meghan Spinazze
CNIT 27200 Spring 2025
Lab Time: Friday 1:30pm
Duration: 2 hours
*/

//Dropping all tables
DROP TABLE classroom CASCADE CONSTRAINTS;
DROP TABLE course CASCADE CONSTRAINTS;
DROP TABLE enrollment CASCADE CONSTRAINTS;
DROP TABLE professor CASCADE CONSTRAINTS;
DROP TABLE student CASCADE CONSTRAINTS;

//Creating the classroom table
CREATE TABLE classroom (
    building      CHAR(5 CHAR) NOT NULL,
    capacity      INTEGER,
    accessibility VARCHAR2(75 CHAR),
    facilities    VARCHAR2(250 CHAR),
    roomnumber    CHAR(3 CHAR) NOT NULL
);

//Adding primary key to classroom
ALTER TABLE classroom ADD CONSTRAINT classroom_pk PRIMARY KEY ( roomnumber,
                                                                building );
//Creating the course table
CREATE TABLE course (
    courseid             CHAR(5 CHAR) NOT NULL,
    description          VARCHAR2(350 CHAR),
    prerequisites        VARCHAR2(30 CHAR),
    creditsoffered       INTEGER NOT NULL,
    classsize            INTEGER,
    professor_lecturerid CHAR(10 CHAR),
    classroom_building   CHAR(5 CHAR),
    classroom_roomnumber CHAR(3 CHAR)
);

//Adding the primary key to table
ALTER TABLE course ADD CONSTRAINT course_pk PRIMARY KEY ( courseid );

//Creating the enrollment table
CREATE TABLE enrollment (
    student_studentid CHAR(10 CHAR) NOT NULL,
    course_courseid   CHAR(5 CHAR) NOT NULL,
    enrollmentdate    DATE NOT NULL,
    grade             CHAR(2 CHAR),
    meetingtime       DATE,
    offeredterm       VARCHAR2(20 CHAR),
    creditsearned     INTEGER
);

//Adding the primary key to enrollment
ALTER TABLE enrollment
    ADD CONSTRAINT enrollment_pk PRIMARY KEY ( student_studentid,
                                               course_courseid,
                                               enrollmentdate );

//Creating the professor table
CREATE TABLE professor (
    lecturerid     CHAR(10 CHAR) NOT NULL,
    firstname      VARCHAR2(20 CHAR),
    lastname       VARCHAR2(30 CHAR),
    department    VARCHAR2(20 CHAR),
    email          VARCHAR2(50 CHAR) NOT NULL,
    salary         NUMBER(10, 2),
    qualifications VARCHAR2(350 CHAR)
);

//Adding the professor primary key
ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY ( lecturerid );


//Creating the student table
CREATE TABLE student (
    studentid        CHAR(10 CHAR) NOT NULL,
    firstname        VARCHAR2(20 CHAR),
    lastname         VARCHAR2(30 CHAR),
    email            VARCHAR2(50 CHAR),
    address          VARCHAR2(200 CHAR),
    emergencycontact CHAR(10 CHAR) NOT NULL
);

//Adding the primary key to student
ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( studentid );

//Adding the foriegn key to course
ALTER TABLE course
    ADD CONSTRAINT course_classroom_fk
        FOREIGN KEY ( classroom_roomnumber,
                      classroom_building )
            REFERENCES classroom ( roomnumber,
                                   building );
ALTER TABLE course
    ADD CONSTRAINT course_professor_fk FOREIGN KEY ( professor_lecturerid )
        REFERENCES professor ( lecturerid );

//Adding the foriegn key to enrollment
ALTER TABLE enrollment
    ADD CONSTRAINT enrollment_course_fk FOREIGN KEY ( course_courseid )
        REFERENCES course ( courseid );

ALTER TABLE enrollment
    ADD CONSTRAINT enrollment_student_fk FOREIGN KEY ( student_studentid )
        REFERENCES student ( studentid );

//Populating the professor table
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000000, 'John', 'Smith', 'Software Engineering', 'josmit@college.edu', 50000.00, 'Masters Degree, Lab certification');
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000001, 'Jane', 'Doe', 'Political Science', 'jaedo@college.edu', 75000.00, 'Masters Degree, Polytechnic certification, PHD');
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000002, 'Jake', 'Brown', 'Art and Design', 'jabrow@college.edu', 45000.00, 'Masters Degree, MFA');
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000003, 'Emily', 'Nguyen', 'Aviation', 'emnguy@college.edu', 62000.00, 'Masters Degree, Aviation Safety Certificate');
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000004, 'Carlos', 'Martinez', 'Aviation', 'cmarti@college.edu', 71000.00, 'PHD, Flight Instructor Certification');
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000005, 'Linda', 'Kim', 'IT', 'likim@college.edu', 68000.00, 'Masters Degree, Web Development Certificate');
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000006, 'Michael', 'Zhao', 'Software Engineering', 'mizhao@college.edu', 72000.00, 'PHD, Software UX Expert');
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000007, 'Fatima', 'Alvi', 'Civil Engineering', 'falvi@college.edu', 69000.00, 'Masters Degree');
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000008, 'Robert', 'King', 'Political Science', 'roking@college.edu', 54000.00, 'Masters Degree, International Law Certificate');
INSERT INTO Professor (LecturerID, FirstName, LastName, Department, Email, Salary, Qualifications)
VALUES (1000000009, 'Sophia', 'Clark', 'Civil Engineering', 'soclark@college.edu', 63000.00, 'Masters Degree, LEED Certification');

//Populating the student table
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000010', 'Anika', 'Rastogi', 'arastogi@college.edu', '123 College Street', '1234567890');
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000011', 'Rayna', 'Aurora', 'raurora@college.edu', '123 Pete Drive', '1735296947');
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000012', 'Elyzabeth', 'Waters', 'ewaters@college.edu', '456 Boiler Maker Street', '5629471549');
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000013', 'Meghan', 'Spinazze', 'mspinazze@college.edu', '204 Ross Ade Drive', '1018395732');
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000014', 'Johanna', 'Walther', 'jwalther@college.edu', '333 Purdue Street', '1526474908');
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000015', 'Doetri', 'Ghosh', 'dghosh@college.edu', '555 Krach Street', '2225627599');
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000016', 'Bea', 'Cabot', 'bcabot@college.edu', '555 Krach Street', '1019462314');
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000017', 'Florence', 'Pugh', 'fpugh@college.edu', '714 Train Avenue', '1844173860');
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000018', 'Rachel', 'Sennot', 'rsennot@college.edu', '829 Meredith South Drive', '9302745566');
INSERT INTO STUDENT(StudentID, FirstName, LastName, Email, Address, EmergencyContact)
VALUES('1000000019', 'Eva', 'Refeld’', 'erefeld@college.edu’', '777 Street Street', '9992746281');

//Populating the classroom table
insert into classroom values ('KNOYH',35,'Ramp, Elevator, Subtitles, Wheelchair Accessible Seats','Computer Lab, TV Screens','274');
insert into classroom values ('BEERI',300,'Elevator','Projector','194');
insert into classroom values ('ARMST',80,'Ramp','Science Lab, Fume Hoods, Eye Wash Station','674');
insert into classroom values ('ARMST',150,'Subtitles','Projector, Chalkboard','101');
insert into classroom values ('PHYSI',35,'Ramp, Subtitles, Wheelchair Accessible Seats','Computer Lab, TV Screens','274');
insert into classroom values ('KNOYH',70,'Ramp, Elevator','Projector','033');
insert into classroom values ('STONE',45,'Elevator','Projector','217');
insert into classroom values ('SMITH',140,NULL,'Projector, Chalkboard','108');
insert into classroom values ('BEERI',30,'Elevator, Wheelchair Accessible Seats','Computer Lab, TV Screens','261');
insert into classroom values ('KNOYH',80,'Ramp, Elevator, Wheelchair Accessible Seats','Projector, Whiteboards','061');

//Populating the course table
insert into course values('SC101','This is a special projects course that will be used for special circumstances with individual study or for experimental courses, pointed toward students who are first- or second-year students.',NULL,3,32,'1000000000',NULL,NULL);
insert into course values('PY234','Contemporary political problems in the United States affecting the interpretation of democracy, human rights and welfare, social pressures, and intergovernmental relations.','PY102',1,250,'1000000001','BEERI','194');
insert into course values('AD113','An introduction to drawing and sketching as a means of communication of ideas.',NULL,3,25,'1000000002','KNOYH','274');
insert into course values('AD213','Introduction to drawing the human figure with emphasis upon structure and gesture.','AD113',3,30,'1000000002','STONE','217');
insert into course values('AT223','This course explores the fundamental concepts of single pilot and multi-crew human factors issues. It focuses on the physiological factors , human error, threat and error management.','AT144',2,130,'1000000004','SMITH','108');
insert into course values('CE311','This course introduces energy efficiency, thermal comfort, indoor environmental quality and green building design concepts. The course covers engineering fundamentals required for the design and analysis of building systems.','CE191',3,30,'1000000003',NULL,NULL);
insert into course values('IT215','This course will provide students with the knowledge and techniques of introductory web programming.','IT180',3,150,'1000000005','ARMST','101');
insert into course values('IT373','Examination of best practices in software interface development for a variety of platforms.','IT220',3,28,NULL,'BEERI','261');
insert into course values('AT327','This course addresses advanced aviation topics to include high speed aerodynamics, automated cockpit instrumentation, domestic/international flight operations, and global navigation.','AT252',3,70,'1000000007','ARMST','674');
insert into course values('PY343','A study of international legal theories, principles, and practices, with an emphasis on the role and utility of law in contemporary international relations.','PY234',3,75,'1000000008','KNOYH','061');

//Populating the enrollment table
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000015', 'SC101', TO_DATE('01-January-2025', 'DD-Month-YYYY'), 'A', TO_DATE('08:00', 'HH24:MI'), 'Spring2025', 3);
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000011', 'PY234', TO_DATE('01-APR-24', 'DD-MON-YY'), 'B+', TO_DATE('09:30', 'HH24:MI'), 'Fall2024', 1);
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000012', 'AD213', TO_DATE('01-JAN-25', 'DD-MON-YY'), 'B', TO_DATE('10:30', 'HH24:MI'), 'Spring2025', 3);
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000013', 'AD213', TO_DATE('01-JAN-24', 'DD-MON-YY'), 'A-', TO_DATE('10:30', 'HH24:MI'), 'Spring2025', 3);
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000014', 'AT223', TO_DATE('01-MAY-24', 'DD-MON-YY'), 'C+', TO_DATE('12:30', 'HH24:MI'), 'Fall2024', 2);
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000015', 'CE311', TO_DATE('01-JAN-25', 'DD-MON-YY'), 'B-', TO_DATE('13:30', 'HH24:MI'), 'Spring2025', 3);
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000016', 'IT215', TO_DATE('01-APR-24', 'DD-MON-YY'), 'A+', TO_DATE('14:00', 'HH24:MI'), 'Fall2024', 3);
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000016', 'IT373', TO_DATE('01-MAY-24', 'DD-MON-YY'), 'C', TO_DATE('15:00', 'HH24:MI'), 'Fall2024', 3);
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000018', 'AT327', TO_DATE('01-FEB-25', 'DD-MON-YY'), 'B+', TO_DATE('15:00', 'HH24:MI'), 'Spring2025', 3);
INSERT INTO Enrollment (Student_StudentID, Course_CourseID, EnrollmentDate, Grade, MeetingTime, OfferedTerm, CreditsEarned)
VALUES ('1000000019', 'PY343', TO_DATE('01-JAN-25', 'DD-MON-YY'), 'A', TO_DATE('17:30', 'HH24:MI'), 'Spring2025', 3);

//Describing all tables
DESCRIBE STUDENT;
DESCRIBE PROFESSOR;
DESCRIBE CLASSROOM;
DESCRIBE COURSE;
DESCRIBE ENROLLMENT;

//Showing all data from all tables
SELECT * FROM STUDENT;
SELECT * FROM PROFESSOR;
SELECT * FROM CLASSROOM;
SELECT * FROM COURSE;
SELECT Student_StudentID, Course_CourseID, EnrollmentDate, Grade, TO_CHAR(MeetingTime,'HH24:MI'), OfferedTerm, CreditsEarned FROM ENROLLMENT;

//Making sure all changes persisted
COMMIT;

