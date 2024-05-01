<h1>Task 1 - Database Design </h1>
Design a SQL schema for a Courier Management System with tables for Customers, Couriers, Orders and Parcels. Define the relationships between these tables using appropriate foreign keys.<br>
<h4>Requirements :</h4> 
• Define the Database Schema • Create SQL tables for entities such as User, Courier, Employee, Location, Payment<br>
• Define relationships between these tables (one-to-many, many-to-many, etc.).<br>
• Populate Sample Data • Insert sample data into the tables to simulate real-world scenarios.<br>

<h3>Task 1 </h3>

> User Table

```sql
Create Table  [User] (
    [UserID] INT PRIMARY KEY,
    [Name] VARCHAR(255),
    [Email] VARCHAR(255) UNIQUE,
    [Password] VARCHAR(255),
    [ContactNumber] VARCHAR(20),
    [Address] TEXT
);
```
> Courier Table

```sql
Create Table [Courier](
    [CourierID] INT PRIMARY KEY,
    [UserID] INT
	[SenderName] VARCHAR(255),
    [SenderAddress] TEXT,
    [ReceiverName] VARCHAR(255),
    [ReceiverAddress] TEXT,
    [Weight] DECIMAL(5, 2),
    [Status] VARCHAR(50),
    [TrackingNumber] VARCHAR(20) UNIQUE,
    [DeliveryDate] DATE
    FOREIGN KEY (UserID) REFERENCES User(UserID),
);
```
> CourierServices Table

```sql

Create Table [CourierServices](
     [ServiceID] INT PRIMARY KEY,
	 [ServiceName] VARCHAR(100),
	 Cost DECIMAL(8, 2)
);
```
> Employee Table

```sql

Create Table [Employee](
    [EmployeeID] INT PRIMARY KEY,
	[Name] VARCHAR(255),
    [Email] VARCHAR(255) UNIQUE,
    [ContactNumber] VARCHAR(20),
	[Role] VARCHAR(50),
	[Salary] DECIMAL(10, 2)
);
```
> Location Table

```sql
Create Table [Location](
    [LocationID] INT PRIMARY KEY,
	[LocationName] VARCHAR(255),
    [Address] TEXT
);
```
> Payment Table

```sql
CREATE TABLE Payment (
    [PaymentID] INT PRIMARY KEY,
    [CourierID] INT,
    [LocationID] INT,
    [Amount] DECIMAL(10, 2),
    [PaymentDate] DATE,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);
```
> CourierServiceMapping Table

```sql
CREATE TABLE CourierServiceMapping (
         CourierID INT,
         ServiceID INT,
         FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
         FOREIGN KEY (ServiceID) REFERENCES CourierServices(ServiceID)
 );
```
> EmployeeCourier Table

```sql

CREATE TABLE EmployeeCourier (
         EmployeeID INT,
         CourierID INT,
         FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
         FOREIGN KEY (CourierID) REFERENCES Courier(CourierID)
     );
```

<h3>Task 2 : Select,Where</h3>
Solve the following queries in the Schema that you have created above 
<br><br>

>1. List all customers:

```sql
Select * from [User]
```

| UserID |   Name  |      Email      |  Password  | ContactNumber |            Address            |
|--------|---------|-----------------|------------|---------------|------------------------------|
|   1    |  Anika  | anika@gmail.com |  password1 |   9876543211  |   12 Gandhi Nagar, Delhi     |
|   2    |  Arjun  | arjun@gmail.com |  password2 |   9876543212  |      21 Main St, Ooty       |
|   3    | Shivika | shivika@gmail.com |  password3 |   9876543213  | 34 Ganga St, Varanasi       |
|   4    |  Shiva  |  shiva@gmail.com  |  password4 |   9876543214  |  43 Church St, Kerala        |
|   5    |   Raya  |  raya@gmail.com   |  password5 |   9876543215  |  56 Joshi Nagar, Pune        |
|   6    |   Ram   |   ram@gmail.com   |  password6 |   9876543216  |  65 Indira Market, Chennai   |
|   7    |  Vihana | vihana@gmail.com |  password7 |   9876543217  |  78 Khan St, Hyderabad       |
|   8    |  Varun  | varun@gmail.com  |  password8 |   9876543218  |  87 Verma Colony, Mumbai     |


>2. List all orders for a specific customer

```sql
Select * from Courier where SenderName='Shiva'
```
| CourierID | SenderName |   SenderAddress   | ReceiverName |  ReceiverAddress  | Weight |   Status   | TrackingNumber | DeliveryDate |
|-----------|------------|-------------------|--------------|-------------------|--------|------------|----------------|--------------|
|     4     |   Shiva    | 43 Church St,Kerala |     Raya     | 56 Joshi Nagar,Pune |  2.00  | In Transit |    TN41234     |  2024-04-04  |


> 3. List all couriers
```sql
Select * from Courier
```
| CourierID | SenderName |    SenderAddress    | ReceiverName |   ReceiverAddress   | Weight |   Status   | TrackingNumber | DeliveryDate |
|-----------|------------|---------------------|--------------|---------------------|--------|------------|----------------|--------------|
|     1     |   Anika    | 12 Gandhi Nagar,Delhi |    Arjun     | 21 Main St,Ooty     |  2.50  | In Transit |    TN11234     |  2024-04-01  |
|     2     |  Shivika   | 34 Ganga St,Varanasi |    Anika     | 12 Gandhi Nagar,Delhi |  3.00  |  Delivered |    TN21234     |  2024-04-02  |
|     3     |   Arjun    |   21 Main St,Ooty    |  Shivika     | 34 Ganga St,Varanasi |  1.50  | In Transit |    TN31234     |  2024-04-03  |
|     4     |   Shiva    | 43 Church St,Kerala  |    Raya      | 56 Joshi Nagar,Pune  |  2.00  | In Transit |    TN41234     |  2024-04-04  |
|     5     |    Ram     | 65 Indira Market,Chennai |  Vihana     | 78 Khan St,Hyderabad |  4.50  |  Delivered |    TN51234     |  2024-04-05  |
|     6     |    Raya    |  56 Joshi Nagar,Pune  |    Varun     | 87 Verma Colony,Mumbai |  4.00  | In Transit |    TN61234     |  2024-04-06  |
|     7     |  Vihana    | 78 Khan St,Hyderabad |    Ram       | 65 Indira Market,Chennai | 3.50  |  Delivered |    TN71234     |  2024-04-07  |
|     8     |   Varun    | 87 Verma Colony,Mumbai |   Shiva     | 43 Church St,Kerala  |  1.00  |  Delivered |    TN81234     |  2024-04-30  |


> 4. List all packages for a specific order:
```sql
Select * from Courier where CourierID=4;
```
| CourierID | SenderName |    SenderAddress    | ReceiverName |   ReceiverAddress   | Weight |   Status   | TrackingNumber | DeliveryDate |
|-----------|------------|---------------------|--------------|---------------------|--------|------------|----------------|--------------|
|     4     |   Shiva    | 43 Church St,Kerala |     Raya     | 56 Joshi Nagar,Pune |  2.00  | In Transit |    TN41234     |  2024-04-04  |


> 5. List all deliveries for a specific courier:
```sql
Select * from courier where Status='Delivered' and courierID=2
```
| CourierID | SenderName |    SenderAddress    | ReceiverName |   ReceiverAddress   | Weight |   Status   | TrackingNumber | DeliveryDate |
|-----------|------------|---------------------|--------------|---------------------|--------|------------|----------------|--------------|
|     2     |  Shivika   | 34 Ganga St,Varanasi |    Anika     | 12 Gandhi Nagar,Delhi |  3.00  |  Delivered |    TN21234     |  2024-04-02  |

> 6. List all undelivered packages:
```sql
Select * from courier where Status!='Delivered'
```
| CourierID | SenderName |    SenderAddress    | ReceiverName |   ReceiverAddress   | Weight |   Status   | TrackingNumber | DeliveryDate |
|-----------|------------|---------------------|--------------|---------------------|--------|------------|----------------|--------------|
|     1     |   Anika    | 12 Gandhi Nagar,Delhi |    Arjun     |   21 Main St,Ooty   |  2.50  | In Transit |    TN11234     |  2024-04-01  |
|     3     |   Arjun    |   21 Main St,Ooty    |  Shivika     | 34 Ganga St,Varanasi |  1.50  | In Transit |    TN31234     |  2024-04-03  |
|     4     |   Shiva    | 43 Church St,Kerala  |    Raya      | 56 Joshi Nagar,Pune  |  2.00  | In Transit |    TN41234     |  2024-04-04  |
|     6     |    Raya    |  56 Joshi Nagar,Pune  |    Varun     | 87 Verma Colony,Mumbai |  4.00  | In Transit |    TN61234     |  2024-04-06  |

> 7. List all packages that are scheduled for delivery today:
```sql
SELECT * FROM Courier WHERE DeliveryDate = CAST(GETDATE() as DATE);
```
| CourierID | SenderName |    SenderAddress    | ReceiverName |   ReceiverAddress   | Weight |   Status   | TrackingNumber | DeliveryDate |
|-----------|------------|---------------------|--------------|---------------------|--------|------------|----------------|--------------|
|     8     |   Varun    | 87 Verma Colony,Mumbai |    Shiva     | 43 Church St,Kerala |  1.00  | Delivered |    TN81234     |  2024-04-30  |

