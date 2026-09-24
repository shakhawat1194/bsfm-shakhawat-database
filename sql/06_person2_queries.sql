-- ============================================================
-- BSFM Database Project — Person 2
-- File: 06_person2_queries.sql
-- Purpose: The seven queries described in Person 2's report.
-- Run in order — some queries depend on an earlier one.
-- ============================================================

-- ------------------------------------------------------------
-- QUERY 1: Register a New Staff Member (INSERT)
-- Purpose: Add a new staff member, Mariam Youssef, as a Cleaner.
-- ------------------------------------------------------------
INSERT INTO Staff (full_name, phone, role, hire_date)
VALUES ('Mariam Youssef', '0509990004', 'Cleaner', '2026-09-20');


-- ------------------------------------------------------------
-- QUERY 2: Assign the New Staff Member to a Booking (INSERT)
-- Purpose: Assign the staff member just registered (staff_id 4)
-- to booking 2 (Fatima Al Suwaidi's AC Duct Cleaning).
-- ------------------------------------------------------------
INSERT INTO Assignment (booking_id, staff_id, assigned_date, role_in_job)
VALUES (2, 4, '2026-09-26', 'Assistant');


-- ------------------------------------------------------------
-- QUERY 3: Assignment History of One Staff Member (SELECT with JOIN)
-- Purpose: Show every job staff_id 1 (Yusuf Rahman) has been
-- assigned to, with the service name, newest first.
-- ------------------------------------------------------------
SELECT a.assignment_id, s.service_name, a.assigned_date, a.role_in_job
FROM Assignment a
JOIN Booking b ON a.booking_id = b.booking_id
JOIN Service s ON b.service_id = s.service_id
WHERE a.staff_id = 1
ORDER BY a.assigned_date DESC;


-- ------------------------------------------------------------
-- QUERY 4: Unpaid Invoices with Customer Name (SELECT with two JOINs)
-- Purpose: List every unpaid invoice together with the customer
-- who needs to pay it.
-- ------------------------------------------------------------
SELECT c.full_name, i.invoice_id, i.amount, i.issue_date
FROM Invoice i
JOIN Booking b   ON i.booking_id = b.booking_id
JOIN Customer c  ON b.customer_id = c.customer_id
WHERE i.payment_status = 'Unpaid'
ORDER BY i.issue_date;


-- ------------------------------------------------------------
-- QUERY 5: Mark an Invoice as Paid (UPDATE)
-- Purpose: Change invoice 3 (booking 4, Office Cleaning Contract)
-- from Unpaid to Paid.
-- ------------------------------------------------------------
UPDATE Invoice
SET payment_status = 'Paid'
WHERE invoice_id = 3;


-- ------------------------------------------------------------
-- QUERY 6: Remove an Incorrect Assignment (DELETE)
-- Purpose: Delete the assignment that was entered by mistake
-- (assignment 3, an Assistant role that was never actually done).
-- ------------------------------------------------------------
DELETE FROM Assignment
WHERE assignment_id = 3 AND role_in_job = 'Assistant';


-- ------------------------------------------------------------
-- QUERY 7: Assignments per Staff Role (Aggregate)
-- Purpose: Count how many assignments exist for each staff role.
-- ------------------------------------------------------------
SELECT st.role, COUNT(a.assignment_id) AS total_assignments
FROM Assignment a
JOIN Staff st ON a.staff_id = st.staff_id
GROUP BY st.role;
