-- CREATE DATABASE event_db;
-- USE event_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    location VARCHAR(255) NOT NULL,
    description TEXT,
    type ENUM('Conference', 'Wedding', 'Workshop', 'Party') NOT NULL,
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE rsvps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_id INT,
    attendees INT NOT NULL,
    status ENUM('Attending', 'Not Attending') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

-- Data
INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'user', 'user@gmail.com', '123456');

-- Data
INSERT INTO events (name, date, location, description, type) VALUES
('Tech Conference 2025', '2025-03-15', 'New York', 'Annual Tech Conference', 'Conference'),
('John & Emily Wedding', '2025-05-10', 'Los Angeles', 'A beautiful wedding ceremony', 'Wedding'),
('AI Workshop', '2025-07-22', 'San Francisco', 'A workshop on AI & ML', 'Workshop'),
('Summer Beach Party', '2025-08-05', 'Miami Beach', 'Enjoy the summer with music and dance!', 'Party');

