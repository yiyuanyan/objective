//
//  ViewController.m
//  04-归档解档
//
//  Created by 何建新 on 15/11/20.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "Teacher.h"
//归档必须寸守NSCoding协议
@interface ViewController ()
- (IBAction)save:(UIButton *)sender;
- (IBAction)load:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(UIButton *)sender {
    //创建自定义对象
    Teacher *t = [[Teacher alloc]init];
    t.name = @"蛮三刀";
    t.age = 19;
    //获取tmp目录
    NSString *path = NSTemporaryDirectory();
    //文件路径
    NSString *tmpFile = [path stringByAppendingPathComponent:@"teacher.data"];
    //归档方法，archiveRootObject:要存档的对象   toFile:存档到什么位置
    [NSKeyedArchiver archiveRootObject:t toFile:tmpFile];
}

- (IBAction)load:(UIButton *)sender {
    NSString *path = NSTemporaryDirectory();
    NSString *tmpFile = [path stringByAppendingPathComponent:@"teacher.data"];
    //解档操作
    Teacher *t = [NSKeyedUnarchiver unarchiveObjectWithFile:tmpFile];
    NSLog(@"%@---%d",t.name,t.age);
}
@end
