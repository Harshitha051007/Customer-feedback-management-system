CREATE DATABASE IF NOT EXISTS customer_feedback_db;
USE customer_feedback_db;

CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) 
);

CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Sentiments (
    SentimentID INT PRIMARY KEY,
    SentimentType VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS FeedbackCategories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Admins (
    AdminID INT PRIMARY KEY,
    AdminName VARCHAR(100) NOT NULL,
    Email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Feedback (
    FeedbackID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    CategoryID INT,
    FeedbackText TEXT,
    FeedbackDate DATE,
    SentimentID INT,
    SentimentScore DECIMAL(3,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES FeedbackCategories(CategoryID),
    FOREIGN KEY (SentimentID) REFERENCES Sentiments(SentimentID)
);

CREATE TABLE IF NOT EXISTS Notifications (
    NotificationID INT PRIMARY KEY,
    FeedbackID INT,
    Message VARCHAR(255),
    NotificationDate DATE,
    FOREIGN KEY (FeedbackID) REFERENCES Feedback(FeedbackID)
);

CREATE TABLE IF NOT EXISTS FeedbackResponses (
    ResponseID INT PRIMARY KEY,
    FeedbackID INT,
    AdminID INT,
    ResponseText TEXT,
    ResponseDate DATE,
    FOREIGN KEY (FeedbackID) REFERENCES Feedback(FeedbackID),
    FOREIGN KEY (AdminID) REFERENCES Admins(AdminID)
);

INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Phone', 'Electronics'),
(3, 'Headphones', 'Accessories')
ON DUPLICATE KEY UPDATE ProductName = VALUES(ProductName), Category = VALUES(Category);

INSERT INTO FeedbackCategories (CategoryID, CategoryName) VALUES
(1, 'Bug'),
(2, 'Suggestion'),
(3, 'Complaint'),
(4, 'Service')
ON DUPLICATE KEY UPDATE CategoryName = VALUES(CategoryName);

INSERT INTO Sentiments (SentimentID, SentimentType) VALUES
(1, 'Positive'),
(2, 'Neutral'),
(3, 'Negative')
ON DUPLICATE KEY UPDATE SentimentType = VALUES(SentimentType);

INSERT INTO Customers (CustomerID, Name, Email) VALUES
(1, 'Aarav Sharma', 'aarav@gmail.com'),
(2, 'Diya Reddy', 'diya@gmail.com'),
(3, 'Nikhil Rao', 'nikhil@gmail.com')
ON DUPLICATE KEY UPDATE Name = VALUES(Name), Email = VALUES(Email);

INSERT INTO Admins (AdminID, AdminName, Email) VALUES
(1, 'Admin One', 'admin1@gmail.com'),
(2, 'Admin Two', 'admin2@gmail.com')
ON DUPLICATE KEY UPDATE AdminName = VALUES(AdminName), Email = VALUES(Email);

INSERT INTO Feedback (FeedbackID, CustomerID, ProductID, CategoryID, FeedbackText, FeedbackDate, SentimentID, SentimentScore) VALUES
(1, 1, 1, 3, 'The laptop performance is good, but the battery drains too fast.', '2026-04-01', 3, 0.32),
(2, 2, 2, 2, 'The phone design is sleek. It would be better with more camera features.', '2026-04-03', 2, 0.61),
(3, 3, 3, 1, 'Headphones audio is excellent and the comfort is impressive.', '2026-04-05', 1, 0.92)
ON DUPLICATE KEY UPDATE FeedbackText = VALUES(FeedbackText), FeedbackDate = VALUES(FeedbackDate), SentimentID = VALUES(SentimentID), SentimentScore = VALUES(SentimentScore);

INSERT INTO Notifications (NotificationID, FeedbackID, Message, NotificationDate) VALUES
(1, 1, 'Negative feedback detected for Laptop. Please review immediately.', '2026-04-02'),
(2, 2, 'Suggestion logged for Phone feature improvement.', '2026-04-04')
ON DUPLICATE KEY UPDATE Message = VALUES(Message), NotificationDate = VALUES(NotificationDate);

INSERT INTO FeedbackResponses (ResponseID, FeedbackID, AdminID, ResponseText, ResponseDate) VALUES
(1, 1, 1, 'We are checking the battery optimization issue and will share an update soon.', '2026-04-02'),
(2, 2, 2, 'Thank you for the suggestion. We have forwarded it to the product team.', '2026-04-04')
ON DUPLICATE KEY UPDATE ResponseText = VALUES(ResponseText), ResponseDate = VALUES(ResponseDate);
