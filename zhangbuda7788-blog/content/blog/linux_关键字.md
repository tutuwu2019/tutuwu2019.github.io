+++
title = "Linux_关键字"
date = "2024-06-13T21:46:35+08:00"
tags = ["linux"]
slug = "linux_关键字"
+++

# linux 关键字

> 主要讲讲，我的linux 的一些使用笔记&资料


## 常用的命令


### awk 命令

> awk 常见变量
> 
> ARGC 命令行参数个数
> ARGV 命令行参数排列
> ENVIRON 支持队列中系统环境变量的使用
> FILENAME awk 浏览的文件名
> FS 设置输入域分隔符，等价于命令行 -F选项
> NF 浏览记录的区域的个数
> NR 已读的记录数
> OFS 输出域分隔符
> ORS 输出记录分隔符
> RS 控制记录分隔符


```
{print $0} 整行打印  
{print $1} 打印第一行  
-F 'x' 根据 x 作为截断  
```


- BEGIN & END
BEGIN {action}处理任何输入行之前执行
END {action}处理所有出入行之后执行
```
 计算所有数字的总和 awk 'BEGIN {sum = 0} {sum += $1} END{print "Total sum: sum}' numbers.txt
```
统计表格
data.csv
name,age
Alice,30
Bob,25
Carl,27
awk ‘BEGIN {FS=","; print"Name\tAge"} NR > 1 {print $1 “\t” $2}’  data.csv
- 查看指定目录有多少个文件
ls -l path | awk ‘BEGIN {count = 0} {count++} END {print “files:\t”, count}’
或者：awk ‘{count++} END{print “user count is “, count}’ /etc/passwd
- 查看输入了什么命令
awk -F ‘:’  ‘{printf(“content-> one:%d,two:%s\n”,ARGC, ARGV[1])}’ /etc/passwd
content-> one:2,two:/etc/passwd
- 查看文件大小
ls -l /home/tudong/projects/ |awk ‘BEGIN {size=0;} {size=size+$5;} END{print “[end]size is “, size/1024/1024,“M”}’  
awk 脚本

printf 和 print  
awk -F ‘:’  ‘{printf(“content-> one:%d,two:%s\n”,ARGC, ARGV[1])}’ /etc/passwd
- do、while、for

查询last ip-num


```
	last | awk '{\
	if($3 == "" || $3 ~ /^(tty.*|login|reboot|boot|[A-Za-z0-9]{3})$/){\
	next\
	}\
	S[$3]++ \
	} \
	END { \
	for(s in S){ \
	print "account: ", s, "\tsize: ", S[s] \
	} \
	}'
```


[awk 官方手册](https://www.gnu.org/software/gawk/manual/gawk.html)


## 参考资料

linux 三剑客
[sed 命令](https://www.cnblogs.com/ggjucheng/archive/2013/01/13/2856901.html)

[awk 命令](https://www.cnblogs.com/ggjucheng/archive/2013/01/13/2858470.html)
[vi & vim](https://www.google.com)

[tcpdump 抓包](https://www.cnblogs.com/ggjucheng/archive/2012/01/14/2322659.html)
