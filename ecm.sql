-- All sql for dbms

------------------------------------------------------------
-- DROP TABLES
------------------------------------------------------------
DROP TABLE RETURNREQUEST CASCADE CONSTRAINTS;
DROP TABLE REVIEW CASCADE CONSTRAINTS;
DROP TABLE REPORT CASCADE CONSTRAINTS;
DROP TABLE PAYMENT CASCADE CONSTRAINTS;
DROP TABLE ORDER_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE STAFF CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;

------------------------------------------------------------
-- CREATE TABLES
------------------------------------------------------------
CREATE TABLE Users (
    UserID     NUMBER PRIMARY KEY,
    FirstName  VARCHAR2(50) NOT NULL,
    LastName   VARCHAR2(50) NOT NULL,
    Email      VARCHAR2(100) UNIQUE NOT NULL,
    Phone      VARCHAR2(15),
    Role       VARCHAR2(20) CHECK (Role IN ('Student','Staff'))
);

CREATE TABLE Staff (
    StaffID    NUMBER PRIMARY KEY,
    Department VARCHAR2(50) NOT NULL,
    Position   VARCHAR2(50),
    HireDate   DATE DEFAULT SYSDATE,
    Salary     NUMBER(10,2) CHECK (Salary >= 0),
    CONSTRAINT fk_staff_user FOREIGN KEY (StaffID) REFERENCES Users(UserID)
);

CREATE TABLE Student (
    StudentID  NUMBER PRIMARY KEY,
    Major      VARCHAR2(50),
    YearLevel  NUMBER(1) CHECK (YearLevel BETWEEN 1 AND 5),
    GPA        NUMBER(3,2) CHECK (GPA BETWEEN 0 AND 4),
    CONSTRAINT fk_student_user FOREIGN KEY (StudentID) REFERENCES Users(UserID)
);

CREATE TABLE Product (
    ProductID     NUMBER PRIMARY KEY,
    Name          VARCHAR2(100) NOT NULL,
    Description   VARCHAR2(255),
    Price         NUMBER(10,2) CHECK (Price > 0),
    StockQuantity NUMBER CHECK (StockQuantity >= 0)
);

