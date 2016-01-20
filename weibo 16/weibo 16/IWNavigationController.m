//
//  IWNavigationController.m
//  weibo 16
//
//  Created by 何建新 on 16/1/20.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWNavigationController.h"

@interface IWNavigationController ()

@end

@implementation IWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //注册远程推送消息的通知
    
    //收到通知
    
    //处理通知
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //取消注册远程推送消息的通知
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSString *title = @"返回";
    //获取navgation里面压入了多少个控制器
    if (self.childViewControllers.count == 1) {
        title = [[self.childViewControllers firstObject] title];
    }
    if (self.childViewControllers.count) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" target:self action:@selector(back) title:title];
        //如果当前不是第一个自控制器，在push出去的时候子页面没有底部按钮
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //因为重定义了方法。加载父类方法要放在后面
    [super pushViewController:viewController animated:animated];
}
-(void)back{
    [self popViewControllerAnimated:YES];
}
@end
