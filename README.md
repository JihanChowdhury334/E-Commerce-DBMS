# 📦 E-Commerce Database System

This project implements a complete **E-Commerce Database System** using **Oracle SQL**.  
It includes the full schema, data population, views, and advanced analytical queries.  
A single unified SQL file is provided for clean deployment.

In future iterations, this database may be extended with a **Java**, **Python**, or **Web-based interface** to demonstrate full-stack integration with a real DBMS backend.

---

## ✅ Features

### **1. Full Database Schema**
The system includes the following entities:
- Users  
- Staff  
- Students  
- Products  
- Orders  
- Order_Product (junction)  
- Payments  
- Reports  
- Reviews  
- Return Requests  

Each table includes:
- Primary keys  
- Foreign keys  
- Constraints (CHECK, UNIQUE, NOT NULL)  
- Proper cascading-safe drop order  

---

## ✅ Sample Data  
The database comes preloaded with realistic seed data including:
- Students and staff  
- Products with stock & pricing  
- Orders and order items  
- Payments  
- Staff reports  
- Product reviews  
- Return requests  

---

## ✅ Views Included
- **Staff_Report_Summary** – staff activity + last report date  
- **VW_TOP_RATED_PRODUCTS** – avg ratings + review counts  
- **VW_SALES_SUMMARY** – units sold + revenue per product  

---

## ✅ Advanced SQL Queries
Includes 5 advanced queries demonstrating:
- Aggregation with HAVING  
- EXISTS subqueries  
- MINUS  
- UNION  
- Multi-table joins with grouping & ordering  

---

## ✅ How to Use

### **Option 1 — Run Everything at Once**
Execute the following file in Oracle SQL:

```
CPS510_A5_Full.sql
```

### **Option 2 — Manual Execution**
1. Drop tables  
2. Create schema  
3. Insert sample data  
4. Create views  
5. Run advanced queries  

---

## ✅ Future Expansion

This project is designed so it can be extended into a real application using:
- A **Java** frontend (JDBC interface)  
- A **Python** application (Flask / FastAPI + cx_Oracle)  
- A **Full Web App** (Node.js / React / Spring Boot)  

The database structure supports CRUD operations, reporting, analytics, and future transaction logging.

---

## ✅ Repository Structure

```
/ecm.sql       # Full combined SQL script
/README.md                # Project documentation

## ✅ License
Released under the **MIT License**.
