TRUNCATE staging.account;

INSERT INTO staging.account(
    id, customer_id, brokerage_id, type_id, currency_id,
	balance, opened_at, status_id
)
SELECT
    id, customer_id, brokerage_id, type_id, currency_id,
	balance, opened_at, status_id
FROM public."Account"
WHERE deleted_at IS NULL;
