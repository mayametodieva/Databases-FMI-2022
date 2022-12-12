USE master
GO
if exists (select * from sysdatabases where name='school_register')
	DROP DATABASE school_register
GO

CREATE DATABASE school_register
GO
USE school_register
GO

---/-/Create tables/-/---

CREATE TABLE STUDENT (
	ID INTEGER NOT NULL IDENTITY(1,1),
	NAME VARCHAR(255) NOT NULL,
	BIRTHDATE DATETIME,
	PIN DECIMAL(11,0)  NOT NULL,
	ADDRESS VARCHAR(255),
	EMAIL VARCHAR(255),
	PHONE_NUMBER DECIMAL(11,0),
	SCHOOL_YEAR# INTEGER,
	CLASS_NAME CHAR(1),
	CLASS# INTEGER,
	FORMTUTOR_ID INTEGER
);

CREATE TABLE STUDENT_PARENT(
	STUDENT_ID INTEGER NOT NULL,
	PARENT_EMAIL VARCHAR(255) NOT NULL
);

CREATE TABLE TEACHER (
	ID INTEGER NOT NULL IDENTITY(1,1),
	NAME VARCHAR(255) NOT NULL,
	ADDRESS VARCHAR(255),
	PHONE# INTEGER,
	EMAIL VARCHAR(255)
);

CREATE TABLE PARENT(
	NAME VARCHAR(255) NOT NULL, 
	PHONE_NUMBER DECIMAL(11,0),
	ADDRESS VARCHAR(255),
	EMAIL VARCHAR(255) NOT NULL
);

CREATE TABLE SUBJECT(
	NAME VARCHAR(255) NOT NULL,
	TEACHER_ID INTEGER NOT NULL
);

CREATE TABLE STUDENT_GRADES(
	STUDENT_ID INTEGER NOT NULL,
	TEACHER_ID INTEGER NOT NULL,
	SUBJECT_NAME VARCHAR(255) NOT NULL,
	DATE DATETIME NOT NULL,
	GRADE_VALUE NUMERIC(3,2) NOT NULL
);

CREATE TABLE ABSENCE (
	STUDENT_ID INTEGER NOT NULL,
	TEACHER_ID INTEGER NOT NULL,
	SUBJECT_NAME VARCHAR(255) NOT NULL,
	DATE DATETIME NOT NULL
);

CREATE TABLE PRAISE_AND_REMARKS(
	STUDENT_ID INTEGER NOT NULL,
	TEACHER_ID INTEGER NOT NULL,
	SUBJECT_NAME VARCHAR(255) NOT NULL,
	DATE DATETIME NOT NULL, 
	COMMENT VARCHAR(255) NOT NULL,
	TYPE CHAR(1)
);

CREATE TABLE HISTORY_TEACHER(
	EventId INTEGER NOT NULL IDENTITY(1,1),
    TeacherId integer not null,
    EventType varchar(7) not null,
    BeginDate datetime not null,
	SubjectName varchar(255),
    Name VARCHAR(100) not null
);

---/-/Add constraints/-/---

---/Define primary keys/---
ALTER TABLE STUDENT ADD CONSTRAINT PK_STUDENT PRIMARY KEY(ID);
ALTER TABLE TEACHER ADD CONSTRAINT PK_TEACHER PRIMARY KEY(ID);
ALTER TABLE HISTORY_TEACHER ADD CONSTRAINT PK_H_TEACHER PRIMARY KEY(EventId);
ALTER TABLE PARENT ADD CONSTRAINT PK_PARENT PRIMARY KEY(EMAIL);
ALTER TABLE STUDENT_PARENT ADD CONSTRAINT PK_STUDENT_PARENT PRIMARY KEY(STUDENT_ID, PARENT_EMAIL);
ALTER TABLE SUBJECT ADD CONSTRAINT PK_SUBJECT PRIMARY KEY(NAME, TEACHER_ID);
ALTER TABLE STUDENT_GRADES ADD CONSTRAINT PK_GRADE PRIMARY KEY( STUDENT_ID, SUBJECT_NAME, DATE);
ALTER TABLE ABSENCE ADD CONSTRAINT PK_ABSENCE PRIMARY KEY( STUDENT_ID, SUBJECT_NAME, DATE);
ALTER TABLE PRAISE_AND_REMARKS ADD CONSTRAINT PK_PRAISE_AND_REMARKS PRIMARY KEY( STUDENT_ID, SUBJECT_NAME, DATE);

