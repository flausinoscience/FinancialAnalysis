TRUNCATE staging.country;

INSERT INTO staging.country(
    code, name
)
SELECT
    code, name
FROM public."Country"
WHERE deleted_at IS NULL;