> 8. List all packages with a specific status:
```sql
Select * from Courier where Status='Delivered'
```
| CourierID | SenderName |    SenderAddress    | ReceiverName |   ReceiverAddress   | Weight |   Status   | TrackingNumber | DeliveryDate |
|-----------|------------|---------------------|--------------|---------------------|--------|------------|----------------|--------------|
|     2     |  Shivika   | 34 Ganga St,Varanasi |    Anika     | 12 Gandhi Nagar,Delhi |  3.00  |  Delivered |    TN21234     |  2024-04-02  |
|     5     |    Ram     | 65 Indira Market,Chennai |  Vihana     | 78 Khan St,Hyderabad |  4.50  |  Delivered |    TN51234     |  2024-04-05  |
|     7     |  Vihana    | 78 Khan St,Hyderabad |    Ram       | 65 Indira Market,Chennai |  3.50  |  Delivered |    TN71234     |  2024-04-07  |
|     8     |   Varun    | 87 Verma Colony,Mumbai |   Shiva     | 43 Church St,Kerala |  1.00  |  Delivered |    TN81234     |  2024-04-30  |

> 9. Calculate the total number of packages for each courier.
```sql
Select courierID,Count(courierID) as No_of_Packages from Courier Group by courierID
```
| CourierID | No_of_Packages |
|-----------|----------------|
|     1     |       1        |
|     2     |       1        |
|     3     |       1        |
|     4     |       1        |
|     5     |       1        |
|     6     |       1        |
|     7     |       1        |
|     8     |       1        |


> 10. Find the average delivery time for each courier
```sql
SELECT c.CourierId,c.SenderName, AVG(DATEDIFF(day,p.PaymentDate, c.DeliveryDate)) AS AvgTime 
FROM Courier c 
JOIN Payment p ON c.CourierId = p.CourierId 
GROUP BY c.CourierId,c.SenderName;
```
| CourierId | SenderName | AvgTime |
|-----------|------------|---------|
|     1     |   Anika    |    0    |
|     2     |  Shivika   |    0    |
|     3     |   Arjun    |    0    |
|     4     |   Shiva    |    0    |
|     5     |    Ram     |    0    |
|     6     |    Raya    |    0    |
|     7     |   Vihana   |    0    |
|     8     |   Varun    |    0    |

> 11. List all packages with a specific weight range:
```sql
Select * from Courier where [Weight] between 2 and 4
```
| CourierID | SenderName |    SenderAddress    | ReceiverName |   ReceiverAddress   | Weight |   Status   | TrackingNumber | DeliveryDate |
|-----------|------------|---------------------|--------------|---------------------|--------|------------|----------------|--------------|
|     1     |   Anika    | 12 Gandhi Nagar,Delhi |    Arjun     |   21 Main St,Ooty   |  2.50  | In Transit |    TN11234     |  2024-04-01  |
|     2     |  Shivika   | 34 Ganga St,Varanasi |    Anika     | 12 Gandhi Nagar,Delhi |  3.00  |  Delivered |    TN21234     |  2024-04-02  |
|     4     |   Shiva    | 43 Church St,Kerala  |    Raya      | 56 Joshi Nagar,Pune  |  2.00  | In Transit |    TN41234     |  2024-04-04  |
|     6     |    Raya    | 56 Joshi Nagar,Pune  |    Varun     | 87 Verma Colony,Mumbai |  4.00  | In Transit |    TN61234     |  2024-04-06  |
|     7     |  Vihana    | 78 Khan St,Hyderabad |    Ram       | 65 Indira Market,Chennai |  3.50  |  Delivered |    TN71234     |  2024-04-07  |

> 12. Retrieve employees whose names contain 'John'
```sql
Select * from Employee where [Name] LIKE '%John%'
```
| EmployeeID | Name |      Email       | ContactNumber |         Role          | Salary     |
|------------|------|------------------|---------------|-----------------------|------------|
|     3      | John | john@gmail.com  |  9387654320  | Warehouse Manager     | 45000.00   |


>13. Retrieve all courier records with payments greater than $50. 
```sql
select * from Courier where courierID in (select courierID from Payment where Amount>50)
```
| CourierID | SenderName |    SenderAddress    | ReceiverName |   ReceiverAddress   | Weight |   Status   | TrackingNumber | DeliveryDate |
|-----------|------------|---------------------|--------------|---------------------|--------|------------|----------------|--------------|
|     1     |   Anika    | 12 Gandhi Nagar,Delhi |    Arjun     |   21 Main St,Ooty   |  2.50  | In Transit |    TN11234     |  2024-04-01  |
|     2     |  Shivika   | 34 Ganga St,Varanasi |    Anika     | 12 Gandhi Nagar,Delhi |  3.00  |  Delivered |    TN21234     |  2024-04-02  |
|     3     |   Arjun    |   21 Main St,Ooty    |   Shivika    | 34 Ganga St,Varanasi |  1.50  | In Transit |    TN31234     |  2024-04-03  |
|     4     |   Shiva    |  43 Church St,Kerala |    Raya      | 56 Joshi Nagar,Pune  |  2.00  | In Transit |    TN41234     |  2024-04-04  |
|     5     |    Ram     | 65 Indira Market,Chennai |   Vihana    | 78 Khan St,Hyderabad |  4.50  |  Delivered |    TN51234     |  2024-04-05  |
|     6     |    Raya    | 56 Joshi Nagar,Pune  |    Varun     | 87 Verma Colony,Mumbai |  4.00  | In Transit |    TN61234     |  2024-04-06  |
|     7     |  Vihana    | 78 Khan St,Hyderabad |     Ram      | 65 Indira Market,Chennai |  3.50  |  Delivered |    TN71234     |  2024-04-07  |
|     8     |   Varun    | 87 Verma Colony,Mumbai |   Shiva     |  43 Church St,Kerala |  1.00  |  Delivered |    TN81234     |  2024-04-30  |



<h3>Task 3: GroupBy, Aggregate Functions, Having, Order By, where </h3>


> 14. Find the total number of couriers handled by each employee.
```sql
select e.EmployeeID,e.[Name],count(ec.CourierID) as TotalCount 
from Employee e JOIN EmployeeCourier ec on e.EmployeeID=ec.EmployeeID 
group by e.EmployeeID,e.[Name]
```
| EmployeeID | Name    | TotalCount |
|------------|---------|------------|
| 1          | Rahul   | 1          |
| 2          | Rihana  | 1          |
| 3          | John    | 1          |
| 4          | Jessica | 1          |
| 5          | Surya   | 1          |
| 6          | Sanjana | 1          |
| 7          | Daksh   | 1          |
| 8          | Dhanvi  | 1          |

> 15. Calculate the total revenue generated by each location
```sql
Select LocationId,sum(Amount) as total_revenue from Payment group by LocationId; 

Select l.LocationId,l.LocationName,sum(p.Amount) as total_revenue from Payment p JOIN [Location] l on p.LocationID=l.LocationID group by l.LocationId,l.LocationName;
```
| LocationId | LocationName | TotalRevenue |
|------------|--------------|--------------|
|     1      |    Delhi     |    130.00    |
|     2      |     Ooty     |    120.00    |
|     3      |   Varanasi   |    180.00    |
|     4      |    Kerala    |    150.00    |
|     5      |     Pune     |    120.00    |
|     6      |   Chennai    |    200.00    |
|     7      |  Hyderabad   |    160.00    |
|     8      |    Mumbai    |    170.00    |

> 16. Find the total number of couriers delivered to each location.
```sql
Select l.LocationID,l.LocationName,count(CourierID) as Count_of_Couriers from Payment p JOIN [Location] l on p.LocationID=l.LocationID group by l.LocationID,l.LocationName;
```
| LocationID | LocationName | Count_of_Couriers |
|------------|--------------|-------------------|
|     1      |    Delhi     |         1         |
|     2      |     Ooty     |         1         |
|     3      |   Varanasi   |         1         |
|     4      |    Kerala    |         1         |
|     5      |     Pune     |         1         |
|     6      |   Chennai    |         1         |
|     7      |  Hyderabad   |         1         |
|     8      |    Mumbai    |         1         |

> 17. Find the courier with the highest average delivery time:

```sql
select TOP 1 p.Courierid, avg(datediff(day,c.DeliveryDate, p.PaymentDate)) as avgdeliverytime from Payment p 
inner join Courier c on c.Courierid = p.Courierid group by p.Courierid order by avgdeliverytime desc;
```
| CourierID | AvgDeliveryTime |
|-----------|-----------------|
|     2     |       0         |

> 18. Find Locations with Total Payments Less Than a Certain Amount
```sql
Select LocationID, sum(Amount) as TotalPayments from Payment where Amount<160 group by LocationID;
```
| LocationID | TotalPayments |
|------------|---------------|
|     1      |    130.00     |
|     2      |    120.00     |
|     4      |    150.00     |
|     5      |    120.00     |

> 19. Calculate Total Payments per Location
```sql
select LocationID,sum(Amount) as TotalPayments from Payment group by LocationID
```
| LocationID | TotalPayments |
|------------|---------------|
|     1      |    130.00     |
|     2      |    120.00     |
|     3      |    180.00     |
|     4      |    150.00     |
|     5      |    120.00     |
|     6      |    200.00     |
|     7      |    160.00     |
|     8      |    170.00     |

