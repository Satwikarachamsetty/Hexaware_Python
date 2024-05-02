--Create User Table

Create Table  [User] (
    [UserID] INT PRIMARY KEY,
    [Name] VARCHAR(255),
    [Email] VARCHAR(255) UNIQUE,
    [Password] VARCHAR(255),
    [ContactNumber] VARCHAR(20),
    [Address] TEXT
);

Create Table [Courier](
    [CourierID] INT PRIMARY KEY,
	[UserID] INT,
	[SenderName] VARCHAR(255),
    [SenderAddress] TEXT,
    [ReceiverName] VARCHAR(255),
    [ReceiverAddress] TEXT,
    [Weight] DECIMAL(5, 2),
    [Status] VARCHAR(50),
    [TrackingNumber] VARCHAR(20) UNIQUE,
    [DeliveryDate] DATE
	FOREIGN KEY (UserID) REFERENCES [User](UserID)
);

Create Table [CourierServices](
     [ServiceID] INT PRIMARY KEY,
	 [ServiceName] VARCHAR(100),
	 Cost DECIMAL(8, 2)
);


Create Table [Employee](
    [EmployeeID] INT PRIMARY KEY,
	[Name] VARCHAR(255),
    [Email] VARCHAR(255) UNIQUE,
    [ContactNumber] VARCHAR(20),
	[Role] VARCHAR(50),
	[Salary] DECIMAL(10, 2)
);

Create Table [Location](
    [LocationID] INT PRIMARY KEY,
	[LocationName] VARCHAR(255),
    [Address] TEXT
);

CREATE TABLE Payment (
    [PaymentID] INT PRIMARY KEY,
    [CourierID] INT,
    [LocationID] INT,
    [Amount] DECIMAL(10, 2),
    [PaymentDate] DATE,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

CREATE TABLE CourierServiceMapping (
         CourierID INT,
         ServiceID INT,
         FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
         FOREIGN KEY (ServiceID) REFERENCES CourierServices(ServiceID)
 );

CREATE TABLE EmployeeCourier (
         EmployeeID INT,
         CourierID INT,
         FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
         FOREIGN KEY (CourierID) REFERENCES Courier(CourierID)
     );

--Inserting values into Tables
INSERT INTO [User] ([UserID],[Name],[Email],[Password],[ContactNumber],[Address]) VALUES
(1,'Anika','anika@gmail.com','password1','9876543211','12 Gandhi Nagar,Delhi'),
(2,'Arjun','arjun@gmail.com','password2','9876543212','21 Main St,Ooty'),
(3,'Shivika','shivika@gmail.com','password3','9876543213','34 Ganga St,Varanasi'),
(4,'Shiva','shiva@gmail.com','password4','9876543214','43 Church St,Kerala'),
(5,'Raya','raya@gmail.com','password5','9876543215','56 Joshi Nagar,Pune'),
(6,'Ram','ram@gmail.com','password6','9876543216','65 Indira Market,Chennai'),
(7,'Vihana','vihana@gmail.com','password7','9876543217','78 Khan St,Hyderabad'),
(8,'Varun','varun@gmail.com','password8','9876543218','87 Verma Colony,Mumbai');


INSERT INTO Courier (CourierID, UserID,SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate) VALUES

(1, 1,'Anika', '12 Gandhi Nagar,Delhi', 'Arjun', '21 Main St,Ooty', 2.5, 'In Transit', 'TN11234', '2024-04-01'),
(2,3, 'Shivika', '34 Ganga St,Varanasi', 'Anika', '12 Gandhi Nagar,Delhi', 3.0, 'Delivered', 'TN21234', '2024-04-02'),
(3,2, 'Arjun', '21 Main St,Ooty', 'Shivika', '34 Ganga St,Varanasi', 1.5, 'In Transit', 'TN31234', '2024-04-03'),
(4,4, 'Shiva', '43 Church St,Kerala', 'Raya', '56 Joshi Nagar,Pune', 2.0, 'In Transit', 'TN41234', '2024-04-04'),
(5,6, 'Ram', '65 Indira Market,Chennai', 'Vihana', '78 Khan St,Hyderabad', 4.5, 'Delivered', 'TN51234', '2024-04-05'),
(6,5, 'Raya', '56 Joshi Nagar,Pune', 'Varun', '87 Verma Colony,Mumbai', 4.0, 'In Transit', 'TN61234', '2024-04-06'),
(7,7, 'Vihana', '78 Khan St,Hyderabad', 'Ram', '65 Indira Market,Chennai', 3.5, 'Delivered', 'TN71234', '2024-04-07'),
(8,8, 'Varun', '87 Verma Colony,Mumbai', 'Shiva', '43 Church St,Kerala', 1.0, 'Delivered', 'TN81234', '2024-04-30');


INSERT INTO CourierServices (ServiceID, ServiceName, Cost) VALUES
(1, 'Standard Delivery', 10.00),
(2, 'Express Delivery', 15.00),
(3, 'Overnight Delivery', 20.00),
(4, 'International Delivery', 30.00),
(5, 'Same-Day Delivery', 25.00);

INSERT INTO CourierServiceMapping (CourierID,ServiceID) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,1),
(7,2),
(8,3);

