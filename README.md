# BSFM Database Project: Customers and Service Bookings

Database design and SQL queries for the booking system of BSFM, a cleaning and facilities management company (https://bsfm.ae/).

This is design and query work only. Nothing is implemented on the live website.

This repository covers the Customer, Service and Booking tables. They store customer details, service types and pricing, and booking dates and status. The queries perform CRUD operations and use JOINs to produce a customer's booking history and a list of upcoming bookings.

## Repository contents

| Folder or file | What it holds |
|---|---|
| `sql/01_schema.sql` | Creates the database `bsfm_db` and its tables |
| `sql/02_sample_data.sql` | Fills the tables with sample data |
| `sql/03_person1_queries.sql` | The 7 queries (CRUD, JOINs and an aggregate) |
| `screenshots/` | Screenshots of every query result and table structure |

## Database design

**Customer**: customer_id, full_name, phone (unique), email, address, created_at

**Service**: service_id, service_name, category, price, description

**Booking**: booking_id, customer_id (foreign key), service_id (foreign key), booking_date, time_slot, service_address, status (Pending, Confirmed, Completed or Cancelled), created_at

How the tables connect:

- One customer can place many bookings.
- One service can be booked many times.
- Each booking points to exactly one customer and one service.

The schema and sample data files also create and fill three supporting tables (Staff, Assignment and Invoice). They belong to the same database but are not covered by the queries here.

## How to run

1. Open phpMyAdmin (or MySQL Workbench) and connect to your MySQL server.
2. Run `sql/01_schema.sql`. It creates the database `bsfm_db` and its tables.
3. Run `sql/02_sample_data.sql`. It fills the tables.
4. Run `sql/03_person1_queries.sql`, or run the queries one at a time.

Run the files in this order, once, on a fresh database. Some queries use fixed ID numbers, so running the sample data twice would break them.

This project was tested in phpMyAdmin (XAMPP). The syntax is MySQL-specific.

## Queries and results

### 1. Register a new customer (INSERT)
Adds Layla Hamdan as customer 4.

![Insert customer](screenshots/p1-01-insert-customer.png)

### 2. Place a new booking (INSERT)
Adds an AC Duct Cleaning booking for customer 4. It becomes booking 6.

![Insert booking](screenshots/p1-02-insert-booking.png)

### 3. Booking history for one customer (SELECT with JOIN)
Lists the bookings of customer 1, newest first, with the service name. Expected: 2 rows.

![Booking history](screenshots/p1-03-booking-history.png)

### 4. Upcoming confirmed bookings (SELECT with two JOINs)
Joins Booking, Customer and Service. Expected: 2 rows, on 25 and 28 September 2026.

![Upcoming bookings](screenshots/p1-04-upcoming-bookings.png)

### 5. Confirm a pending booking (UPDATE)
Changes booking 2 from Pending to Confirmed. Expected: 1 row affected.

![Update booking](screenshots/p1-05-update-booking.png)

### 6. Remove a cancelled booking (DELETE)
Deletes booking 5, but only if its status is Cancelled. Expected: 1 row deleted.

![Delete booking](screenshots/p1-06-delete-booking.png)

### 7. Bookings per service category (aggregate)
Counts bookings for each category with COUNT and GROUP BY. Expected: Cleaning 3, Maintenance 2.

![Bookings per category](screenshots/p1-07-bookings-per-category.png)

## Table structures

### Customer
![Customer structure](screenshots/p1-08-structure-customer.png)

### Service
![Service structure](screenshots/p1-09-structure-service.png)

### Booking
![Booking structure](screenshots/p1-10-structure-booking.png)

## Notes

- Query 4 uses `CURDATE()`, so its result depends on the day it is run. The result shown was taken on 24 September 2026.
- Query 2 uses customer ID 4, which is the customer created by query 1, so run the queries in order.
- Booking 5 has no invoice and no staff assignment, so it can be deleted. A booking that has either one cannot be deleted, because of the foreign keys.
| `report/BSFM_Database_Report.docx` | The Word report with explanations and result screenshots |
## Person 2 Addition: Staff, Assignment and Invoice

This section documents the Staff, Assignment and Invoice tables, added by
S M Shakhawat Azam (Student ID: 0222220005101194).

| Folder or file | What it holds |
|---|---|
| `sql/04_person2_tables.sql` | Creates the Staff, Assignment and Invoice tables |
| `sql/05_person2_sample_data.sql` | Fills those tables with sample data |
| `sql/06_person2_queries.sql` | The 7 queries (CRUD, JOINs and an aggregate) |
| `screenshots/p2-*.png` | Screenshots of every query result and table structure |
| `report/Shakhawat_Azam_BSFM_Database_Report.pdf` | Full written report for this part of the project |

**Staff**: staff_id, full_name, phone (unique), role, hire_date
**Assignment**: assignment_id, booking_id (FK), staff_id (FK), assigned_date, role_in_job
**Invoice**: invoice_id, booking_id (FK, unique), amount, issue_date, payment_status
