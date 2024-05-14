--system databases cannot be deleted.
--when we CREATE a DATABASE two files of that DATABASE is also created which are MDF which is master datafile which is used to store the actual data of that DATABASE and LDF which is log data file which is used to recover the DATABASE FOR  viewing those files SELECT the DATABASE and right click ON it go to properties then files tab here you will see a path copy that path and paste it ON windows run dialog box and press enter.
--A foreign KEY in one TABLE points to a PRIMARY  KEY in another table. the foreign KEY CONSTRAINT prevents invalid data FROM being inserted into the foreign KEY columns. the VALUES that we enter into foreign KEY column has to be one of the VALUES contained in the    TABLE it points to.
-- Adding a foreign KEY CONSTRAINT using below query.

--ALTER TABLE foreignkeytable ADD CONSTRAINT foreigntable_foreignkeycolumn_fk foreign KEY (foreignkeycolumn) references primarykeytable (primarykeycolumn)
--ALTER TABLE child_table ADD CONSTRAINT fk_name FOREIGN KEY (child_col1, child_col2,child_col_n) REFERENCES parent_table (parent_col1,parent_col_n);
--child_table: The name of the child TABLE that you wish to modify.

/*fk_name: The name of the foreign KEY CONSTRAINT that you wish to create

child_col1, child_col2, ... child_col_n: The columns in child_table that will reference a PRIMARY  KEY in the parent_table.

parent_table: The name of the parent    TABLE whose PRIMARY  KEY will be used in the child_table.

parent_col1, parent_col2, ... parent_col3: The columns that make up the PRIMARY  KEY in the parent_table. 
The foreign KEY will enforce a link between this data and the child_col1, child_col2, ... child_col_n columns in the child_table.*/

SELECT * FROM person 

--Renaming an existing column
-- EXEC sp_rename 'tablename.oldcolumnname', 'newcolumnname', 'Column';

 EXEC sp_rename 'person.Qualification', 'Education', 'Column'
 EXEC sp_rename 'person.Education', 'Qualification', 'Column'
 
SELECT * FROM Medicine;
SELECT * FROM Hospital;
SELECT * FROM Doctor;
SELECT * FROM Patient;

CREATE   TABLE Hospital(Id INT  PRIMARY  KEY IDENTITY(1,1), 
HospitalName VARCHAR(70), 
HospitalType VARCHAR(100), 
NoofHospitalTypes INT ,	
DoctorId INT FOREIGN KEY REFERENCES Doctor(Id));

/*in the hospital    TABLE we have created a new column named as DoctorId and made it 
as Foreign KEY and we have given it a reference of Id in Doctor    TABLE here Hospital 
   TABLE is my child    TABLE and doctor    TABLE is my parent    TABLE as hospital    TABLE is taking the data FROM doctor table.*/
--IDENTITY(1,1) will auto increment the particular column FOR  which it is SET FOR .

DELETE FROM Doctor WHERE Id = 1; 
--we cannot DELETE the column record FOR  which the foreign KEY is SET, so FOR  removing this column first we have to remove the dependancy by dropping the foreign KEY references FROM the child    TABLE i.e Hospital table.

CREATE TABLE Doctor(Id INT  PRIMARY  KEY IDENTITY(1,1), DoctorName VARCHAR(40), DoctorDesignation VARCHAR(100));
CREATE TABLE Patient(Id INT  PRIMARY  KEY IDENTITY(1,1), PatientName VARCHAR(40), PatientDisease VARCHAR(100));
CREATE TABLE Medicine(Id INT  PRIMARY  KEY IDENTITY(1,1), MedicineName VARCHAR(100), NoofMedicines INT );

INSERT INTO  Doctor(DoctorName, DoctorDesignation) VALUES('Ajay', 'allergist');
INSERT INTO  Doctor(DoctorName, DoctorDesignation) VALUES('Vijay', 'cardiologist');
INSERT INTO  Doctor(DoctorName, DoctorDesignation) VALUES('Alex', 'dentist');
INSERT INTO  Doctor(DoctorName, DoctorDesignation) VALUES('Ajay', 'dermatologist');

INSERT INTO  Hospital(HospitalName, HospitalType, NoofHospitalTypes, DoctorId) VALUES('Agarwal Hospital', 'Private', 56, 1);
INSERT INTO  Hospital(HospitalName, HospitalType, NoofHospitalTypes, DoctorId) VALUES('Apex Hospital', 'Government', 78, 2);
INSERT INTO  Hospital(HospitalName, HospitalType, NoofHospitalTypes, DoctorId) VALUES('Saket Hospital', 'Private', 72, 3);
INSERT INTO  Hospital(HospitalName, HospitalType, NoofHospitalTypes, DoctorId) VALUES('Dhara Hospital', 'Government', 89, 4);
INSERT INTO  Hospital(HospitalName, HospitalType, NoofHospitalTypes, DoctorId) VALUES('Dh', 'Private', 56, 1);
INSERT INTO  Hospital(HospitalName, HospitalType, NoofHospitalTypes, DoctorId) VALUES('NEXEX', 'Private', 56, 1);

