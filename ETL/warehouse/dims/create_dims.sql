CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- SCD Type 2
CREATE TABLE IF NOT EXISTS dw.dim_account(
    account_sk SERIAL PRIMARY KEY,
    account_id UUID NOT NULL,
    account_type VARCHAR(45),
    account_status VARCHAR(45),
    account_country VARCHAR(45),
    currency CHAR(3),
    opened_at TIMESTAMP,
    owner_email VARCHAR(255) NOT NULL,
    owner_first_name VARCHAR(255),
    owner_last_name VARCHAR(255),
    owner_country VARCHAR(255),
    owner_birth_date DATE,
    owner_sign_up_at TIMESTAMP,

    hash_diff TEXT NOT NULL,
    valid_from TIMESTAMP NOT NULL,
    valid_to TIMESTAMP,
    is_current BOOLEAN NOT NULL,
    deleted_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dw.dim_brokerage(
    brokerage_sk SERIAL PRIMARY KEY,
    brokerage_id UUID NOT NULL,
    name VARCHAR(255),
    country VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS dw.dim_asset(
    asset_sk SERIAL PRIMARY KEY,
    asset_id UUID NOT NULL,
    ticker TEXT NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    currency CHAR(3)
);

-- Junk Dimension
CREATE TABLE IF NOT EXISTS dw.dim_trade_info(
    trade_info_sk SERIAL PRIMARY KEY,
    trade_type_id SMALLINT NOT NULL,
    trade_type_name VARCHAR(255) NOT NULL,
    is_flagged BOOLEAN,
    reason_flag TEXT
);

CREATE TABLE IF NOT EXISTS dw.dim_date(
    date_sk INT PRIMARY KEY, -- YYYYMMDD
    full_date DATE NOT NULL,

    day INT NOT NULL,
    day_name VARCHAR(10) NOT NULL,
    day_of_week INT NOT NULL,
    day_of_year INT NOT NULL,

    week_of_year INT NOT NULL,

    month INT NOT NULL,
    month_name VARCHAR(10) NOT NULL,
    month_start_date DATE NOT NULL,
    month_end_date DATE NOT NULL,

    quarter INT NOT NULL,
    quarter_name CHAR(2) NOT NULL,

    year INT NOT NULL,

    is_weekend BOOLEAN NOT NULL
);