-- Creation of Databse and Tables
CREATE DATABASE Wave; 
CREATE TABLE users (
u_id integer PRIMARY KEY,
name text NOT NULL,
mobile text NOT NULL,
wallet_id integer NOT NULL,
when_created timestamp without time zone NOT NULL
);
CREATE TABLE transfers (
transfer_id integer PRIMARY KEY,
u_id integer NOT NULL,
source_wallet_id integer NOT NULL,
dest_wallet_id integer NOT NULL,
send_amount_currency text NOT NULL,
send_amount_scalar numeric NOT NULL,
receive_amount_currency text NOT NULL,
receive_amount_scalar numeric NOT NULL,
kind text NOT NULL,
dest_mobile text,
dest_merchant_id integer,
when_created timestamp without time zone NOT NULL
);
CREATE TABLE agents (
agent_id integer PRIMARY KEY,
name text,
country text NOT NULL,
region text,
city text,
subcity text,
when_created timestamp without time zone NOT NULL
);
CREATE TABLE agent_transactions (
atx_id integer PRIMARY KEY,
u_id integer NOT NULL,
agent_id integer NOT NULL,
amount numeric NOT NULL,
fee_amount_scalar numeric NOT NULL,
when_created timestamp without time zone NOT NULL
);
CREATE TABLE wallets (
wallet_id integer PRIMARY KEY,
currency text NOT NULL,
ledger_location text NOT NULL,
when_created timestamp without time zone NOT NULL
);

--Number 1
SELECT COUNT (*) FROM users;

---Number 2
SELECT COUNT (transfer_id) 
FROM "Wave1".transfers, "Wave1".users
WHERE transfers.u_id = users.u_id
AND transfers.send_amount_currency = 'CFA';

--Number 3
SELECT COUNT (distinct users.u_id)
FROM "Wave1".transfers, "Wave1".users 
WHERE transfers.u_id = users.u_id
AND transfers.send_amount_currency='CFA';

--Number 4
SELECT COUNT (atx_id) AS agents_transactions,
extract(MONTH from agent_transactions.when_created) AS Months
FROM "Wave1".agent_transactions, "Wave1".agents
WHERE agent_transactions.agent_id = agents.agent_id
AND agent_transactions.when_created 
BETWEEN '2018-01-01 00:00:00' AND '2018-12-31 23:59:59' GROUP BY
agent_transactions.when_created
ORDER BY agent_transactions.when_created ASC;

--Number 5
--Net depositors Count
SELECT COUNT (agents.agent_id) 
AS net_depositors 
FROM "Wave1".agent_transactions, "Wave1".agents
WHERE amount < 0 
AND agent_transactions.agent_id =agents.agent_id 
AND agent_transactions.when_created BETWEEN '2020-01-01 00:00:00' AND '2020-01-07 23:59:59';

-- Net withdrawals Count
SELECT COUNT (agents.agent_id) 
AS net_withdrawal 
FROM "Wave1".agent_transactions, "Wave1".agents
WHERE amount > 0 
AND agent_transactions.agent_id =agents.agent_id 
AND agent_transactions.when_created BETWEEN '2020-04-01 00:00:00' AND '2020-04-07 23:59:59';

--Number 6
SELECT COUNT (atx_id) 
AS volume, City 
FROM "Wave1".agent_transactions,"Wave1".agents
WHERE agent_transactions.when_created BETWEEN '2020-04-01 00:00:00' AND '2020-04-07 23:59:59'
GROUP BY City;

--Number 7
SELECT COUNT (atx_id) 
AS volume, City, Country
FROM "Wave1".agent_transactions,"Wave1".agents
WHERE agent_transactions.when_created BETWEEN '2020-04-01 00:00:00' AND '2020-01-07 23:59:59'
GROUP BY City, Country;

--Number 8
SELECT ledger_location AS Country, kind AS transfer_kind,
COUNT(send_amount_scalar) 
AS volume 
FROM "Wave1".agent_transactions,"Wave1".wallets, "Wave1".transfers 
WHERE transfers.source_wallet_id= wallets.wallet_id
AND agent_transactions.when_created BETWEEN '2020-04-01 00:00:00' AND '2020-04-07 23:59:59'
GROUP BY Country,kind;

--Number 9
SELECT ledger_location AS Country, kind AS transfer_kind
, COUNT(transfers.u_id) AS transaction_count, COUNT(distinct transfers.u_id) AS
unique_users,
COUNT(send_amount_scalar) 
AS volume, users.name AS names_ 
FROM "Wave1".agent_transactions,"Wave1".wallets, "Wave1".transfers, "Wave1".users 
WHERE transfers.source_wallet_id= wallets.wallet_id AND transfers.u_id = users.u_id
AND agent_transactions.when_created BETWEEN '2020-04-01 00:00:00' AND '2020-04-07 23:59:59'
GROUP BY Country,kind, users.name;

--Number 10 
SELECT wallet_id, send_amount_scalar
FROM "Wave1".transfers,"Wave1".wallets 
WHERE wallets.wallet_id= transfers.source_wallet_id
AND transfers.send_amount_scalar >10000000
AND transfers.send_amount_currency='CFA' 
AND wallets.when_created BETWEEN'2020-03-01 00:00:00' AND '2020-04-01 23:59:59'


-- Kindly check the README file for thought process and assumptions. 