INSERT INTO  Patient(PatientName, PatientDisease) VALUES('Amar', 'Dengue');
INSERT INTO  Patient(PatientName, PatientDisease) VALUES('Veer', 'Malaria');
INSERT INTO  Patient(PatientName, PatientDisease) VALUES('Bhanu', 'Flu');
INSERT INTO  Patient(PatientName, PatientDisease) VALUES('Sakshi', 'Fever');
INSERT INTO  Patient(PatientName, PatientDisease) VALUES('Meenakshi', 'Fever');
INSERT INTO  Patient(PatientName, PatientDisease) VALUES('Vidhushi', 'Flu');

ALTER TABLE Doctor ADD TotalDoctor INT 
DELETE FROM Patient WHERE Id = 11
update Patient SET PatientName = 'Naman' WHERE Id = 5
update Patient SET TotalPatient = Null+10 WHERE Id = 4

INSERT INTO  Medicine(MedicineName, NoofMedicines)  VALUES('Metformin', 6);
INSERT INTO  Medicine(MedicineName, NoofMedicines)  VALUES('Losartan', 8);
INSERT INTO  Medicine(MedicineName, NoofMedicines)  VALUES('Antibiotics', 45);
INSERT INTO  Medicine(MedicineName, NoofMedicines)  VALUES('Antihistamines',34);
INSERT INTO  Medicine(MedicineName, NoofMedicines)  VALUES('Antis',39);

--update query
update Medicine SET NoofMedicines=90 WHERE Id = 1;

--Below query will ADD a DEFAULT CONSTRAINT named as DF_Medicine_NoofMedicines in NoofMedicines column WHERE it will take the DEFAULT the value as 10 until not specified. when we specify the value FOR  that column it will not insert the DEFAULT value.
ALTER     TABLE Medicine ADD CONSTRAINT DF_Medicine_NoofMedicines DEFAULT 10 FOR  NoofMedicines; 
INSERT INTO  Medicine(MedicineName)  VALUES('Antihistamines');
ALTER TABLE Medicine DROP  CONSTRAINT DF_Medicine_NoofMedicines; -- this will DROP  the DEFAULT CONSTRAINT.
ALTER TABLE Medicine ADD DEFAULT 10 FOR  NoofMedicines;
ALTER TABLE Medicine ADD DEFAULT 'Po' FOR  MedicineName;
INSERT INTO  Medicine(NoofMedicines)  VALUES(34);
ALTER TABLE Medicine DROP  [DF__Medicine__Medici__5EBF139D];

--Adding a new column with DEFAULT value to an existing    TABLE using below query.
ALTER     TABLE [Table_Name] ADD [Column_Name][data_type] CONSTRAINT [constraint_name] DEFAULT [Default_value]

--not null CONSTRAINT
ALTER     TABLE Medicine ALTER  column NoofMedicines INT  not null;
INSERT INTO  Medicine(MedicineName, NoofMedicines) VALUES('Dolo', Null);
ALTER     TABLE Medicine ALTER  column NoofMedicines INT  null;
DELETE FROM Medicine WHERE Id = 4;
DELETE FROM Medicine WHERE Id = 7;

--unique CONSTRAINT so we cannot ADD duplicate VALUES to that column
ALTER TABLE Medicine ADD unique (MedicineName);
ALTER TABLE Medicine DROP UQ__Medicine__D61E2C0E368077BF;

--check CONSTRAINT, this checks the value of the particular column under specified condition.
ALTER TABLE Hospital ADD check(NoofHospitalTypes>=10);
ALTER TABLE Hospital DROP  [CK__Hospital__NoofHo__5BE2A6F2]

--below query will turn off the IDENTITY parameter and we can give the value in that column according to our requirement.
SET identity_insert Medicine ON 
INSERT INTO  Medicine(Id, MedicineName, NoofMedicines)  VALUES(67,'Omeprazole', 12);
INSERT INTO  Medicine(Id,MedicineName, NoofMedicines)  VALUES(68,'Omeprazole', 12);

--using below query we will not be able to give the value of that column ourselves and again IDENTITY parameter will be SET.
SET identity_insert Medicine off 
INSERT INTO  Medicine(MedicineName, NoofMedicines)  VALUES('Antihis',55);
DELETE FROM Medicine WHERE Id= 67;
DELETE FROM Medicine WHERE Id= 68;
DELETE FROM Medicine WHERE Id= 69;



