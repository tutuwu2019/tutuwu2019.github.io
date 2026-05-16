+++
title = "Shell语法"
date = "2024-08-14T01:20:35+08:00"
tags = ["linux"]
slug = "shell语法"
+++

# shell 语法

> 其实因该改成 shell 脚本语法

> 后来，我才发现原来很多越来越方便的语言(迎合人类习惯)的开发，就叫脚本语言开发。
> 比如 shell脚本、python脚本、js脚本、vim 脚本、lua脚本等等


## shell脚本语法

像介绍其他开发语言一样，先介绍变量、常量、逻辑、if-else、循环(for、while)，再到 shell 脚本开发


### 变量、常量


### 逻辑(与/或/非)


### if-else


### 循环 for、while


## 脚本


### 词频统计

> 话说回来，shell 脚本好像把很多方法嵌入进入了，比如sort

```
# word.txt
the day is sunny the the
the sunny is is
```

- 首先切片 根据 空格、换行切片成若干个单词
cat ./word.txt | tr -s ’ ’ ‘\n’
- 再将切片后的单词排序
cat ./word.txt | tr -s ’ ’ ‘\n’ | sort
- 再将单词去重
cat ./word.txt | tr -s ’ ’ ‘\n’ | sort | uniq -c
- 统计词频并逆序排列  (-nr 分别表示按照数字排序  逆序排序)
cat ./word.txt | tr -s ’ ’  ‘\n’ | sort | uniq -c | sort -nr
- 打印  按照  [单词  出现次数] 格式打印
cat ./word.txt | tr -s ’ ’ ‘\n’ | sort | uniq -c |sort -nr | awk ‘{print $2, $1}’


