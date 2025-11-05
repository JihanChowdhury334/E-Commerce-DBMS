#!/bin/sh
sqlplus64 "cs_username/cs_password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
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

exit;
EOF

echo "-------------------------------------------"
echo "Tables created successfully."
echo "Press Enter to return to the menu..."
read
