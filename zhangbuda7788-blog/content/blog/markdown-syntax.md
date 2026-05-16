+++
title = "md 语法参考"
date = "2024-05-07T00:00:00+00:00"
tags = ["md"]
slug = "markdown-syntax"
+++

[更多玩法参考(markdown-guide)](https://simplemde.com/markdown-guide)

> 主要讲讲用 md 语法 去构建 hugo 元素，同时也可以像html 一样使用css 对其进行装饰(基于某个hugo 主题)


---


## 主题

> 从 H1 （最高主题）到 H6 最低主题


# H1


## H2


### H3


#### H4


##### H5


###### H6


---


## 段落

段落1:什么？你说你个人的性格从什么时候就已经定型了呢？还有改的可能吗？好像在很多时候，都是一时的冲动，给自己造成很大且不可逆的影响。尤其是像我这种脑子一热就很冲的的怪家伙🙈

段落2:一段很有意思的话，每个人都应该珍视眼前的生活，这句话是对的，而我觉得这是在没有爱情发生时，一个人安慰他自己生活的话，一旦爱情出现，他的生活就会失去平衡，而真正的爱强恰恰就是在孤单和痛苦时才会出现。

段落3:战争中你流尽鲜血，和平中你存不难行。

段落4:无论相爱与否，人人死而平等，希望死亡不是你的终结，憧憬光明，就不会惧怕黑暗。


## 块引用(Blockquotes)

The blockquote element represents content that is quoted from another source, optionally with a citation which must be within a `footer` or `cite` element, and optionally with in-line changes such as annotations and abbreviations.


#### 不带归属的块引用（Blockquote without attribution）

> 峰哥给新来的**张不大**说明天不要睡过头!
>  **强调明天早上不要睡过头！** **强调明天早上不要睡过头！** **强调明天早上不要睡过头！** 重要的事情说三遍！
> 如果爱睡懒觉，你可以设置多个魔鬼闹铃！！！
> 结果到了早上9点半，张不大猛的一惊，已经九点半了完蛋了要迟到了要迟到了要迟到了，而此时峰哥也火速打电话过来问情况……


#### 带归属的块引用（Blockquote with attribution）

> 不要通过共享内存来通信，而要通过通信来实现共享内存
> — Rob Pike[1](#fn:1)


## Tables

Tables aren’t part of the core Markdown spec, but Hugo supports supports them out-of-the-box.


Name
Age


Bob
27


Alice
23


#### Inline Markdown within tables


Italics
Bold
Code


*italics*
**bold**
```
code`


## 代码块（Code Blocks）


#### Code block with backticks

`<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Example HTML5 Document</title>
</head>
<body>
  <p>Test</p>
</body>
</html>
```
#### Code block indented with four spaces

```
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Example HTML5 Document</title>
</head>
<body>
  <p>Test</p>
</body>
</html>
```

#### Code block with Hugo’s internal highlight shortcode

```
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Example HTML5 Document</title>
</head>
<body>
  <p>Test</p>
</body>
</html>`

## 列表（List Types）


#### 顺序列表（Ordered List）


- First item
- Second item
- Third item


#### 无序列表（Unordered List）


- List item
- Another item
- And another item


#### 嵌套列表（Nested list）


- Fruit

Apple
- Orange
- Banana


- Dairy

Milk
- Cheese


## 加粗、斜体、删除线、下划线、大号字体、小号字体

`# 1.加粗 **文本**

# 2.斜体  *文本* 或者 _文本_

# 3.删除线 ~~文本~~

# 4.大号字体 <big>文本</big>

# 5.小号字体 <small>文本</small>
```
## 其他元素 — abbr, sub, sup, kbd, mark

GIF is a bitmap image format.

H2O

Xn + Yn = Zn

Press CTRL+ALT+Delete to end the session.

Most salamanders are nocturnal, and hunt for insects, worms, and other small creatures.


---

[markdown官网文档](https://markdown.com.cn/basic-syntax/)


---


- The above quote is excerpted from Rob Pike’s [talk](https://www.youtube.com/watch?v=PAAkCSZUG1c) during Gopherfest, November 18, 2015. [↩︎](#fnref:1)
