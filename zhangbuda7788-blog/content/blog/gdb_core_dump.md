+++
title = "Gdb_core_dump"
date = "2024-05-29T02:42:32+08:00"
tags = ["c_cpp"]
slug = "gdb_core_dump"
+++

# Gdb_core_dump


## GDB 调试

[GDB中文手册](https://github.com/zhuzongzhen/Books/blob/master/GDB%E4%B8%AD%E6%96%87%E6%89%8B%E5%86%8C%E5%AE%8C%E7%BE%8E%E7%89%88.pdf)

[GDB调试死循环](https://blog.csdn.net/ttxiaoxiaobai/article/details/137161187?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522171692182416800211537952%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fblog.%2522%257D&request_id=171692182416800211537952&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~blog~first_rank_ecpm_v1~rank_v31_ecpm-1-137161187-null-null.nonecase&utm_term=gdb&spm=1018.2226.3001.4450)

[GDB调试入门](https://blog.csdn.net/ttxiaoxiaobai/article/details/131756836?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522171692182416800211537952%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fblog.%2522%257D&request_id=171692182416800211537952&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~blog~first_rank_ecpm_v1~rank_v31_ecpm-2-131756836-null-null.nonecase&utm_term=gdb&spm=1018.2226.3001.4450)

[GDB 多线程调试](https://blog.csdn.net/ttxiaoxiaobai/article/details/136793651?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522171692182416800211537952%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fblog.%2522%257D&request_id=171692182416800211537952&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~blog~first_rank_ecpm_v1~rank_v31_ecpm-3-136793651-null-null.nonecase&utm_term=gdb&spm=1018.2226.3001.4450)


# gdb core dump 调试

cat  segfault.cpp

`
#include <stdio.h>
#include <stdlib.h>

void cause_segfault(){
    int *p = NULL;
    *p = 42;

  //  int *p = (int*)malloc(sizeof(int));
   // if(p == NULL){
     //   exit(1);
   // }
  //  *p = 42;
   // printf("the *p is %d", *p);
}

int main(){
    cause_segfault();
    return 0;
}
`编译
g++ -g segfault.cpp  -o segfault

`# 查看 core dump 文件 存储路径
cat /proc/sys/kernel/core_pattern
|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %e


# 修改存储路径

sudo sysctl -w kernel.core_pattern=/tmp/core.%e.%p.%h.%t
kernel.core_pattern = /tmp/core.%e.%p.%h.%t

# 查看 core dump 文件
ls /tmp

core.segfault.3540311.localhost.localdomain.1716920116

# gdb 调试
gdb ./segfault /tmp/core.segfault.3540311.localhost.localdomain.1716920116

# 接着，会出在 运行至报错的地方报出相应的错误

# 查看 调用栈
(gdb) bt
#0  0x0000000000400566 in cause_segfault () at segfault.cpp:6
#1  0x0000000000400578 in main () at segfault.cpp:17


#  调用栈帧
(gdb) frame 0
#0  0x0000000000400566 in cause_segfault () at segfault.cpp:5
5           *p = 42;
# 查看本地信息
(gdb) info locals
p = 0x0

# 打印 p 指针
(gdb) p p
$1 = (int *) 0x0
#  打印 p指针解引用
(gdb) p *p
Cannot access memory at address 0x0
`[gdb 栈帧](https://ivanzz1001.github.io/records/post/cplusplus/2018/11/08/cpluscplus-gdbusage_part4)


---

未完待续
