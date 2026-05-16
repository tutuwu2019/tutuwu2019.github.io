+++
title = "Go基本数据类型"
date = "2024-05-09T12:18:11+08:00"
tags = ["go语法"]
slug = "go基本数据类型"
+++

# go基本数据类型

> 编程有感
> 这是一篇由浅入深介绍go 数据类型的笔记(自用)
> 对于新手，最快进入学习状态的方式莫过于，看别人的写的博客或者视频了。当然高手写的博客或者视频那就更好了。
> 这是比较好的切入点，我也看了 go 的官方文档，感觉写的很浅
> 学技术，最重要的是学权威内容，这个东西不能出现二义性，可是网上（内网）的很多“博客”都是半吊子水，这对于思维不活泛的同学（不比如我，要多走很多弯路😩😩），**后面深入的话还是要看源码的**

主要有以下内容，会由浅入深以及结合面试题总结（05-08）


- 常见的数据数据类型（参考c/c++、python、js、java）int、string、struct、**slice**、map
- 关键字 new、make
- interface、闭包
- 关键字 reflect
- chan、defer、goroutine
- 抢占式调度?
- panic、recover
- GMP
- Go的内存管理(栈内存管理、)


---


## 常见的数据数据类型（参考c/c++、python、js）int、string、struct、slice、map

> 先添个小料，我问gpt go1.18中的切片扩容规则的时候，它直接讲 切片扩容阈值threshold 是**1024**，但是在go1.18以后的切片扩容阈值改成了**256**，而且扩容规则也调整了一些


### int


### string


### struct


### slice

切片 本质是一个数据结构，包含指向底层数组的首地址，切片大小以及切片容量
[入门讲解](https://www.bilibili.com/video/BV1hv411x7we?p=2&vd_source=185f80d453b08f4c6ad76d3216e073b8)

```
// 写几种 定义 方式
var tmp01 []int = make([]int, 2, 5)

tmp01 = append(tmp01, 1, 2, 3, 4, 5)


tmp02 := []int{1, 2, 3, 4, 5}

tmp03 := new([]int)
*tmp03 = append(*tmp03, 1, 2, 3, 4, 5)
`注意采用的是左闭右开
[demo](https://github.com/tutuwu2019/go_code/blob/main/%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84/slice.go)

`//切片的操作，截取切片指定范围      

tmp_01 := tem01[:2]

tmp_02 := tmp01[1:3]
```
#### 切片扩容机制—go1.18版本

[参考](https://yufengbiji.com/posts/golang-slice)

![alt text](/images/kuorongjizhi.png)

> 扩容思路
> 
> 预期新容量 是不是 大于 原来容量的两倍 ？ 如果是，直接扩成预期新容量 : (不是，进行下一步判定 原始容量 是不是 小于 256 ？ 是的，那么预期新容量大小为原来的2倍 : 不是[也就是大于等于256] 按照公式， 预期 = (原来的 + threshold * 3)/4 )
> **注意：采用这种机制，“大的小点扩，小的往大扩”是为了平滑两者过渡。


#### 切片扩容以后还要内存对齐

> 是的，和c/c++ 的 struct 内存对齐 是同一个思路
> 本质还是基本数据类型 和 操作系统架构 位数 对齐？