> 20. Retrieve couriers who have received payments totaling more than $1000 in a specific location
(LocationID = X):
```sql
select c.CourierID,c.SenderName,p.Amount,p.LocationID from Payment p join Courier c on p.CourierID=c.CourierID where p.LocationID=7 group by c.CourierID,c.SenderName,p.Amount,p.LocationID having sum(p.Amount)>120
```
| CourierID | SenderName | Amount | LocationID |
|-----------|------------|--------|------------|
| 8         | Varun      | 160.00 | 7          |


> 21. Retrieve couriers who have received payments totaling more than $1000 after a certain date
(PaymentDate > 'YYYY-MM-DD'):
```sql
select c.CourierID,sum(p.Amount) as TotalPayment,p.PaymentDate 
from Payment p JOIN Courier c on p.CourierID=c.CourierID
where p.PaymentDate >'2024-04-02' 
group by c.CourierID,p.PaymentDate,p.Amount
having p.Amount>140

```
| CourierID | TotalPayment | PaymentDate |
|-----------|--------------|-------------|
| 3         | 150.00       | 2024-04-03  |
| 4         | 180.00       | 2024-04-04  |
| 5         | 200.00       | 2024-04-05  |
| 7         | 170.00       | 2024-04-07  |
| 8         | 160.00       | 2024-04-30  |

> 22. Retrieve locations where the total amount received is more than $5000 before a certain date
(PaymentDate > 'YYYY-MM-DD') 
```sql
Select l.LocationID,l.LocationName,Sum(p.Amount) as TotalPayment,p.PaymentDate
from Payment p JOIN [Location] l on p.LocationID=l.LocationID 
where p.PaymentDate<'2024-04-05'
group by l.LocationID,l.LocationName,p.PaymentDate
having sum(p.Amount)>120
```
| LocationID | LocationName | TotalPayment | PaymentDate |
|------------|--------------|--------------|-------------|
| 1          | Delhi        | 130.00       | 2024-04-02  |
| 3          | Varanasi     | 180.00       | 2024-04-04  |
| 4          | Kerala       | 150.00       | 2024-04-03  |


<h3>Task 4: Inner Join,Full Outer Join, Cross Join, Left Outer Join,Right Outer Join</h3>
<br>

> 23. Retrieve Payments with Courier Information
```sql
Select p.*,c.*
from Payment p JOIN Courier c on p.CourierID=c.CourierID

```
| PaymentID | CourierID | LocationID | Amount | PaymentDate | SenderName | SenderAddress         | ReceiverName | ReceiverAddress       | Weight | Status       | TrackingNumber | DeliveryDate |
|-----------|-----------|------------|--------|--------------|------------|-----------------------|--------------|-----------------------|--------|--------------|----------------|--------------|
| 1         | 1         | 2          | 120.00 | 2024-04-01   | Anika      | 12 Gandhi Nagar, Delhi| Arjun        | 21 Main St, Ooty      | 2.50   | In Transit   | TN11234        | 2024-04-01   |
| 2         | 2         | 1          | 130.00 | 2024-04-02   | Shivika    | 34 Ganga St, Varanasi | Anika        | 12 Gandhi Nagar, Delhi| 3.00   | Delivered    | TN21234        | 2024-04-02   |
| 3         | 3         | 4          | 150.00 | 2024-04-03   | Arjun      | 21 Main St, Ooty      | Shivika      | 34 Ganga St, Varanasi | 1.50   | In Transit   | TN31234        | 2024-04-03   |
| 4         | 4         | 3          | 180.00 | 2024-04-04   | Shiva      | 43 Church St, Kerala   | Raya         | 56 Joshi Nagar, Pune  | 2.00   | In Transit   | TN41234        | 2024-04-04   |
| 5         | 5         | 6          | 200.00 | 2024-04-05   | Ram        | 65 Indira Market, Chennai| Vihana     | 78 Khan St, Hyderabad| 4.50   | Delivered    | TN51234        | 2024-04-05   |
| 6         | 6         | 5          | 120.00 | 2024-04-06   | Raya       | 56 Joshi Nagar, Pune  | Varun        | 87 Verma Colony, Mumbai| 4.00   | In Transit   | TN61234        | 2024-04-06   |
| 7         | 7         | 8          | 170.00 | 2024-04-07   | Vihana     | 78 Khan St, Hyderabad| Ram          | 65 Indira Market, Chennai| 3.50   | Delivered    | TN71234        | 2024-04-07   |
| 8         | 8         | 7          | 160.00 | 2024-04-30   | Varun      | 87 Verma Colony, Mumbai| Shiva       | 43 Church St, Kerala  | 1.00   | Delivered    | TN81234        | 2024-04-30   |



> 24. Retrieve Payments with Location Information
```sql
Select p.*,l.*
from Payment p JOIN [Location] l on p.CourierID=l.LocationID
```
| PaymentID | CourierID | LocationID | Amount | PaymentDate | LocationName | Address                 |
|-----------|-----------|------------|--------|--------------|--------------|-------------------------|
| 1         | 1         | 2          | 120.00 | 2024-04-01   | Delhi        | 12 Gandhi Nagar, Delhi  |
| 2         | 2         | 1          | 130.00 | 2024-04-02   | Ooty         | 21 Main St, Ooty        |
| 3         | 3         | 4          | 150.00 | 2024-04-03   | Varanasi     | 34 Ganga St, Varanasi   |
| 4         | 4         | 3          | 180.00 | 2024-04-04   | Kerala       | 43 Church St, Kerala    |
| 5         | 5         | 6          | 200.00 | 2024-04-05   | Pune         | 56 Joshi Nagar, Pune    |
| 6         | 6         | 5          | 120.00 | 2024-04-06   | Chennai      | 65 Khan, Chennai        |
| 7         | 7         | 8          | 170.00 | 2024-04-07   | Hyderabad    | 78 Khan St, Hyderabad   |
| 8         | 8         | 7          | 160.00 | 2024-04-30   | Mumbai       | 87 Verma Colony, Mumbai |



> 25. Retrieve Payments with Courier and Location Information
```sql
Select p.*,l.*,c.*
from Payment p 
JOIN [Location] l on p.CourierID=l.LocationID
JOIN Courier c on p.CourierID=c.CourierID
```
| PaymentID | CourierID | LocationID | Amount | PaymentDate | LocationName | Address                 | SenderName | SenderAddress          | ReceiverName | ReceiverAddress       | Weight | Status     | TrackingNumber | DeliveryDate |
|-----------|-----------|------------|--------|--------------|--------------|-------------------------|------------|------------------------|--------------|-----------------------|--------|------------|----------------|--------------|
| 1         | 1         | 2          | 120.00 | 2024-04-01   | Delhi        | 12 Gandhi Nagar, Delhi  | Anika      | 12 Gandhi Nagar, Delhi| Arjun        | 21 Main St, Ooty      | 2.50   | In Transit | TN11234        | 2024-04-01   |
| 2         | 2         | 1          | 130.00 | 2024-04-02   | Ooty         | 21 Main St, Ooty        | Shivika    | 34 Ganga St, Varanasi | Anika        | 12 Gandhi Nagar, Delhi| 3.00   | Delivered  | TN21234        | 2024-04-02   |
| 3         | 3         | 4          | 150.00 | 2024-04-03   | Varanasi     | 34 Ganga St, Varanasi   | Arjun      | 21 Main St, Ooty      | Shivika      | 34 Ganga St, Varanasi | 1.50   | In Transit | TN31234        | 2024-04-03   |
| 4         | 4         | 3          | 180.00 | 2024-04-04   | Kerala       | 43 Church St, Kerala    | Shiva      | 43 Church St, Kerala  | Raya         | 56 Joshi Nagar, Pune  | 2.00   | In Transit | TN41234        | 2024-04-04   |
| 5         | 5         | 6          | 200.00 | 2024-04-05   | Pune         | 56 Joshi Nagar, Pune    | Ram        | 65 Indira Market, Chennai| Vihana     | 78 Khan St, Hyderabad| 4.50   | Delivered  | TN51234        | 2024-04-05   |
| 6         | 6         | 5          | 120.00 | 2024-04-06   | Chennai      | 65 Khan, Chennai        | Raya       | 56 Joshi Nagar, Pune  | Varun        | 87 Verma Colony, Mumbai| 4.00   | In Transit | TN61234        | 2024-04-06   |
| 7         | 7         | 8          | 170.00 | 2024-04-07   | Hyderabad    | 78 Khan St, Hyderabad   | Vihana     | 78 Khan St, Hyderabad| Ram          | 65 Indira Market, Chennai| 3.50   | Delivered  | TN71234        | 2024-04-07   |
| 8         | 8         | 7          | 160.00 | 2024-04-30   | Mumbai       | 87 Verma Colony, Mumbai | Varun      | 87 Verma Colony, Mumbai| Shiva       | 43 Church St, Kerala  | 1.00   | Delivered  | TN81234        | 2024-04-30   |

