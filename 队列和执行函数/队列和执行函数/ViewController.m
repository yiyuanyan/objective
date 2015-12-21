//
//  ViewController.m
//  队列和执行函数
//
//  Created by 何建新 on 15/12/16.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建串行队列,使用dispatch_queue_t类型的dispatch_queue_create(唯一码,宏DISPATCH_QUEUE_SERIAL串行队列)
    dispatch_queue_t serialQueue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    
    //创建一个并发队列,宏DISPATCH_QUEUE_CONCURRENT并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    //主队列，不用创建，获取
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //全局并发队列,不用创建，直接获取
    //dispatch_get_global_queue(0,0)默认
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    //执行函数
    //dispatch_async(队列,block)函数是异步执行函数
    dispatch_async(serialQueue, ^{
        //执行任务
        NSLog(@"下载图片");
    });
    //同步执行函数
    //dispatch_sync(并发队列,block)函数是同步执行函数
    dispatch_sync(concurrentQueue, ^{
       //执行任务
        NSLog(@"下载图片");
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