[demo](https://github.com/tutuwu2019/hard-study-to-stronger/blob/main/linux/%E8%84%9A%E6%9C%AC/test/word_count.sh)


### 打印有效电话号码     (xxx) xxx-xxxx 或 xxx-xxx-xxxx。（x 表示一个数字）

```
# file.txt
987-123-4567
123 456 7890
(123) 456-7890
``# 正确格式的电话号码行如 （xxx) xxx-xxx
# 有固定的地方  左括号  右括号  空格  横杠
# 正则  
#   ^ 表示开始
#               () 需要转译 \( \) 
#         注意 横杠 - 是怎么样就是怎样，空格  是怎么样就是怎样   ([0-9]{3}-|\([0-9]{3}\) )  ==> ([0-9]{3} - |\([0-9]{3}\) )  (在横杠前后加空格会比配成 "空格-空格"
# $ 结束
awk '/^([0-9]{3}-|\([0-9]{3}\) )[0-9]{3}-[0-9]{4}$/' file.txt
`正则表达式补充

`Note 表含义中的出现次数：限定符前面字符的出现次数。
限定符 | 表达含义 |
-|-|-
*| 出现次数 >=0|
+| 出现次数 >=1|
?| 出现次数 0 or 1, 等价 {0,1}|
{n}| 出现次数 = n|
{n,}| 出现次数 >=n|
{n, m}|n=< 出现次数 <= m|

定位符

定位符 | 表达含义 |
-|-|-
^| 字符串开始的位置 |
$| 字符串结束的位置 |
\b | 限定单词 (字) 的字符，常用来确定一个单词，可以结合两个‘\b’使用 |
\B | 限定非单词 (字) 边界的字符，用的很少 |
```
## 实用技能


### 命令 echo

携带参数


- -n 打印的文本末尾不换行(默认换行)
- -e 表示转译 ，比如echo “test\nthe new test” 会进行 \n 转译
- -E 禁用反斜杠转译 比如echo “test\nthe new test” 会进行 \n  ==> 不会进行转译 不换换行


### 默认参数


- $# 传递脚本的参数个数或者传递函数的参数个数
- $* 和 $@
- $0 当前脚本或命令的名称
- $1、$2、$3、… 表示传递的第几个参数 比如 $1 表述传递的第1个参数
- $#
- $$ 获取当前脚本执的进程号
- $? 返回上一个命令执行的状态码
- $! 最后一个后台运行的命令进程id
- $_ 上一个命令的最后一个参数


[demo_test](https://github.com/tutuwu2019/hard-study-to-stronger/blob/main/linux/%E8%84%9A%E6%9C%AC/test/%E9%BB%98%E8%AE%A4%E5%8F%98%E9%87%8F.md)


### []、()、(())和 {}


- [] 条件测试


```
#用于比较字符串、文件属性  注意 condition 要与 '[' 和 ']' 要有空格   这是条件测试固有的要求
# 如
if [ condition ]; then
    xxx
fi
# -f 检查是否是文件
if [ -f "readme.md" ]; then
    xxx
fi
# -d 检查是否有目录
if [ -d "~/xxxdirName" ]; then
    xxx
fi
# 或者
fi [ "$VAR" -eq 0 ]; then
    xxx
fi
```

- () 子shell


> $() 和 `` 会进行命令替换

```
#比如 执行子命令 (command1; command2)
VAR=1
if [ $VAR -eq 1 ]; then
    (echo -e "VAR: $VAR\n"; echo -e "else")
fi


#还是可以定义数组
array_name=(value0 value1 value2 value3)

array_name=(
value0
value1
value2
value3
)
array_name[0]=value0
array_name[1]=value1
array_name[2]=value2
```

- (()) 进行算数运算的结构
((xxx))  xxx 表示进行算数运算。如((i+=20))  ==> i=i+20
$((xxx)) 表示把xxx 的结果赋给变量


```bash
    #!/bin/bash
    VAR=0
    for ((i=1; i < 10; i++));
    do
        ((VAR+=i))
    done
```

- {}
> 命令组  {} 内部放多个命令，在同一个环境中顺序执行
> 字符串扩展   注意会保留空格


```bash
#!/bin/bash
echo {a,b,c}{1,2,3}
#a1 a2 a3 b1 b2 b3 c1 c2 c3
echo -e {a,b,c}{" 1\t"," 2\t"," 3\t"}
#a 1      a 2     a 3     b 1     b 2     b 3     c 1     c 2     c 3
echo -e {a,b,c}{" 1"," 2"," 3"}
#a 1 a 2 a 3 b 1 b 2 b 3 c 1 c 2 c 3
echo -e {a,b,c}{"1\t","2\t","3\t"}
#a1       a2      a3      b1      b2      b3      c1      c2      c3

#内联代码块  

for i in {1..5}; { echo "Number: $i"; }
#等价于
for i in {1..5}; 
do 
    echo "Number: $i"; 
done
# 函数定义

my_function() {
    echo "Hello from my_function"
}
my_function
```

- 总结

区别


```
cat  ./tmp_0824_03.sh 
#!/bin/bash

VAR1="this is test"

VAR2=$VAR1

VAR3="$VAR1"

VAR4="${VAR1}"

echo -e "VAR1: $VAR1\tVAR2:$VAR2\tVAR3:$VAR3\tVAR4:$VAR4"

./tmp_0824_03.sh 
VAR1: this is test      VAR2:this is test       VAR3:this is test       VAR4:this is test
``2. 建议使用 "$VAR1" 而不是 $VAR1
    因为 "$VAR1" 表示的是一个整体，而且两者是数字(比如整数)的效果是等价的，而当表示字符串、空值会出现一些问题，比如  VAR1=“hello world" -->"$VAR1"表示 "hello world" 而 $VAR1表示 hello world 在执行  "$VAR1" -eq xxx 或者 $VAR1 -eq xxx 会报错(尽管都会报错)

    1. 举例说明
        > var1=1
        > [$var1 -eq 1] 和 ["$var1" -eq 1 ] 的区别
         1. [$var1 -eq 1]
```
```bash
    #!/bin/bash
    #变量展开：这里 var1 被直接展开为其值。这个语法在变量 var1 不为空且值为整数时工作正常。
    #无引号：没有引号包裹变量，因此如果 var1 的值为空或包含空格，这种情况会引发错误或意外行为。
    #潜在风险：如果 var1 是空的或包含特殊字符（如空格），会导致语法错误。例如，[ -eq 1 ] 会导致错误。
    #比如 var1 是空 
    
    var1=
    if [ $var1 -eq 1 ]; then
        echo "Variable equals 1"
    else
        echo "Variable does not equal 1"
    fi
    #当 var1 为空时，[ $var1 -eq 1 ] 变成 [ -eq 1 ]   会报错：bash: [: -eq: unary operator expected


    #比如 var1 有空格

    var1="some value"

    if [ $var1 -eq 1 ]; then
        echo "Variable equals 1"
    else
        echo "Variable does not equal 1"
    fi
    #  问题: 当 var1 包含空格时，[ $var1 -eq 1 ] 会变成 [ some value -eq 1 ]。这将导致语法错误 bash: [: some: integer expression expected
``         2. ["$var1" -eq 1 ]
```
```bash
    #!/bin/bash
    #变量展开："$var1" 通过引号包裹，因此变量的值会被正确处理，尤其是当变量包含空格或特殊字符时。
    #安全性：这种方式更安全，因为即使 var1 的值为空或包含空格，也不会导致语法错误。
    #推荐使用：使用引号包裹变量是一个好习惯，可以避免一些常见的错误和不期望的行为。
    #比如 var1 是空

    var1=
    if [ "$var1" -eq 1 ]; then
        echo "Variable equals 1"
    else
        echo "Variable does not equal 1"
    fi
    #行为: 这个脚本不会出错，因为 "$var1" 被引号包裹。引号确保了即使变量为空，它也会被正确地处理为一个空字符串。
    #结果: Shell 会将空字符串与 1 比较，-eq 运算符只接受整数，所以结果会是一个错误（可能会输出 “Variable does not equal 1”）。但不会产生语法错误。

    #比如 var1 有空格

    var1="some value"

    if [ "$var1" -eq 1 ]; then
        echo "Variable equals 1"
    else
        echo "Variable does not equal 1"
    fi
    #行为: 即使引号包裹变量，"$var1" 仍然包含空格，这将导致一个错误：bash: [: some value: integer expression expected   注意啊，这种情况和 $var1 -eq 1 是等价的错误
    
``3. shell 中整数变量和字符串变量
   1. shell 提供了 ((xxx)) 用于整数计算，比如 
```
```
var1=21
if (($var1 -eq 22)); then
    echo "var1==22"
else 
    echo "var1!=22"
fi
``        逻辑比较 -eq (比较是否相等)、-ne (是否不相等)、-lt( less then 判断第一个整数是否小于第二个整数)、-le (判断第一个整数是否小于或等于第二个整数)、-gt (判断第一个整数是否大于第二个整数) 和 -ge (判断第一个整数是否大于或等于第二个整数)
    2. 字符串   字符串变量用于文本操作，包括拼接、比较和模式匹配。字符串操作通常使用 [ 或 [[ 进行
       1. 字符串拼接
```

## 补充：

> 字符串测试
> 
> -z STRING：如果 STRING 的长度为零，则为 true。
> -n STRING：如果 STRING 的长度非零，则为 true。
> STRING1 == STRING2：如果 STRING1 和 STRING2 相等，则为 true。
> STRING1 != STRING2：如果 STRING1 和 STRING2 不相等，则为 true。


> 文件测试
> 
> -e FILE：如果 FILE 存在，则为 true。
> -d FILE：如果 FILE 是目录，则为 true。
> -f FILE：如果 FILE 是常规文件，则为 true。
> -r FILE：如果 FILE 可读，则为 true。
> -w FILE：如果 FILE 可写，则为 true。
> -x FILE：如果 FILE 可执行，则为 true。
> -s FILE：如果 FILE 存在且其大小大于零，则为 true。


> 数字测试
> 
> NUM1 -eq NUM2：如果 NUM1 等于 NUM2，则为 true。
> NUM1 -ne NUM2：如果 NUM1 不等于 NUM2，则为 true。
> NUM1 -lt NUM2：如果 NUM1 小于 NUM2，则为 true。
> NUM1 -le NUM2：如果 NUM1 小于或等于 NUM2，则为 true。
> NUM1 -gt NUM2：如果 NUM1 大于 NUM2，则为 true。
> NUM1 -ge NUM2：如果 NUM1 大于或等于 NUM2，则为 true。


> 逻辑操作
> 
> &&：逻辑与操作符。
> ||：逻辑或操作符。


---

`
#!/bin/bash

first_name="John"
last_name="Doe"
full_name="${first_name} ${last_name}"

echo "Full Name: $full_name"
full_name_length=${#full_name}
echo "full_name length is $full_name_length"
#Full Name: John Doe
#the full_name length is 8
``        2. 字符串匹配
`
```bash
#!/bin/bash

filename="report_2024.txt"

if [[ "$filename" == report_*.txt ]]; then
    echo "The filename starts with 'report_' and ends with '.txt'."
else
    echo "The filename does not match the pattern."
fi
``        3. 计算字符串长度
```
```bash
#!/bin/bash

text="Hello, World!"
text_length=${#text}

if (( text_length > 10 )); then
    echo "The text is long."
else
    echo "The text is short."
fi
``        4. 检查是否有 有效整数
```
```bash
#!/bin/bash

input="100"

# 检查字符串是否是有效整数
if [[ "$input" =~ ^[0-9]+$ ]]; then
    # 进行算术运算
    doubled=$((input * 2))
    echo "Doubled value: $doubled"
else
    echo "The input is not a valid integer."
fi
``        5. 字符串切片
```
```
    string="alibaba is a great company"
    echo ${string:1:4}
    liba
```
#### 综合使用

’’ 会保留字符字面含义不会进行变量替换和命令替换

"" 允许变量替换和命令替换，保留大部分特殊字符的字面含义

{} 明确变量名的边界，特别是在变量与后续字符相连时

```
name="hello"
echo "$name"    ---> hello
echo "'$name'"  ---> 'hello'    要看 'xx' 的部份是否已经被 双引号包围
echo '$name'    ---> $name
echo '"$name"'  ---> "$name"
echo ""$name""  ---> hello
echo "\$name"   ---> $name
echo "\'$name\'"    ---> \'hello\'
echo ""$name""  ---> hello
echo "\"$name\""    --->"hello"

# 注意  "" 保留了特殊字符
    1. 空格不会解释为命令空格符
    2. * 不会解释为通配符扩展
    3. ？  不会匹配单个字符
    4. 大括号（{}）、方括号（[]）：不会被解析为扩展
`> 双引号中的单引号涉及 $、`、${}或者单引号中的双引号涉及$、、${}
> 
> 在双引号中使用单引号：单引号会被视为普通字符，$、` 和 ${} 的替换规则依然生效
> 在单引号中使用双引号：所有字符，包括双引号，都被视为字面值，不会进行替换或解释


### 重定向


- > 和 »


`# > 会把内容重定向到新的地方，会覆盖原来已有的内容
cat record.log > tmp.log

# >> 会把内容重定向到新的地方，不会覆盖原来已有的内容
cat record.log >> tmp.log

# 注意 在使用 tcpdump 抓包 把抓包内容写入文件中采用的是 -w
tcpdump -vvv -n -i any 192.168.21.26 -w tmp.log
```

- 把标准输出、标准错误抛弃
有两种方式


```
#1.
cat record.log  &> /dev/null

#2. 这种方式更通用
cat record.log > /dev/null 2>&1
```
### 判断主机是否存在 xxx命令

command -v xxx


### switch-case 语法

OSNAME=“Linux”

case “$OSNAME” in
Linux*)
echo “This is a Linux system.”
;;
Darwin*)
echo “This is a macOS system.”
;;
*)
echo “Unknown operating system.”
;;
esac


