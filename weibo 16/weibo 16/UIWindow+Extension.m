//
//  UIWindow+Extension.m
//  weibo 16
//
//  Created by 何建新 on 16/1/23.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "IWAcount.h"
#import "IWViewController.h"
#import "IWOAuthViewCtrl.h"
#import "IWAccountTool.h"
@implementation UIWindow (Extension)
-(void)switchRootViewCtrl
{
    
    IWAcount *account = [IWAccountTool account];
    //是否有过登陆
    if (!account) {
        //没有登陆过，跳转到登陆页面
        self.rootViewController = [[IWOAuthViewCtrl alloc]init];
    }else{
        //登陆过则进入页面
        IWViewController *tabbar = [[IWViewController alloc] init];
        self.rootViewController = tabbar;
    }
}
@end
