TRUNCATE staging.account_status;

INSERT INTO staging.account_status(
    id, name
)
SELECT
    id, name
FROM public."Account_Status"
WHERE deleted_at IS NULL;