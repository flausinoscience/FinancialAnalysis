TRUNCATE staging.market_price;

INSERT INTO staging.market_price(
    id, asset_id, price_at, price
)
SELECT
    id, asset_id, price_at, price
FROM public."Market_Price"
WHERE deleted_at IS NULL;