> 26. List all payments with courier details
```sql
Select p.*,c.* from Payment p Join Courier c on c.CourierID=p.CourierID
```
| PaymentID | CourierID | LocationID | Amount | PaymentDate | SenderName | SenderAddress          | ReceiverName | ReceiverAddress       | Weight | Status     | TrackingNumber | DeliveryDate |
|-----------|-----------|------------|--------|--------------|------------|------------------------|--------------|-----------------------|--------|------------|----------------|--------------|
| 1         | 1         | 2          | 120.00 | 2024-04-01   | Anika      | 12 Gandhi Nagar, Delhi | Arjun        | 21 Main St, Ooty      | 2.50   | In Transit | TN11234        | 2024-04-01   |
| 2         | 2         | 1          | 130.00 | 2024-04-02   | Shivika    | 34 Ganga St, Varanasi  | Anika        | 12 Gandhi Nagar, Delhi| 3.00   | Delivered  | TN21234        | 2024-04-02   |
| 3         | 3         | 4          | 150.00 | 2024-04-03   | Arjun      | 21 Main St, Ooty       | Shivika      | 34 Ganga St, Varanasi | 1.50   | In Transit | TN31234        | 2024-04-03   |
| 4         | 4         | 3          | 180.00 | 2024-04-04   | Shiva      | 43 Church St, Kerala    | Raya         | 56 Joshi Nagar, Pune  | 2.00   | In Transit | TN41234        | 2024-04-04   |
| 5         | 5         | 6          | 200.00 | 2024-04-05   | Ram        | 65 Indira Market, Chennai| Vihana     | 78 Khan St, Hyderabad| 4.50   | Delivered  | TN51234        | 2024-04-05   |
| 6         | 6         | 5          | 120.00 | 2024-04-06   | Raya       | 56 Joshi Nagar, Pune   | Varun        | 87 Verma Colony, Mumbai| 4.00   | In Transit | TN61234        | 2024-04-06   |
| 7         | 7         | 8          | 170.00 | 2024-04-07   | Vihana     | 78 Khan St, Hyderabad  | Ram          | 65 Indira Market, Chennai| 3.50   | Delivered  | TN71234        | 2024-04-07   |
| 8         | 8         | 7          | 160.00 | 2024-04-30   | Varun      | 87 Verma Colony, Mumbai| Shiva       | 43 Church St, Kerala  | 1.00   | Delivered  | TN81234        | 2024-04-30   |

> 27. Total payments received for each courier
```sql
select c.CourierID,c.SenderName,c.ReceiverName,sum(p.Amount) as TotalPayment
from Payment p JOIN Courier c on p.CourierID=c.CourierID
group by c.CourierID,c.SenderName,c.ReceiverName
```
| CourierID | SenderName | ReceiverName | TotalPayment |
|-----------|------------|--------------|--------------|
| 1         | Anika      | Arjun        | 120.00       |
| 2         | Shivika    | Anika        | 130.00       |
| 3         | Arjun      | Shivika      | 150.00       |
| 4         | Shiva      | Raya         | 180.00       |
| 5         | Ram        | Vihana       | 200.00       |
| 6         | Raya       | Varun        | 120.00       |
| 7         | Vihana     | Ram          | 170.00       |
| 8         | Varun      | Shiva        | 160.00       |

> 28. List payments made on a specific date
```sql
select * from Payment where PaymentDate='2024-04-04'
``` 
| PaymentID | CourierID | LocationID | Amount | PaymentDate |
|-----------|-----------|------------|--------|--------------|
| 4         | 4         | 3          | 180.00 | 2024-04-04   |


> 29. Get Courier Information for Each Payment
```sql
Select p.*,c.* from Payment p Join Courier c on c.CourierID=p.CourierID
```
| PaymentID | CourierID | LocationID | Amount | PaymentDate | CourierID | SenderName | SenderAddress          | ReceiverName | ReceiverAddress       | Weight | Status     | TrackingNumber | DeliveryDate |
|-----------|-----------|------------|--------|--------------|-----------|------------|------------------------|--------------|-----------------------|--------|------------|----------------|--------------|
| 1         | 1         | 2          | 120.00 | 2024-04-01   | 1         | Anika      | 12 Gandhi Nagar, Delhi | Arjun        | 21 Main St, Ooty      | 2.50   | In Transit | TN11234        | 2024-04-01   |
| 2         | 2         | 1          | 130.00 | 2024-04-02   | 2         | Shivika    | 34 Ganga St, Varanasi  | Anika        | 12 Gandhi Nagar, Delhi| 3.00   | Delivered  | TN21234        | 2024-04-02   |
| 3         | 3         | 4          | 150.00 | 2024-04-03   | 3         | Arjun      | 21 Main St, Ooty       | Shivika      | 34 Ganga St, Varanasi | 1.50   | In Transit | TN31234        | 2024-04-03   |
| 4         | 4         | 3          | 180.00 | 2024-04-04   | 4         | Shiva      | 43 Church St, Kerala    | Raya         | 56 Joshi Nagar, Pune  | 2.00   | In Transit | TN41234        | 2024-04-04   |
| 5         | 5         | 6          | 200.00 | 2024-04-05   | 5         | Ram        | 65 Indira Market, Chennai| Vihana     | 78 Khan St, Hyderabad| 4.50   | Delivered  | TN51234        | 2024-04-05   |
| 6         | 6         | 5          | 120.00 | 2024-04-06   | 6         | Raya       | 56 Joshi Nagar, Pune    | Varun        | 87 Verma Colony, Mumbai| 4.00   | In Transit | TN61234        | 2024-04-06   |
| 7         | 7         | 8          | 170.00 | 2024-04-07   | 7         | Vihana     | 78 Khan St, Hyderabad   | Ram          | 65 Indira Market, Chennai| 3.50   | Delivered  | TN71234        | 2024-04-07   |
| 8         | 8         | 7          | 160.00 | 2024-04-30   | 8         | Varun      | 87 Verma Colony, Mumbai | Shiva        | 43 Church St, Kerala  | 1.00   | Delivered  | TN81234        | 2024-04-30   |

> 30. Get Payment Details with Location
```sql
Select p.*,l.*
from Payment p JOIN [Location] l on p.CourierID=l.LocationID
```
| PaymentID | CourierID | LocationID | Amount | PaymentDate | LocationName | Address                 |
|-----------|-----------|------------|--------|--------------|--------------|-------------------------|
| 1         | 1         | 2          | 120.00 | 2024-04-01   | Delhi        | 12 Gandhi Nagar, Delhi  |
| 2         | 2         | 1          | 130.00 | 2024-04-02   | Ooty         | 21 Main St, Ooty        |
| 3         | 3         | 4          | 150.00 | 2024-04-03   | Varanasi     | 34 Ganga St, Varanasi   |
| 4         | 4         | 3          | 180.00 | 2024-04-04   | Kerala       | 43 Church St, Kerala    |
| 5         | 5         | 6          | 200.00 | 2024-04-05   | Pune         | 56 Joshi Nagar, Pune    |
| 6         | 6         | 5          | 120.00 | 2024-04-06   | Chennai      | 65 Khan, Chennai        |
| 7         | 7         | 8          | 170.00 | 2024-04-07   | Hyderabad    | 78 Khan St, Hyderabad   |
| 8         | 8         | 7          | 160.00 | 2024-04-30   | Mumbai       | 87 Verma Colony, Mumbai |


> 31. Calculating Total Payments for Each Courier
```sql
Select CourierID,sum(Amount) as TotalPayment 
from Payment group by CourierID
```
| CourierID | TotalPayment |
|-----------|--------------|
| 1         | 120.00       |
| 2         | 130.00       |
| 3         | 150.00       |
| 4         | 180.00       |
| 5         | 200.00       |
| 6         | 120.00       |
| 7         | 170.00       |
| 8         | 160.00       |


> 32. List Payments Within a Date Range
```sql
Select * from Payment where PaymentDate between '2024-04-03' and '2024-04-06'
```
| PaymentID | CourierID | LocationID | Amount | PaymentDate |
|-----------|-----------|------------|--------|--------------|
| 3         | 3         | 4          | 150.00 | 2024-04-03   |
| 4         | 4         | 3          | 180.00 | 2024-04-04   |
| 5         | 5         | 6          | 200.00 | 2024-04-05   |
| 6         | 6         | 5          | 120.00 | 2024-04-06   |

> 33. Retrieve a list of all users and their corresponding courier records, including cases where there are
no matches on either side
```sql
select u.*,c.CourierID,c.[Weight],c.[Status],c.TrackingNumber,c.DeliveryDate from [User] u JOIN Courier c on u.[Name]=c.SenderName
```
| UserID | Name    | Email            | Password | ContactNumber | Address                  | CourierID | Weight | Status     | TrackingNumber | DeliveryDate |
|--------|---------|------------------|----------|---------------|--------------------------|-----------|--------|------------|----------------|--------------|
| 1      | Anika   | anika@gmail.com | password1| 9876543211    | 12 Gandhi Nagar, Delhi  | 1         | 2.50   | In Transit | TN11234        | 2024-04-01   |
| 2      | Arjun   | arjun@gmail.com | password2| 9876543212    | 21 Main St, Ooty        | 3         | 1.50   | In Transit | TN31234        | 2024-04-03   |
| 3      | Shivika | shivika@gmail.com| password3| 9876543213    | 34 Ganga St, Varanasi   | 2         | 3.00   | Delivered  | TN21234        | 2024-04-02   |
| 4      | Shiva   | shiva@gmail.com | password4| 9876543214    | 43 Church St, Kerala    | 4         | 2.00   | In Transit | TN41234        | 2024-04-04   |
| 5      | Raya    | raya@gmail.com  | password5| 9876543215    | 56 Joshi Nagar, Pune    | 6         | 4.00   | In Transit | TN61234        | 2024-04-06   |
| 6      | Ram     | ram@gmail.com   | password6| 9876543216    | 65 Indira Market, Chennai| 5        | 4.50   | Delivered  | TN51234        | 2024-04-05   |
| 7      | Vihana  | vihana@gmail.com| password7| 9876543217    | 78 Khan St, Hyderabad   | 7         | 3.50   | Delivered  | TN71234        | 2024-04-07   |
| 8      | Varun   | varun@gmail.com | password8| 9876543218    | 87 Verma Colony, Mumbai | 8         | 1.00   | Delivered  | TN81234        | 2024-04-30   |

