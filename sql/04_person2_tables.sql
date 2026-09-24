-- ============================================================
-- BSFM Database Project — Person 2
-- File: 04_person2_tables.sql
-- Purpose: Creates the Staff, Assignment and Invoice tables.
-- Requires: Customer, Service and Booking tables must already exist
--           (created by Person 1's 01_schema.sql), because Assignment
--           and Invoice both reference Booking as a foreign key.
-- ============================================================

-- ----------------------------------------------------------
-- STAFF TABLE
-- One row per staff member who can be assigned to a booking.
-- ----------------------------------------------------------
CREATE TABLE Staff (
    staff_id    INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    phone       VARCHAR(20)  NOT NULL UNIQUE,
    role        VARCHAR(50)  NOT NULL,
    hire_date   DATE
);

-- ----------------------------------------------------------
-- ASSIGNMENT TABLE
-- Links one staff member to one booking (who is doing the job).
-- A booking can have more than one staff member assigned to it.
-- ----------------------------------------------------------
CREATE TABLE Assignment (
    assignment_id  INT AUTO_INCREMENT PRIMARY KEY,
    booking_id     INT NOT NULL,
    staff_id       INT NOT NULL,
    assigned_date  DATE NOT NULL,
    role_in_job    VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (staff_id)   REFERENCES Staff(staff_id)
);

-- ----------------------------------------------------------
-- INVOICE TABLE
-- One invoice per booking (booking_id is UNIQUE, so a booking
-- cannot be invoiced twice).
-- ----------------------------------------------------------
CREATE TABLE Invoice (
    invoice_id      INT AUTO_INCREMENT PRIMARY KEY,
    booking_id      INT NOT NULL UNIQUE,
    amount          DECIMAL(10,2) NOT NULL,
    issue_date      DATE NOT NULL,
    payment_status  ENUM('Unpaid', 'Paid', 'Refunded') NOT NULL DEFAULT 'Unpaid',
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);
