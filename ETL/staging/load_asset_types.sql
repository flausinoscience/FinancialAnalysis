TRUNCATE staging.asset_type;

INSERT INTO staging.asset_type(
    id, name
)
SELECT
    id, name
FROM public."Asset_Type"
WHERE deleted_at IS NULL;