> 34. Retrieve a list of all couriers and their corresponding services, including cases where there are no
matches on either side
```sql
select cs.*,c.CourierID,c.[Weight],c.[Status],c.TrackingNumber,c.DeliveryDate from Courier c 
INNER JOIN CourierServiceMapping csm on c.CourierID=csm.CourierID
INNER JOIN CourierServices cs on cs.ServiceID=csm.ServiceID
```
| ServiceID | ServiceName          | Cost | CourierID | Weight | Status      | TrackingNumber | DeliveryDate |
|-----------|----------------------|------|-----------|--------|-------------|----------------|--------------|
| 1         | Standard Delivery    | 10.00| 1         | 2.50   | In Transit  | TN11234        | 2024-04-01   |
| 2         | Express Delivery     | 15.00| 2         | 3.00   | Delivered   | TN21234        | 2024-04-02   |
| 3         | Overnight Delivery   | 20.00| 3         | 1.50   | In Transit  | TN31234        | 2024-04-03   |
| 4         | International Delivery| 30.00| 4        | 2.00   | In Transit  | TN41234        | 2024-04-04   |
| 5         | Same-Day Delivery    | 25.00| 5         | 4.50   | Delivered   | TN51234        | 2024-04-05   |
| 1         | Standard Delivery    | 10.00| 6         | 4.00   | In Transit  | TN61234        | 2024-04-06   |
| 2         | Express Delivery     | 15.00| 7         | 3.50   | Delivered   | TN71234        | 2024-04-07   |
| 3         | Overnight Delivery   | 20.00| 8         | 1.00   | Delivered   | TN81234        | 2024-04-30   |

> 35. Retrieve a list of all employees and their corresponding payments, including cases where there are
no matches on either side
```sql
select e.*,p.* from Payment p 
INNER JOIN EmployeeCourier ec on ec.CourierID=p.CourierID
INNER JOIN Employee e on e.EmployeeID=ec.EmployeeID
```
| EmployeeID | Name    | Email               | ContactNumber | Role             | Salary   | PaymentID | CourierID | LocationID | Amount | PaymentDate |
|------------|---------|---------------------|---------------|------------------|----------|-----------|-----------|------------|--------|-------------|
| 1          | Rahul   | rahul@gmail.com    | 9187654320    | Manager          | 50000.00 | 1         | 1         | 2          | 120.00 | 2024-04-01  |
| 2          | Rihana  | rihana@gmail.com   | 9287654320    | Delivery Person  | 30000.00 | 2         | 2         | 1          | 130.00 | 2024-04-02  |
| 3          | John    | john@gmail.com     | 9387654320    | Manager          | 45000.00 | 3         | 3         | 4          | 150.00 | 2024-04-03  |
| 4          | Jessica | jessica@gmail.com  | 9487654320    | Customer Service | 32000.00 | 4         | 4         | 3          | 180.00 | 2024-04-04  |
| 5          | Surya   | surya@gmail.com    | 9587654320    | Driver           | 28000.00 | 5         | 5         | 6          | 200.00 | 2024-04-05  |
| 6          | Sanjana | sanjana@gmail.com  | 9687654320    | Customer Support | 35000.00 | 6         | 6         | 5          | 120.00 | 2024-04-06  |
| 7          | Daksh   | daksh@gmail.com    | 9787654320    | Dispatcher       | 38000.00 | 7         | 7         | 8          | 170.00 | 2024-04-07  |
| 8          | Dhanvi  | dhanvi@gmail.com   | 9887654320    | Supervisor       | 42000.00 | 8         | 8         | 7          | 160.00 | 2024-04-30  |

> 36. List all users and all courier services, showing all possible combinations.
```sql
select * from [User] cross join [CourierServices]
```
| UserID | Name    | Email            | Password | ContactNumber | Address                  | ServiceID | ServiceName          | Cost  |
|--------|---------|------------------|----------|---------------|--------------------------|-----------|----------------------|-------|
| 1      | Anika   | anika@gmail.com | password1| 9876543211    | 12 Gandhi Nagar, Delhi  | 1         | Standard Delivery    | 10.00 |
| 2      | Arjun   | arjun@gmail.com | password2| 9876543212    | 21 Main St, Ooty        | 1         | Standard Delivery    | 10.00 |
| 3      | Shivika | shivika@gmail.com| password3| 9876543213    | 34 Ganga St, Varanasi   | 1         | Standard Delivery    | 10.00 |
| 4      | Shiva   | shiva@gmail.com | password4| 9876543214    | 43 Church St, Kerala    | 1         | Standard Delivery    | 10.00 |
| 5      | Raya    | raya@gmail.com  | password5| 9876543215    | 56 Joshi Nagar, Pune    | 1         | Standard Delivery    | 10.00 |
| 6      | Ram     | ram@gmail.com   | password6| 9876543216    | 65 Indira Market, Chennai| 1        | Standard Delivery    | 10.00 |
| 7      | Vihana  | vihana@gmail.com| password7| 9876543217    | 78 Khan St, Hyderabad   | 1         | Standard Delivery    | 10.00 |
| 8      | Varun   | varun@gmail.com | password8| 9876543218    | 87 Verma Colony, Mumbai | 1         | Standard Delivery    | 10.00 |
| 1      | Anika   | anika@gmail.com | password1| 9876543211    | 12 Gandhi Nagar, Delhi  | 2         | Express Delivery     | 15.00 |
| 2      | Arjun   | arjun@gmail.com | password2| 9876543212    | 21 Main St, Ooty        | 2         | Express Delivery     | 15.00 |
| 3      | Shivika | shivika@gmail.com| password3| 9876543213    | 34 Ganga St, Varanasi   | 2         | Express Delivery     | 15.00 |
| 4      | Shiva   | shiva@gmail.com | password4| 9876543214    | 43 Church St, Kerala    | 2         | Express Delivery     | 15.00 |
| 5      | Raya    | raya@gmail.com  | password5| 9876543215    | 56 Joshi Nagar, Pune    | 2         | Express Delivery     | 15.00 |
| 6      | Ram     | ram@gmail.com   | password6| 9876543216    | 65 Indira Market, Chennai| 2        | Express Delivery     | 15.00 |
| 7      | Vihana  | vihana@gmail.com| password7| 9876543217    | 78 Khan St, Hyderabad   | 2         | Express Delivery     | 15.00 |
| 8      | Varun   | varun@gmail.com | password8| 9876543218    | 87 Verma Colony, Mumbai | 2         | Express Delivery     | 15.00 |
| 1      | Anika   | anika@gmail.com | password1| 9876543211    | 12 Gandhi Nagar, Delhi  | 3         | Overnight Delivery   | 20.00 |
| 2      | Arjun   | arjun@gmail.com | password2| 9876543212    | 21 Main St, Ooty        | 3         | Overnight Delivery   | 20.00 |
| 3      | Shivika | shivika@gmail.com| password3| 9876543213    | 34 Ganga St, Varanasi   | 3         | Overnight Delivery   | 20.00 |
| 4      | Shiva   | shiva@gmail.com | password4| 9876543214    | 43 Church St, Kerala    | 3         | Overnight Delivery   | 20.00 |
| 5      | Raya    | raya@gmail.com  | password5| 9876543215    | 56 Joshi Nagar, Pune    | 3         | Overnight Delivery   | 20.00 |
| 6      | Ram     | ram@gmail.com   | password6| 9876543216    | 65 Indira Market, Chennai| 3        | Overnight Delivery   | 20.00 |
| 7      | Vihana  | vihana@gmail.com| password7| 9876543217    | 78 Khan St, Hyderabad   | 3         | Overnight Delivery   | 20.00 |
| 8      | Varun   | varun@gmail.com | password8| 9876543218    | 87 Verma Colony, Mumbai | 3         | Overnight Delivery   | 20.00 |
| 1      | Anika   | anika@gmail.com | password1| 9876543211    | 12 Gandhi Nagar, Delhi  | 4         | International Delivery | 30.00 |
| 2      | Arjun   | arjun@gmail.com | password2| 9876543212    | 21 Main St, Ooty        | 4         | International Delivery | 30.00 |
| 3      | Shivika | shivika@gmail.com| password3| 9876543213    | 34 Ganga St, Varanasi   | 4         | International Delivery | 30.00 |
| 4      | Shiva   | shiva@gmail.com | password4| 9876543214    | 43 Church St, Kerala    | 4         | International Delivery | 30.00 |
| 5      | Raya    | raya@gmail.com  | password5| 9876543215    | 56 Joshi Nagar, Pune    | 4         | International Delivery | 30.00 |
| 6      | Ram     | ram@gmail.com   | password6| 9876543216    | 65 Indira Market, Chennai| 4        | International Delivery | 30.00 |
| 7      | Vihana  | vihana@gmail.com| password7| 9876543217    | 78 Khan St, Hyderabad   | 4         | International Delivery | 30.00 |
| 8      | Varun   | varun@gmail.com | password8| 9876543218    | 87 Verma Colony, Mumbai | 4         | International Delivery | 30.00 |
| 1      | Anika   | anika@gmail.com | password1| 9876543211    | 12 Gandhi Nagar, Delhi  | 5         | Same-Day Delivery    | 25.00 |
| 2      | Arjun   | arjun@gmail.com | password2| 9876543212    | 21 Main St, Ooty        | 5         | Same-Day Delivery    | 25.00 |
| 3      | Shivika | shivika@gmail.com| password3| 9876543213    | 34 Ganga St, Varanasi   | 5         | Same-Day Delivery    | 25.00 |
| 4      | Shiva   | shiva@gmail.com | password4| 9876543214    | 43 Church St, Kerala    | 5         | Same-Day Delivery    | 25.00 |
| 5      | Raya    | raya@gmail.com  | password5| 9876543215    | 56 Joshi Nagar, Pune    | 5         | Same-Day Delivery    | 25.00 |
| 6      | Ram     | ram@gmail.com   | password6| 9876543216    | 65 Indira Market, Chennai| 5        | Same-Day Delivery    | 25.00 |
| 7      | Vihana  | vihana@gmail.com| password7| 9876543217    | 78 Khan St, Hyderabad   | 5         | Same-Day Delivery    | 25.00 |
| 8      | Varun   | varun@gmail.com | password8| 9876543218    | 87 Verma Colony, Mumbai | 5         | Same-Day Delivery    | 25.00 |


