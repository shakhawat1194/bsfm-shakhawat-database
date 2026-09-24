-- ============================================================
-- BSFM Database Project — Person 2
-- File: 05_person2_sample_data.sql
-- Purpose: Loads sample data into Staff, Assignment and Invoice.
-- Run AFTER 04_person2_tables.sql and AFTER Person 1's booking
-- sample data (02_sample_data.sql), because Assignment and Invoice
-- reference existing booking_id values (1 to 5).
-- ============================================================

-- ----------------------------------------------------------
-- STAFF
-- ----------------------------------------------------------
INSERT INTO Staff (full_name, phone, role, hire_date) VALUES
('Yusuf Rahman', '0509990001', 'Cleaner',     '2025-01-15'),
('Sara Khaled',  '0509990002', 'Technician',  '2025-03-10'),
('Hassan Ali',   '0509990003', 'Supervisor',  '2024-11-01');

-- ----------------------------------------------------------
-- ASSIGNMENT
-- Booking IDs 1, 2, 3, 4 refer to the bookings created in
-- Person 1's sample data (booking 5 was later deleted in query 6,
-- so it is not assigned here).
-- ----------------------------------------------------------
INSERT INTO Assignment (booking_id, staff_id, assigned_date, role_in_job) VALUES
(1, 1, '2026-09-25', 'Lead'),
(2, 2, '2026-09-26', 'Lead'),
(3, 1, '2026-09-27', 'Assistant'),
(4, 3, '2026-09-28', 'Lead');

-- ----------------------------------------------------------
-- INVOICE
-- Only bookings that have reached a billable stage are invoiced
-- here (booking 2 is still Pending, so no invoice yet).
-- ----------------------------------------------------------
INSERT INTO Invoice (booking_id, amount, issue_date, payment_status) VALUES
(1, 350.00, '2026-09-25', 'Paid'),
(3, 200.00, '2026-09-27', 'Paid'),
(4, 900.00, '2026-09-28', 'Unpaid');
