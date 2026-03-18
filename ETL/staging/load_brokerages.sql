TRUNCATE staging.brokerage;

INSERT INTO staging.brokerage(
    id, name, country_code
)
SELECT
    id, name, country_code
FROM public."Brokerage"
WHERE deleted_at IS NULL;