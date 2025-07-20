CREATE DATABASE finance_tracker;
USE finance_tracker;

-- Users
CREATE TABLE users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  email VARCHAR(100)
);

-- Income
CREATE TABLE income (
  income_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  source VARCHAR(100),
  amount DECIMAL(10,2),
  date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Expenses
CREATE TABLE expenses (
  expense_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  category VARCHAR(100),
  amount DECIMAL(10,2),
  date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Optional: Categories table
CREATE TABLE categories (
  category_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50)
);


INSERT INTO users (name, email) VALUES 
('Alice', 'alice@email.com'),
('Bob', 'bob@email.com');

INSERT INTO income (user_id, source, amount, date) VALUES
(1, 'Salary', 50000, '2024-07-01'),
(1, 'Freelance', 10000, '2024-07-15'),
(2, 'Salary', 40000, '2024-07-01');

INSERT INTO expenses (user_id, category, amount, date) VALUES
(1, 'Food', 5000, '2024-07-03'),
(1, 'Rent', 15000, '2024-07-05'),
(1, 'Travel', 2000, '2024-07-10'),
(2, 'Food', 4000, '2024-07-04'),
(2, 'Electricity', 2000, '2024-07-06');


-- Income by user and month
SELECT 
  u.name,
  DATE_FORMAT(i.date, '%Y-%m') AS month,
  SUM(i.amount) AS total_income
FROM income i
JOIN users u ON u.user_id = i.user_id
GROUP BY u.name, month;

-- Expenses by user and month
SELECT 
  u.name,
  DATE_FORMAT(e.date, '%Y-%m') AS month,
  SUM(e.amount) AS total_expense
FROM expenses e
JOIN users u ON u.user_id = e.user_id
GROUP BY u.name, month;


CREATE VIEW monthly_balance AS
SELECT 
  u.name,
  DATE_FORMAT(i.date, '%Y-%m') AS month,
  SUM(i.amount) AS total_income,
  (
    SELECT IFNULL(SUM(e.amount), 0)
    FROM expenses e
    WHERE e.user_id = i.user_id AND DATE_FORMAT(e.date, '%Y-%m') = DATE_FORMAT(i.date, '%Y-%m')
  ) AS total_expense,
  (
    SUM(i.amount) -
    (
      SELECT IFNULL(SUM(e.amount), 0)
      FROM expenses e
      WHERE e.user_id = i.user_id AND DATE_FORMAT(e.date, '%Y-%m') = DATE_FORMAT(i.date, '%Y-%m')
    )
  ) AS balance
FROM income i
JOIN users u ON u.user_id = i.user_id
GROUP BY u.name, month;


SELECT * FROM income;

SELECT * FROM expenses;

SELECT * FROM monthly_balance;