> 37. List all employees and all locations, showing all possible combinations:
```sql
select * from [Employee] cross join [Location]
```
| EmployeeID | Name    | Email            | ContactNumber | Role              | Salary   | LocationID | LocationName | Address                  |
|------------|---------|------------------|---------------|-------------------|----------|------------|--------------|--------------------------|
| 1          | Rahul   | rahul@gmail.com | 9187654320    | Manager           | 50000.00 | 1          | Delhi        | 12 Gandhi Nagar,Delhi   |
| 2          | Rihana  | rihana@gmail.com| 9287654320    | Delivery Person   | 30000.00 | 1          | Delhi        | 12 Gandhi Nagar,Delhi   |
| 3          | John    | john@gmail.com  | 9387654320    | Warehouse Manager| 45000.00 | 1          | Delhi        | 12 Gandhi Nagar,Delhi   |
| 4          | Jessica | jessica@gmail.com| 9487654320   | Customer Service  | 32000.00 | 1          | Delhi        | 12 Gandhi Nagar,Delhi   |
| 5          | Surya   | surya@gmail.com | 9587654320    | Driver            | 28000.00 | 1          | Delhi        | 12 Gandhi Nagar,Delhi   |
| 6          | Sanjana | sanjana@gmail.com| 9687654320   | Customer Support  | 35000.00 | 1          | Delhi        | 12 Gandhi Nagar,Delhi   |
| 7          | Daksh   | daksh@gmail.com | 9787654320    | Dispatcher        | 38000.00 | 1          | Delhi        | 12 Gandhi Nagar,Delhi   |
| 8          | Dhanvi  | dhanvi@gmail.com| 9887654320    | Supervisor        | 42000.00 | 1          | Delhi        | 12 Gandhi Nagar,Delhi   |
| 1          | Rahul   | rahul@gmail.com | 9187654320    | Manager           | 50000.00 | 2          | Ooty         | 21 Main St,Ooty          |
| 2          | Rihana  | rihana@gmail.com| 9287654320    | Delivery Person   | 30000.00 | 2          | Ooty         | 21 Main St,Ooty          |
| 3          | John    | john@gmail.com  | 9387654320    | Warehouse Manager| 45000.00 | 2          | Ooty         | 21 Main St,Ooty          |
| 4          | Jessica | jessica@gmail.com| 9487654320   | Customer Service  | 32000.00 | 2          | Ooty         | 21 Main St,Ooty          |
| 5          | Surya   | surya@gmail.com | 9587654320    | Driver            | 28000.00 | 2          | Ooty         | 21 Main St,Ooty          |
| 6          | Sanjana | sanjana@gmail.com| 9687654320   | Customer Support  | 35000.00 | 2          | Ooty         | 21 Main St,Ooty          |
| 7          | Daksh   | daksh@gmail.com | 9787654320    | Dispatcher        | 38000.00 | 2          | Ooty         | 21 Main St,Ooty          |
| 8          | Dhanvi  | dhanvi@gmail.com| 9887654320    | Supervisor        | 42000.00 | 2          | Ooty         | 21 Main St,Ooty          |
| 1          | Rahul   | rahul@gmail.com | 9187654320    | Manager           | 50000.00 | 3          | Varanasi     | 34 Ganga St,Varanasi     |
| 2          | Rihana  | rihana@gmail.com| 9287654320    | Delivery Person   | 30000.00 | 3          | Varanasi     | 34 Ganga St,Varanasi     |
| 3          | John    | john@gmail.com  | 9387654320    | Warehouse Manager| 45000.00 | 3          | Varanasi     | 34 Ganga St,Varanasi     |
| 4          | Jessica | jessica@gmail.com| 9487654320   | Customer Service  | 32000.00 | 3          | Varanasi     | 34 Ganga St,Varanasi     |
| 5          | Surya   | surya@gmail.com | 9587654320    | Driver            | 28000.00 | 3          | Varanasi     | 34 Ganga St,Varanasi     |
| 6          | Sanjana | sanjana@gmail.com| 9687654320   | Customer Support  | 35000.00 | 3          | Varanasi     | 34 Ganga St,Varanasi     |
| 7          | Daksh   | daksh@gmail.com | 9787654320    | Dispatcher        | 38000.00 | 3          | Varanasi     | 34 Ganga St,Varanasi     |
| 8          | Dhanvi  | dhanvi@gmail.com| 9887654320    | Supervisor        | 42000.00 | 3          | Varanasi     | 34 Ganga St,Varanasi     |
| 1          | Rahul   | rahul@gmail.com | 9187654320    | Manager           | 50000.00 | 4          | Kerala       | 43 Church St,Kerala      |
| 2          | Rihana  | rihana@gmail.com| 9287654320    | Delivery Person   | 30000.00 | 4          | Kerala       | 43 Church St,Kerala      |
| 3          | John    | john@gmail.com  | 9387654320    | Warehouse Manager| 45000.00 | 4          | Kerala       | 43 Church St,Kerala      |
| 4          | Jessica | jessica@gmail.com| 9487654320   | Customer Service  | 32000.00 | 4          | Kerala       | 43 Church St,Kerala      |
| 5          | Surya   | surya@gmail.com | 9587654320    | Driver            | 28000.00 | 4          | Kerala       | 43 Church St,Kerala      |
| 6          | Sanjana | sanjana@gmail.com| 9687654320   | Customer Support  | 35000.00 | 4          | Kerala       | 43 Church St,Kerala      |
| 7          | Daksh   | daksh@gmail.com | 9787654320    | Dispatcher        | 38000.00 | 4          | Kerala       | 43 Church St,Kerala      |
| 8          | Dhanvi  | dhanvi@gmail.com| 9887654320    | Supervisor        | 42000.00 | 4          | Kerala       | 43 Church St,Kerala      |
| 1          | Rahul   | rahul@gmail.com | 9187654320    | Manager           | 50000.00 | 5          | Pune         | 56 Joshi Nagar,Pune      |
| 2          | Rihana  | rihana@gmail.com| 9287654320    | Delivery Person   | 30000.00 | 5          | Pune         | 56 Joshi Nagar,Pune      |
| 3          | John    | john@gmail.com  | 9387654320    | Warehouse Manager| 45000.00 | 5          | Pune         | 56 Joshi Nagar,Pune      |
| 4          | Jessica | jessica@gmail.com| 9487654320   | Customer Service  | 32000.00 | 5          | Pune         | 56 Joshi Nagar,Pune      |
| 5          | Surya   | surya@gmail.com | 9587654320    | Driver            | 28000.00 | 5          | Pune         | 56 Joshi Nagar,Pune      |
| 6          | Sanjana | sanjana@gmail.com| 9687654320   | Customer Support  | 35000.00 | 5          | Pune         | 56 Joshi Nagar,Pune      |
| 7          | Daksh   | daksh@gmail.com | 9787654320    | Dispatcher        | 38000.00 | 5          | Pune         | 56 Joshi Nagar,Pune      |
| 8          | Dhanvi  | dhanvi@gmail.com| 9887654320    | Supervisor        | 42000.00 | 5          | Pune         | 56 Joshi Nagar,Pune      |
| 1          | Rahul   | rahul@gmail.com | 9187654320    | Manager           | 50000.00 | 6          | Chennai      | 65 Khan,Chennai          |
| 2          | Rihana  | rihana@gmail.com| 9287654320    | Delivery Person   | 30000.00 | 6          | Chennai      | 65 Khan,Chennai          |
| 3          | John    | john@gmail.com  | 9387654320    | Warehouse Manager| 45000.00 | 6          | Chennai      | 65 Khan,Chennai          |
| 4          | Jessica | jessica@gmail.com| 9487654320   | Customer Service  | 32000.00 | 6          | Chennai      | 65 Khan,Chennai          |
| 5          | Surya   | surya@gmail.com | 9587654320    | Driver            | 28000.00 | 6          | Chennai      | 65 Khan,Chennai          |
| 6          | Sanjana | sanjana@gmail.com| 9687654320   | Customer Support  | 35000.00 | 6          | Chennai      | 65 Khan,Chennai          |
| 7          | Daksh   | daksh@gmail.com | 9787654320    | Dispatcher        | 38000.00 | 6          | Chennai      | 65 Khan,Chennai          |
| 8          | Dhanvi  | dhanvi@gmail.com| 9887654320    | Supervisor        | 42000.00 | 6          | Chennai      | 65 Khan,Chennai          |
| 1          | Rahul   | rahul@gmail.com | 9187654320    | Manager           | 50000.00 | 7          | Hyderabad    | 78 Khan St,Hyderabad     |
| 2          | Rihana  | rihana@gmail.com| 9287654320    | Delivery Person   | 30000.00 | 7          | Hyderabad    | 78 Khan St,Hyderabad     |
| 3          | John    | john@gmail.com  | 9387654320    | Warehouse Manager| 45000.00 | 7          | Hyderabad    | 78 Khan St,Hyderabad     |
| 4          | Jessica | jessica@gmail.com| 9487654320   | Customer Service  | 32000.00 | 7          | Hyderabad    | 78 Khan St,Hyderabad     |
| 5          | Surya   | surya@gmail.com | 9587654320    | Driver            | 28000.00 | 7          | Hyderabad    | 78 Khan St,Hyderabad     |
| 6          | Sanjana | sanjana@gmail.com| 9687654320   | Customer Support  | 35000.00 | 7          | Hyderabad    | 78 Khan St,Hyderabad     |
| 7          | Daksh   | daksh@gmail.com | 9787654320    | Dispatcher        | 38000.00 | 7          | Hyderabad    | 78 Khan St,Hyderabad     |
| 8          | Dhanvi  | dhanvi@gmail.com| 9887654320    | Supervisor        | 42000.00 | 7          | Hyderabad    | 78 Khan St,Hyderabad     |
| 1          | Rahul   | rahul@gmail.com | 9187654320    | Manager           | 50000.00 | 8          | Mumbai       | 87 Verma Colony,Mumbai   |
| 2          | Rihana  | rihana@gmail.com| 9287654320    | Delivery Person   | 30000.00 | 8          | Mumbai       | 87 Verma Colony,Mumbai   |
| 3          | John    | john@gmail.com  | 9387654320    | Warehouse Manager| 45000.00 | 8          | Mumbai       | 87 Verma Colony,Mumbai   |
| 4          | Jessica | jessica@gmail.com| 9487654320   | Customer Service  | 32000.00 | 8          | Mumbai       | 87 Verma Colony,Mumbai   |
| 5          | Surya   | surya@gmail.com | 9587654320    | Driver            | 28000.00 | 8          | Mumbai       | 87 Verma Colony,Mumbai   |
| 6          | Sanjana | sanjana@gmail.com| 9687654320   | Customer Support  | 35000.00 | 8          | Mumbai       | 87 Verma Colony,Mumbai   |
| 7          | Daksh   | daksh@gmail.com | 9787654320    | Dispatcher        | 38000.00 | 8          | Mumbai       | 87 Verma Colony,Mumbai   |
| 8          | Dhanvi  | dhanvi@gmail.com| 9887654320    | Supervisor        | 42000.00 | 8          | Mumbai       | 87 Verma Colony,Mumbai   |


