//
//  ViewController.m
//  NSOperation
//
//  Created by 何建新 on 15/12/18.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong)NSOperationQueue *queue;
@end

@implementation ViewController
-(NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc]init];
    }
    return _queue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof (self) wself = self;
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [wself longTimeOperation];
    }];
    [self.queue addOperation:op2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //取消、暂停、恢复线程操作
    [self.queue cancelAllOperations];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self longTimeOperation];
    }];
    
    //将操作添加到队列
    [self.queue addOperation:op];
    
}
-(void)longTimeOperation
{
    NSLog(@"-------下载图片------");
}
@end
