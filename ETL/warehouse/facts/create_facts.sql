CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS dw.fact_trade(
    trade_sk BIGSERIAL PRIMARY KEY,
    trade_info_key INT REFERENCES dw.dim_trade_info(trade_info_sk) NOT NULL,
    account_key INT REFERENCES dw.dim_account(account_sk) NOT NULL,
    brokerage_key INT REFERENCES dw.dim_brokerage(brokerage_sk) NOT NULL,
    asset_key INT REFERENCES dw.dim_asset(asset_sk) NOT NULL,
    trade_date_key INT REFERENCES dw.dim_date(date_sk) NOT NULL,
    trade_id UUID NOT NULL,
    traded_at TIMESTAMP NOT NULL,

	quantity NUMERIC(18,6) CHECK (quantity > 0), 
	price NUMERIC(18,6) CHECK (price >= 0), 
	commission NUMERIC(18,6) CHECK (commission >= 0), 
);