---/Make relations/---
ALTER TABLE STUDENT_PARENT ADD CONSTRAINT FK_STUDENT_PARENT_STUDENT FOREIGN KEY(STUDENT_ID) REFERENCES STUDENT(ID);
ALTER TABLE STUDENT_PARENT ADD CONSTRAINT FK_STUDENT_PARENT_PARENT FOREIGN KEY(PARENT_EMAIL) REFERENCES PARENT(EMAIL);

ALTER TABLE STUDENT ADD CONSTRAINT FK_STUDENT_TEACHER FOREIGN KEY(FORMTUTOR_ID) REFERENCES TEACHER(ID);

ALTER TABLE SUBJECT ADD CONSTRAINT FK_SUBJECT_TEACHER FOREIGN KEY(TEACHER_ID) REFERENCES TEACHER(ID);

ALTER TABLE ABSENCE ADD CONSTRAINT FK_ABSENCE_SUBJECT FOREIGN KEY(SUBJECT_NAME, TEACHER_ID) REFERENCES SUBJECT(NAME, TEACHER_ID);
ALTER TABLE ABSENCE ADD CONSTRAINT FK_ABSENCE_STUDENT FOREIGN KEY(STUDENT_ID) REFERENCES STUDENT(ID);

ALTER TABLE PRAISE_AND_REMARKS ADD CONSTRAINT FK_PRAISE_AND_REMARKS_SUBJECT FOREIGN KEY(SUBJECT_NAME, TEACHER_ID) REFERENCES SUBJECT(NAME, TEACHER_ID);
ALTER TABLE PRAISE_AND_REMARKS ADD CONSTRAINT FK_PRAISE_AND_REMARKS_STUDENT FOREIGN KEY(STUDENT_ID) REFERENCES STUDENT(ID);

ALTER TABLE STUDENT_GRADES ADD CONSTRAINT FK_STUDENT_GRADES_SUBJECT FOREIGN KEY(SUBJECT_NAME, TEACHER_ID) REFERENCES SUBJECT(NAME, TEACHER_ID);
ALTER TABLE STUDENT_GRADES ADD CONSTRAINT FK_STUDENT_GRADES_STUDENT FOREIGN KEY(STUDENT_ID) REFERENCES STUDENT(ID);

---/-/Insert values/-/---

  ---/INTO TEACHER/---

