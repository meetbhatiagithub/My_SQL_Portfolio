select * from personaldetails
select StudentGender,* from personaldetails
SELECT distinct(StudentFirstName) FROM personaldetails
select count(distinct Semester) from examdetails
select count(Student10thMarks) from educationdetails where Student10thMarks='52'
SELECT * FROM examdetails WHERE EnrollmentNumber='197002' AND SubjectName='InformationSecurity';
SELECT * FROM contactdetails WHERE Address='Amreli' OR ContactNumber='9567890123';
SELECT * FROM personaldetails WHERE NOT StudentFirstName='Nidhi';
SELECT * FROM contactdetails WHERE ContactId='5' AND (MobileNumber='9737809766' OR Address='Halol');
SELECT * FROM personaldetails WHERE NOT StudentAge='45' AND NOT StudentGender='Female'
SELECT * FROM contactdetails ORDER BY ContactNumber;
SELECT * FROM personaldetails ORDER BY StudentLastName DESC;
SELECT * FROM educationdetails ORDER BY StudentGraduate, StudentPostGraduate;
SELECT EducationId, StudentGraduate, StudentPostGraduate FROM educationdetails WHERE EducationId IS NULL;
update educationdetails set StudentId='19' where EducationId='19'
delete from personaldetails where StudentId='101'
select TOP 3 * from contactdetails
select min(StudentAge)  from personaldetails
select count(StudentFirstName) from personaldetails where StudentFirstName='meet'
select sum(Student10thMarks) from educationdetails
SELECT * FROM personaldetails WHERE StudentFirstName LIKE 'a%';
select * from personaldetails where StudentFirstName like '[a-c]%'
select * from personaldetails where StudentAge in (22,25,29)
select StudentAge as Meet from personaldetails where StudentAge between 22 and 25