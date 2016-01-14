//
//  ViewController.m
//  美团
//
//  Created by 何建新 on 15/12/28.
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

- (IBAction)zhifu:(id)sender {
    //跳转到支付宝，并且携带一些参数
    //拿到APP
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"zfb://cn.itcast.zfb?app=mt"];
    //判断是否能打开URL
    if ([app canOpenURL:url]) {
        //打开应用
        [app openURL:url];
    }else{
        //跳转到appStore
    }
}
@end
