# Database Schema Documentation

## Table Structure

### customers
Stores customer information
- `customer_id` (INT, PRIMARY KEY) - Unique customer ID
- `first_name` (VARCHAR(50), NOT NULL) - Customer first name
- `last_name` (VARCHAR(50), NOT NULL) - Customer last name
- `email` (VARCHAR(100), UNIQUE) - Email address
- `phone` (VARCHAR(15)) - Phone number
- `address` (TEXT) - Full address
- `city` (VARCHAR(50)) - City name
- `state` (VARCHAR(50)) - State name
- `postal_code` (VARCHAR(10)) - ZIP code
- `created_at` (TIMESTAMP) - When record was created

### products
Product catalog with pricing
- `product_id` (INT, PRIMARY KEY) - Unique product ID
- `product_name` (VARCHAR(100), NOT NULL) - Product name
- `description` (TEXT) - Product description
- `price` (DECIMAL(10,2), NOT NULL) - Product price
- `category` (VARCHAR(50)) - Product category
- `stock_quantity` (INT, DEFAULT 0) - Available stock
- `created_at` (TIMESTAMP) - When record was created

### orders
Order transactions
- `order_id` (INT, PRIMARY KEY) - Unique order ID
- `customer_id` (INT, FOREIGN KEY) - Links to customers table
- `order_date` (DATE, NOT NULL) - When order was placed
- `total_amount` (DECIMAL(10,2), NOT NULL) - Total order value
- `status` (ENUM) - Order status: pending, processing, shipped, delivered, cancelled
- `shipping_address` (TEXT) - Where to ship the order
- `created_at` (TIMESTAMP) - When record was created

### order_items
Individual items in each order
- `order_item_id` (INT, PRIMARY KEY) - Unique item ID
- `order_id` (INT, FOREIGN KEY) - Links to orders table
- `product_id` (INT, FOREIGN KEY) - Links to products table
- `quantity` (INT, NOT NULL) - How many items ordered
- `unit_price` (DECIMAL(10,2), NOT NULL) - Price per item
- `total_price` (DECIMAL(10,2), NOT NULL) - Total for this line item

### payments
Payment records
- `payment_id` (INT, PRIMARY KEY) - Unique payment ID
- `order_id` (INT, FOREIGN KEY) - Links to orders table
- `payment_date` (DATE, NOT NULL) - When payment was made
- `amount` (DECIMAL(10,2), NOT NULL) - Payment amount
- `payment_method` (ENUM) - Method: credit_card, debit_card, paypal, bank_transfer, cash
- `transaction_id` (VARCHAR(100), UNIQUE) - External transaction reference
- `status` (ENUM) - Payment status: pending, completed, failed, refunded
- `created_at` (TIMESTAMP) - When record was created

## Relationships

- One customer can have many orders
- One order can have many items (products)
- One order can have multiple payments
- One product can be in many orders

## Indexes Created

For better performance:
- All primary keys are indexed
- Foreign keys are indexed
- Email field is indexed for fast customer lookup
- Order date is indexed for date range queries
- Order status is indexed for filtering

## Views Created

### customer_orders_view
Shows customer info with their orders
```sql
SELECT customer_name, email, order_date, total_amount, status
FROM customer_orders_view;
```

### daily_sales_report
Daily sales summary
```sql
SELECT sale_date, total_orders, total_sales
FROM daily_sales_report;
```

### product_sales_summary
Product performance report
```sql
SELECT product_name, total_quantity_sold, total_revenue
FROM product_sales_summary;
```

## Data Validation

- All prices must be positive numbers
- Stock quantities cannot be negative
- Email addresses must be unique
- Order quantities must be greater than 0
- All foreign key relationships are enforced

## Sample Data

The database includes test data:
- 10 customers from different cities
- 20 products in various categories
- 15 orders with different statuses
- Payment records for each order

This provides realistic data for testing all queries and reports.