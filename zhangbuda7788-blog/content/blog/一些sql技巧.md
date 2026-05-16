+++
title = "一些sql技巧"
date = "2024-11-19T22:48:17+08:00"
tags = ["c_cpp", "git", "sql"]
slug = "一些sql技巧"
+++

# sql 的一些技巧


## sql 与时间相关的用法


- 获取当前时间
now() 返回当前的日期和时间 (YYYY-MM-DD HH:MM:SS)
current_date()  返回当前的日期 (YYYY-MM-DD)
current_time() 返回当前的时间(HH:MM:SS)
curdate() 返回当前的日期 类似 current_date
curtime() 返回当前的时间 类似 current_time


```
SELECT NOW();          -- 获取当前时间
SELECT CURRENT_DATE;   -- 获取当前日期
```

- 日期与时间运算
date_add() 或 date_sub() 分别用来加、减指定的时间间隔


```
SELECT DATE_ADD(NOW(), INTERVAL 5 DAY);  -- 当前时间加 5 天
SELECT DATE_SUB(NOW(), INTERVAL 2 HOUR); -- 当前时间减去 2 小时
```

- 比较日期和时间
日期比较，直接比较date、datetime字段，比如运算符 =、<、>、<=、>=


```
SELECT * FROM orders WHERE order_date > '2024-01-01';
`时间区间比较，通过 between 操作符在指定时间范围内查询记录

`SELECT * FROM events WHERE event_date BETWEEN '2024-01-01' AND '2024-12-31';
`timestampdiff() 计算两个日期时间之间的差异，计算天数、小时、分钟

`SELECT TIMESTAMPDIFF(DAY, '2024-01-01', NOW()); -- 计算当前日期与 2024-01-01 之间的天数
`datediff() 返回两个日期之间的天数差

`SELECT DATEDIFF(NOW(), '2024-01-01'); -- 返回当前日期与指定日期的天数差
`日期格式化, date_format() 格式化日期时间值，返回指定格式的字符串

`SELECT DATE_FORMAT(NOW(), '%Y-%m-%d');  -- 格式化为 '2024-11-14'
SELECT DATE_FORMAT(NOW(), '%H:%i:%s');  -- 格式化为 '14:30:25'
`常见格式符：

%Y：四位年份（如 2024）
%m：月份（01 到 12）
%d：日期（01 到 31）
%H：小时（00 到 23）
%i：分钟（00 到 59）
%s：秒（00 到 59）

=================================

获取特定的日期部分:

YEAR()：返回日期的年份部分。
MONTH()：返回日期的月份部分。
DAY()：返回日期的日部分。
HOUR()：返回时间的小时部分。
MINUTE()：返回时间的分钟部分。
SECOND()：返回时间的秒部分。

`SELECT YEAR(NOW());    -- 获取当前年份
SELECT MONTH(NOW());   -- 获取当前月份
SELECT DAY(NOW());     -- 获取当前日期

SELECT UNIX_TIMESTAMP(NOW()); -- 当前时间的时间戳
SELECT UNIX_TIMESTAMP('2024-01-01 00:00:00'); -- 指定时间的时间戳

SELECT FROM_UNIXTIME(1609459200); -- 转换时间戳为日期时间

SELECT * FROM events WHERE event_date > NOW() - INTERVAL 1 WEEK;  -- 最近一周内的事件

SELECT DATE(created_at) AS day, COUNT(*) FROM orders GROUP BY day;  -- 按天统计订单数量
SELECT MONTH(created_at) AS month, COUNT(*) FROM orders GROUP BY month;  -- 按月统计订单数量
```
