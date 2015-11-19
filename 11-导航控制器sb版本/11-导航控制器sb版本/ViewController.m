//
//  ViewController.m
//  11-导航控制器sb版本
//
//  Created by 何建新 on 15/11/17.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)jump2green:(UIButton *)sender;

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

- (IBAction)jump2green:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
