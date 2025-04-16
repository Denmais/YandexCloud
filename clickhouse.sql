CREATE TABLE if not exists orders (
    order_id bigint,
    user_id bigint,
    order_date timestamp,
    total_amount float,
    payment_status text)
  ENGINE = MergeTree
  ORDER BY order_id;

CREATE table order_items (
  item_id bigint,
  order_id bigint,
  product_name text,
  product_price float,
  quantity bigint)
  ENGINE = MergeTree
  ORDER BY item_id;

insert into table orders values
(1001,10,'2023-03-01 10:00:00',1200.0,'paid'),
(1002,11,'2023-03-01 10:05:00',999.5,'pending'),
(1003,10,'2023-03-01 10:10:00',0.0,'cancelled'),
(1004,12,'2023-03-01 11:00:00',1450.0,'paid'),
(1005,10,'2023-03-01 12:00:00',500.0,'paid'),
(1006,13,'2023-03-02 09:00:00',2100.0,'paid'),
(1007,14,'2023-03-02 09:30:00',300.0,'pending'),
(1008,15,'2023-03-02 10:00:00',450.0,'paid'),
(1009,10,'2023-03-02 10:15:00',1000.0,'pending'),
(1010,11,'2023-03-02 11:00:00',799.0,'paid'),
(1011,12,'2023-03-02 12:00:00',120.0,'cancelled'),
(1012,13,'2023-03-03 08:00:00',2000.0,'paid'),
(1013,15,'2023-03-03 09:00:00',450.0,'paid'),
(1014,15,'2023-03-03 09:30:00',899.99,'paid'),
(1015,14,'2023-03-03 10:00:00',1350.0,'paid'),
(1016,10,'2023-03-03 11:00:00',750.0,'pending');





insert into table order_items VALUES
(1, 1001, 'Smartphone', 600.0, 2),
(2, 1002, 'Laptop', 999.5, 1),
(3, 1004, 'Monitor', 300.0, 2),
(4, 1004, 'Keyboard', 50.0, 1),
(5,1007,'Mouse',25.0,2),
(6,1010,'Laptop',799.0,1),
(7,1019,'Laptop',1100.0,2),
(8,1020,'Speaker',185.5,3),
(9,1009,'Tablet',500.0,2),
(10,1011,'PhoneCase',20.0,3),
(11,1012,'GamingConsole',650.0,3),
(12,1013,'Book',15.0,10),
(13,1014,'Smartwatch',300.0,1),
(14,1015,'Monitor',300.0,2),
(15,1015,'Keyboard',50.0,1),
(16,1016,'Camera',250.0,2);


-- Группировка по payment_status: подсчитываем количество заказов, сумму (total_amount), среднюю стоимость заказа.
select payment_status, count(payment_status) as order_count, sum(total_amount) as total_sum, avg(total_amount) from orders GROUP by payment_status


--JOIN с order_items: подсчитать общее количество товаров, общую сумму, среднюю цену за продукт.
select product_name, sum(total_amount) as sum_total, avg(total_amount) from order_items join orders on  orders.order_id=order_items.order_id group by product_name

--Отдельно посмотреть статистику по датам (количество заказов и их суммарная стоимость за каждый день).
select toDayOfMonth(order_date), sum(total_amount), count(order_id) from orders GROUP by toDayOfMonth(order_date);

--Выделить «самых активных» пользователей (по сумме заказов или по количеству заказов).
select user_id, sum(total_amount) as sum_total from orders group by user_id order by user_id;


