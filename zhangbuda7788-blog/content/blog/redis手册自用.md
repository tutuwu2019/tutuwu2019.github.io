+++
title = "Redis手册(自用)"
date = "2024-12-29T23:57:55+08:00"
tags = ["c_cpp", "mysql", "redis", "数据库"]
slug = "redis手册自用"
+++

# redis操作手册–自用


## 访问redis 服务器，并测试

`
redis-cli -h host -p port -a password
# 如果是直接在本地访问
redis-cli

127.0.0.1:6379> ping
PONG
127.0.0.1:6379> ping zhangbuda
"zhangbuda"
127.0.0.1:6379>
`
## 数据类型&增删改查

> 字符串、哈希、列表、集合、有序集合


### 字符串

```
127.0.0.1:6379> set zhangbuda 188
OK
127.0.0.1:6379> get zhangbuda
"188"
127.0.0.1:6379> del zhangbuda
(integer) 1
127.0.0.1:6379> get zhangbuda
(nil)
127.0.0.1:6379>

#######获取value 的长度(字符串) 、截取指定范围的内容(子字符串)、同时存储多个key、同时获取多个 key 的value、修改原来key的value，拼接字符串
set zhangbuda hello,world
OK
127.0.0.1:6379> get zhangbuda
"hello,world"
127.0.0.1:6379> getrange zhangbuda 2 4
"llo"
127.0.0.1:6379> getrange zhangbuda 0 4
"hello"
127.0.0.1:6379> strlen zhangbuda
(integer) 11
127.0.0.1:6379> mset zhangsan1 aaaaaa zhangsan2 bbbbbb zhangsan3 cccccc
OK
127.0.0.1:6379> mget zhangsan1 zhangsan2 zhangsan3
1) "aaaaaa"
2) "bbbbbb"
3) "cccccc"
127.0.0.1:6379> getset zhangsan1 dddddd
"aaaaaa"
127.0.0.1:6379> get zhangsan1
"dddddd"
127.0.0.1:6379> append zhangsan1 fffff
(integer) 11
127.0.0.1:6379> get zhangsan1
"ddddddfffff"
127.0.0.1:6379> strlen zhangsan1
(integer) 11
`为key 设置生效时间

`#在 Redis 中，EXPIRE 命令用于设置键（key）的生存时间（TTL，Time-to-Live），即指定键值对在指定的秒数后过期并自动删除。除了基本的过期时间设置，EXPIRE 命令也支持一些附加选项，如 NX、XX、GT 和 LT，用于在特定条件下设置过期时间。
# 比如在 300s 后失效
EXPIRE mykey 300
# 不存在，300，而如果存在则不进行任何操作
EXPIRE key 300 NX

# 仅仅存在是设置失效时间，300s后失效
EXPIRE key 300 XX

### 更新过期时间
# GT（仅当过期时间大于当前过期时间时才设置过期时间）
EXPIRE key 300 GT      # 如果key 的过期时间是10s，此时设置的300s 大于过期已有的过期时间，会更新过期时间

# LT（仅当过期时间小于当前过期时间时才设置过期时间）
EXPIRE key 300 LT      # 如果当前 的过期时间是 600s 此时设置的过期时间300s 小于已经设置的过期时间，会更新过期时间，执行命令后，key 的过期时间为300s
`其他操作

`检查key 是否存在
EXISTS key             ##检查给定 key 是否存在。
##序列化给定 key
DUMP key               ##序列化给定 key ，并返回被序列化的值。

PEXPIRE key milliseconds ##设置 key 的过期时间亿以毫秒计

MOVE key db             ##将当前数据库的 key 移动到给定的数据库 db 当中

PERSIST key             ##移除 key 的过期时间，key 将持久保持。

set zhangbuda 188
OK
127.0.0.1:6379> expire zhangbuda 200      # 设置过期时间为 200s
(integer) 1
127.0.0.1:6379> pttl zhangbuda            # 显示还有多少时间过期，单位毫秒
(integer) 191951
127.0.0.1:6379> ttl zhangbuda             # 显示还有多少时间过期，单位秒
(integer) 180
127.0.0.1:6379> persist zhangbuda          # 永久有效
(integer) 1
127.0.0.1:6379> ttl zhangbuda
(integer) -1
127.0.0.1:6379> type zhangbuda            # 返回key 的类型
string
127.0.0.1:6379> get zhangbuda
"188"
127.0.0.1:6379>
```
---


