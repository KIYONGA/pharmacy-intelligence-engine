-- Vision 2036: Pharmacy Intelligence Engine - Database Schema
-- Focus: Anti-Stockout Logic and Inventory Valuation

CREATE DATABASE IF NOT EXISTS Anti_stockout;
USE Anti_stockout;

CREATE TABLE IF NOT EXISTS Inventory (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    current_stock INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    unit_price DECIMAL(10, 2),
    expiry_date DATE,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Initial seed data for testing the 'Running out of stock' logic
INSERT INTO Inventory (product_name, current_stock, reorder_level, unit_price, expiry_date)
VALUES 
('Amoxicillin 500mg', 50, 20, 15.00, '2026-12-01'),
('Paracetamol 500mg', 100, 30, 5.00, '2027-05-15'),
('Artemether/Lumefantrine', 5, 15, 120.00, '2026-08-20'), -- Critical Alert
('Cetirizine 10mg', 45, 10, 8.00, '2026-11-10'),
('Insulin Solostar', 12, 5, 1500.00, '2026-06-30');
