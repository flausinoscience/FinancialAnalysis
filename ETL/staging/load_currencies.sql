TRUNCATE staging.currency;

INSERT INTO staging.currency(
    id, name
)
SELECT 
    id, name
FROM public."Currency";
