//
//  ViewController.m
//  NSThread
//
//  Created by 何建新 on 15/12/11.
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
    //在后台执行，创建隐性的线程方式
    [self performSelectorInBackground:@selector(downloadImage:) withObject:nil];
    //获得当前线程
    [NSThread currentThread];
    //获得主线程
    NSThread *mainThread = [NSThread mainThread];
    //线程停止30秒。阻塞线程。
    [NSThread sleepForTimeInterval:30];
    //强制退出线程
    [NSThread exit];
}

-(void)downloadImage:(NSString *)urlString{
    NSLog(@"-----%@",[NSThread currentThread]);
    //返回指定线程执行UIOperation方法。waitUntilDone:是否等待方法执行完毕
    [self performSelector:@selector(UIOperation) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO modes:nil];
}
-(void)UIOperation
{

}
-(void)test{
    NSString *str = @"myThread";
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:nil];
    //设置线程名字
    thread.name = @"yiyuanyan";
    //设置线程优先级
    thread.threadPriority = 0.5;
    //设置线程占据内存大小。默认512K
    thread.stackSize = 1024 * 1024;  //1M
    //告诉CPU线程准备完毕
    [thread start];
    
    //从当前线程分离出一条新线程，不需要手动启动，会自动执行。为downloadImage:方法开启子线程进行运算
    [NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:@"itcast"];
}
@end
