
Create Or Replace Table $(LIBRARY)/MY_EMP(
   EmpID Integer Not Null Primary Key,
   Name  Varchar(10) Not Null,
   Salary Decimal(9, 2) Not Null,
   Mgrid Integer Not Null
);

Insert Into $(LIBRARY)/MY_EMP Values ( 1, 'Jones', 30000, 10);
Insert Into $(LIBRARY)/MY_EMP Values ( 2, 'Hall', 35000, 10);
Insert Into $(LIBRARY)/MY_EMP Values ( 3, 'Kim', 40000, 10);
Insert Into $(LIBRARY)/MY_EMP Values ( 4, 'Lindsay', 38000, 10);
Insert Into $(LIBRARY)/MY_EMP Values ( 5, 'McKeough', 42000, 11);
Insert Into $(LIBRARY)/MY_EMP Values ( 6, 'Barnes', 41000, 11);
Insert Into $(LIBRARY)/MY_EMP Values ( 7, 'O''Neil', 36000, 12);
Insert Into $(LIBRARY)/MY_EMP Values ( 8, 'Smith', 34000, 12);
Insert Into $(LIBRARY)/MY_EMP Values ( 9, 'Shoeman', 33000, 12);
Insert Into $(LIBRARY)/MY_EMP Values (10, 'Monroe', 50000, 15);
Insert Into $(LIBRARY)/MY_EMP Values (11, 'Zander', 52000, 16);
Insert Into $(LIBRARY)/MY_EMP Values (12, 'Henry', 51000, 16);
Insert Into $(LIBRARY)/MY_EMP Values (13, 'Aaron', 54000, 15);
Insert Into $(LIBRARY)/MY_EMP Values (14, 'Scott', 53000, 16);
Insert Into $(LIBRARY)/MY_EMP Values (15, 'Mills', 70000, 17);
Insert Into $(LIBRARY)/MY_EMP Values (16, 'Goyal', 80000, 17);
Insert Into $(LIBRARY)/MY_EMP Values (17, 'Urbassek', 95000, NULL);
