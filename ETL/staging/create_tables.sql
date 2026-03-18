CREATE TABLE IF NOT EXISTS staging.country(
    code CHAR(2),
    name VARCHAR(255),

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.customer(
    id UUID NOT NULL,
    email VARCHAR(255),
    first_name VARCHAR(255),
    surname VARCHAR(255),
    sign_up_at TIMESTAMP,
    country_code CHAR(2),
    birth_date DATE,

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.brokerage(
   id UUID,
   name VARCHAR(255),
   country_code CHAR(2),

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.currency(
   id SMALLINT,
   name CHAR(3),

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.account_type(
   id SMALLINT,
   name VARCHAR(255),

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.account_status(
   id SMALLINT,
   name VARCHAR(255),

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.account(
    id UUID,
    customer_id UUID,
    brokerage_id UUID,
    type_id SMALLINT,
    currency_id SMALLINT,
	balance NUMERIC(18, 4),
    opened_at TIMESTAMP,
    status_id SMALLINT,
    
    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.asset_type(
   id SMALLINT,
   name TEXT,

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.asset(
    id UUID,
    ticker TEXT,
    name TEXT,
    type_id SMALLINT,
    currency_id SMALLINT,

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.trade_type(
   id SMALLINT,
   name VARCHAR(255),

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.trade(
    id UUID,
    asset_id UUID,
    account_id UUID,
    type_id SMALLINT,
	quantity NUMERIC(18,6), 
	price NUMERIC(18,6), 
	traded_at TIMESTAMP, 
	commission NUMERIC(18,6), 
	is_flagged BOOLEAN, 
	reason_flag TEXT,

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.position(
    id UUID,
    account_id UUID,
    asset_id UUID,
    quantity NUMERIC(18,6), 
	avg_price NUMERIC(18,6), 

    _loaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staging.market_price(
	id BIGINT,
	asset_id UUID,
	price_at TIMESTAMP,
	price NUMERIC(18, 6),

    _loaded_at TIMESTAMP DEFAULT NOW()
);