> 38. Retrieve a list of couriers and their corresponding sender information (if available)
```sql
Select c.CourierID,c.SenderName,u.* from [User] u join Courier c on u.[Name]=c.SenderName
```
| CourierID | SenderName | UserID | Name   | Email            | Password | ContactNumber | Address                |
|-----------|------------|--------|--------|------------------|----------|---------------|------------------------|
| 1         | Anika      | 1      | Anika  | anika@gmail.com | password1| 9876543211    | 12 Gandhi Nagar, Delhi|
| 3         | Arjun      | 2      | Arjun  | arjun@gmail.com | password2| 9876543212    | 21 Main St, Ooty       |
| 2         | Shivika    | 3      | Shivika| shivika@gmail.com| password3| 9876543213    | 34 Ganga St, Varanasi |
| 4         | Shiva      | 4      | Shiva  | shiva@gmail.com  | password4| 9876543214    | 43 Church St, Kerala   |
| 6         | Raya       | 5      | Raya   | raya@gmail.com   | password5| 9876543215    | 56 Joshi Nagar, Pune   |
| 5         | Ram        | 6      | Ram    | ram@gmail.com    | password6| 9876543216    | 65 Indira Market, Chennai |
| 7         | Vihana     | 7      | Vihana | vihana@gmail.com | password7| 9876543217    | 78 Khan St, Hyderabad  |
| 8         | Varun      | 8      | Varun  | varun@gmail.com  | password8| 9876543218    | 87 Verma Colony, Mumbai|

> 39. Retrieve a list of couriers and their corresponding receiver information (if available):
```sql
Select c.CourierID,c.ReceiverName,u.* from [User] u join Courier c on u.[Name]=c.ReceiverName
```
| CourierID | ReceiverName | UserID | Name   | Email            | Password | ContactNumber | Address                |
|-----------|--------------|--------|--------|------------------|----------|---------------|------------------------|
| 2         | Anika        | 1      | Anika  | anika@gmail.com | password1| 9876543211    | 12 Gandhi Nagar, Delhi|
| 1         | Arjun        | 2      | Arjun  | arjun@gmail.com | password2| 9876543212    | 21 Main St, Ooty       |
| 3         | Shivika      | 3      | Shivika| shivika@gmail.com| password3| 9876543213    | 34 Ganga St, Varanasi |
| 8         | Shiva        | 4      | Shiva  | shiva@gmail.com  | password4| 9876543214    | 43 Church St, Kerala   |
| 4         | Raya         | 5      | Raya   | raya@gmail.com   | password5| 9876543215    | 56 Joshi Nagar, Pune   |
| 7         | Ram          | 6      | Ram    | ram@gmail.com    | password6| 9876543216    | 65 Indira Market, Chennai |
| 5         | Vihana       | 7      | Vihana | vihana@gmail.com | password7| 9876543217    | 78 Khan St, Hyderabad  |
| 6         | Varun        | 8      | Varun  | varun@gmail.com  | password8| 9876543218    | 87 Verma Colony, Mumbai|


> 40. Retrieve a list of couriers along with the courier service details (if available):
```sql
select c.* ,csm.ServiceID,cs.ServiceName,cs.Cost from Courier c 
JOIN CourierServiceMapping csm on c.CourierID=csm.CourierID
JOIN CourierServices cs on csm.ServiceID=cs.ServiceID
```
| CourierID | UserID | SenderName | SenderAddress              | ReceiverName | ReceiverAddress           | Weight | Status      | TrackingNumber | DeliveryDate | ServiceID | ServiceName         | Cost |
|-----------|--------|------------|----------------------------|--------------|---------------------------|--------|-------------|----------------|--------------|-----------|---------------------|------|
| 1         | 1      | Anika      | 12 Gandhi Nagar,Delhi      | Arjun        | 21 Main St,Ooty           | 2.50   | In Transit  | TN11234        | 2024-04-01   | 1         | Standard Delivery   | 10.00|
| 2         | 3      | Shivika    | 34 Ganga St,Varanasi      | Anika        | 12 Gandhi Nagar,Delhi     | 3.00   | Delivered   | TN21234        | 2024-04-02   | 2         | Express Delivery    | 15.00|
| 3         | 2      | Arjun      | 21 Main St,Ooty           | Shivika      | 34 Ganga St,Varanasi      | 1.50   | In Transit  | TN31234        | 2024-04-03   | 3         | Overnight Delivery  | 20.00|
| 4         | 4      | Shiva      | 43 Church St,Kerala        | Raya         | 56 Joshi Nagar,Pune       | 2.00   | In Transit  | TN41234        | 2024-04-04   | 4         | International Delivery | 30.00|
| 5         | 6      | Ram        | 65 Indira Market,Chennai  | Vihana       | 78 Khan St,Hyderabad      | 4.50   | Delivered   | TN51234        | 2024-04-05   | 5         | Same-Day Delivery   | 25.00|
| 6         | 5      | Raya       | 56 Joshi Nagar,Pune       | Varun        | 87 Verma Colony,Mumbai    | 4.00   | In Transit  | TN61234        | 2024-04-06   | 1         | Standard Delivery   | 10.00|
| 7         | 7      | Vihana     | 78 Khan St,Hyderabad      | Ram          | 65 Indira Market,Chennai | 3.50   | Delivered   | TN71234        | 2024-04-07   | 2         | Express Delivery    | 15.00|
| 8         | 8      | Varun      | 87 Verma Colony,Mumbai    | Shiva        | 43 Church St,Kerala       | 1.00   | Delivered   | TN81234        | 2024-04-30   | 3         | Overnight Delivery  | 20.00|

> 41. Retrieve a list of employees and the number of couriers assigned to each employee:
```sql
select e.EmployeeID,e.[Name],count(ec.CourierID) as TotalCount 
from Employee e JOIN EmployeeCourier ec on e.EmployeeID=ec.EmployeeID 
group by e.EmployeeID,e.[Name]
```
| EmployeeID | Name    | TotalCount |
|------------|---------|------------|
| 1          | Rahul   | 1          |
| 2          | Rihana  | 1          |
| 3          | John    | 1          |
| 4          | Jessica | 1          |
| 5          | Surya   | 1          |
| 6          | Sanjana | 1          |
| 7          | Daksh   | 1          |
| 8          | Dhanvi  | 1          |

