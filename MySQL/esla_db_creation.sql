-- Create database
CREATE DATABASE IF NOT EXISTS Esla;

-- Select Esla database
USE Esla;

-- Create tables
-- location table
CREATE TABLE IF NOT EXISTS location (
	location_id INT NOT NULL,
    street_address VARCHAR(30),
    unit VARCHAR(15),
    city VARCHAR(30),
    sate VARCHAR(30),
	country VARCHAR(30),
    zip_code VARCHAR(30),
    PRIMARY KEY (location_id)
);
CREATE INDEX idx_location_id ON location(location_id);

-- supplier table
CREATE TABLE IF NOT EXISTS supplier (
	supplier_id INT NOT NULL,
    supplier_name VARCHAR(25) NOT NULL,
    supplier_number INT,
    location_id INT NOT NULL,
    PRIMARY KEY (supplier_id),
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

-- customer table
CREATE TABLE IF NOT EXISTS customer (
	customer_id INT NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25),
    gender VARCHAR(15),
	email VARCHAR(30) NOT NULL,
    location_id INT NOT NULL,
    PRIMARY KEY(customer_id),
    FOREIGN KEY(location_id) REFERENCES location(location_id)
    );
    
-- customer social media table
CREATE TABLE IF NOT EXISTS customer_social_media (
	customer_id INT NOT NULL,
    social_media_type VARCHAR(25) NOT NULL,
    social_media_username VARCHAR(50) NOT NULL,
    PRIMARY KEY(customer_id, social_media_type),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id) 
);
    
-- product table
CREATE TABLE IF NOT EXISTS product (
	product_id INT NOT NULL,
    name_portuguese VARCHAR(25),
    name_english VARCHAR(25),
    description VARCHAR(80),
    unit_buy_cost_real FLOAT NOT NULL,
    unit_buy_cost_dollar FLOAT NOT NULL,
    unit_selling_cost_real FLOAT NOT NULL,
    unit_selling_cost_dollar FLOAT NOT NULL,
    quantity_in_stock INT NOT NULL,
    supplier_id INT NOT NULL,
    PRIMARY KEY (product_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

-- purchases
CREATE TABLE IF NOT EXISTS purchase (
	purchase_id INT NOT NULL AUTO_INCREMENT,
    timestamp TIMESTAMP NOT NULL,
    unit_cost FLOAT NOT NULL,
    quantity INT NOT NULL,
    total_cost FLOAT NOT NULL,
    dollar_today FLOAT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (purchase_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- sales
CREATE TABLE IF NOT EXISTS sale (
	sale_id INT NOT NULL AUTO_INCREMENT,
    timestamp TIMESTAMP NOT NULL,
    customer_id INT NOT NULL,
    unit_cost FLOAT NOT NULL,
    quantity INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (sale_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- feedback
CREATE TABLE IF NOT EXISTS customer_feedback (
	feedback_id INT NOT NULL AUTO_INCREMENT,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating_stars INT,
    comments VARCHAR(200),
    PRIMARY KEY (feedback_id),
    FOREIGN KEY (sale_id) REFERENCES sale(sale_id),
    FOREIGN KEY  (product_id) REFERENCES product(product_id),
	FOREIGN KEY  (customer_id) REFERENCES customer(customer_id)
    );