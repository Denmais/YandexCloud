

create table logs (
log_id bigint,
transaction_id bigint,
category string,
comment string,
log_timestamp timestamp
);

insert into table logs
values (1, 10001, 'Electronics', 'User bought a phone', '2023-03-10 14:26:00');
(2, 10002, 'Travel', 'Flight ticket to Europe', '2023-03-10 14:31:00'),
(3, 99999, 'System', 'Unrelated transaction', '2023-03-10 14:40:00'),
(4, 10004, 'System', 'Weird currency ???', '2023-03-10 15:15:00'),
(5, 10006, 'Electronics', 'Laptop purchase', '2023-03-11 09:10:00'),
(6, 10007, 'Misc', 'Zero amount transaction?', '2023-03-11 10:11:00'),
(7, 10010, 'Electronics', 'Gaming console', '2023-03-12 11:06:00'),
(8, 11111, 'System', 'No valid transaction link', '2023-03-14 08:55:00'),
(9, 10010, 'Electronics', 'Gaming console extended', '2023-03-12 11:07:00'),
(10, 10013, 'Misc', 'Extra big sum transaction?', '2023-03-13 09:01:00'),
(11, 11111, 'System', 'Still no valid transaction link', '2023-03-14 08:56:00'),
(12, 10014, 'Electronics', 'Laptop purchase with discount', '2023-03-13 09:06:00'),
(13, 10015, 'Other', 'Unexpected currency GBP', '2023-03-13 09:11:00'),
(14, 10020, 'Misc', 'Negative sum check again', '2023-03-14 10:21:00'),
(15, 99998, 'System', 'Random noise entry', '2023-03-14 10:25:00'),
(16, 10019, 'Travel', 'Flight to Europe?', '2023-03-14 10:11:00');




create table transactions (
transaction_id bigint,
user_id bigint, 
amount numeric,
currency varchar(5),
transaction_date timestamp,
is_fraud int
);
insert into table transactions 
values (10001,500,250.0,'USD','2023-03-10 14:25:00',0),
(10002,500,300.5,'EUR','2023-03-10 14:30:00',1),
(10003,501,-10.0,'USD','2023-03-10 15:00:00',0),
(10004,502,400.0,'???','2023-03-10 15:10:00',0),
(10005,501,120.5,'RUB','2023-03-11 09:00:00',1),
(10006,503,999.0,'USD','2023-03-11 09:05:00',0),
(10007,504,0.0,'USD','2023-03-11 10:10:00',1),
(10008,504,750.0,'EUR','2023-03-11 10:20:00',1),
(10009,500,275.25,'RUB','2023-03-12 11:00:00',0),
(10010,500,600.0,'USD','2023-03-12 11:05:00',1),
(10011,505,45.5,'GBP','2023-03-12 11:10:00',0),
(10012,505,-25.0,'USD','2023-03-12 11:15:00',1),
(10013,506,9999.99,'USD','2023-03-13 09:00:00',1),
(10014,506,120.5,'EUR','2023-03-13 09:05:00',0),
(10015,507,500.0,'GBP','2023-03-13 09:10:00',1),
(10016,507,123.45,'???','2023-03-13 09:15:00',0),
(10017,508,0.0,'RUB','2023-03-14 10:00:00',1),
(10018,508,450.0,'USD','2023-03-14 10:05:00',0),
(10019,509,1000.0,'EUR','2023-03-14 10:10:00',0),
(10020,509,-75.5,'RUB','2023-03-14 10:20:00',1);



-- Фильтрация «хороших» валют (USD, EUR, RUB), подсчёт суммарной суммы транзакций по каждой валюте.
select currency, sum(amount) as total_amount from transactions t group by currency having currency in ('USD', 'EUR', 'RUB');



--Подсчёт количества мошеннических (is_fraud=1) и нормальных (is_fraud=0) транзакций, суммарной суммы и среднего чека.
select sum(is_fraud) as fraud_count, count(is_fraud)-sum(is_fraud) as is_not_fraud, sum(amount) as total_amount, avg(amount) as avg_amount  from transactions;

-- Группировка по датам с вычислением ежедневного количества транзакций, суммарного объёма и среднего amount.
select count(transaction_id) as count_transactions, sum(amount) as total_amount, avg(amount) as avg_amount from transactions group by transaction_date;


--Использование временных функций (например, извлечение дня/месяца из transaction_date) и анализ транзакций по временным интервалам.
select date_format(transaction_date ,'d') as day, sum(amount) as total_amount, count(amount) as count_amount from transactions
group by date_format(transaction_date ,'d'); 


--Использование временных функций (например, извлечение дня/месяца из transaction_date) и анализ транзакций по временным интервалам.
select transaction_id, count(log_id) from logs as l
join transactions as t on t.transaction_id = l.transaction_id
group by l.transaction_id;








