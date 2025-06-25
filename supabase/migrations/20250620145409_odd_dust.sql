/*
  Palm Kissed Paws Transport Database Setup Script
  
  This script creates the MySQL database and user for the Palm Kissed Paws Transport application.
  Run this script as a MySQL administrator (root user) to set up the database.
  
  Usage:
  1. Connect to MySQL as root: mysql -u root -p
  2. Run this script: source database_setup.sql
  3. Update the .env file with your database credentials
*/

-- Create database
DROP DATABASE IF EXISTS palm_kissed_paws;
CREATE DATABASE palm_kissed_paws CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create user (change password in production)
DROP USER IF EXISTS 'palm_kissed_user'@'localhost';
CREATE USER 'palm_kissed_user'@'localhost' IDENTIFIED BY 'secure_password_2024';

-- Grant privileges
GRANT ALL PRIVILEGES ON palm_kissed_paws.* TO 'palm_kissed_user'@'localhost';
FLUSH PRIVILEGES;

-- Use the database
USE palm_kissed_paws;

-- Show success message
SELECT 'Database palm_kissed_paws created successfully!' as message;
SELECT 'User palm_kissed_user created with full privileges!' as message;
SELECT 'Update your .env file with these credentials:' as message;
SELECT 'DATABASE_NAME=palm_kissed_paws' as env_setting;
SELECT 'DATABASE_USER=palm_kissed_user' as env_setting;
SELECT 'DATABASE_PASSWORD=secure_password_2024' as env_setting;

-- Insert default services
INSERT INTO services (id, name, description, type, smallPetPrice, mediumPetPrice, largePetPrice, cratePrice, medicationPrice, waitReturnHourlyPrice, specialTimePrice, roundTripMultiplier, isActive, createdAt, updatedAt) VALUES
(UUID(), 'Local Transport', 'Pet transportation within 15 miles', 'local', 25.00, 35.00, 45.00, 7.00, 5.00, 15.00, 10.00, 1.60, 1, NOW(), NOW()),
(UUID(), 'Standard Transport', 'Pet transportation 16-30 miles', 'standard', 35.00, 45.00, 55.00, 7.00, 5.00, 15.00, 10.00, 1.60, 1, NOW(), NOW()),
(UUID(), 'Long Distance Transport', 'Pet transportation 31-50 miles', 'long', 50.00, 65.00, 80.00, 7.00, 5.00, 15.00, 10.00, 1.60, 1, NOW(), NOW()),
(UUID(), 'Extended Transport', 'Pet transportation 51+ miles', 'extended', 75.00, 95.00, 115.00, 7.00, 5.00, 15.00, 10.00, 1.60, 1, NOW(), NOW());