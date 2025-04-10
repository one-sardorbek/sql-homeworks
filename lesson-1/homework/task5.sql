use mySql
create table account(
	account_id int primary key,
	balance float constraint CC_balance check (balance > 0),
	account_type varchar(100) constraint CC_account_type check (account_type = 'Saving' or account_type = 'Checking')
)
alter table account
drop constraint CC_balance,CC_account_type
alter table account
add constraint  CC_balance check (balance > 0)
alter table account
add constraint CC_account_type check (account_type = 'Saving' or account_type = 'Checking')
