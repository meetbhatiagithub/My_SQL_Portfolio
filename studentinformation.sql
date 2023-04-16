select * from personaldetails
select * from educationdetails
select * from contactdetails
select * from documentdetails
select * from examdetails

create proc studentinformation
as
select pd.StudentFirstName, pd.StudentLastName, pd.StudentAge, ed.Student10thMarks, ed.Student12thMarks, ed.StudentGraduate, cd.EmailID, cd.MobileNumber,cd.Address from personaldetails as pd
left join educationdetails as ed on pd.StudentId=ed.EducationId
left join contactdetails as cd on pd.StudentId=cd.ContactId
Go

exec studentinformation

create proc justexample
as
select pd.StudentFirstName, pd.StudentMiddleName, pd.StudentLastName, pd.StudentDOB, cd.EmailID, cd.MobileNumber, dd.AadharCardNumber, dd.DrivingLicenseNumber from personaldetails as pd 
left join contactdetails as cd on pd.StudentId=cd.ContactId
left join documentdetails as dd on pd.StudentId=dd.DocumentId
go

exec justexample