### 哈希

> 注意 主键key 必须唯一，比如，string 的key 与 hash 的 key 不能重复

```
### hmset 、hgetall
hmset zhangbuda2 name "tt is a tt" description "he is a worker" age "24 26"
OK
127.0.0.1:6379> hget zhangbuda2
(error) ERR wrong number of arguments for 'hget' command
127.0.0.1:6379> hgetall  zhangbuda2
1) "name"
2) "tt is a tt"
3) "description"
4) "he is a worker"
5) "age"
6) "24 26"

hexists zhangbuda2 name
(integer) 1
127.0.0.1:6379> hexists zhangbuda2 age
(integer) 1
127.0.0.1:6379> hdel zhangbuda2 age
(integer) 1
127.0.0.1:6379> hgetall zhangbuda2
1) "name"
2) "tt is a tt"
3) "description"
4) "he is a worker"
127.0.0.1:6379> hkeys zhangbuda2
1) "name"
2) "description"
127.0.0.1:6379> hlen zhangbuda2
(integer) 2
127.0.0.1:6379> hset zhangbuda2 name "zhangbuda"
(integer) 0
127.0.0.1:6379> hgetall zhangbuda2
1) "name"
2) "zhangbuda"
3) "description"
4) "he is a worker"
127.0.0.1:6379> hvals zhangbuda2
1) "zhangbuda"
2) "he is a worker"
127.0.0.1:6379>
```
### 链表

```
# 分批次插入链表中    lpush 就是不断往头部插入  rpush 就是不断往尾部插入
27.0.0.1:6379> lpush zhangbuda1229 zhang
(integer) 1
127.0.0.1:6379> lpush zhangbuda1229 zhang2
(integer) 2
127.0.0.1:6379> lpush zhangbuda1229 zhang2
(integer) 3
127.0.0.1:6379> lpush zhangbuda1229 zhang3
(integer) 4
127.0.0.1:6379> lpush zhangbuda1229 zhang4

## 查看插入结果，后插入的排在前面  从0开始到n-1     如果要打印所有元素  lrange zhangbuda1229 0 -1
127.0.0.1:6379> lrange zhangbuda1229 0 10
1) "zhang4"
2) "zhang3"
3) "zhang2"
4) "zhang2"
5) "zhang"

## 删除首个元素
127.0.0.1:6379> blpop zhangbuda1229 1
1) "zhangbuda1229"
2) "zhang4"

## 删除末尾元素
brpop zhangbuda1229 1
1) "zhangbuda1229"
2) "zhang"

## 往尾部继续插入元素
RPUSH zhangbuda1229 zhanbuda1 zhanbuda2 zhanbuda3
## 再往 zhangbuda2 后面插入一个元素 zhangbuda5
LINSERT zhangbuda1229 AFTER zhanbuda2 zhangbuda5
127.0.0.1:6379> LRANGE zhangbuda1229 0 -1
1) "zhang3"
2) "zhang2"
3) "zhang2"
4) "zhanbuda1"
5) "zhanbuda2"
6) "zhangbuda5"
7) "zhanbuda3"
# 往 zhangbuda5 后面插入 zhangbuda6
linsert zhangbuda1229 after zhangbuda5 zhangbuda6

# 往zhangbuda5 前面插入 zhangbuda4
linsert zhangbuda1229 before zhangbuda5 zhangbuda4
LRANGE zhangbuda1229 0 -1
1) "zhang3"
2) "zhang2"
3) "zhang2"
4) "zhanbuda1"
5) "zhanbuda2"
6) "zhangbuda4"
7) "zhangbuda5"
8) "zhangbuda6"
9) "zhanbuda3"
```
### 集合

