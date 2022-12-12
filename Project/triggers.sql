USE master
GO
USE school_register
GO

GO
if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'teacher_history_insert')
	drop trigger teacher_history_insert;
GO


CREATE TRIGGER teacher_history_insert
ON TEACHER
AFTER INSERT
AS
BEGIN
	INSERT INTO HISTORY_TEACHER(TeacherId, EventType, BeginDate, Name)
	SELECT
		i.ID,
		'insert',
		GETDATE(),
		i.Name
	FROM inserted i;
END;

GO
if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'subject_history_insert')
	drop trigger subject_history_insert;
GO


CREATE TRIGGER subject_history_insert
ON SUBJECT
AFTER INSERT
AS
BEGIN
	UPDATE HISTORY_TEACHER set SubjectName = (select name from inserted) 
	where teacherid = (select i.teacher_id from inserted as i);
END;

GO
if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'teacher_history_update')
	drop trigger teacher_history_update;
GO

CREATE TRIGGER teacher_history_update
ON TEACHER
AFTER UPDATE
AS
BEGIN
	INSERT INTO HISTORY_TEACHER(TeacherId, EventType, BeginDate, Name)
	SELECT
		i.ID,
		'update',
		GETDATE(),
		i.Name
	FROM inserted i;
END;

GO
if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'parent_address_update')
	drop trigger parent_address_update;
GO

CREATE TRIGGER parent_address_update
ON PARENT
AFTER UPDATE
AS
BEGIN
	DECLARE @OldAddress AS varchar(255)
	SET @OldAddress = (select address from deleted);
	DECLARE @NewAddress AS varchar(255)
	SET @NewAddress = (select address from inserted);
	PRINT @OldAddress
	print @NewAddress
	if(@OldAddress = @NewAddress)
		return;
	UPDATE STUDENT set address = (select i.address from inserted as i) 
	where id in (select sp.student_id from STUDENT_PARENT sp 
		where sp.PARENT_EMAIL = (select email from inserted));
END;
--Test trigger1
INSERT INTO Teacher(NAME,ADDRESS,PHONE#,EMAIL) VALUES('Ivan Ivanov','Lyulin',0871323531,'iii@aol.org');
select * from HISTORY_TEACHER;
select * from TEACHER;

--Test trigger3
UPDATE Teacher Set Name = 'Stoqnov' where id = 3;
select * from HISTORY_TEACHER;
select * from TEACHER;

--Test trigger2
INSERT INTO SUBJECT(NAME, TEACHER_ID)
VALUES ('Boba', 18);
select * from HISTORY_TEACHER;
select * from TEACHER;
select * from SUBJECT;

--Test trigger4
update parent set address = 'alabala1' where email = 'rhoncus@outlook.net';
select * from student s
inner join STUDENT_PARENT sp on sp.STUDENT_ID = s.id
inner join parent p on p.EMAIL = sp.PARENT_EMAIL
where p.address = 'alabala1';

select * from STUDENT_PARENT
where PARENT_EMAIL = 'rhoncus@outlook.net';