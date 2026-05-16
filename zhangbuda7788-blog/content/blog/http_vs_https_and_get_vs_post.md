+++
title = "Http_vs_https_and_get_vs_post"
date = "2024-05-19T03:38:47+08:00"
tags = ["面试"]
slug = "http_vs_https_and_get_vs_post"
+++

# Http_vs_https_and_get_vs_post


## Http_vs_https


## get_vs_post

> RFC2616中没有对url 长度有限制，但是浏览器会有长度限制。还有浏览器会有url缓存记录
> GET 只允许 ASCII格式编码，而POST则没有要求。


---

> GET 只采用 url 传入信息，不安全，所以把数据裸露在url 使用GET 方法传输不是明智的选择。
> POST 不仅可以通过参数传递信息，还能通过 body 传递消息，通常通过表单上产消息给服务器就是采用post 方法


---

> 注意：这两个只是规范，是在http协议层定义的两个方法，所以本质上都是通过tcp 传递数据，没有实质性差别
> V2EX 上看到一个大哥说，GET 和 POST 的区别就是，一个的方法是’GET’，一个的方法是’POST’。我觉得这个答案很有哲理性.. 很有佛教性空的味道。
> 就是说：在 http 这个应用层协议上来说，两种被定义为不同的方法，但是从 TCP 这个传输层上说，他们并没有什么区别。给 GET 加上 request body，给 POST 带上 url 参数？完全可以。


## 参考

[引用01](https://crouchred.github.io/2017/10/difference_between_http_get_and_post.html)