INSERT INTO  EmployeeCourier(EmployeeID,CourierID) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8);

INSERT INTO Employee (EmployeeID, Name, Email, ContactNumber, Role, Salary) VALUES
(1, 'Rahul', 'rahul@gmail.com', '9187654320', 'Manager', 50000.00),
(2, 'Rihana', 'rihana@gmail.com', '9287654320', 'Delivery Person', 30000.00),
(3, 'John', 'john@gmail.com', '9387654320', 'Manager', 45000.00),
(4, 'Jessica', 'jessica@gmail.com', '9487654320', 'Customer Service', 32000.00),
(5, 'Surya', 'surya@gmail.com', '9587654320', 'Driver', 28000.00),
(6, 'Sanjana', 'sanjana@gmail.com', '9687654320', 'Customer Support', 35000.00),
(7, 'Daksh', 'daksh@gmail.com', '9787654320', 'Dispatcher', 38000.00),
(8, 'Dhanvi', 'dhanvi@gmail.com', '9887654320', 'Supervisor', 42000.00);

INSERT INTO Location (LocationID, LocationName, Address) VALUES
(1, 'Delhi', '12 Gandhi Nagar,Delhi'),
(2, 'Ooty', '21 Main St,Ooty'),
(3, 'Varanasi', '34 Ganga St,Varanasi'),
(4, 'Kerala', '43 Church St,Kerala'),
(5, 'Pune', '56 Joshi Nagar,Pune'),
(6, 'Chennai', '65 Khan,Chennai'),
(7, 'Hyderabad', '78 Khan St,Hyderabad'),
(8, 'Mumbai', '87 Verma Colony,Mumbai');

INSERT INTO Payment (PaymentID, CourierID, LocationId, Amount, PaymentDate) VALUES
(1, 1, 2, 120.00, '2024-04-01'),
(2, 2, 1, 130.00, '2024-04-02'),
(3, 3, 4, 150.00, '2024-04-03'),
(4, 4, 3, 180.00, '2024-04-04'),
(5, 5, 6, 200.00, '2024-04-05'),
(6, 6, 5, 120.00, '2024-04-06'),
(7, 7, 8, 170.00, '2024-04-07'),
(8, 8, 7, 160.00, '2024-04-30');

INSERT INTO Courier (CourierID, UserID,SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate) VALUES

(9, 1,'Anika', '12 Gandhi Nagar,Delhi', 'Varun', '87 Verma Colony,Mumbai', 2.5, 'In Transit', 'TN91234', '2024-04-29');

INSERT INTO Payment (PaymentID, CourierID, LocationId, Amount, PaymentDate) VALUES
(9, 9, 1, 250.00, '2024-04-29');

Select * from [User]
Select * from Courier
Select * from [CourierServices]
Select * from [Employee]
Select * from [Location]
Select * from [Payment]
Select * from  EmployeeCourier 
select * from CourierServiceMapping
--Task 2
--1. List all customers: 
Select * from [User]

--2. List all orders for a specific customer: 
Select * from Courier where SenderName='Shiva'

--3. List all couriers
Select * from Courier

--4. List all packages for a specific order:
Select * from Courier where CourierID=4;

--5. List all deliveries for a specific courier:
Select * from courier where Status='Delivered' and courierID=2

--6. List all undelivered packages:
Select * from courier where Status!='Delivered'

--7. List all packages that are scheduled for delivery today:
SELECT * FROM Courier WHERE DeliveryDate = CAST(GETDATE() as DATE);

--8. List all packages with a specific status:
Select * from Courier
Select * from Courier where Status='Delivered'

--9. Calculate the total number of packages for each courier.
Select courierID,Count(courierID) as No_of_Packages from Courier Group by courierID

--10. Find the average delivery time for each courier
SELECT c.CourierId,c.SenderName, AVG(DATEDIFF(day,p.PaymentDate, c.DeliveryDate)) AS AvgTime 
FROM Courier c 
JOIN Payment p ON c.CourierId = p.CourierId 
GROUP BY c.CourierId,c.SenderName;

--11. List all packages with a specific weight range:
Select * from Courier where Weight between 2 and 4

