+++
title = "Git_tips"
date = "2024-05-16T00:16:27+08:00"
tags = ["git"]
slug = "git_tips"
+++

# git tips

> 老实讲，git 的很多功能我还不是很熟，常用吧，用着用着就熟悉了


## 本地git仓库被污染了

> 是这样的，hugo 博客在编写完了，然后hugo 生成静态页，hugo  server 正常，但是 git push 迟迟没有更新

> 大概率是本地的git 仓库被污染了。
> 其实环境被污染，挺难处理的，尤其是《新手》、《对这个环境不熟》
> 我甚至想暴力把github 仓库删除，重新创建。
> 后来误打误撞的解决了


---

```
# 先创建一个
git checkout --orphan temp  # 创建一个新的孤立分支

# 创建一个空的提交      什么是空的提交？空的提交就是什么也没有改变，和原来的一样。  默认git 是不允许的，但是可以采用  --allow-empty  强制空提交
# 在这个特定的情况下，你使用这个命令的目的是为了在远程仓库中创建一个空的提交，以便清空远程仓库的内容。这个空的提交并没有任何实际的更改，但是它会在提交历史中留下一个标记，表示远程仓库在某个特定时间点被清空了。
git commit --allow-empty -m "Clear remote repository"

# 删除本地的  main 分之
git branch -D main  # 删除本地的 main 分支

# 将新的孤立分支重命名为 main
git branch -m temp main  


git push origin main --force
`注：  git remote -v 查看远程远程仓库信息


---


## 出现 Name or service not known


- 网络问题，重新操作一次, (例如，我是执行 git push origin main 出现，那我就再执行一边)
- 查看 DNS 解析过程 dig github.com 或者 nslookup github.com
- 测试 ssh 连接情况 ssh -T [git@github.com](mailto:git@github.com)


## git check 命令


### 分支

`# 进入某个分支  -b 表示如果没有该分支就创建一个分支
git checkout -b xxx 
```
### 回退指定文件

```
# 比如说回退到上一次提交的状态的 xxx.txt文件

git checkout <commit_hash> -- xxx.txt

# 详细操作
#先查看历史记录，找到提交的 hash 值   -- 用于区分哈希值 和 文件路径
git log -- <file_path>
# 知道 某次提交的 hash 值为 abc1234 
git checkout abc1234 -- xxx.txt 
# 使用 git diff 查看变化
# 查看文件是否已经恢复
# 如果想永久保留这个修改
git add xxx.txt 
git commit -m "Revert file.txt to the state of commit abc1234"
`> 假设 file.txt 经历了以下三个提交：
> 
> 提交 A：文件内容是 “Hello”
> 提交 B：文件内容是 “Hello, World”
> 提交 C：文件内容是 “Hello, Universe”
> 
> git checkout B – file.txt


> 项目中的 file.txt 会恢复至 提交B 版本，而项目的其他文件不发生修改

注意，也可以使用 git restore 做同等操作
举例说明：假设你在 main 分支上，不小心删除了 src/app.js 文件并提交了更改，现在你想恢复这个文件到 commit_hash 为 d4e5f6g 时的状态。

> git restore d4e5f6g – src/app.js
> git add src/app.js
> git commit -m “恢复 src/app.js 到 d4e5f6g 提交时的状态”
> git push origin main     (推送至远程仓库)


## git log 命令

`# 基本用法
git log --oneline

# 图形化显示所有分支的提交历史
git log --oneline --graph --decorate --all

# 查看最近 5 个提交
git log --oneline -n 5

# 查看特定作者的提交
git log --oneline --author="Author Name"

# 查看包含特定关键词的提交
git log --oneline --grep="keyword"

# 查看特定文件的修改历史
git log --oneline -- path/to/file.txt

# 查看特定时间段的提交
git log --oneline --since="2024-08-01" --until="2024-09-01"

# 自定义输出格式
git log --pretty=format:"%h - %an, %ar : %s"
```
## git ls-files

```
## 查看 列出当前仓库中所有的已跟踪文件，不仅仅是暂存区的文件。
git ls-files

## 查看已经删除的文件
git ls-files --deleted

## 查看已经修改的文件
git ls-files --modified

## 查看未跟踪的文件
git ls-files --others

## 查看被 .gitignore 忽略的文件
git ls-files --ignored


git ls-files --stage
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       .gitignore
100644 c7cc7ecea78e60867a573e7b3fdb5cbd969496d4 0       zhangsan0105.md
100644 ac3b6a483760aa04c26ddfcdc97f844fb90a33aa 0       zhangsan2.md
```
## git 场景


### 本地代码上传github

> 是这样的，我想把本地一份代码 push 到 github。

```
#1.本地初始化       当前目录作为本地仓库
git init
#2.关联远程仓库     关联远程仓库 main 
git remote add main git@github.com:tutuwu2019/xxxx.git
#3.把本地仓库要 push 的文件加入 缓存
git add xxx             # 如果是所有文件则  git add .
# 4. 提交
git commit -m 'note'
#5. push 注意啊，这里是把本地的 main  分支 push 到 远程仓库github 的 master 仓库，注意啊，在github中默认主仓库是main            git push <远程主机名> <本地分支名>:<远程分支名>
#### 注意啊，如果本地没有 master分支，本地也会自动创建master分支
git push -u main master                    # 也有 git push origin master:main 把本地 master 分支 推送到远程仓库 main分支
``## 查看 remote 信息
git remote -v

## 给远程仓库名命名为 origin
git remote rename main origin
```
#### 如果想撤销 git add 、git commit 操作