### 正则表达式


- 模糊匹配


`
# .*?
`[demo_01](https://github.com/tutuwu2019/hard-study-to-stronger/blob/main/linux/%E6%AD%A3%E5%88%99%E5%8C%B9%E9%85%8D/tmp01.md)


### 关于 脚本退出的状态码

> 可以通过 $? 获取上一个命令结束的状态码
> 
> 默认正确执行命令结束状态码为 0，错误执行为 1， 2， 3 …
> 注意，在做 if 判断的时候 if ( command ); then  xxx  ; 如果正确执行会会执行 if 里面的语句命令 (尽管返回值是0，而错误结果返回值反而是非零 但是不能和逻辑 true 和 false 混淆)


`./tmp_0825_03.sh
exit 
[root@localhost sh_]# echo "$?"
0
[root@localhost sh_]# cat ./tmp_0825_03.sh 
#!/bin/bash

echo "exit "
exit
``./tmp_0825_02.sh 
the srcipt will exit and return 2
echo "$?"
2
cat ./tmp_0825_02.sh 
#!/bin/bash

myfunc(){
    echo "the srcipt will exit and return 2"
    exit 2
}

myfunc
`如果在函数中执行返回值 可以用 return

`#!/bin/bash
my_function() {
  echo "Inside function"
  return 2
}

my_function
echo "Function returned $?"
`综上，总结来说 退出脚本 exit ， 可以退出的时候选择指定状态码，默认状态码为0，在函数返回值上可以使用 return 然后再带上数字


### 命令 getopts

> 注意啊，c语言里面也是有这个函数，同名函数


## shell 测试

> shell  的测试文件后缀为 .bats

`#!/usr/bin/env bats

@test "Check if file exists" {
  run test -f "/etc/passwd"
  [ "$status" -eq 0 ]
}

@test "Check if string matches" {
  result="hello"
  [ "$result" = "hello" ]
}

@test "Check the output of a command" {
  run echo "Hello, Bats!"
  [ "$status" -eq 0 ]
  [ "$output" = "Hello, Bats!" ]
}

# 运行结果
bats  tmp_0825_01.bats
 ✓ Check if file exists
 ✓ Check if string matches
 ✓ Check the output of a command

3 tests, 0 failures
`> [引申](https://github.com/tutuwu2019/hard-study-to-stronger/blob/main/linux/test%E5%91%BD%E4%BB%A4.md)
