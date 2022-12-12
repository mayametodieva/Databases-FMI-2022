
--/-/VIEWS/-/--

--Изглед представящ имената на учениците, заедно с имената на родителите им и адресът, на който живеят
GO  
CREATE VIEW student_parent_view  
AS  
SELECT s.name as student_name, p.name as parent_name, p.address  
FROM student s inner JOIN STUDENT_PARENT sp  
ON s.id = sp.STUDENT_ID
inner join parent p on p.email = sp.PARENT_EMAIL;   
GO  

--Test View 1
SELECT student_name, parent_name, address  
from student_parent_view
ORDER BY student_name, parent_name;

--Изглед представящ имената на учениците и съответен предмет, който изучават
GO  
CREATE VIEW student_subject_view  
AS  
SELECT DISTINCT STUDENT.NAME AS 'STUDENT_NAME', SUBJECT.NAME AS 'SUBJECT'
FROM STUDENT JOIN TEACHER ON STUDENT.FORMTUTOR_ID = TEACHER.ID 
JOIN SUBJECT ON TEACHER.ID = SUBJECT.TEACHER_ID
UNION
SELECT DISTINCT STUDENT.NAME AS 'STUDENT_NAME', STUDENT_GRADES.SUBJECT_NAME AS 'SUBJECT'
FROM STUDENT JOIN STUDENT_GRADES ON STUDENT.ID = STUDENT_GRADES.STUDENT_ID
UNION 
SELECT DISTINCT STUDENT.NAME AS 'STUDENT_NAME', ABSENCE.SUBJECT_NAME AS 'SUBJECT'
FROM STUDENT JOIN ABSENCE ON STUDENT.ID = ABSENCE.STUDENT_ID
UNION
SELECT DISTINCT STUDENT.NAME AS 'STUDENT_NAME', PRAISE_AND_REMARKS.SUBJECT_NAME AS 'SUBJECT'
FROM STUDENT JOIN PRAISE_AND_REMARKS ON STUDENT.ID = PRAISE_AND_REMARKS.STUDENT_ID
GO  

--Test View 2
SELECT student_subject_view.STUDENT_NAME, student_subject_view.SUBJECT 
FROM student_subject_view
ORDER BY student_subject_view.STUDENT_NAME


--Изглед представящ имената на ученците и съответният им класен ръководител
GO
CREATE VIEW student_formtutor_view  
AS  
SELECT STUDENT.NAME as student_name, TEACHER.NAME as teacher_name
FROM STUDENT JOIN TEACHER ON STUDENT.FORMTUTOR_ID = TEACHER.ID
GO

--Test View 3
SELECT student_formtutor_view.student_name, student_formtutor_view.teacher_name
FROM student_formtutor_view
ORDER BY student_formtutor_view.student_name


--/-/INDEXES/-/--

create unique index student_index on student(pin);
create unique index parent_email_index on parent(email);
create unique index parent_phone_index on parent(PHONE_NUMBER);
create unique index absence_index on ABSENCE(STUDENT_ID, TEACHER_ID);
create unique index praise_and_remarks_index on PRAISE_AND_REMARKS(STUDENT_ID, TEACHER_ID);
create unique index student_grades_index on STUDENT_GRADES(STUDENT_ID, SUBJECT_NAME);








