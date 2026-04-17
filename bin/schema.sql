-- Create Database
CREATE DATABASE IF NOT EXISTS booktrack_db;
USE booktrack_db;

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Books Table
CREATE TABLE IF NOT EXISTS books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year INT,
    available_copies INT DEFAULT 1,
    image_url VARCHAR(255)
);

-- Borrowings Table
CREATE TABLE IF NOT EXISTS borrowings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

-- Insert Sample Books
INSERT INTO books (title, author, isbn, published_year, available_copies) VALUES 
('Clean Code', 'Robert C. Martin', '978-0132350884', 2008, 5),
('Design Patterns', 'Erich Gamma, Richard Helm', '978-0201633610', 1994, 3),
('Introduction to Algorithms', 'Thomas H. Cormen', '978-0262033848', 2009, 2);

-- Insert Sample Admin
INSERT INTO users (full_name, email, password, role) VALUES 
('Admin BookTrack', 'admin@booktrack.com', 'admin123', 'LIBRARIAN');
