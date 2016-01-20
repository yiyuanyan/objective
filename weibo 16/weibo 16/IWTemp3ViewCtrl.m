//
//  IWTemp3ViewCtrl.m
//  weibo 16
//
//  Created by 何建新 on 16/1/20.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWTemp3ViewCtrl.h"

@interface IWTemp3ViewCtrl ()

@end

@implementation IWTemp3ViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"IWTemp3ViewCtrl";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" target:self action:@selector(back) title:@"返回"];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
