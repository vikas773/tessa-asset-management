-- ============================================
-- Asset Management Software Database
-- ============================================

-- Drop tables if they already exist
DROP TABLE IF EXISTS asset_maintenance;
DROP TABLE IF EXISTS asset_status_history;
DROP TABLE IF EXISTS asset_allocations;
DROP TABLE IF EXISTS assets;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS users;

-- ============================================
-- USERS TABLE
-- ============================================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    company_id VARCHAR(50) NOT NULL,
    username VARCHAR(100) NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- DEPARTMENTS TABLE
-- ============================================
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- ============================================
-- EMPLOYEES TABLE
-- ============================================
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    employee_code VARCHAR(50) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    department_id INTEGER,
    designation VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    joined_date DATE
);

-- ============================================
-- ASSETS TABLE
-- ============================================
CREATE TABLE assets (
    id SERIAL PRIMARY KEY,
    asset_code VARCHAR(50) NOT NULL,
    asset_name VARCHAR(150) NOT NULL,
    asset_category VARCHAR(100),
    purchase_date DATE,
    asset_value NUMERIC(12,2),
    current_status VARCHAR(50),
    is_retired BOOLEAN DEFAULT FALSE
);

-- ============================================
-- ASSET ALLOCATIONS TABLE
-- ============================================
CREATE TABLE asset_allocations (
    id SERIAL PRIMARY KEY,
    asset_id INTEGER,
    employee_id INTEGER,
    allocated_date DATE,
    returned_date DATE,
    allocation_status VARCHAR(50)
);

-- ============================================
-- ASSET STATUS HISTORY TABLE
-- ============================================
CREATE TABLE asset_status_history (
    id SERIAL PRIMARY KEY,
    asset_id INTEGER,
    status VARCHAR(50),
    changed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    remarks TEXT
);

-- ============================================
-- ASSET MAINTENANCE TABLE
-- ============================================
CREATE TABLE asset_maintenance (
    id SERIAL PRIMARY KEY,
    asset_id INTEGER,
    maintenance_type VARCHAR(100),
    maintenance_date DATE,
    cost NUMERIC(10,2),
    remarks TEXT
);

-- ============================================
-- DUMMY DATA INSERTION
-- ============================================

INSERT INTO departments (department_name, description)
VALUES
('HR', 'Human Resources'),
('IT', 'Information Technology'),
('Finance', 'Finance Department');

INSERT INTO users (company_id, username, password_hash, role)
VALUES
('TC001', 'admin', 'hashed_password_here', 'ADMIN'),
('TC001', 'manager1', 'hashed_password_here', 'MANAGER');

INSERT INTO employees (employee_code, full_name, email, department_id, designation, joined_date)
VALUES
('EMP001', 'Ravi Kumar', 'ravi@company.com', 2, 'Software Engineer', '2022-01-15'),
('EMP002', 'Anita Sharma', 'anita@company.com', 1, 'HR Executive', '2021-11-01');

INSERT INTO assets (asset_code, asset_name, asset_category, purchase_date, asset_value, current_status)
VALUES
('AST001', 'Dell Laptop', 'IT Equipment', '2023-03-10', 65000, 'AVAILABLE'),
('AST002', 'Office Chair', 'Furniture', '2022-08-01', 8000, 'ASSIGNED');

INSERT INTO asset_allocations (asset_id, employee_id, allocated_date, allocation_status)
VALUES
(2, 1, '2023-09-01', 'ACTIVE');

INSERT INTO asset_status_history (asset_id, status, remarks)
VALUES
(1, 'AVAILABLE', 'New asset added'),
(2, 'ASSIGNED', 'Assigned to employee');

INSERT INTO asset_maintenance (asset_id, maintenance_type, maintenance_date, cost, remarks)
VALUES
(1, 'General Check', '2024-01-10', 1500, 'Routine maintenance');
