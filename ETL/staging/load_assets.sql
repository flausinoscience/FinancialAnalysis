TRUNCATE staging.asset;

INSERT INTO staging.asset(
    id, ticker, name, type_id, currency_id    
)
SELECT
    id, ticker, name, type_id, currency_id    
FROM public."Asset" 
WHERE deleted_at IS NULL;