> 42. Retrieve a list of locations and the total payment amount received at each location:
```sql
select l.LocationID,l.LocationName,sum(p.Amount) as TotalPayment from Payment p JOIN [Location] l on p.LocationID=l.LocationID group by l.LocationID,l.LocationName
```
| LocationID | LocationName | TotalPayment |
|------------|--------------|--------------|
| 1          | Delhi        | 130.00       |
| 2          | Ooty         | 120.00       |
| 3          | Varanasi     | 180.00       |
| 4          | Kerala       | 150.00       |
| 5          | Pune         | 120.00       |
| 6          | Chennai      | 200.00       |
| 7          | Hyderabad    | 160.00       |
| 8          | Mumbai       | 170.00       |

> 43. Retrieve all couriers sent by the same sender (based on SenderName).
```sql
select * from Courier 
where SenderName in (Select SenderName 
                     from Courier 
					 group by SenderName
					 having count(CourierID)>1);
```
| CourierID | UserID | SenderName | SenderAddress          | ReceiverName | ReceiverAddress        | Weight | Status      | TrackingNumber | DeliveryDate |
|-----------|--------|------------|------------------------|--------------|------------------------|--------|-------------|----------------|--------------|
| 1         | 1      | Anika      | 12 Gandhi Nagar,Delhi | Arjun        | 21 Main St,Ooty        | 2.50   | In Transit  | TN11234        | 2024-04-01   |
| 9         | 1      | Anika      | 12 Gandhi Nagar,Delhi | Varun        | 87 Verma Colony,Mumbai | 2.50   | In Transit  | TN91234        | 2024-04-29   |

> 44. List all employees who share the same role.
```sql
select * from [Employee]
where [Role] in (Select [Role] 
                     from [Employee]
					 group by [Role]
					 having count(EmployeeID)>1);
```
| EmployeeID | Name  | Email             | ContactNumber | Role     | Salary    |
|------------|-------|-------------------|---------------|----------|-----------|
| 1          | Rahul | rahul@gmail.com  | 9187654320    | Manager  | 50000.00  |
| 3          | John  | john@gmail.com   | 9387654320    | Manager  | 45000.00  |

> 45. Retrieve all payments made for couriers sent from the same location.
```sql
select p1.* from Payment p1 
INNER JOIN Payment p2 on p1.LocationID=p2.LocationID and p1.PaymentID!=p2.PaymentID
```
| PaymentID | CourierID | LocationID | Amount | PaymentDate |
|-----------|-----------|------------|--------|--------------|
| 2         | 2         | 1          | 130.00 | 2024-04-02   |
| 9         | 9         | 1          | 250.00 | 2024-04-29   |

> 46. Retrieve all couriers sent from the same location (based on SenderAddress).
```sql
select c1.* from Courier c1 
INNER JOIN Courier c2 on c1.UserID=c2.UserID and c1.CourierID!=c2.CourierID
```
| CourierID | UserID | SenderName | SenderAddress          | ReceiverName | ReceiverAddress         | Weight | Status     | TrackingNumber | DeliveryDate |
|-----------|--------|------------|------------------------|--------------|-------------------------|--------|------------|----------------|--------------|
| 1         | 1      | Anika      | 12 Gandhi Nagar,Delhi | Arjun        | 21 Main St,Ooty         | 2.50   | In Transit | TN11234        | 2024-04-01   |
| 9         | 1      | Anika      | 12 Gandhi Nagar,Delhi | Varun        | 87 Verma Colony,Mumbai  | 2.50   | In Transit | TN91234        | 2024-04-29   |

> 47. List employees and the number of couriers they have delivered:
```sql
select e.EmployeeID,e.[Name],count(ec.CourierID) as TotalCount,c.[Status] 
from Employee e 
JOIN EmployeeCourier ec on e.EmployeeID=ec.EmployeeID 
JOIN Courier c on ec.CourierID=c.CourierID
where c.Status='Delivered'
group by e.EmployeeID,e.[Name],c.[Status]
```
| EmployeeID | Name   | TotalCount | Status    |
|------------|--------|------------|-----------|
| 2          | Rihana | 1          | Delivered |
| 5          | Surya  | 1          | Delivered |
| 7          | Daksh  | 1          | Delivered |
| 8          | Dhanvi | 1          | Delivered |

> 48. Find couriers that were paid an amount greater than the cost of their respective courier services 
```sql
select p.CourierID,p.Amount,c.Cost from Payment p 
inner join CourierServiceMapping csm on p.CourierID=csm.CourierID
inner join CourierServices c on csm.ServiceID = c.ServiceID 
where Amount>Cost;
```
| CourierID | Amount | Cost  |
|-----------|--------|-------|
| 1         | 120.00 | 10.00 |
| 2         | 130.00 | 15.00 |
| 3         | 150.00 | 20.00 |
| 4         | 180.00 | 30.00 |
| 5         | 200.00 | 25.00 |
| 6         | 120.00 | 10.00 |
| 7         | 170.00 | 15.00 |
| 8         | 160.00 | 20.00 |

<h3>Scope: Inner Queries, Non Equi Joins, Equi joins,Exist,Any,All</h3>
<br>

> 49. Find couriers that have a weight greater than the average weight of all couriers
```sql
select * from Courier where [Weight] > (select avg([Weight]) from Courier)
```
| CourierID | UserID | SenderName | SenderAddress          | ReceiverName | ReceiverAddress       | Weight | Status       | TrackingNumber | DeliveryDate |
|-----------|--------|------------|------------------------|--------------|-----------------------|--------|--------------|----------------|--------------|
| 2         | 3      | Shivika    | 34 Ganga St,Varanasi   | Anika        | 12 Gandhi Nagar,Delhi | 3.00   | Delivered    | TN21234        | 2024-04-02   |
| 5         | 6      | Ram        | 65 Indira Market,Chennai | Vihana     | 78 Khan St,Hyderabad | 4.50   | Delivered    | TN51234        | 2024-04-05   |
| 6         | 5      | Raya       | 56 Joshi Nagar,Pune    | Varun        | 87 Verma Colony,Mumbai| 4.00   | In Transit   | TN61234        | 2024-04-06   |
| 7         | 7      | Vihana     | 78 Khan St,Hyderabad   | Ram          | 65 Indira Market,Chennai | 3.50 | Delivered    | TN71234        | 2024-04-07   |

>50. Find the names of all employees who have a salary greater than the average salary:
```sql
select [Name] from Employee where Salary > (select avg(Salary) from Employee);
```
| Name   |
|--------|
| Rahul  |
| John   |
| Daksh  |
| Dhanvi |

> 51. Find the total cost of all courier services where the cost is less than the maximum cost
```sql
select ServiceID,ServiceName,sum(Cost) as total_cost from CourierServices where Cost<(select max(Cost) from CourierServices) group by ServiceID,ServiceName
```
| ServiceID |   ServiceName    | total_cost |
|-----------|------------------|------------|
|     1     | Standard Delivery|   10.00   |
|     2     | Express Delivery |   15.00   |
|     3     | Overnight Delivery|   20.00   |
|     5     | Same-Day Delivery|   25.00   |

> 52. Find all couriers that have been paid for
```sql
Select * from Payment where Amount>0;
```
| PaymentID | CourierID | LocationID | Amount | PaymentDate |
|-----------|-----------|------------|--------|-------------|
| 1         | 1         | 2          | 120.00 | 2024-04-01  |
| 2         | 2         | 1          | 130.00 | 2024-04-02  |
| 3         | 3         | 4          | 150.00 | 2024-04-03  |
| 4         | 4         | 3          | 180.00 | 2024-04-04  |
| 5         | 5         | 6          | 200.00 | 2024-04-05  |
| 6         | 6         | 5          | 120.00 | 2024-04-06  |
| 7         | 7         | 8          | 170.00 | 2024-04-07  |
| 8         | 8         | 7          | 160.00 | 2024-04-30  |
| 9         | 9         | 1          | 250.00 | 2024-04-29  |

> 53. Find the locations where the maximum payment amount was made
```sql
select * from Payment where Amount = (Select MAX(Amount) from Payment)
```
| PaymentID | CourierID | LocationID | Amount | PaymentDate |
|-----------|-----------|------------|--------|-------------|
| 9         | 9         | 1          | 250.00 | 2024-04-29  |

> 54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender
(e.g., 'SenderName'): 
```sql
select * from Courier where [Weight] > all(select [Weight] from Courier where SenderName = 'Shivika')
```
| CourierID | UserID | SenderName | SenderAddress         | ReceiverName | ReceiverAddress      | Weight | Status      | TrackingNumber | DeliveryDate |
|-----------|--------|------------|-----------------------|--------------|----------------------|--------|-------------|----------------|--------------|
| 5         | 6      | Ram        | 65 Indira Market,Chennai | Vihana      | 78 Khan St,Hyderabad| 4.50   | Delivered   | TN51234        | 2024-04-05   |
| 6         | 5      | Raya       | 56 Joshi Nagar,Pune   | Varun        | 87 Verma Colony,Mumbai| 4.00  | In Transit  | TN61234        | 2024-04-06   |
| 7         | 7      | Vihana     | 78 Khan St,Hyderabad | Ram          | 65 Indira Market,Chennai| 3.50 | Delivered   | TN71234        | 2024-04-07   |