```
### 单个插入或者插入多个、插入重复的元素、查看插入后的所有元素、插入后的元素个数
127.0.0.1:6379> sadd zhangbuda1229_2 zhang1
(integer) 1
127.0.0.1:6379> sadd zhangbuda1229_2 zhang2
(integer) 1
127.0.0.1:6379> sadd zhangbuda1229_2 zhang3
(integer) 1
127.0.0.1:6379> sadd zhangbuda1229_2 zhang4
(integer) 1
127.0.0.1:6379> sadd zhangbuda1229_2 zhang5 zhang6
(integer) 2
127.0.0.1:6379> sadd zhangbuda1229_2 zhang1
(integer) 0
127.0.0.1:6379> smembers zhangbuda1229_2
1) "zhang4"
2) "zhang1"
3) "zhang5"
4) "zhang2"
5) "zhang6"
6) "zhang3"
127.0.0.1:6379> scard zhangbuda1229_2
(integer) 6

### 比较 另一个 set 不同的元素有哪些
sadd zhangbuda1229_3 zhang1 zhang2 zhangbuda1 zhangbuda2
(integer) 4
127.0.0.1:6379> sdiff zhangbuda1229_2 zhangbuda1229_3
1) "zhang5"
2) "zhang3"
3) "zhang6"
4) "zhang4"

### 把两个 set 中相同的元素 复制到 新的set 中
sinterstore zhangbuda1229_4 zhangbuda1229_2 zhangbuda1229_3
(integer) 2
127.0.0.1:6379> smembers zhangbuda1229_4
1) "zhang2"
2) "zhang1"

### 删除指定元素
127.0.0.1:6379> smembers zhangbuda1229_2
1) "zhang5"
2) "zhang2"
3) "zhang6"
4) "zhang3"
5) "zhang1"
6) "zhang4"
127.0.0.1:6379> srem zhangbuda1229_2 zhang5
(integer) 1
127.0.0.1:6379> smembers zhangbuda1229_2
1) "zhang2"
2) "zhang6"
3) "zhang3"
4) "zhang1"
5) "zhang4"

### 随机删除 x 个元素
127.0.0.1:6379> smembers zhangbuda1229_2
1) "zhang2"
2) "zhang6"
3) "zhang3"
4) "zhang1"
5) "zhang4"
127.0.0.1:6379> scard zhangbuda1229_2
(integer) 5
127.0.0.1:6379> spop zhangbuda1229_2 2
1) "zhang3"
2) "zhang1"
127.0.0.1:6379> smembers zhangbuda1229_2
1) "zhang2"
2) "zhang6"
3) "zhang4"
```
### 有序集合

```
### 有序集合的增删改查
127.0.0.1:6379> zadd zhangbdua1229_6 1 'zhang' 2 'zhang2' 3 'zhang3'        # 同时插入多个有序元素  有序 == 分数
(integer) 3
127.0.0.1:6379> zcard zhangbuda1229_6
(integer) 0
127.0.0.1:6379> zcard zhangbdua1229_6                                        #  查 zhangbdua1229_6 有多少个元素个数
(integer) 3
127.0.0.1:6379> zrem zhangbdua1229_6 zhang2                                  # 删除 指定元素
(integer) 1
127.0.0.1:6379> zincrby zhangbdua1229_6 5 zhang3                              # 改  修改该元素的 分数  其实就是 执行加法
"8"
127.0.0.1:6379> zrangebyscore zhangbdua1229_6 1 10                            # 查指定范围内(根据分数)的元素
1) "zhang"
2) "zhang3"
127.0.0.1:6379> zscore zhangdua1229_6 zhang3
(nil)
127.0.0.1:6379> zscore zhangbdua1229_6 zhang3
"8"
127.0.0.1:6379> zincrby zhangbdua1229_6 10 zhang3
"18"
127.0.0.1:6379> zscore zhangbdua1229_6 zhang3
"18"
127.0.0.1:6379> zrangebyscore zhangbdua1229_6 1 10
1) "zhang"
127.0.0.1:6379> zrangebyscore zhangbdua1229_6 1 20
1) "zhang"
2) "zhang3"
127.0.0.1:6379> zincrby zhangbdua1229_6 -5 zhang3
"13"
127.0.0.1:6379> zrangebyscore zhangbdua1229_6 1 20
1) "zhang"
2) "zhang3"
```
---

后续更新2024.12.29
