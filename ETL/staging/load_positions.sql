TRUNCATE staging.position;

INSERT INTO staging.position(
    id, account_id, asset_id, quantity, avg_price
)
SELECT 
    id, account_id, asset_id, quantity, avg_price
FROM public."Position"
WHERE deleted_at IS NULL;