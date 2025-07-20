# 💰 Personal Finance Tracker – SQL Project

This project demonstrates how to build a **Personal Finance Tracker** using SQL and MySQL Workbench. The goal is to help users manage and analyze their **income**, **expenses**, and **monthly financial balance** using SQL tables, queries, and views.

---

## 📌 Project Objectives

- Track user income and expense records
- Generate monthly financial reports
- Calculate and view income, expenses, and net balance
- Showcase SQL skills: schema design, aggregation, views

---

## 🛠️ Tools Used

- **MySQL Server** & **MySQL Workbench**
- SQL (DDL, DML, `GROUP BY`, `DATE_FORMAT`, `JOIN`, `VIEW`)
- Optional: CSV Export

---

## 🧱 Database Schema

The project uses four main tables:

- `users(user_id, name, email)`
- `income(income_id, user_id, source, amount, date)`
- `expenses(expense_id, user_id, category, amount, date)`
- `categories(category_id, name)` *(optional)*

---

## 📥 Sample Data

Dummy data was inserted for two users:

- Alice: Salary and Freelance income, Food/Rent/Travel expenses
- Bob: Salary income, Food/Electricity expenses

---

## 📊 Key Queries

### 1. Monthly Income

```sql
SELECT u.name, DATE_FORMAT(i.date, '%Y-%m') AS month, SUM(i.amount) AS total_income
FROM income i
JOIN users u ON u.user_id = i.user_id
GROUP BY u.name, month;
```

---

📁 Project Structure
finance-tracker-project/
│
├── finance_tracker.sql               # Full SQL script (schema + data + queries)
├── monthly_balance.csv               # Exported report 
├── Personal_Finance_Tracker_Project_Report.pdf  # Final 2-page report
└── README.md                         # This file

---

📌 Conclusion
This project showcases essential SQL skills including:
- Schema design
- Relational joins
- Aggregate functions
- View creation and monthly analysis
