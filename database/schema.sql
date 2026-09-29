-- Production Cost & Inventory Automation
-- Database schema derived from the documented Supabase table structure.
--
-- Notes:
-- - Primary keys and explicitly documented UNIQUE constraints are preserved.
-- - Nullable columns are left nullable.
-- - Foreign keys/default values/check constraints are not added because they
--   were not specified in the provided schema documentation.

CREATE TABLE products (
    id uuid PRIMARY KEY,
    name text,
    sku text UNIQUE,
    unit text,
    selling_price numeric,
    created_at timestamptz
);

CREATE TABLE suppliers (
    id uuid PRIMARY KEY,
    name text,
    phone text,
    address text,
    created_at timestamptz
);

CREATE TABLE raw_materials (
    id uuid PRIMARY KEY,
    name text,
    unit text,
    minimum_quantity numeric,
    created_at timestamptz,
    material_type text
);

CREATE TABLE raw_material_purchases (
    id uuid PRIMARY KEY,
    raw_material_id uuid,
    supplier_id uuid,
    quantity numeric,
    unit_price numeric,
    shipping_cost numeric,
    total_cost numeric,
    purchase_date date,
    created_at timestamptz
);

CREATE TABLE production_batches (
    id uuid PRIMARY KEY,
    product_id uuid,
    batch_number text UNIQUE,
    quantity_produced numeric,
    production_date date,
    expiry_date date,
    labor_cost numeric,
    electricity_cost numeric,
    shipping_cost numeric,
    other_cost numeric,
    total_material_cost numeric,
    total_production_cost numeric,
    unit_cost numeric,
    created_at timestamptz,
    production_request_id uuid
);

CREATE TABLE production_materials (
    id uuid PRIMARY KEY,
    production_batch_id uuid,
    raw_material_id uuid,
    quantity_used numeric,
    unit_cost numeric,
    total_cost numeric
);

CREATE TABLE sales_reps (
    id uuid PRIMARY KEY,
    name text,
    phone text,
    status text,
    created_at timestamptz
);

CREATE TABLE customers (
    id uuid PRIMARY KEY,
    name text,
    phone text,
    address text,
    created_at timestamptz
);

CREATE TABLE orders (
    id uuid PRIMARY KEY,
    customer_id uuid,
    rep_id uuid,
    order_date timestamptz,
    status text,
    payment_status text,
    subtotal numeric,
    discount numeric,
    shipping_cost numeric,
    total_amount numeric,
    notes text,
    created_at timestamptz
);

CREATE TABLE order_items (
    id uuid PRIMARY KEY,
    order_id uuid,
    product_id uuid,
    production_batch_id uuid,
    quantity numeric,
    unit_price numeric,
    unit_cost numeric,
    total_price numeric,
    total_cost numeric
);

CREATE TABLE expense_categories (
    id uuid PRIMARY KEY,
    name text UNIQUE,
    created_at timestamptz
);

CREATE TABLE expenses (
    id uuid PRIMARY KEY,
    category_id uuid,
    description text,
    amount numeric,
    expense_date date,
    production_batch_id uuid,
    created_at timestamptz
);

CREATE TABLE inventory_movements (
    id uuid PRIMARY KEY,
    product_id uuid,
    production_batch_id uuid,
    rep_id uuid,
    movement_type text,
    quantity numeric,
    reference_type text,
    reference_id uuid,
    movement_date timestamptz,
    notes text
);

CREATE TABLE raw_material_movements (
    id uuid PRIMARY KEY,
    raw_material_id uuid,
    movement_type text,
    quantity numeric,
    reference_id uuid,
    movement_date timestamptz,
    notes text
);

CREATE TABLE product_formulas (
    id uuid PRIMARY KEY,
    product_id uuid,
    formula_name text,
    batch_size numeric,
    unit text,
    status text,
    created_at timestamptz
);

CREATE TABLE product_formula_items (
    id uuid PRIMARY KEY,
    formula_id uuid,
    raw_material_id uuid,
    material_name text,
    quantity numeric,
    unit text,
    created_at timestamptz
);

CREATE TABLE order_item_batches (
    id uuid PRIMARY KEY,
    order_item_id uuid,
    production_batch_id uuid,
    quantity numeric,
    unit_cost numeric,
    total_cost numeric,
    created_at timestamptz
);