CREATE TABLE Orders (
    OrderID   NUMBER PRIMARY KEY,
    UserID    NUMBER NOT NULL,
    OrderDate DATE DEFAULT SYSDATE,
    Status    VARCHAR2(20) CHECK (Status IN ('Pending','Completed','Cancelled')),
    CONSTRAINT fk_orders_user FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Order_Product (
    OrderID   NUMBER NOT NULL,
    ProductID NUMBER NOT NULL,
    Quantity  NUMBER NOT NULL CHECK (Quantity > 0),
    CONSTRAINT pk_order_product PRIMARY KEY (OrderID, ProductID),
    CONSTRAINT fk_op_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT fk_op_product FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Payment (
    PaymentID     NUMBER PRIMARY KEY,
    OrderID       NUMBER NOT NULL,
    Amount        NUMBER(10,2) NOT NULL CHECK (Amount > 0),
    PaymentDate   DATE DEFAULT SYSDATE,
    PaymentMethod VARCHAR2(20) CHECK (PaymentMethod IN ('Credit Card','Debit Card','Cash')),
    CONSTRAINT fk_payment_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Report (
    ReportID      NUMBER PRIMARY KEY,
    StaffID       NUMBER NOT NULL,
    ReportType    VARCHAR2(50) NOT NULL,
    GeneratedDate DATE DEFAULT SYSDATE,
    CONSTRAINT fk_report_staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Review (
    ReviewID   NUMBER PRIMARY KEY,
    UserID     NUMBER NOT NULL,
    ProductID  NUMBER NOT NULL,
    Rating     NUMBER CHECK (Rating BETWEEN 1 AND 5),
    ReviewComment VARCHAR2(255),
    ReviewDate DATE DEFAULT SYSDATE,
    CONSTRAINT fk_review_user FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT fk_review_product FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE ReturnRequest (
    ReturnID    NUMBER PRIMARY KEY,
    OrderID     NUMBER NOT NULL,
    ProductID   NUMBER NOT NULL,
    RequestDate DATE DEFAULT SYSDATE,
    Status      VARCHAR2(20) CHECK (Status IN ('Pending','Approved','Rejected')),
    CONSTRAINT fk_return_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT fk_return_product FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

------------------------------------------------------------
-- INSERT DATA
------------------------------------------------------------
INSERT INTO Users VALUES (1,'Eshwar','Vetrichelvan','evetrichelvan@torontomu.ca','501111111','Student');
INSERT INTO Users VALUES (2,'Ashwin','Jakanathan','ajakanathan@torontomu.ca','501222222','Student');
INSERT INTO Users VALUES (3,'Jihan','Chowdury','jchowdury@torontomu.ca','501333333','Student');
INSERT INTO Users VALUES (4,'Clara','Lee','clee@torontomu.ca','416444444','Staff');
INSERT INTO Users VALUES (5,'David','Wong','dwong@torontomu.ca','416555555','Staff');
INSERT INTO Users VALUES (6,'Jassar','Surinder','jsurinder@torontomu.ca','416666666','Staff');

INSERT INTO Staff VALUES (4,'IT Services','Technician',DATE '2022-01-15',60000);
INSERT INTO Staff VALUES (5,'Admin','Manager',DATE '2021-06-01',75000);
INSERT INTO Staff VALUES (6,'Admin','Professor',DATE '2023-04-12',75000);

INSERT INTO Student VALUES (1,'Computer Engineering',3,3.2);
INSERT INTO Student VALUES (2,'Computer Engineering',2,3.2);
INSERT INTO Student VALUES (3,'Computer Engineering',3,3.2);

INSERT INTO Product VALUES (101,'Database Textbook','Intro to Oracle SQL',79.99,10);
INSERT INTO Product VALUES (102,'Laptop','14-inch lightweight laptop',899.99,5);
INSERT INTO Product VALUES (103,'Headphones','Noise-cancelling wireless headphones',199.99,15);

INSERT INTO Orders VALUES (5001,1,SYSDATE-7,'Completed');
INSERT INTO Orders VALUES (5002,2,SYSDATE-3,'Completed');

INSERT INTO Order_Product VALUES (5001,101,2);
INSERT INTO Order_Product VALUES (5001,103,1);
INSERT INTO Order_Product VALUES (5002,102,1);

INSERT INTO Payment VALUES (9001,5001,359.97,SYSDATE-6,'Credit Card');
INSERT INTO Payment VALUES (9002,5002,899.99,SYSDATE-2,'Debit Card');

INSERT INTO Report VALUES (7001,4,'Sales Report',SYSDATE-1);
INSERT INTO Report VALUES (7002,5,'User Activity Report',SYSDATE-2);

INSERT INTO Review VALUES (8001,1,101,5,'Great textbook for SQL learning!',SYSDATE-5);
INSERT INTO Review VALUES (8002,2,102,4,'Good laptop, battery health is okay.',SYSDATE-2);
INSERT INTO Review VALUES (8003,1,103,5,'Headphones have clear audio.',SYSDATE-1);

INSERT INTO ReturnRequest VALUES (6001,5001,103,SYSDATE,'Pending');

------------------------------------------------------------
-- CREATE VIEWS
------------------------------------------------------------
CREATE OR REPLACE VIEW Staff_Report_Summary AS
SELECT s.StaffID,
       u.FirstName||' '||u.LastName AS StaffName,
       COUNT(r.ReportID) AS ReportCount,
       MAX(r.GeneratedDate) AS LastGenerated
FROM Staff s
JOIN Users u ON s.StaffID=u.UserID
LEFT JOIN Report r ON s.StaffID=r.StaffID
GROUP BY s.StaffID,u.FirstName,u.LastName;

CREATE OR REPLACE VIEW VW_TOP_RATED_PRODUCTS AS
SELECT p.ProductID,p.Name AS ProductName,AVG(r.Rating) AS AvgRating,COUNT(r.ReviewID) AS ReviewCount
FROM Product p JOIN Review r ON p.ProductID=r.ProductID
GROUP BY p.ProductID,p.Name
ORDER BY AvgRating DESC;

CREATE OR REPLACE VIEW VW_SALES_SUMMARY AS
SELECT p.ProductID,p.Name AS ProductName,SUM(op.Quantity) AS TotalUnitsSold,
       SUM(op.Quantity*p.Price) AS TotalRevenue
FROM Product p JOIN Order_Product op ON p.ProductID=op.ProductID
GROUP BY p.ProductID,p.Name
ORDER BY TotalRevenue DESC;

------------------------------------------------------------
-- ADVANCED QUERIES
------------------------------------------------------------
-- High-earning departments
SELECT Department, SUM(Salary) AS TotalSalary
FROM Staff
GROUP BY Department
HAVING SUM(Salary) > 60000;

-- Students with completed orders
SELECT s.StudentID, u.FirstName || ' ' || u.LastName AS StudentName
FROM Student s
JOIN Users u ON s.StudentID = u.UserID
WHERE EXISTS (
    SELECT 1 FROM Orders o
    WHERE o.UserID = s.StudentID AND o.Status = 'Completed'
);

-- Products never reviewed
SELECT Name AS UnreviewedProduct
FROM Product
MINUS
SELECT DISTINCT p.Name
FROM Product p JOIN Review r ON p.ProductID = r.ProductID;

-- Staff + Students list
SELECT u.FirstName || ' ' || u.LastName AS Name, 'Staff' AS Role
FROM Users u WHERE Role = 'Staff'
UNION
SELECT u.FirstName || ' ' || u.LastName AS Name, 'Student' AS Role
FROM Users u WHERE Role = 'Student';

-- Top product by revenue
SELECT p.Name AS ProductName,
       SUM(op.Quantity) AS UnitsSold,
       COUNT(op.OrderID) AS TotalOrders,
       SUM(op.Quantity * p.Price) AS TotalRevenue
FROM Product p
JOIN Order_Product op ON p.ProductID = op.ProductID
GROUP BY p.Name
ORDER BY TotalRevenue DESC;
