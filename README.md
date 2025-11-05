# 🖥️ E‑Commerce DBMS — Oracle SQL + Unix Shell Automation

This project implements a complete **E‑Commerce Database Management System** using **Oracle SQL**, fully automated with **Unix Shell scripting**.  
It demonstrates end‑to‑end database lifecycle management — including table creation, population, teardown, and advanced analytics — all driven by executable `.sh` scripts.

This repo also includes a unified SQL file and modular shell scripts, and is structured for future expansion into a **Java**, **Python**, or **full web-based interface** using the same backend DBMS.

---

## ✅ Key Features

### **🗄️ Full Relational Database Schema**
- Users, Staff, Students  
- Products & Inventory  
- Orders, Order Items  
- Payments, Reports, Reviews  
- Return Requests  
- Normalized design with PKs, FKs, CHECK constraints, and referential integrity.

### **🔁 Automated DB Lifecycle (Unix Shell Scripts)**
Each operation is executed through dedicated `.sh` scripts:

| Script | Purpose |
|--------|---------|
| `drop_tables.sh` | Safely removes all tables in dependency order |
| `create_tables.sh` | Builds the full relational schema |
| `populate_tables.sh` | Inserts sample data + creates 3 analytical views |
| `query_tables.sh` | Runs analytics, summaries, joins, and advanced SQL |
| `menu.sh` | Interactive terminal menu to run the entire system |

### **📊 Advanced SQL Queries Included**
- Aggregation & HAVING  
- EXISTS subqueries  
- MINUS & UNION  
- Revenue analytics  
- Top‑rated product summary  
- Staff performance reports  

### **🏗️ Future Extensions**
The system is designed to be easily extended into:
- **Java Application** (JDBC interface)  
- **Python Backend** (Flask / FastAPI + cx_Oracle)  
- **Web App** (React/Node/Spring Boot)  

A clean DBMS foundation ready for full-stack use.

---

## ✅ How to Use

### **1. Make scripts executable**
```bash
chmod +x *.sh
```

### **2. Run the interactive menu**
```bash
bash menu.sh
```

### **3. Run operations manually**
```bash
bash drop_tables.sh
bash create_tables.sh
bash populate_tables.sh
bash query_tables.sh
```

You must update the Oracle login string in each script:
```
YOUR_USERNAME/YOUR_PASSWORD@oracle.scs.ryerson.ca:1521/orcl
```

---

## ✅ Repository Structure
```
/menu.sh
/drop_tables.sh
/create_tables.sh
/populate_tables.sh
/query_tables.sh
/CPS510_A5_Full.sql
/README.md
```

---

## ✅ Author  
**Jihan Chowdhury**  
Toronto Metropolitan University — Computer Engineering (Software Option)

---

## ✅ License  
Released under the **MIT License**.
