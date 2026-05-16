+++
title = "Cpp_issue"
date = "2024-05-23T14:08:55+08:00"
tags = ["c_cpp"]
slug = "cpp_issue"
+++

# cpp_issue


## 一些基础讨论


### 指针大小

```text
| 系统       | 指针大小 |
|----------|------|
| 32 位     | 4 字节 |
| 64 位     | 8 字节 |
```

### const 关键字

```
// 常变量 
const int x = 10;   // x 不能修改 
x =20;              // 这是错的

// 注意：
const int xxx;
int const yyy;
/*
const int xxx;
const 放在类型前面表示这是一个常量类型的变量。这种写法更符合自然语言的习惯，读作 “常量整数 xxx”。

int const yyy;
const 放在变量名后面，但在类型之后，语义上与前者相同。这种写法有时更容易理解复杂的指针声明，因为它遵循从右到左的阅读顺序。
*/


// 指针
// 指向常量的指针
const int* ptr = &x;
*ptr = 20;          //这是错的，*ptr 的值不能通过 ptr 修改，但是 ptr可以指向其他地址
int y = 20;
prt = &y;

// 常量指针     ptr 的地址不能修改，但是 *ptr 可以修改
int* const ptr = &x;
int z = 30;
*ptr = y;
prt = &z;       // 这是错误的

// 指向常量的常量指针
const int* const ptr = &x;
// *ptr 和 ptr 都不能被修改
// *ptr = 20; // 错误，不能修改 *ptr
// int z = 30;
// ptr = &z; // 错误，不能修改 ptr 指向的地址


// 引用
// 对常量的引用
const int &ref = x;
// ref 不能用于修改 x 的值
// ref = 20; // 错误，不能修改 ref 指向的值
```
### 值&指针&引用

[值&指针&引用](https://www.cnblogs.com/strive-sun/p/16809942.html)

引申面试题：

> 指针和引用的区别？指针占内存？引用占内存？


### c/c++ linux 文件操作


### c/c++ 多线程编程

[多线程问题01](https://www.cnblogs.com/strive-sun/p/16267463.html#5185414)


---

[cpp学习清单](https://stackoverflow.com/questions/388242/the-definitive-c-book-guide-and-list)


### 闲聊

[35岁危机](https://juejin.cn/post/7306036684922929191)

[高绩效指南](https://www.cnblogs.com/wenbochang/p/18074126)