--12. Retrieve employees whose names contain 'John'
Select * from Employee where [Name] LIKE '%John%'

--13. Retrieve all courier records with payments greater than $50. 
select * from Courier where courierID in (select courierID from Payment where Amount>50)

--Task 3: GroupBy, Aggregate Functions, Having, Order By, where
--14. Find the total number of couriers handled by each employee.
select e.EmployeeID,e.[Name],count(ec.CourierID) as TotalCount 
from Employee e JOIN EmployeeCourier ec on e.EmployeeID=ec.EmployeeID 
group by e.EmployeeID,e.[Name]

--15. Calculate the total revenue generated by each location
select LocationId,sum(Amount) as total_revenue from Payment group by LocationId;

select l.LocationId,l.LocationName,sum(p.Amount) as total_revenue from Payment p JOIN [Location] l on p.LocationID=l.LocationID group by l.LocationId,l.LocationName;

--16. Find the total number of couriers delivered to each location.
Select l.LocationID,l.LocationName,count(CourierID) as Count_of_Couriers from Payment p JOIN [Location] l on p.LocationID=l.LocationID group by l.LocationID,l.LocationName;
--17. Find the courier with the highest average delivery time:
select TOP 1 p.Courierid, avg(datediff(day,c.DeliveryDate, p.PaymentDate)) as avgdeliverytime from Payment p 
inner join Courier c on c.Courierid = p.Courierid group by p.Courierid order by 
avgdeliverytime desc;
--18. Find Locations with Total Payments Less Than a Certain Amount
Select LocationID, sum(Amount) as TotalPayments from Payment where Amount<160 group by LocationID;
--19. Calculate Total Payments per Location
select LocationID,sum(Amount) as TotalPayments from Payment group by LocationID

--20. Retrieve couriers who have received payments totaling more than $1000 in a specific location (LocationID = X):
select c.CourierID,c.SenderName,p.Amount,p.LocationID from Payment p join Courier c on p.CourierID=c.CourierID where p.LocationID=7 group by c.CourierID,c.SenderName,p.Amount,p.LocationID having sum(p.Amount)>120

--21. Retrieve couriers who have received payments totaling more than $1000 after a certain date (PaymentDate > 'YYYY-MM-DD'):
select c.CourierID,sum(p.Amount) as TotalPayment,p.PaymentDate 
from Payment p JOIN Courier c on p.CourierID=c.CourierID
where p.PaymentDate >'2024-04-02' 
group by c.CourierID,p.PaymentDate,p.Amount
having p.Amount>140

--22. Retrieve locations where the total amount received is more than $5000 before a certain date (PaymentDate > 'YYYY-MM-DD') Select l.LocationID,l.LocationName,Sum(p.Amount) as TotalPayment,p.PaymentDatefrom Payment p JOIN [Location] l on p.LocationID=l.LocationID where p.PaymentDate<'2024-04-05'group by l.LocationID,l.LocationName,p.PaymentDatehaving sum(p.Amount)>120--Task 4: Inner Join,Full Outer Join, Cross Join, Left Outer Join,Right Outer Join-----------------------------------------------------------------------------------------------


--23. Retrieve Payments with Courier Information
Select p.*,c.*
from Payment p JOIN Courier c on p.CourierID=c.CourierID

--24. Retrieve Payments with Location Information
Select p.*,l.*
from Payment p JOIN [Location] l on p.CourierID=l.LocationID

--25. Retrieve Payments with Courier and Location Information
Select p.*,l.*,c.*
from Payment p 
JOIN [Location] l on p.CourierID=l.LocationID
JOIN Courier c on p.CourierID=c.CourierID

--26. List all payments with courier details
Select p.*,c.* from Payment p Join Courier c on c.CourierID=p.CourierID

--27. Total payments received for each courier
select c.CourierID,c.SenderName,c.ReceiverName,sum(p.Amount) as TotalPayment
from Payment p JOIN Courier c on p.CourierID=c.CourierID
group by c.CourierID,c.SenderName,c.ReceiverName

--28. List payments made on a specific date 
select * from Payment where PaymentDate='2024-04-04'

--29. Get Courier Information for Each Payment
Select p.*,c.* from Payment p Join Courier c on c.CourierID=p.CourierID

--30. Get Payment Details with Location
Select p.*,l.*
from Payment p JOIN [Location] l on p.CourierID=l.LocationID

--31. Calculating Total Payments for Each Courier
Select CourierID,sum(Amount) as TotalPayment 
from Payment group by CourierID
--32. List Payments Within a Date Range
Select * from Payment where PaymentDate between '2024-04-03' and '2024-04-06'

