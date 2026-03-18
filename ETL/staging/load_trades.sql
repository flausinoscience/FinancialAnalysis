TRUNCATE staging.trade;

INSERT INTO staging.trade(
    id, asset_id, account_id, type_id,
    quantity, price, traded_at, commission,
    is_flagged, reason_flag
)
SELECT
    id, asset_id, account_id, type_id,
    quantity, price, traded_at, commission,
    is_flagged, reason_flag
FROM public."Trade"
WHERE deleted_at IS NULL;