CREATE SCHEMA IF NOT EXISTS sample;

-- Create table for subjects
CREATE TABLE sample.subjects (
    id VARCHAR(255) PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- Create table for heart rate data
CREATE TABLE sample.heart_rate (
    id VARCHAR(255) REFERENCES sample.subjects(id),
    date DATE NOT NULL,
    time TIME NOT NULL,
    value INT NOT NULL,
    PRIMARY KEY (id, date, time)
);

-- Create table for calories data
CREATE TABLE sample.calories (
    id VARCHAR(255) REFERENCES sample.subjects(id),
    date DATE NOT NULL,
    time TIME NOT NULL,
    value DECIMAL(10, 5) NOT NULL,
    mets INT,
    PRIMARY KEY (id, date, time)
);

-- Create table for weight data
CREATE TABLE sample.weight (
    id VARCHAR(255) REFERENCES sample.subjects(id),
    date DATE NOT NULL,
    time timeTZ NOT NULL,
    weight DECIMAL(10, 2) NOT NULL,
    bmi DECIMAL(10, 2),
    fat_percent DECIMAL(10, 2),
    source VARCHAR(255),
    PRIMARY KEY (id, date, time)
);

-- Import data from CSV into products table
COPY sample.subjects(id, start_date, end_date)
FROM '/data/fitbit_subjects.csv'
DELIMITER ','
CSV HEADER;

-- XXX: These fail with duplicate keys, but let's sort out the correct GeoMTS format and data before we import it

-- Import data from CSV into heart_rate table
-- COPY sample.heart_rate(id, date, time, value)
-- FROM '/data/fitbit_heart_rate.csv'
-- DELIMITER ','
-- CSV HEADER;

-- Import data from CSV into calories table
-- COPY sample.calories(id, date, time, value, mets)
-- FROM '/data/fitbit_calories.csv'
-- DELIMITER ','
-- CSV HEADER;

-- Import data from CSV into weight table
-- COPY sample.weight(id, date, time, weight, bmi, fat_percent, source)
-- FROM '/data/fitbit_weight.csv'
-- DELIMITER ','
-- CSV HEADER;