--33. Retrieve a list of all users and their corresponding courier records, including cases where there are no matches on either side
select u.*,c.CourierID,c.[Weight],c.[Status],c.TrackingNumber,c.DeliveryDate from [User] u JOIN Courier c on u.[Name]=c.SenderName

--34. Retrieve a list of all couriers and their corresponding services, including cases where there are no matches on either side
select cs.*,c.CourierID,c.[Weight],c.[Status],c.TrackingNumber,c.DeliveryDate from Courier c 
INNER JOIN CourierServiceMapping csm on c.CourierID=csm.CourierID
INNER JOIN CourierServices cs on cs.ServiceID=csm.ServiceID

--35. Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side
select e.*,p.* from Payment p 
INNER JOIN EmployeeCourier ec on ec.CourierID=p.CourierID
INNER JOIN Employee e on e.EmployeeID=ec.EmployeeID

--36. List all users and all courier services, showing all possible combinations.
select * from [User] cross join [CourierServices]

--37. List all employees and all locations, showing all possible combinations:
select * from [Employee] cross join [Location]

--38. Retrieve a list of couriers and their corresponding sender information (if available)
Select c.CourierID,c.SenderName,u.* from [User] u join Courier c on u.[Name]=c.SenderName

--39. Retrieve a list of couriers and their corresponding receiver information (if available):
Select c.CourierID,c.ReceiverName,u.* from [User] u join Courier c on u.[Name]=c.ReceiverName

--40. Retrieve a list of couriers along with the courier service details (if available):
select c.* ,csm.ServiceID,cs.ServiceName,cs.Cost from Courier c JOIN CourierServiceMapping csm on c.CourierID=csm.CourierID
                                                                JOIN CourierServices cs on csm.ServiceID=cs.ServiceID

--41. Retrieve a list of employees and the number of couriers assigned to each employee:
select e.EmployeeID,e.[Name],count(ec.CourierID) as TotalCount 
from Employee e JOIN EmployeeCourier ec on e.EmployeeID=ec.EmployeeID 
group by e.EmployeeID,e.[Name]
--42. Retrieve a list of locations and the total payment amount received at each location:
select l.LocationID,l.LocationName,sum(p.Amount) as TotalPayment from Payment p JOIN [Location] l on p.LocationID=l.LocationID group by l.LocationID,l.LocationName
--43. Retrieve all couriers sent by the same sender (based on SenderName).
select * from Courier 
where SenderName in (Select SenderName 
                     from Courier 
					 group by SenderName
					 having count(CourierID)>1);

--44. List all employees who share the same role.
select * from [Employee]
where [Role] in (Select [Role] 
                     from [Employee]
					 group by [Role]
					 having count(EmployeeID)>1);
--45. Retrieve all payments made for couriers sent from the same location.
select p1.* from Payment p1 
INNER JOIN Payment p2 on p1.LocationID=p2.LocationID and p1.PaymentID!=p2.PaymentID
--46. Retrieve all couriers sent from the same location (based on SenderAddress).
select c1.* from Courier c1 
INNER JOIN Courier c2 on c1.UserID=c2.UserID and c1.CourierID!=c2.CourierID

--47. List employees and the number of couriers they have delivered:
select e.EmployeeID,e.[Name],count(ec.CourierID) as TotalCount,c.[Status] 
from Employee e 
JOIN EmployeeCourier ec on e.EmployeeID=ec.EmployeeID 
JOIN Courier c on ec.CourierID=c.CourierID
where c.Status='Delivered'
group by e.EmployeeID,e.[Name],c.[Status]

--48. Find couriers that were paid an amount greater than the cost of their respective courier services
select p.CourierID,p.Amount,c.Cost from Payment p 
inner join CourierServiceMapping csm on p.CourierID=csm.CourierID
inner join CourierServices c on csm.ServiceID = c.ServiceID 
where Amount>Cost;

--Scope: Inner Queries, Non Equi Joins, Equi joins,Exist,Any,All
--49. Find couriers that have a weight greater than the average weight of all couriers
select * from Courier where [Weight] > (select avg([Weight]) from Courier)

--50. Find the names of all employees who have a salary greater than the average salary:
select [Name] from Employee where Salary > (select avg(Salary) from Employee);
--51. Find the total cost of all courier services where the cost is less than the maximum cost
select ServiceID,ServiceName,sum(Cost) as total_cost from CourierServices where Cost<(select max(Cost) from CourierServices) group by ServiceID,ServiceName

--52. Find all couriers that have been paid for
Select * from Payment where Amount>0

--53. Find the locations where the maximum payment amount was made
select * from Payment where Amount = (Select MAX(Amount) from Payment)

--54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender (e.g., 'SenderName'): 
select * from Courier where [Weight] > all(select [Weight] from Courier where SenderName = 'Shivika')