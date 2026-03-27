BEGIN;

MERGE INTO dw.dim_account dim
USING staging.account_pre_dimension src
    ON dim.account_id = src.account_id AND dim.is_current = TRUE
-- expire current data warehouse rows (insert updated rows later using INSERT INTO)  
-- for now just expire the dw rows that are no longer current 
WHEN MATCHED AND src.hash_diff <> dim.hash_diff THEN
    UPDATE SET 
        valid_to = (CURRENT_TIMESTAMP - INTERVAL '100 millisecond'), 
        is_current = FALSE
-- soft delete from the data warehouse
WHEN NOT MATCHED BY SOURCE AND dim.is_current = TRUE THEN
    UPDATE SET
        valid_to = CURRENT_TIMESTAMP, is_current = FALSE,
        deleted_at = CURRENT_TIMESTAMP
-- insert new rows present only in source
WHEN NOT MATCHED THEN
    INSERT (
        account_id,
        account_type,
        account_status,
        account_country,
        currency,
        opened_at,
        owner_email,
        owner_first_name,
        owner_last_name,
        owner_country,
        owner_birth_date,
        owner_sign_up_at,
        hash_diff,
        valid_from,
        valid_to,
        is_current
    )
    VALUES (
        src.account_id,
        src.account_type,
        src.account_status,
        src.account_country,
        src.currency,
        src.opened_at,
        src.owner_email,
        src.owner_first_name,
        src.owner_last_name,
        src.owner_country,
        src.owner_birth_date,
        src.owner_sign_up_at,
        src.hash_diff,
        CURRENT_TIMESTAMP,
        NULL,
        TRUE
    )
;

-- now insert the rows that exists on the dw but were updated on the
-- source. We already expired the old rows in the dw in the MERGE, so there is no
-- is_current = TRUE for these natural keys:
INSERT INTO dw.dim_account(
    account_id,
    account_type,
    account_status,
    account_country,
    currency,
    opened_at,
    owner_email,
    owner_first_name,
    owner_last_name,
    owner_country,
    owner_birth_date,
    owner_sign_up_at,
    hash_diff,
    valid_from,
    valid_to,
    is_current
)
SELECT
    src.account_id,
    src.account_type,
    src.account_status,
    src.account_country,
    src.currency,
    src.opened_at,
    src.owner_email,
    src.owner_first_name,
    src.owner_last_name,
    src.owner_country,
    src.owner_birth_date,
    src.owner_sign_up_at,
    src.hash_diff,
    CURRENT_TIMESTAMP,
    NULL,
    TRUE
FROM staging.account_pre_dimension src
LEFT JOIN dw.dim_account dim
    ON src.account_id = dim.account_id
    AND dim.is_current = TRUE
WHERE 
    -- the rows that do not have a match on the dw 
    -- (because we expired them) on the MERGE.
    -- these rows are the ones that we need to insert
    dim.account_sk IS NULL
;

COMMIT;