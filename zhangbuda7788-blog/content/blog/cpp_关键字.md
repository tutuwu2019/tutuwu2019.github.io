+++
title = "Cpp_关键字"
date = "2024-06-12T15:30:32+08:00"
tags = ["c_cpp"]
slug = "cpp_关键字"
+++

# cpp 关键字

{{ < toc >}}


## static


- 隐藏。当编译多个文件是，所有未加static 前缀的全局变量和函数都具有全局可见性。(extern static int x;  // 这个是无效的)
- 保持变量内容的持久。存储在静态数据区，默认初始化为0，注意这也是唯一的一次初始化。主持静态存储有两种，一个是 data区，用于存放已经初始化的全局/静态变量，另一个是bss区，用于存放未初始化的全局/静态变量，注意：默认初始化为0x00。这是从底层来讲为什么保持内容持久，从使用来讲的话，每次调用static 变量都是调用它的副本，而不是新开辟一个内存存储。这也可以理解内容的持久。
- 讲讲c++ 中的 static 一些特点：简单理解，类中的static成员(无论是变量还是方法)所有权都是归这个类本身，而不是类对象(所以，static 是类对象的共享资源)，所以会延伸很多限制，比如static成员方法只能调用static成员变量(注意：正常的类方法可以调用static方法)。不能通过this 指针获取staic 成员。该类的所有对象都只是拥有static的一份拷贝。static成员变量是先于类对象存在的，所以static对象是在类外完成初始化。static成员方法不能被virtual修饰，本质上static不属于任何对象或者实例，虚函数的的实现是通过对象的虚指针，而虚指针是通过this指针调用。(this->vptr->ctable->virtual function)


[static](https://www.cnblogs.com/33debug/p/7223869.html)
[code](https://github.com/tutuwu2019/cpp_code/tree/main/static)


---

[c/c++ 基本数据类型的内存大小](https://www.cnblogs.com/lqcdsns/p/6819821.html)