ALTER TABLE Medicine DROP  [PK__Medicine__3214EC076C1D509F]; --This query will DROP  the PRIMARY  key.

ALTER TABLE Medicine ADD PRIMARY  key(Id);

TRUNCATE TABLE Medicine; /*this query will reset the TABLE and DELETE all the TABLE data. the major difference between truncate and DELETE is 
that DELETE will not reset the    TABLE in its original form but only deletes the    TABLE data.*/

ALTER DATABASE HospitalDatabase modify Name = Hospital; -- this will rename the DATABASE with ALTER  query.

 EXEC sp_renameDB 'Hospital', 'HospitalDatabase'; -- this will also rename the DATABASE but using the stored procedures.

CREATE DATABASE sample1; --this will CREATEa new DATABASE in the DATABASE snapshots.

ALTER  DATABASE sample1 SET SINGLE_USER with Rollback Immediate; 

/*if other users are connected you need to put the DATABASE in single user mode and then DROP  the DATABASE we can do this by using rollback 
immediate option, will rollback all incomplete transactions and closes the connection to the DATABASE.*/

--Joins
SELECT d.DoctorName, h.HospitalName FROM Doctor d LEFT JOIN Hospital h ON d.Id=h.Id;
SELECT d.DoctorName, h.HospitalName FROM Doctor d Right JOIN Hospital h ON d.Id=h.Id;
SELECT d.DoctorName, h.HospitalName FROM Doctor d INNER JOIN Hospital h ON d.Id=h.Id;
SELECT * FROM Doctor d left join Hospital h ON d.Id=h.Id;
SELECT * FROM Doctor d right join Hospital h ON d.Id=h.Id;
SELECT * FROM Doctor d full join Hospital h ON d.Id=h.Id;
SELECT p.PatientName, d.DoctorName FROM Patient p inner join Doctor d ON P.Id=d.Id;
SELECT p.PatientName, d.DoctorName FROM Patient p inner join Doctor d ON P.PatientName=d.DoctorName;
SELECT p.PatientName, d.DoctorName FROM Patient p inner join Doctor d ON not P.PatientName='Amar';
SELECT * FROM Patient p inner join Doctor d ON not P.PatientName='amar';
SELECT * FROM Patient p inner join Doctor d ON P.PatientName<>d.DoctorName;

--AND, OR, NOT
SELECT * FROM Hospital WHERE not HospitalName='Dhara' and not Id=3;
SELECT * FROM Hospital WHERE  HospitalName='Dhara Hospital' and ( Id=4 or Id=1);
SELECT * FROM Hospital WHERE not HospitalName='Dhara Hospital' and not( Id=4 or Id=1);
SELECT * FROM Hospital WHERE not (HospitalName='Dhara Hospital' or Id=4 or Id=1);
SELECT * FROM Hospital WHERE not HospitalName='Dhara Hospital' and HospitalName='Saket Hospital';
SELECT * FROM Hospital WHERE not HospitalName = 'Dhara Hospital' and not HospitalName='Saket Hospital';



--LIKE Query
SELECT HospitalName FROM Hospital WHERE HospitalName LIKE'D%'; --Starting with D
SELECT HospitalName FROM Hospital WHERE HospitalName LIKE'%L'; --ending with L
SELECT HospitalName FROM Hospital WHERE HospitalName LIKE'%D%'; --Character or word in any position
SELECT HospitalName FROM Hospital WHERE HospitalName LIKE'_A%'; --Charater in second Position
SELECT HospitalName FROM Hospital WHERE HospitalName LIKE'D_%'; --Starts with D and has atleast number of characters specified by number of underscores(_)
SELECT HospitalName FROM Hospital WHERE HospitalName LIKE'D%L'; --Starts with D and end with L
SELECT HospitalName FROM Hospital WHERE HospitalName LIKE'D_'; --Starts with D and has only 1 character after it
SELECT HospitalName FROM Hospital WHERE HospitalName LIKE'_%X'; --Whatever may the letter always should end with X.

--In query
SELECT HospitalName FROM Hospital WHERE HospitalName in ('Saket Hospital');
SELECT HospitalName FROM Hospital WHERE HospitalName not in ('Saket Hospital');

--Between Query
SELECT * FROM Medicine WHERE NoofMedicines Between 9 and 20;
SELECT * FROM Medicine WHERE NoofMedicines not Between 9 and 20;
SELECT * FROM Medicine WHERE NoofMedicines Between 9 and 20 and MedicineName not in('PO');
SELECT * FROM Medicine WHERE MedicineName between 'Metformin' and 'Antibiotics' ORDER BY  MedicineName;



