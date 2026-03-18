TRUNCATE staging.account_type;

INSERT INTO staging.account_type(
    id, name
)
SELECT
    id, name
FROM public."Account_Type"
WHERE deleted_at IS NULL;