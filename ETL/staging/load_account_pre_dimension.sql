TRUNCATE staging.account_pre_dimension;

INSERT INTO staging.account_pre_dimension(
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
	hash_diff
)
SELECT
	acc.id account_id,
	acc_t.name account_type,
	acc_s.name account_status,
	brk_country.name account_country,
	currency.name currency,
	acc.opened_at,
	c.email owner_email,
	c.first_name owner_first_name,
	c.surname owner_last_name,
	c_country.name owner_country,
	c.birth_date owner_birth_date,
	c.sign_up_at owner_sign_up_at,
	md5(
		concat_ws('|',
			coalesce(acc_t.name, ''),
			coalesce(acc_s.name,''),
			coalesce(brk_country.name,''),
			coalesce(currency.name,''),
			coalesce(acc.opened_at::text,''),
			coalesce(c.email,''),
			coalesce(c.first_name,''),
			coalesce(c.surname,''),
			coalesce(c_country.name,''),
			coalesce(c.birth_date::text,''),
			coalesce(c.sign_up_at::text,'')
		)
	) hash_diff
FROM staging.account acc
LEFT JOIN staging.account_type acc_t
	ON acc.type_id = acc_t.id
LEFT JOIN staging.account_status acc_s
	ON acc.status_id = acc_s.id
LEFT JOIN staging.brokerage bkr
	ON acc.brokerage_id = bkr.id
LEFT JOIN staging.country brk_country
	ON brk_country.code = bkr.country_code
LEFT JOIN staging.currency currency
	ON acc.currency_id = currency.id
INNER JOIN staging.customer c
	ON c.id = acc.customer_id
LEFT JOIN staging.country c_country
	ON c.country_code = c_country.code
;

