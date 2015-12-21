//
//  ViewController.m
//  JSON输出汉字
//
//  Created by 何建新 on 15/12/21.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [[Person alloc]init];
    p.name = @"lll";
    p.age = 5;
    NSLog(@"%@",p);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
