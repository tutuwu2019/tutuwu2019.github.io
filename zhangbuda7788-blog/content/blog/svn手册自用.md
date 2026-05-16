+++
title = "Svn手册(自用)"
date = "2025-01-02T00:58:02+08:00"
tags = ["c_cpp", "git"]
slug = "svn手册自用"
+++

# svn手册(自用)

> 老实说，之前用的svn gui版本，现在用svn终端版，所有关于svn的命令要用起来。老实说，用过git，再用svn应该会容易上手不少吧。


## 常规操作


- checkout(co)


> 使用 svn checkout path 把svn服务器上的代码down 下来
> 
> 注意啊，cppProject 替换成  svn://svnbucket.com/xxx/cppProject
> 如， svn checkout cppProject 或者 svn co cppProject
> 如果要 down 到指定目录，用 svn co cppProject zhangbuda/cppProject_
> 如果要指定用户名和密码
> svn co cppProject –username xxx –password yyy


- commit
提交 和 git 差不多的意思。
把本地代码，提交到 svn 服务器上
简单的如，svn commit -m ‘提交描述’  当然可以把 commit 替换成 ci  如，svn ci -m ‘提交描述’
提交指定的文件或者目录 svn ci /path/cppProject -m ‘提交指定的文件’
提交指定后缀的文件 svn ci *.cpp -m ‘提交指定文件’       其实这也没啥好单独拎出来的
- 更新 update
执行命令，会把其他人提交的代码从svn 服务器更新到自己的电脑上
svn update 可以简写为 svn up
更新到指定的版本(场景：比如当前版本有问题，需要回退到上一个版本)
svn update -r xxx
仅更新指定文件或者目录
svn update /path/cppProject
- 添加文件
svn add /path/xxx


或者添加 *.cpp 文件
svn add *.cpp


- 删除文件
svn delete /path/xxx
删除版本控制，但是本地依然保留文件
svn delete /path/xxx –keep-local
- 查看日志
查看当前目录的日志
svn -log
查看指定文件或者目录的提交日志
svn log /path/cppProject
查看日志，并输出变动文件列表
svn log -v
限定输出日志条数
svn log -l 5
- 查看变动
查看当前工作区的改动
svn diff
查看指定文件或者目录的改动
svn diff /path/xxx
本地文件或者指定版本号的差异
svn diff /path/xxx -r yyy
指定版号比较差异
svn diff /path/xxx -r 1:2
- 撤销修改
撤销对指定文件的修改
svn revert xxx.cpp
递归撤销目录中的本地修改
svn revert -R /path/xxx
- 添加忽略
忽略通过设置目录的属性 pro 来实现，添加后会有一个目录属性变动的修改需要提交


```
svn propset svn:ignore '* .log'  .    # 忽略所有log文件。
svn propset svn:global-ignores '*.log' . #递归忽略
svn proplist . -v # 查看当前目录的属性配置
svn prodel svn:ignore . #删除当前目录的忽略配置
```

- 查看状态


```
svn status  
svn status /path/xxx #查看指定目录的svn 状态
```

- 清理


```
svn cleanup     #清理本地缓存
```

- 查看信息


```
svn info
```

- 查看文件列表


```
svn ls 

svn ls -r xxx # 指定版本号
```

- 查看blame


```
svn blame xxx.cpp   #显示文件的每一行最后是谁修改的
```

- 分支操作


```
svn cp -m '描述内容' xxx yyy  # 从 xxx 中传讲一个分支保存在 yyy 上   参考：svn cp -m "描述内容" http://svnbucket.com/repos/trunk http://svnbucket.com/repos/branches/online1.0  从主干 trunk 创建一个分支保存到 branches/online1.0
cd yyy 
svn merge --reintegrate xxx  # yyy合并到 xxx上
svn  switch zzz     #切换分支
svn rm path    #删除分支
```
