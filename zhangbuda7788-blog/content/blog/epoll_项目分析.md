+++
title = "Epoll_项目分析"
date = "2024-07-09T02:50:01+08:00"
tags = ["c_cpp", "高性能服务器"]
slug = "epoll_项目分析"
+++

# 对项目webServer 再分析

```
This is a page about »Epoll_项目分析«.

int listenfd = socket(PF_INET, SOCKET_STREAM, 0);

...

setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
int ret = 0;
ret = bind(listenfd, (struct sockaddr*)&address, sizeof(address));

ret = listen(listenfd, 5);


epoll_event events[MAX_EVENT_NUMBER];
epollfd = epoll_create(5);             // 后面 epoll_create(5)中的参数后面失效

addfd(epollfd, listenfd, bool_);

http_conn::m_epollfd = epollfd;


ret = socketpair(PF_UNIX, SOCK_STREAM, 0 , pipefd);
setnonblocking(pipefd[1]);

addfd(epollfd, pipefd[0], bool_);

// 设置管道 pipe[1] 的任务，处理信号 初始化，捕获终止信号，然后调用回调函数，给pipe[1] 发送中断信号、捕获时间alarm信号，然后调用回调函数，给pipe[1] 发送alarm信号
addsig(SIGALRM, sig_handler, false);
addsig(SIGTERM, sig_handler, false);


while(!stop_server){
	int number =epoll_wait(epollfd, events, MAX_EVENT_NUMBER, -1);

	// EINTR 系统被信号中号终端时返回的错误码
	if(number < 0 && errno != EINTR){
		// epoll failure
		break;
	}

	for(int i = 0; i < number; i++){
		int sockfd = events[i].data.fd;

		if(sockfd == listenfd){
			// accept、connect
		}else if(events[i].events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR)){
			// 监听的事件：对端关闭或者半关闭、对端挂起、对端错误事件
			// 获取事件的对应的计时器
			util_timer* timer = users[sockfd].timer;
			timer->cn_func(&users_timer[sockfd]);   // epoll 删除对该事件的监听
			if(timer){
				timer_lst.del_timer(timer);   // 如果 lst 链表中还有该fd 对应的timer 就删除
			}
		}else if((sockfd == pipefd[0]) && (events[i].events & EPOLLIN)){
			// ret = recv(pipefd[0], signals, sizeof(signals), 0);
			if(ret == -1){
				continue;
			}else if(ret == 0){
				continue;
			}else{
				for(int i = 0; i < ret; i++){
					switch(signals[i]){
						case SIGALRM:   // 定时器信号
							{
								// 因为设置的是每5s 触发一次SUGALRM 所以会通过管道把信号发送过来，然后 epoll 监听管道，判断管道发送的信号类型，如果是超时信号，就去处理lst 把所有超时节点都给处理了
								timeout = true;
								break;
							}
						case SIGTERM:   // 终止信号
							{
							// 如果是超时信号，就停止服务
								stop_server = true;
							}
					}
					
						
				}
			}
		}else if(events[i].events & EPOLLIN){
			//表示 监听的文件描述符有数据，而且可读
			util_timer* timer = users_timer[sockfd].timer;
			if(users[sockfd].read_once()){
				pool->append(users + sockfd);

				// 如果事件 之前有标记，则继续延长时间
				if(timer){
					timer_t cur = time(NULL);
					timer->expire = cur + 3 * TIMESLOT;
					// 刷新 timer 节点双向链表
					timer_lst.adjust_timer(timer);
				}
			}else{
				// timer 的 cd_func 就是让epoll 事件 delete  该监控的fd
				timer->cb_func(&users_timer[sockfd]);
				if(timer){
					timer_lst.del_timer(timer);
				}
			}
		}else if(events[i].events & EPOLLOUT){
		  // 如果监听到的是写操作，直接timer 延长
			util_timer* timer = users_timer[sockfd].timer;
			if(users[sockfd].write()){
				if(timer){
					timer cur = time(NULL);
					timer->expire = cur + 3 * TIMESLOT;
					timer_lst.adjust_timer(timer);
				}
			}else{
				timer->cb_func(&users_timer[sockfd]);
				if(timer){
					timer_lst.del_timer(timer);
				}
			}
		}
		
	}
	if(timeout){
		timer_handler();
		timerout = false;
	}
}

close(epollfd);
close(listenfd);
close(pipe[0]);
close(pipe[1]);

// else release source ...
```
## 总结


- 涉及信号量
- 涉及和 fd 相关的关键字
- 涉及和 epoll 相关的关键字
- 业务，处理各个类型的fd、采用lst 对 epoll监听的 fd 采用 time 双向链表结构处理，采用 lst? 算法思路，使得链表的head 的 expire 最少(也就是首选提出剔除)、对于 http/https 的业务部分采用 线程池 去做处理，在设计 EPLOOIN 的时候更新 buff、len (这里可以采用ET/LT)、在EPOLLOUT 的时候，把数据封装，发送给客户端(响应客户端的请求).


---

确实很有意思。

未完待续
