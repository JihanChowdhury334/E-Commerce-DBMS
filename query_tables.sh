#!/bin/sh
sqlplus64 "cs_username/cs_password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
SET LINESIZE 200;
SET PAGESIZE 50;

PROMPT ==== STAFF REPORT SUMMARY ====
SELECT * FROM STAFF_REPORT_SUMMARY;

PROMPT ==== TOP RATED PRODUCTS ==== 
SELECT * FROM VW_TOP_RATED_PRODUCTS;

PROMPT ==== SALES SUMMARY ==== 
SELECT * FROM VW_SALES_SUMMARY;

PROMPT ==== ADVANCED QUERY 1: High-Earning Departments ====
SELECT Department, SUM(Salary) AS TotalSalary
FROM Staff
GROUP BY Department
HAVING SUM(Salary) > 60000;

PROMPT ==== ADVANCED QUERY 2: Students With Completed Orders ====
SELECT s.StudentID, u.FirstName || ' ' || u.LastName AS StudentName
FROM Student s
JOIN Users u ON s.StudentID = u.UserID
WHERE EXISTS (
    SELECT 1 FROM Orders o
    WHERE o.UserID = s.StudentID AND o.Status = 'Completed'
);

PROMPT ==== ADVANCED QUERY 3: Products Never Reviewed ====
SELECT Name AS UnreviewedProduct
FROM Product
MINUS
SELECT DISTINCT p.Name
FROM Product p JOIN Review r ON p.ProductID = r.ProductID;

PROMPT ==== ADVANCED QUERY 4: All Staff and Students ====
SELECT u.FirstName || ' ' || u.LastName AS Name, 'Staff' AS Role
FROM Users u WHERE Role = 'Staff'
UNION
SELECT u.FirstName || ' ' || u.LastName AS Name, 'Student' AS Role
FROM Users u WHERE Role = 'Student';

PROMPT ==== ADVANCED QUERY 5: Top Product by Revenue ====
SELECT p.Name AS ProductName,
       SUM(op.Quantity) AS UnitsSold,
       COUNT(op.OrderID) AS TotalOrders,
       SUM(op.Quantity * p.Price) AS TotalRevenue
FROM Product p
JOIN Order_Product op ON p.ProductID = op.ProductID
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

exit;
EOF

echo "-------------------------------------------"
echo "Press Enter to return to the menu..."
read
