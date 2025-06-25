-- Palm Kissed Paws Transport Database Setup Script
-- Run this script in MySQL to create the database and user

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

-- The tables will be automatically created by TypeORM when you start the NestJS server
-- with synchronize: true in the TypeORM configuration

-- Optional: Insert default services after the server creates the tables
-- You can run this after starting the server for the first time:

/*
INSERT INTO services (id, name, description, type, smallPetPrice, mediumPetPrice, largePetPrice, cratePrice, medicationPrice, waitReturnHourlyPrice, specialTimePrice, roundTripMultiplier, isActive, createdAt, updatedAt) VALUES
(UUID(), 'Local Transport', 'Pet transportation within 15 miles', 'local', 25.00, 35.00, 45.00, 7.00, 5.00, 15.00, 10.00, 1.60, 1, NOW(), NOW()),
(UUID(), 'Standard Transport', 'Pet transportation 16-30 miles', 'standard', 35.00, 45.00, 55.00, 7.00, 5.00, 15.00, 10.00, 1.60, 1, NOW(), NOW()),
(UUID(), 'Long Distance Transport', 'Pet transportation 31-50 miles', 'long', 50.00, 65.00, 80.00, 7.00, 5.00, 15.00, 10.00, 1.60, 1, NOW(), NOW()),
(UUID(), 'Extended Transport', 'Pet transportation 51+ miles', 'extended', 75.00, 95.00, 115.00, 7.00, 5.00, 15.00, 10.00, 1.60, 1, NOW(), NOW());
*/

-- Create an admin user (run this after the server creates the users table)
/*
INSERT INTO users (id, email, password, firstName, lastName, role, isActive, createdAt, updatedAt) VALUES
(UUID(), 'admin@palmkissedpaws.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj6hsxq5S/kS', 'Admin', 'User', 'admin', 1, NOW(), NOW());
-- Password is 'admin123' - change this in production!
*/