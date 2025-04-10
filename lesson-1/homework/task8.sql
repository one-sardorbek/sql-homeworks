DROP TABLE IF EXISTS books;

CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY, -- Auto-increment primary key
    title NVARCHAR(255) NOT NULL CHECK (title <> ''), -- Must not be empty
    price DECIMAL(10,2) NOT NULL CHECK (price > 0), -- Must be greater than 0
    genre NVARCHAR(100) NOT NULL DEFAULT 'Unknown' -- Default value 'Unknown'
);
-- Valid Inserts
INSERT INTO books (title, price, genre) VALUES ('The Alchemist', 15.99, 'Fiction');
INSERT INTO books (title, price) VALUES ('Python Basics', 29.99); -- Genre defaults to 'Unknown'
INSERT INTO books (title, price, genre) VALUES ('SQL Mastery', 40.00, 'Technology');

-- Check table contents
SELECT * FROM books;
--checking
--INSERT INTO books (title, price, genre) VALUES ('', 20.00, 'Science');
--INSERT INTO books (title, price, genre) VALUES ('Bad Price', 0, 'Horror');
--INSERT INTO books (title, price, genre) VALUES ('Negative Price', -5, 'Mystery');
