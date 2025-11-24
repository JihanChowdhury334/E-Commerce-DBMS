# 🛒 E-Commerce Database Management System
### Full-Stack DBMS with Web Interface & Unix Automation

[![Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white)](https://www.oracle.com/)
[![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net/)
[![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)](https://developer.mozilla.org/en-US/docs/Web/HTML)
[![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)](https://developer.mozilla.org/en-US/docs/Web/CSS)

<video width="100%" controls>
  <source src="https://github.com/JihanChowdhury334/E-Commerce-DBMS/releases/download/v1.0/Loom.Message.-.24.November.2025.1.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>


> **Production-ready** e-commerce database system demonstrating enterprise-level database design, full CRUD operations, and advanced SQL analytics. Built with dual interfaces: modern web UI and automated Unix shell scripts.

---

## 🎯 Project Highlights

- 🏗️ **Enterprise Database Design** — 11 normalized tables (3NF/BCNF) with complete referential integrity
- 🌐 **Full-Stack Web Application** — PHP-based CRUD interface with modern responsive UI
- 🔐 **Security-First Architecture** — Parameterized queries, input validation, SQL injection protection
- 📊 **Advanced Analytics** — Multi-table JOINs, aggregations, subqueries, and analytical views
- 🤖 **DevOps Automation** — Unix shell scripts for complete database lifecycle management
- ⚡ **Production-Ready** — Error handling, transaction management, cascade operations

---

## 🚀 Live Demo

**Access the application:** `https://webdev.scs.ryerson.ca/~username/a9/`

### Quick Start
```bash
# 1. Deploy to web server
ssh username@webdev.scs.ryerson.ca
cd ~/webdev/a9

# 2. Configure database credentials
cp .env.example .env
nano .env  # Add your Oracle credentials

# 3. Access via browser and click "Create Tables" → "Populate Tables"
```

---

## 💡 Key Features

### **🎨 Modern Web Interface**
- ✅ **Complete CRUD Operations** — Create, Read, Update, Delete for all entities
- ✅ **Real-Time Search** — Filter records across multiple fields with live results
- ✅ **Responsive Design** — Modern gradient UI, mobile-friendly, smooth animations
- ✅ **Error Handling** — User-friendly error messages with context
- ✅ **Data Validation** — Client and server-side validation with constraint enforcement

### **🗄️ Robust Database Architecture**

**11 Core Tables:**
| Table | Purpose | Key Features |
|-------|---------|--------------|
| `Users` | Customer & staff accounts | Email uniqueness, role validation |
| `Department` | Organizational structure | Salary tracking |
| `Staff` | Employee records | Hire date, position management |
| `Student` | Academic details | GPA tracking, year validation |
| `Product` | Inventory catalog | Price constraints, stock management |
| `Orders` | Transaction records | Status tracking, date stamping |
| `Order_Product` | Line items | Composite key, quantity validation |
| `Payment` | Financial transactions | Multiple payment methods |
| `Report` | Staff analytics | Auto-generated reports |
| `Review` | Product feedback | Rating system (1-5 stars) |
| `ReturnRequest` | Return management | Approval workflow |

**3 Analytical Views:**
- `Staff_Report_Summary` — Report counts by staff member
- `VW_TOP_RATED_PRODUCTS` — Products ranked by customer ratings
- `VW_SALES_SUMMARY` — Revenue and units sold per product

### **📊 Advanced SQL Capabilities**

**Query 1: Multi-Table JOIN**
```sql
-- Comprehensive order details with customer and product information
SELECT o.OrderID, u.FirstName || ' ' || u.LastName AS Customer,
       p.Name AS Product, op.Quantity, (op.Quantity * p.Price) AS LineTotal
FROM Orders o
INNER JOIN Users u ON o.UserID = u.UserID
INNER JOIN Order_Product op ON o.OrderID = op.OrderID
INNER JOIN Product p ON op.ProductID = p.ProductID
```

**Query 2: Aggregation & Analytics**
```sql
-- Product performance metrics with ratings and revenue
SELECT p.ProductID, p.Name,
       SUM(op.Quantity) AS TotalUnitsSold,
       SUM(op.Quantity * p.Price) AS TotalRevenue,
       AVG(r.Rating) AS AvgRating,
       COUNT(r.ReviewID) AS ReviewCount
FROM Product p
LEFT JOIN Order_Product op ON p.ProductID = op.ProductID
LEFT JOIN Review r ON p.ProductID = r.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalRevenue DESC
```

**Query 3: Subquery — VIP Customer Identification**
```sql
-- Customers spending above average
SELECT u.UserID, u.FirstName || ' ' || u.LastName AS Name,
       SUM(op.Quantity * p.Price) AS TotalSpent
FROM Users u
JOIN Orders o ON u.UserID = o.UserID
JOIN Order_Product op ON o.OrderID = op.OrderID
JOIN Product p ON op.ProductID = p.ProductID
GROUP BY u.UserID, u.FirstName, u.LastName
HAVING SUM(op.Quantity * p.Price) > (SELECT AVG(OrderTotal) FROM ...)
```

### **🔧 DevOps Automation**

**Unix Shell Scripts for CI/CD:**
```bash
menu.sh              # Interactive terminal menu
drop_tables.sh       # Safe teardown with dependency handling
create_tables.sh     # Schema deployment
populate_tables.sh   # Sample data injection
query_tables.sh      # Analytics execution
```

---

## 🛠️ Technical Stack

### **Backend**
- **Database:** Oracle 19c with OCI8 driver
- **Server-Side:** PHP 7.4+ with procedural architecture
- **Connection Pooling:** Persistent connections with error recovery
- **Security:** Prepared statements, parameterized queries, input sanitization

### **Frontend**
- **HTML5** — Semantic markup
- **CSS3** — Modern gradients, flexbox, responsive design
- **Vanilla JavaScript** — Form validation, dynamic interactions

### **Automation**
- **Bash/Shell** — Unix scripting for database lifecycle
- **SQL*Plus** — Oracle command-line interface

---

## 📁 Project Structure

```
📦 E-Commerce-DBMS/
├── 🌐 Web Interface
│   ├── index.php                 # Main dashboard
│   ├── config.php                # Database configuration & utilities
│   ├── create_tables.php         # Schema creation UI
│   ├── drop_tables.php           # Table removal UI
│   ├── populate.php              # Data population UI
│   │
│   ├── 📂 tables/                # CRUD Operations
│   │   ├── users.php             # User management
│   │   ├── staff.php             # Staff records
│   │   ├── students.php          # Student records
│   │   ├── products.php          # Inventory management
│   │   ├── orders.php            # Order processing
│   │   ├── payments.php          # Payment tracking
│   │   ├── reviews.php           # Review management
│   │   ├── returns.php           # Return requests
│   │   └── edit_*.php / delete_*.php
│   │
│   └── 📂 queries/               # Analytics Dashboard
│       ├── query1.php            # JOIN analysis
│       ├── query2.php            # Aggregation analytics
│       └── query3.php            # Subquery insights
│
├── 🤖 Automation Scripts
│   ├── menu.sh                   # Interactive CLI
│   ├── create_tables.sh          # Schema deployment
│   ├── drop_tables.sh            # Cleanup automation
│   ├── populate_tables.sh        # Data seeding
│   └── query_tables.sh           # Analytics runner
│
├── 📄 Documentation
│   ├── ecm.sql                   # Complete SQL schema
│   ├── README.md                 # This file
│   └── code_snippets_for_screenshots.txt
│
└── 🔒 Configuration
    ├── .env.example              # Environment template
    └── .gitignore                # Git exclusions
```

---

## 🎓 Database Design Principles

### **Normalization**
- ✅ **3NF/BCNF Compliant** — Eliminates redundancy
- ✅ **Referential Integrity** — Foreign keys with CASCADE operations
- ✅ **Data Consistency** — CHECK constraints on all critical fields

### **Indexing Strategy**
- Primary keys on all tables
- Unique constraints on business keys (email, etc.)
- Optimized for JOIN operations

### **Transaction Management**
- ACID compliance with explicit commits
- Rollback on error scenarios
- Optimistic locking for concurrent access

---

## 🚀 Setup & Deployment

### **Prerequisites**
- Oracle Database 11g+ (tested on 19c)
- Apache/Nginx with PHP 7.4+
- OCI8 PHP extension
- Unix/Linux environment (for shell scripts)

### **Web Application Setup**

**1. Clone Repository**
```bash
git clone https://github.com/JihanChowdhury334/E-Commerce-DBMS.git
cd E-Commerce-DBMS
```

**2. Configure Database Connection**
```bash
cp .env.example .env
nano .env
```

```env
DB_USERNAME=your_oracle_username
DB_PASSWORD=your_oracle_password
DB_HOST=oracle.scs.ryerson.ca
DB_PORT=1521
DB_SID=orcl
```

**3. Deploy to Web Server**
```bash
# Set proper permissions
chmod 755 . tables queries
chmod 644 *.php tables/*.php queries/*.php

# Upload to web server
scp -r * username@webdev.scs.ryerson.ca:~/webdev/a9/
```

**4. Initialize Database**
- Navigate to `https://your-domain/a9/`
- Click **"Create Tables"** to build schema
- Click **"Populate Tables"** to insert sample data
- Start managing data through CRUD interfaces

### **Shell Script Setup**

```bash
# Make scripts executable
chmod +x *.sh

# Update Oracle credentials in each script
nano create_tables.sh  # Update connection string

# Run interactive menu
bash menu.sh
```

---

## 📊 Sample Data

The system includes realistic sample data:
- **8 Users** (students and staff)
- **4 Departments** (CS, IT, Business, Engineering)
- **3 Staff Members** (Professor, Lab Instructor, Admin)
- **5 Students** (various majors and GPAs)
- **8 Products** (laptops, peripherals, accessories)
- **6 Orders** with multiple line items
- **3 Payments** with different methods
- **5 Reviews** with ratings and comments
- **2 Return Requests**

---

## 🎯 Learning Outcomes

This project demonstrates proficiency in:

✅ **Database Design** — ERD modeling, normalization, constraint design  
✅ **SQL Mastery** — DDL, DML, DQL, advanced queries, views  
✅ **Backend Development** — PHP, OCI8, session management  
✅ **Frontend Skills** — HTML5, CSS3, responsive design  
✅ **Security** — SQL injection prevention, input validation  
✅ **DevOps** — Shell scripting, automation, deployment  
✅ **Software Engineering** — Modular code, separation of concerns  

---

## 🔮 Future Enhancements

- [ ] RESTful API with JWT authentication
- [ ] React/Vue.js frontend migration
- [ ] Docker containerization
- [ ] CI/CD pipeline with GitHub Actions
- [ ] Redis caching layer
- [ ] Elasticsearch integration for search
- [ ] GraphQL endpoint
- [ ] Real-time notifications with WebSockets
- [ ] Admin dashboard with analytics charts
- [ ] Multi-language support (i18n)

---

## 👨‍💻 Author

**Jihan Chowdhury**  
Computer Engineering (Software Option)  
Toronto Metropolitan University

📧 [jihan.chowdhury@torontomu.ca](mailto:jihan.chowdhury@torontomu.ca)  
🔗 [LinkedIn](https://linkedin.com/in/jihanchowdhury) | [GitHub](https://github.com/JihanChowdhury334)

---

## 📜 License

This project is licensed under the **MIT License** — see LICENSE file for details.

---

## 🙏 Acknowledgments

- Toronto Metropolitan University — CPS510 Database Systems I
- Oracle Academy for database resources
- Open source community for inspiration

---

<div align="center">

### ⭐ If you find this project useful, please consider giving it a star!

**Built with ❤️ for database enthusiasts and recruiters alike**

</div>
