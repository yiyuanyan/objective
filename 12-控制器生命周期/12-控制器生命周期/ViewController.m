//
//  ViewController.m
//  12-控制器生命周期
//
//  Created by 何建新 on 15/11/17.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//view将要显示
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view将要显示");
}
//view已经显示
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"view已经显示");
}
//view将要消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view将要消失");
}
//view已经消失
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"view已经消失");
}
@end
