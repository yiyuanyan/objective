//
//  main.m
//  通知机制
//
//  Created by 何建新 on 15/11/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "CZPerson.h"
int main(int argc, const char * argv[]) {
    //1.创建通知中心对象(通知中心是一个单利对象)
    //获得通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //创建信息发布者
    Company *wangYi = [[Company alloc]init];
    //信息发布者的名称
    wangYi.name = @"网易";
    //接收通知
    /**
     必须先创建监听者，然后才能发布通知
     */
    //创建监听者
    CZPerson *zhangSan = [[CZPerson alloc]init];
    zhangSan.name = @"张三";
    zhangSan = nil;
    [center addObserver:zhangSan selector:@selector(receiveNotifaction:) name:@"头条" object:wangYi];
    
    
    //发布消息       消息名称               消息发布者         字典，消息内容
    [center postNotificationName:@"头条" object:wangYi userInfo:@{@"info":@"测试内容"}];
    
    
    return 0;
}
