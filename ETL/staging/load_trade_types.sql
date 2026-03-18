TRUNCATE staging.trade_type;

INSERT INTO staging.trade_type(
    id, name
)
SELECT
    id, name
FROM public."Trade_Type"
WHERE deleted_at IS NULL;