#!/bin/sh
sqlplus64 "cs_username/cs_password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
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
SELECT s.StaffID, u.FirstName||' '||u.LastName AS StaffName,
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

exit;
EOF

echo "-------------------------------------------"
echo "Tables populated successfully."
echo "Press Enter to return to the menu..."
read
