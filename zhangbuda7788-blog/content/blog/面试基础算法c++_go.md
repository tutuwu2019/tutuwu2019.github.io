+++
title = "面试基础算法c++_go"
date = "2024-05-09T02:58:29+08:00"
tags = ["面试", "算法"]
slug = "面试基础算法c++_go"
+++

# 列举一些算法


## 杂序（c++和go 实现）


- 链表反转


> 链表反转的核心思想就是每次遍历 head 链表的时候把当前节点充当newHead 的头节点，在把上轮的newHead 接到 newHead 的屁股上


- c++


```
struct ListNode{
    int val;
    struct ListNode* next;
    ListNode(int x):val(x),next(nullptr){};
};

class solution{
    ListNode* ReverseList(ListNode* head){
        ListNode* nhead;
        while(head != nullptr){
            ListNode* tmp;
            tmp = nhead;
            nhead = head;
            head = head->next;
            nhead->next = tmp;
        }
        return nHead;
    }
}
```

- go


```go
package main

import(
    "fmt"
)

type ListNode struct{
    Val int
    Next *ListNode
}

func ReverseList(head *ListNode)*ListNode{
    var newHead *ListNode = nil

    for head != nil{
        tmp := head
        newHead = head
        head = head.Next
        newHead.Next = tmp
    }
    return newHead
}

func PrintList(head *ListNode){
    for head != nil{
        fmt.Print(head.Val, " ")
        head = head.Next
    }
    fmt.Println()
}

func main(){

    head := &ListNode{Val:1}
    head.Next = &ListNode{Val:2}
    head.Next.Next = &ListNode{Val:3}
    head.Next.Next.Next = &ListNode{Val:4}

    fmt.Print("the List before: ")
    PrintList(head)

    reverseHead := ReverseList(head)
    fmtPrint("after reverse and the List: ")
    PrintList(reverseHead)
}
```

- c++ 采用栈存链表


```cpp
#include <iostream>
#include <stack>

struct ListNode{
    int val;
    ListNode* next;
    ListNode(int x):val(x), next(nullptr){};
};


ListNode* reverseListNode(ListNode* head){
    if(head == nullptr){
        return nullptr;
    }

    std::stack<ListNode*> nodeStack;
    ListNode* current = head;

    while(current != nullptr){
        nodeStack.push(current);
        current = current->next;
    }

    ListNode* newHead = nodeStack.top();
    nodeStack.pop();
    current = newHead;

    while(!nodeStack.empty()){
        current->next = nodeStack.top();
        nodeStack.pop();
        current = current->next;

    }

    current->next = nullptr;
    
    return newHead;

}

//打印链表
void printList(ListNode* head){
    while(head != nullptr){
        std::cout<<head->val<<" ";
        head = head->next;
    }

    std::cout<<std::endl;

}

int main(){

    ListNode* head = new ListNode(1);
    head->next = new ListNode(2);
    head->next->next = new ListNode(3);
    head->next->next->next = new ListNode(4);

    std::cout<<"Original List: ";
    printList(head);

    ListNode* reverHead = reverseListNode(head);
    
    std::cout<<"Reverse List: ";
    printList(reverHead);

    return 0;
}
```
---


- 链表指定区间反转链表


>
