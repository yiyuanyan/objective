//
//  ViewController.m
//  01-本地推送
//
//  Created by 何建新 on 16/1/15.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //需要注册通知类型 settingsForTypes:几种模式为枚举,可并存
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeNone | UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    //1.创建本地通知
    UILocalNotification *local = [[UILocalNotification alloc]init];
    //
    local.alertBody = @"提醒主题";
    //通知时间
    local.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //通知声音---默认声音
    local.soundName = UILocalNotificationDefaultSoundName;
    //滑动解锁文字
    local.alertAction = @"滑动解锁";
    //
    local.applicationIconBadgeNumber = 10;
    //用户信息
    local.userInfo = @{@"name":@"信息通知",@"content":@"内容"};
    //定制一个通知.
    [[UIApplication sharedApplication]scheduleLocalNotification:local];
    //使用代理监听通知信息
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
