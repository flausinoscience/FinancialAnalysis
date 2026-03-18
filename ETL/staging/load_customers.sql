TRUNCATE staging.customer;

INSERT INTO staging.customer (
    id, email, first_name, surname,
    sign_up_at, country_code, birth_date
)
SELECT 
    id, email, first_name, surname,
    sign_up_at, country_code, birth_date 
FROM public."Customer"
WHERE deleted_at IS NULL;