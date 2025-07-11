# Order-Managment-System-SQL
# Order Management System - SQL Database

A complete database solution for managing customers, products, orders, and payments.

## What's Included

- **Customer Management**: Store customer information with proper validation
- **Product Catalog**: Track products with pricing and inventory
- **Order Processing**: Handle orders with status tracking
- **Payment System**: Record payments with different methods
- **Reporting**: Generate sales reports and customer analytics

## Database Tables

1. **customers** - Customer master data
2. **products** - Product catalog with pricing
3. **orders** - Order transactions with status
4. **order_items** - Individual items in each order
5. **payments** - Payment records and methods

## Setup Instructions

1. Clone this repository
2. Create a new database called `order_management`
3. Run `sql/database_script.sql` to create all tables
4. Use `sql/sample_data.sql` to add test data
5. Try the queries in `sql/test_queries.sql`

## Project Structure

```
├── sql/
│   ├── database_script.sql      # Main database setup
│   ├── sample_data.sql          # Test data
│   └── test_queries.sql         # Example queries
├── diagrams/
│   └── er-diagram.png           # Database diagram
├── docs/
│   └── schema_documentation.md  # Table details
└── README.md
```

## Key Features

- **Joins**: Connect customers with their orders
- **Aggregations**: Calculate total sales per customer
- **Filtering**: Find orders by date range and status
- **Indexes**: Optimized for fast queries
- **Views**: Pre-built reports for easy access

## Sample Queries

```sql
-- Recent orders with customer info
SELECT c.first_name, c.last_name, o.order_date, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL '30 days';

-- Total sales per customer
SELECT c.first_name, c.last_name, SUM(o.total_amount) as total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- Daily sales report
SELECT DATE(order_date) as sale_date, 
       COUNT(*) as total_orders,
       SUM(total_amount) as daily_sales
FROM orders
WHERE status != 'cancelled'
GROUP BY DATE(order_date)
ORDER BY sale_date DESC;
```

## Testing

All queries tested with sample data. Database includes:
- 10 sample customers
- 20 products across different categories
- 15 orders with various statuses
- Multiple payment records

## Database Compatibility

Works with:
- PostgreSQL 12+
- MySQL 8.0+

## Author

Niyas Naz