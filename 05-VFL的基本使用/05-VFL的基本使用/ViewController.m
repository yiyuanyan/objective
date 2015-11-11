//
//  ViewController.m
//  05-VFL的基本使用
//
//  Created by 何建新 on 15/11/6.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:blueView];
    [self.view addSubview:redView];
    //2.关闭autoresizing
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    //水平方向
    //H:|-20-[blueView]-20-|  左边界20像素然后是蓝色view20像素右边界
    //options:对齐方式
    //views:字典，用到那个视图就写哪个
    //返回的是数组
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[blueView]-20-|" options:NSLayoutFormatAlignAllTop metrics:nil views:@{@"blueView":blueView}];
    //添加到约束
    [self.view addConstraints:hConstraints];
    //垂直方向
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[blueView(100)]-20-[redView(==blueView)]" options:NSLayoutFormatAlignAllRight metrics:nil views:@{@"blueView":blueView,@"redView":redView}];
    [self.view addConstraints:vConstraints];
    NSLayoutConstraint *redW = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
    [self.view addConstraint:redW ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