INSERT INTO TEACHER (NAME,ADDRESS,PHONE#,EMAIL)
VALUES
  ('Griffith Summers','P.O. Box 552, 5089 Suspendisse Av.',0881823283,'nunc@aol.org'),
  ('Aileen Good','P.O. Box 227, 8412 Iaculis Rd.',0984884656,'pharetra@protonmail.org'),
  ('Hashim Hall','Ap #265-4559 Faucibus St.',0873550573,'egestas.lacinia@hotmail.ca'),
  ('Hall Ortiz','Ap #475-4594 Arcu. Ave',0783076118,'eleifend@outlook.ca'),
  ('Rana Hess','Ap #755-6463 Tincidunt Avenue',0989484578,'libero.morbi@protonmail.com'),
  ('Igor Mayo','P.O. Box 413, 4801 Elit Avenue',0881312315,'neque.sed.sem@yahoo.couk'),
  ('Aileen Lott','6500 Tempus Rd.',0874261432,'lobortis.risus.in@google.com'),
  ('Aaron Knight','247-2062 Pede Rd.',0881953728,'interdum.sed@icloud.org'),
  ('Daniel Harvey','1799 Quisque Rd.',0890159493,'consectetuer.adipiscing@outlook.org'),
  ('Len Chan','872-9640 A Road',0882975453,'id.libero@icloud.ca');
INSERT INTO TEACHER (NAME,ADDRESS,PHONE#,EMAIL)
VALUES 
  ('Kim Powers','Ap #104-3812 Aliquam Road',0886537821,'ridiculus.mus.proin@icloud.edu'),
  ('Virginia Noble','P.O. Box 110, 310 Scelerisque Rd.',0895168662,'proin.ultrices@aol.edu'),
  ('Ezra Whitley','Ap #313-9598 Pede. Road',0982342347,'amet.luctus@aol.edu'),
  ('Veda Farrell','Ap #540-3702 Sapien, St.',0886648305,'lectus.a@yahoo.couk'),
  ('Dana Moreno','Ap #172-1599 Donec Avenue',0871100606,'rutrum.lorem.ac@hotmail.org');

INSERT INTO STUDENT (NAME,BIRTHDATE, PIN, ADDRESS, EMAIL, PHONE_NUMBER, SCHOOL_YEAR#, CLASS_NAME, CLASS#, FORMTUTOR_ID)
VALUES
  ('Vivien Crane','2004-07-30',0447302515,'Ap #784-6500 Nulla. Rd.','amet.lorem@hotmail.org',0895632569,11,'b',7,9),
  ('Madonna Osborne','2006-01-13', 0641132617,'Ap #896-2184 Nullam Av.','in@aol.ca',0898456235,9,'c',8,3),
  ('Tatiana Gomez','2003-01-23',0341234628,'Ap #325-3327 Velit. Rd.','curabitur.vel@aol.net',0988256356,12,'a',6,12),
  ('Bruce James','2005-01-24', 0541248312,'545-3900 Leo Avenue','ut.nulla@outlook.edu',0878412563,10,'d',24,14),
  ('Garth Payne','2003-01-17', 0341171625,'Ap #913-9585 Magna Ave','mauris@google.com',0888756532,12,'a',9,12),
  ('Courtney Kline','2005-08-01', 0548013658,'482-7750 Mauris Road','ultrices@aol.org',0898456123,10,'d',11,14),
  ('Kiona Manning','2007-08-16', 0748153214,'758-2849 Bibendum St.','ornare.sagittis@google.com',0886259636,8,'g',23,5),
  ('Caldwell Mclean','2005-06-11', 0546117465,'P.O. Box 503, 2540 Porttitor Street','diam.sed.diam@icloud.org',0887142536,10,'d',28,14),
  ('Lacota Sweeney','2004-09-15', 0449159582,'Ap #448-2296 Luctus Rd.','iaculis@outlook.net',0888788288,11,'b',23,9),
  ('Mona Hall','2008-01-23', 0841237214,'195-917 Dui. St.','cras.convallis.convallis@hotmail.net',0878388256,7,'e',1,4);
INSERT INTO STUDENT (NAME,BIRTHDATE, PIN, ADDRESS, EMAIL, PHONE_NUMBER, SCHOOL_YEAR#, CLASS_NAME, CLASS#, FORMTUTOR_ID)
VALUES
  ('Libby Benson','2005-08-27', 0548270036,'711-7319 Nascetur Av.','justo@hotmail.couk',0882456936,10,'d',4,14),
  ('Hedwig Mann','2004-11-18', 0411185695,'Ap #555-2914 Magna. St.','erat@icloud.couk',0886262636,11,'b',10,9),
  ('Anastasia Pearson','2005-01-06', 0541063695,'Ap #763-1691 Tincidunt Rd.','lobortis.nisi.nibh@aol.edu',0882626396,10,'f',1,8),
  ('Germane Macdonald','2005-09-29', 0549298793,'Ap #966-7316 Egestas Avenue','pellentesque@google.ca',0885625126,10,'d',22,14),
  ('Gay Herman','2004-12-13', 0412135263,'Ap #217-2853 Eget Avenue','ornare.lectus@aol.ca',0883462634,11,'b',11,9),
  ('Zephania Davidson','2005-11-21', 0511214785,'Ap #727-9127 Odio Ave','cras.interdum.nunc@hotmail.ca',0882707577,10,'d',19,14),
  ('Hanae Maxwell','2004-09-23', 0449236598,'P.O. Box 291, 9079 Eros. St.','mollis@aol.net',08854023156,11,'b',15,9),
  ('Zelda Bolton','2004-09-09', 0449095214,'P.O. Box 330, 6911 Volutpat. Rd.','risus.varius@icloud.org',08896220901,11,'b',30,9),
  ('Gannon Collier','2004-12-05', 0412056589,'4032 Malesuada Av.','donec.egestas.aliquam@yahoo.edu',08741256398,11,'b',18,9),
  ('Cleo Merritt','2005-02-09', 0542095231,'Ap #374-4028 Malesuada Av.','molestie@outlook.org',0884290503,10,'f',10,8);
INSERT INTO STUDENT (NAME,BIRTHDATE, PIN, ADDRESS, EMAIL, PHONE_NUMBER, SCHOOL_YEAR#, CLASS_NAME, CLASS#, FORMTUTOR_ID)
VALUES
  ('Steven Chambers','2010-05-08', 1045087459,'4032 Malesuada Av.','tempor.lorem@google.couk',088888858,5,'a',9,1),
  ('Ivana Huffman','2011-02-01', 1142015691,'P.O. Box 330, 6911 Volutpat. Rd.','at@icloud.com',0877777737,4,'d',21,7),
  ('Tanya Fulton','2010-12-09', 1012096548,'P.O. Box 291, 9079 Eros. St.','ligula.aenean.gravida@yahoo.couk',0881236598,5,'a',24,1),
  ('Chiquita Ward','2011-04-17', 1144172567,'Ap #727-9127 Odio Ave','at.fringilla@outlook.org',0988878828,4,'d',24,7),
  ('Zoe Horne','2009-11-26', 0911265976,'Ap #966-7316 Egestas Avenue','felis@aol.net',0889789286,6,'b',12,6),
  ('Tamara Melendez','2012-01-11', 1241115261,'Ap #784-6500 Nulla. Rd.','nam.ac.nulla@google.couk',0883607525,3,'c',16,10),
  ('Naida Duffy','2012-05-06', 1245063974,'545-3900 Leo Avenue','nec.malesuada.ut@protonmail.com',0882804384,3,'c',4,10),
  ('Xander Guy','2012-01-06', 1241062597,'Ap #913-9585 Magna Ave','nunc.mauris.sapien@hotmail.org',0885905265,3,'c',12,10),
  ('Tatum Mills','2011-02-01', 1142015324,'Ap #325-3327 Velit. Rd.','ut.pharetra.sed@aol.org',0789369258,4,'d',6,7),
  ('Emerson Lyons','2010-05-10', 1045106215,'Ap #784-6500 Nulla. Rd.','cursus@icloud.net',0885275325,5,'a',11,1);

  ---/INTO PARENT/---
  
INSERT INTO PARENT (NAME,PHONE_NUMBER,ADDRESS,EMAIL)
VALUES
  ('Scarlett Neal',0888856236,'Ap #784-6500 Nulla. Rd.','rhoncus@outlook.net'),
  ('Deirdre Buchanan',0892431307,'Ap #896-2184 Nullam Av.','tellus@icloud.org'),
  ('Linus Everett',0983311903,'Ap #325-3327 Velit. Rd.','nam.ligula.elit@hotmail.org'),
  ('Kelly Mullen',0896342212,'545-3900 Leo Avenue','sed.leo@google.net'),
  ('Otto Rush',0888537633,'Ap #913-9585 Magna Ave','turpis.in@icloud.couk'),
  ('Lawrence Hunt',0879715123,'482-7750 Mauris Road','turpis@outlook.org'),
  ('Cameron Delacruz',0896891151,'758-2849 Bibendum St.','auctor.nunc@icloud.com'),
  ('Daphne Pittman',0785724625,'P.O. Box 503, 2540 Porttitor Street','ut@icloud.org'),
  ('Hyacinth Greene',0988213427,'Ap #448-2296 Luctus Rd.','lobortis.mauris@icloud.ca'),
  ('Elvis Kirkland',0873125384,'195-917 Dui. St.','tellus.aenean@google.net');
INSERT INTO PARENT (NAME,PHONE_NUMBER,ADDRESS,EMAIL)
VALUES 
  ('Kibo Forbes',0883412477,'711-7319 Nascetur Av.','ultrices@icloud.org'),
  ('Nicholas Skinner',0871574569,'Ap #555-2914 Magna. St.','lacus.quisque@google.org'),
  ('Althea Alexander',0874730883,'Ap #763-1691 Tincidunt Rd.','in.faucibus@icloud.net'),
  ('Bert Mccall',0887311667,'Ap #966-7316 Egestas Avenue','euismod.mauris@google.ca'),
  ('Fulton Shannon',0895582642,'Ap #217-2853 Eget Avenue','nunc@outlook.couk'),
  ('Mercedes Ratliff',0981550726,'Ap #727-9127 Odio Ave','nulla.tempor@protonmail.edu'),
  ('Athena Neal',08885446221,'P.O. Box 291, 9079 Eros. St.','et.ultrices@protonmail.ca'),
  ('Jordan Burnett',0984742536,'P.O. Box 330, 6911 Volutpat. Rd.','facilisis.eget@outlook.org'),
  ('Brenna Wagner',0886715777,'4032 Malesuada Av.','feugiat.non.lobortis@protonmail.com'),
  ('Rebecca Newton',0883567406,'Ap #374-4028 Malesuada Av.','nibh@protonmail.edu');

--/INTO STUDENT_PARENT

INSERT INTO STUDENT_PARENT(STUDENT_ID, PARENT_EMAIL)
SELECT STUDENT.ID, PARENT.EMAIL
FROM STUDENT INNER JOIN PARENT ON STUDENT.ADDRESS = PARENT.ADDRESS

---/INTO SUBJECT/---

INSERT INTO SUBJECT(NAME, TEACHER_ID)
VALUES
  ('Mathematics', 1),
  ('Physics', 2),
  ('Bulgarian language', 3),
  ('English language', 4),
  ('German language', 5),
  ('History', 6),
  ('Biology', 7),
  ('Geography', 8),
  ('Chemistry', 9),
  ('Music', 10),
  ('Sport', 11),
  ('IT', 12),
  ('IT', 1),
  ('Bulgarian language', 13),
  ('English language', 14),
  ('Bulgarian language', 15),
  ('Physics', 9),
  ('History', 7),
  ('English language', 5);

---/INTO STUDENT_GRADES/---

INSERT INTO STUDENT_GRADES (STUDENT_ID,TEACHER_ID,SUBJECT_NAME,DATE,GRADE_VALUE)
VALUES
  (29,4,'English language','2021-12-26', 6),
  (13,7,'History','2022-02-27',5),
  (1,10,'Music','2022-04-04',4.50),
  (5,8,'Geography','2022-06-12', 3),
  (23,5,'German language','2021-12-18',6),
  (10,7,'Biology','2021-12-20',5),
  (10,9,'Physics','2021-12-11',6),
  (16,14,'English language','2022-02-10',4),
  (12,1,'Mathematics','2022-06-18',5),
  (27,13,'Bulgarian language','2022-04-17',6);
INSERT INTO STUDENT_GRADES (STUDENT_ID,TEACHER_ID,SUBJECT_NAME,DATE,GRADE_VALUE)
VALUES
  (3,4,'English language','2021-11-10',6),
  (2,2,'Physics','2021-12-15',5),
  (14,3,'Bulgarian language','2021-10-14',5),
  (17,4,'English language','2021-12-12',4),
  (10,12,'IT','2022-05-16',6),
  (18,9,'Chemistry','2021-12-09',5),
  (16,2,'Physics','2022-03-01',5),
  (9,2,'Physics','2021-12-28',6),
  (6,8,'Geography','2021-12-23',6),
  (18,1,'Mathematics','2022-06-28',6);
INSERT INTO STUDENT_GRADES (STUDENT_ID,TEACHER_ID,SUBJECT_NAME,DATE,GRADE_VALUE)
VALUES
  (23,4,'English language','2021-10-12',6),
  (4,11,'Sport','2022-01-25',6),
  (28,4,'English language','2021-10-05',5),
  (12,9,'Physics','2022-05-11',2),
  (1,12,'IT','2022-05-11',6),
  (22,14,'English language','2022-03-25',5),
  (3,12,'IT','2021-11-04',4),
  (23,6,'History','2022-02-25',5),
  (2,14,'English language','2022-03-20',2),
  (23,10,'Music','2022-04-28',6);
INSERT INTO STUDENT_GRADES (STUDENT_ID,TEACHER_ID,SUBJECT_NAME,DATE,GRADE_VALUE)
VALUES
  (21,5,'German language','2022-03-19',5),
  (10,6,'History','2022-05-10',3),
  (8,2,'Physics','2022-05-07',5),
  (29,6,'History','2021-10-09',4),
  (14,11,'Sport','2022-02-02',6),
  (21,1,'Mathematics','2021-10-22',5),
  (8,15,'Bulgarian language','2021-10-20',6),
  (25,5,'German language','2021-10-14',6),
  (20,7,'Biology','2022-02-12',6),
  (13,9,'Chemistry','2022-04-14',3);

 ---/INTO ABSENCE/---

INSERT INTO ABSENCE(STUDENT_ID,TEACHER_ID,SUBJECT_NAME,DATE)
VALUES
  (6,3,'Bulgarian language','2022-05-20'),
  (8,8,'Geography','2022-06-24'),
  (18,2,'Physics','2022-01-12'),
  (30,5,'German language','2022-02-01'),
  (7,4,'English language','2022-05-15'),
  (16,5,'English language','2021-12-12'),
  (13,15,'Bulgarian language','2022-01-25'),
  (28,9,'Physics','2021-12-30'),
  (28,8,'Geography','2022-03-17'),
  (29,1,'Mathematics','2022-02-25');
INSERT INTO ABSENCE(STUDENT_ID,TEACHER_ID,SUBJECT_NAME,DATE)
VALUES
  (7,8,'Geography','2022-05-25'),
  (20,13,'Bulgarian language','2022-03-21'),
  (5,6,'History','2021-11-28'),
  (29,5,'German language','2022-04-03'),
  (2,2,'Physics','2022-02-02'),
  (23,9,'Chemistry','2022-01-30'),
  (11,2,'Physics','2022-01-28'),
  (16,14,'English language','2022-02-17'),
  (10,10,'Music','2022-03-23'),
  (10,3,'Bulgarian language','2021-12-18');

---/INTO PRAISE_AND_REMARKS/---

INSERT INTO PRAISE_AND_REMARKS(STUDENT_ID,TEACHER_ID,SUBJECT_NAME,DATE,COMMENT,TYPE)
VALUES
  (15,6,'History','2022-02-05','The student have excelent skills in analysing timelines!', 'p'),
  (27,10,'Music','2022-01-12', 'The student knows all of the learned songs perfectly!', 'p'),
  (19,9,'Chemistry','2022-06-12','The student behaves inappropriately!','r'),
  (7,7,'Biology','2021-10-22', 'The student sleeps in class!', 'r'),
  (27,5,'German language','2021-12-03', 'The student shows fluent skills in "listening" and "reading" exercises!','p'),
  (4,9,'Chemistry','2021-12-18', 'The student have lack of knowledge in specific part of the material!', 'r'),
  (3,9,'Chemistry','2022-03-02', 'The student assists experiments very well!', 'p'),
  (30,15,'Bulgarian language','2022-01-04', 'The student have really good articulation!', 'p'),
  (22,13,'Bulgarian language','2022-06-10', 'The student need to focus on improving its semantics skills!', 'r'),
  (13,13,'Bulgarian language','2022-04-24', 'The student eats in class!', 'r');	