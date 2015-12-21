//
//  ViewController.m
//  异步执行函数
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
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //异步函数 + 全局并发队列 开启子线程执行block
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"下载图片1%@",[NSThread currentThread]);
    });
}
-(void)test{
    //异步函数 + 串行队列 开启一条新线程执行block
    dispatch_async(dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL), ^{
        NSLog(@"下载图片1%@",[NSThread currentThread]);
    });
    dispatch_async(dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL), ^{
        NSLog(@"下载图片2%@",[NSThread currentThread]);
    });
    dispatch_async(dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL), ^{
        NSLog(@"下载图片3%@",[NSThread currentThread]);
    });
}
@end
