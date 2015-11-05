//
//  ViewController.m
//  autorezing的基本使用
//
//  Created by 何建新 on 15/11/4.
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
//当用户点击控制器上的view的时候就会调用这个方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect bounds = self.blueView.bounds;
    bounds.size.width += 10;
    bounds.size.height += 10;
    self.blueView.bounds = bounds;
}
@end
