+++
title = "Sql_note"
date = "2024-08-19T23:30:26+08:00"
tags = ["mysql"]
slug = "sql_note"
+++

# sql_note

> 说来惭愧，之前sql 学的就不怎么样，总是写一些很low 的语句，然后现在数据量上来的，得把基础打的更扎实一些才好。


## 一些tips

> sql 其实很像一门脚本，当然 .sql 也确实是脚本语言，它也有一些脚本语言的特色(比如简洁)
> 当然 tips 也是一阵子一阵的持续更新


### 重命名

sql 的重命名有两种表示的方式，一个是用 as，另一个是直接写别名(当然哈，这就是省略了 as 关键字)

> 重命名 表名

```
select column_name as alias_name
from table_name;

# 省略关键字
select column_name alias_name
from table_name;
`> 重命名表名

`select column_name
from table_name as alias_name;
`> 重命计算字段

`select price * quantity as total
from orders;
`> 重命名子查询的结果

`select alias_name.column_name
from (select * from table_name) as alias_name;
`往往 重命名会在一些复杂的语句中出现


## 基本规则


### 排序

order by desc/asc

排序有降序和升序。其中降序为 desc，升序为 asc。注意：默认是升序排列。

比如查看employees 查询工人的所有字段，根据工资


- 降序排列&升序排列


> 按照工资降序排列

`select *
from employees
order by salary desc;
`> 按照工资 升序排列

`select *
from employees
order by salary asc;
```

- 多列排序


> 多列排序，会先进行第一列排序，如果第一列排序是一样的，就进行第二列排序。

> 查表，先根据department_id 升序，如果department_id 相同，再对salary 进行降序排序。

```
select * 
from employees
order by department_id asc, salary desc;
```

- 按索引排序


```
select first_name, last_name, salary
from employees
order by 3 desc;
```

- 组合排序


> 先按照部门id 升序排列，再按照薪水降序排列

```
select first_name, last_name, salary, department_id
from employees
order by department_id asc, salary desc;
```

- 性能分析


> 对于大表或者复杂的排序条件，排序操作可能会造成性能下降。对此，可以采用索引、LIMIT/OFFSET

索引这片文章会另立。
先讲讲 limit 以及 offset

> 返回薪水最高的前十员工

`select * 
from employees
order by salary desc
limit 10;
`> 排序与分页
> 按薪水排列返回第20～30的员工(限制 只要10个员工的数据，然后 offset 偏移20个，也就是跳过前2页，显示第2页)

`select *
from employees
order by salary desc
limit 10 offset 20;
`还有另外一种表达方式

`select *
from table
order by column_name desc
limit skip, count;
# 这和上面显示第3页的结果是一致的
select *
from employees
order by salary desc
limit 20, 10;
`还有另另外一种方式

> offset skip rows 跳过的行数
> fetch next count rows only 获取的行数

`select * 
from employees
order by salary desc
offset 20 rows fetch next 10 rows only;
`关键词：分页优化、避免深分页、前端分页、后端分页

[sql 入门](https://github.com/jaywcjlove/mysql-tutorial)


## crud


### 1


### sql 语句分类

> 数据定义语言 DDL(Data Definition Language)
> 数据查询语言 DQL(Data Query Language)
> 数据操纵语言 DML(Date Manipulation Language)
> 数据控制语言 DCL(Date Control Language)


## 分析工具、备份
