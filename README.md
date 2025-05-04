# Clinic-Task-Manager

This project is divided into two key sections:

1. **Clinic Booking System**  
   A MySQL-based relational database system designed to manage doctors, patients, appointments, and payments in a clinic setting.

2. **Task Manager API**  
   A CRUD API built with FastAPI (Python) that connects to a MySQL database to manage users and their tasks.
---

Description

A robust relational database schema that supports:
- Registering patients and doctors
- Assigning specializations to doctors
- Booking appointments
- Recording appointment payments

Files Included
- `clinic_system.sql`: Contains all `CREATE TABLE` statements and sample data inserts
- All tables are structured with appropriate `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, and `NOT NULL` constraints
- Inline comments included for clarity

### 🔧 How to Set Up

1. Open MySQL Workbench or your preferred SQL client
2. Create a new database, e.g., `clinicdb`
3. Import and run the `clinic_system.sql` file

```sql
CREATE DATABASE clinicdb;
USE clinicdb;

## 🧩 Entity-Relationship Diagram (ERD)

![ERD](./erd.png)

For an interactive version, visit: [dbdiagram.io](https://dbdiagram.io/d/your-diagram-id)

-- Then run clinic_system.sql
