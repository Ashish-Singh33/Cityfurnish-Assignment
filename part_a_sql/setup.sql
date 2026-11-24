/*
Dialect: PostgreSQL.
How to run:
1. Create a database in pgAdmin (or any PostgreSQL client).
2. Run the CREATE TABLE statements from this in the Query Tool.
3. Import customers.csv, rentals.csv and payments.csv into the matching tables (right-click the table, choose Import/Export Data, and turn the header option on).
4. Run the queries in order in the Query Tool.
*/

CREATE TABLE customers (
    customer_id          INT,
    city                 TEXT,
    signup_date          DATE,
    channel  			 TEXT
);

CREATE TABLE rentals (
    rental_id         INT,
    customer_id       INT,
    product_category  TEXT,
    start_date        DATE,
    end_date          DATE,
    monthly_rent      INT,
    status            TEXT
);

CREATE TABLE payments (
    payment_id    INT,
    rental_id     INT,
    payment_date  DATE,
    amount        INT,
    status        TEXT
);