```
## 回退
git restore record.log
`当然，如果想忽略指定文件，或者目录，可以在 .gitignore  中添加。如果项目根目录没有，则手动创建，并在文件中添加要忽略文件、或者指定目录

如果想忽略已经跟踪的文件，需要 git rm –cached  来从 git 的索引中移除

`##比如
git rm --cached record.log
git rm --cached -r .vscode/
`配置好本地变更，还要提交记录

`git add .gitignore
git commit -m "Add record.log and .vscode/ to .gitignore and remove from tracking"
`最后查看 状态

`git status

##会看到如下内容
git status
On branch main
nothing to commit, working tree clean
```
#### push 回退


- 提交一个新提交来撤销上一次的提交


```bash
git revert HEAD

### 然后再次push 
git push origin main

### 注意这会把本地的上次操作的文件给清空，比如你上一次新建一个文件，这次回退，那么这次的操作会把上次新建的文件删掉。同理如果上次是在已有文件操作，则回退到上一编辑之前的状态
```

- 回退至指定版本


```
### 使用 git log 查看要回退到哪个版本
git log 

### 然后回退到特定提交
git reset --hard xxxx

### 强行推送到远程仓库
git push --force origin main
```

- 软重置和应重置


```
### 硬重置：彻底删除上一次的提交
git reset --hard HEAD~1
``### 软重置：撤销推送的提交，但是保留了删除本地工作去的所有更改
git reset --soft HEAD~1
``### 然后都是强行推送到远程仓库
git push --force origin main
`> 注意这个参数 –force 操作会强制推送更改远程仓库，会覆盖远程分支的历史记录，会影响其他协作者！！！


### git merge 和 git rebase

> 是的,经常push 会容易碰到 分支冲突和版本冲突


#### 版本冲突

> 版本冲突：同一个文件的同一行或者相近的行在不同分支上被修改。当执行 git pull 或者 git merge 时，Git 无法自动合并文件内容。需要手动编辑本地文件。
> 
> 打开冲突文件，上面会有git 标记的冲突部分，你只需要编辑文件至你想要的结果。然后重新 提交一遍。


场景复现：


- 本地编辑文件 vim zhangsan2.md    远程仓库编辑 zhangsan2.md
- 提交文件     git add zhangsan2.md   git commit -m ‘zhangsan2 modify by local git’  git push origin main:main  (在这一步报冲突错误)
![alt text](/images/tmp0105image-2.png)
- 拉远程仓库   git pull origin main
- 合并 仓库    git merge –no-ff           报错：  fatal: No remote for the current branch.  表示当前分支没有绑定远程仓库的分支


`# 此处还可以改成
git merge --no-ff main
```

- 检查当前分支，然后绑定远程分支。(我记得是直接 git push origin main:main 提交了上一版)                 git branch –set-upstream-to=origin/main main
- 然后重新执行步骤3. 拉远程仓库 git pull origin main    然后会提示：git merge –no-ff 或者 git rebase
- 合并冲突文件 git merge –no-ff   注意哈，然后要编辑冲突文件，解决冲突。  解决完冲突后，可以使用命令 git status、git diff 检查冲突


![alt text](/images/tmp0105image-1.png)
8. 然后重新提交文件。
9. 检查 远程仓库内容
![alt text](/images/tmp0105image-3.png)

补充：
合并策略：
–no-ff 强制创建一个合并提交，即使合并是快进的
–ff-only 只允许快进合并，如果无法快进合并则拒绝合并
–squash 将所有变更合并为一个提交，而不保留历史


#### 分支冲突

> 分支冲突：同一个文件不同部分在多个分支被修改，Git无法判断这些修改是否可以合并。文件删除与修改：一个分支删除了某个文件，而另一个文件对该文件进行了修改，Git无法判断是否该文件是否删除还是保留。多次并行开发：不同分支上独立开发了不同功能，合并时会出现冲突。

```bash
git pull origin main        #### 我 pull 报分支冲突
From github.com:tutuwu2019/tmp0105_remote
 * branch            main       -> FETCH_HEAD
hint: You have divergent branches and need to specify how to reconcile them.
hint: You can do so by running one of the following commands sometime before
hint: your next pull:
hint: 
hint:   git config pull.rebase false  # merge
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint: 
hint: You can replace "git config" with "git config --global" to set a default
hint: preference for all repositories. You can also pass --rebase, --no-rebase,
hint: or --ff-only on the command line to override the configured default per
hint: invocation.

## 然后我就按照提示操作  先配置一下 
git config pull.ff only

## 然后再 pull   
git pull origin main
``## 然后 又出了 提示
From github.com:tutuwu2019/tmp0105_remote
* branch            main       -> FETCH_HEAD
hint: Diverging branches can't be fast-forwarded, you need to either:
hint: 
hint:   git merge --no-ff
hint: 
hint: or:
hint: 
hint:   git rebase
hint: 
hint: Disable this message with "git config advice.diverging false"
``## 然后我就又按照上面的提示 合并
git merge origin/main --no-ff
``## 因为我之前已经  把文件 加载到 git cached 中，所以只需要再 push 一次就好
git push origin main:main
`注意：如果想看手册，

`git push --help
git merge --help
git rebase --help
git pull --help
```
## 至此大功告成。
