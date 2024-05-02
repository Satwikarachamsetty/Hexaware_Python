--Creating Tables 

Create Table [Vehicle](
 [vehicleID] INT PRIMARY KEY,
 [make] VARCHAR(255),
 [model] VARCHAR(255),
 [year] INT,
 [dailyRate] DECIMAL(8, 2),
 [status] INT,
 [passengerCapacity] INT,
 [engineCapacity] INT
 );

Create Table [Customer](
  [customerID] INT PRIMARY KEY,
  [firstName] VARCHAR(255),
  [lastName] VARCHAR(255),
  [email] VARCHAR(255) UNIQUE,
  [phoneNumber] VARCHAR(20)
);

Create Table [Lease]( 
  [leaseID] INT PRIMARY KEY,
  [vehicleID] INT,
  [customerID] INT,
  [startDate] DATE,
  [endDate] DATE,
  [type] VARCHAR(50),
  FOREIGN KEY ([vehicleID]) REFERENCES Vehicle(vehicleID),
  FOREIGN KEY ([customerID]) REFERENCES Customer(customerID)
);

Create Table [Payment]( 
  [paymentID] INT PRIMARY KEY,
  [leaseID] INT,
  [paymentDate] DATE,
  [amount] DECIMAL(10, 2)
);

--Inserting values into Tables

INSERT INTO [Vehicle] ([vehicleID],[make],[model],[year],[dailyRate],[status],[passengerCapacity],[engineCapacity]) VALUES
(1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
(7, 'BMW', '3-Series', 2023, 60.00, 1, 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599),
(9, 'Audi', 'A4', 2022, 55.00, 0, 4, 2500),
(10, 'Lexus', 'ES', 2023, 54.00, 1, 4, 2500);

INSERT INTO [Customer] ([customerID],[firstName],[lastName],[email],[phoneNumber]) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

INSERT INTO [Lease] ([leaseID],[vehicleID],[customerID],[startDate],[endDate],[type]) VALUES
(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

INSERT INTO [Payment]([paymentID],[leaseID],[paymentDate],[amount]) VALUES
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);

select * from [Vehicle];
select * from [Customer];
select * from [Lease];
select * from [Payment];

--1. Update the daily rate for a Mercedes car to 68.
UPDATE Vehicle Set dailyRate=68.00 where make='Mercedes';
Select * from Vehicle;

--2. Delete a specific customer and all associated leases and payments.
Delete from Payment where leaseID in (Select leaseID from Lease where customerID='10');

Delete from Lease where customerID='10';

Delete From Customer where customerID='10';

--3. Rename the "paymentDate" column in the Payment table to "transactionDate".
Alter Table Payment ALTER COLUMN paymentDate transactionDate DATE;
EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';


--4. Find a specific customer by email.
Select * from Customer where email='sarah@example.com';

--5. Get active leases for a specific customer.
Select * from Lease where customerID=8 and endDate>= CAST(GETDATE() AS DATE)

--6. Find all payments made by a customer with a specific phone number.
Select * from Payment where leaseID in (Select leaseID from Lease where customerID in (Select customerID from Customer where phoneNumber='555-432-1098'));  

--7. Calculate the average daily rate of all available cars.
Select avg(dailyRate) as AverageDailyRate from Vehicle

--8. Find the car with the highest daily rate.
Select * from Vehicle where dailyRate = (Select MAX(dailyRate) from Vehicle);

--9. Retrieve all cars leased by a specific customer.
Select * from Vehicle where vehicleID in (Select vehicleID from Lease where customerID=3)

--10. Find the details of the most recent lease.
select TOP 1 * from Lease order by startDate DESC

--11. List all payments made in the year 2023.
Select * from Payment 
WHERE (YEAR(transactionDate) = 2023);

--12. Retrieve customers who have not made any payments.
Select c.*
From Customer c 
LEFT JOIN LEASE L ON c.CustomerID = l.CustomerID
INNER JOIN Payment p ON p.LeaseID = l.LeaseID
Where p.amount is NULL;

--13. Retrieve Car Details and Their Total Payments.
Select v.*,sum(p.amount) as TotalPayment from Vehicle v
LEFT JOIN Lease l on v.vehicleID=l.vehicleID
LEFT JOIN Payment p on p.leaseID=l.leaseID
group by v.vehicleID,v.make,v.model,v.dailyRate,v.[year],v.[status],v.passengerCapacity,v.engineCapacity

--14. Calculate Total Payments for Each Customer.
SELECT c.*, SUM(p.amount) AS TotalPayments
FROM Customer c
LEFT JOIN Lease l ON c.customerID = l.customerID
LEFT JOIN Payment p ON l.leaseID = p.leaseID
GROUP BY c.customerID,c.firstName,c.lastName,c.email,c.phoneNumber;

--15. List Car Details for Each Lease.
SELECT l.*, v.*
FROM Lease l
INNER JOIN Vehicle v ON l.vehicleID = v.vehicleID;

--16. Retrieve Details of Active Leases with Customer and Car Information.
SELECT l.*, v.*, c.*
FROM Lease l
INNER JOIN Vehicle v ON l.vehicleID = v.vehicleID
INNER JOIN Customer c ON l.customerID = c.customerID
WHERE endDate >= CAST(GETDATE() as DATE);

--17. Find the Customer Who Has Spent the Most on Leases.
SELECT TOP 1 c.customerID,c.firstName, SUM(p.amount) AS TotalPayments
FROM Customer c
 JOIN Lease l ON c.customerID = l.customerID
 JOIN Payment p ON l.leaseID = p.leaseID
GROUP BY c.customerID,c.firstName
ORDER BY sum(p.amount) DESC;

--18. List All Cars with Their Current Lease Information
SELECT v.*, l.*
FROM Vehicle v
LEFT JOIN Lease l ON v.vehicleID = l.vehicleID
WHERE l.endDate >= CAST(GETDATE() as DATE);
