+++
title = "纳秒级cpu优化&rdtsc测试"
date = "2024-09-23T01:51:56+08:00"
tags = ["c_cpp"]
slug = "纳秒级cpu优化rdtsc测试"
+++

# 纳秒级cpu优化&rdtsc测试

> 起因：看了一段演讲视频，感觉讲的偏底层&基础

> 除法比乘法慢的原因
> 访问对齐数据更高效
> 访问松散数据导致cache命中率低下
> 访问矩阵元素不要跨行访问，要逐行访问 → 编写 cache 友好代码的
> 第一原则：局部性原则 授人以渔：纳米级优化第一守则：防止编译器好心帮倒忙；
> 第二守则：禁止CPU调频，否则看不出优化的效果；
> 第三守则：使用专业工具精准测量-Intel Vtune


## 内存对其与内存不对其


## 结构体的定义

> 松散的结构体不仅浪费内存而且访问效率很低。

`struct t1{
	int x;
	char testName[Length];
};

struct t2{
	int x;
	const char* testName;
};
`> 多核加剧了 CPU与内存之间访问的压力


## 纳秒级调优守则


- 编译器优化问题


> 防止编译器好心干坏事
> 
> 如果调用的函数返回结果没有使用，可能编译器会抛弃这个函数，造成执行结果没有差别


- 禁止CPU 调频
- 使用专业工具：VTUNE PROFILEPROFILER


[rdtsc参考01](https://zhou-yuxin.github.io/articles/2018/%E4%BD%BF%E7%94%A8rdtsc%E6%8C%87%E4%BB%A4%E8%BF%9B%E8%A1%8C%E6%97%B6%E9%92%9F%E5%91%A8%E6%9C%9F%E7%BA%A7%E6%B5%8B%E9%87%8F/index.html)

[rdtsc demo](https://github.com/tutuwu2019/cpp_code/tree/main/test_rdtsc)

[使用 rdtsc 指令进行时钟周期级测量](https://zhou-yuxin.github.io/articles/2018/%E4%BD%BF%E7%94%A8rdtsc%E6%8C%87%E4%BB%A4%E8%BF%9B%E8%A1%8C%E6%97%B6%E9%92%9F%E5%91%A8%E6%9C%9F%E7%BA%A7%E6%B5%8B%E9%87%8F/index.html)

[rdtsc 参考02](https://www.cnblogs.com/hugetong/p/6050791.html) 

[Pitfalls of TSC usage](http://oliveryang.net/2015/09/pitfalls-of-TSC-usage/)

[rdtsc 参考03](https://gist.github.com/savanovich/f07eda9dba9300eb9ccf)

[rdtsc 参考04](https://github.com/fordsfords/rdtsc)  

[rdtsc 参考05](https://blog.csdn.net/ithiker/article/details/119981737)

[rdtsc 参考06](http://www.wangkaixuan.tech/?p=901)

[rdtsc 参考07](https://zhuanlan.zhihu.com/p/437178265)

[rdtsc 参考08](https://www.cnblogs.com/cnmaizi/archive/2011/01/17/1937772.html)

后面的话，其实这部分涉及很多汇编，可以很好的作为 汇编<—>c 作为偏操作系c/cpp 开发而言，这很需要！！！ (讲给自己的话)
