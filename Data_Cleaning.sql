-- Step 1 create database

CREATE DATABASE customerDB;

USE customerDB;

-- Step 2 Create Table

CREATE TABLE CustomerTransaction
(TransactionID INT PRIMARY KEY,
CustomerName VARCHAR(100),
Email VARCHAR(100),
phoneNumber VARCHAR(20),
PurchaseAmount DECIMAL(10,2),
PurchaseDate date,
PaymentMethod VARCHAR(50),
Status VARCHAR(20)
);

SELECT *FROM CustomerDB.CustomerTransaction;

-- 1 Fill missing email address with a placeholder

SET SQL_SAFE_UPDATEs=0;

UPDATE Customertransaction
SET email='unknown@example.com'
WHERE email= '';

SELECT *FROM CustomerDB.CustomerTransaction;

-- 2.identify and remove duplicate records based on phone number

DELETE FROM Customertransaction
WHERE TransactionID NOT IN
(SELECT *FROM(
SELECT min(transactionID)
FROM customertransaction
GROUP BY PhoneNumber
) AS temp_table
);

SELECT *FROM CustomerDB.CustomerTransaction;

-- 3. Fix Email Format Issues:

UPDATE customertransaction
SET email= concat(email, 'com')
WHERE email NOT LIKE "%.com";

SELECT *FROM CustomerDB.CustomerTransaction;

-- 4. Standarize Payment Method Names:

UPDATE customertransaction
SET Paymentmethod = 'Credit Card'
WHERE paymentmethod LIKE '%card';

SELECT *FROM CustomerDB.CustomerTransaction;

-- 5. Remove Failed Transactions From Dataset

DELETE FROM customertransaction
WHERE STATUS = 'failed';

SELECT *FROM CustomerDB.CustomerTransaction;

-- 6. Replace Negative Purchase Amount With NUll.ALTER

UPDATE customertransaction
SET purchaseamount = null
WHERE purchaseamount< 0;

SELECT *FROM CustomerDB.CustomerTransaction;

-- 7. Capitalize the first letter in customername

UPDATE customertransaction
SET customername = CONCAT(
UPPER(LEFT(customername,1)),
LOWER(SUBSTRING(customername,2))
)
WHERE customername IS NOT NULL;

SELECT *FROM CustomerDB.CustomerTransaction;