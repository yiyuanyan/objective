//
//  getUserInfo.m
//  Login
//
//  Created by 何建新 on 16/3/10.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "getUserInfo.h"

@implementation getUserInfo
//读取用户配置信息

-(NSString *)getUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *mobile = [defaults valueForKey:@"username"];
    return mobile;
}

@end
