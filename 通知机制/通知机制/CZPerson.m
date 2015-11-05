//
//  CZPerson.m
//  通知机制
//
//  Created by 何建新 on 15/11/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZPerson.h"
#import "Company.h"
@implementation CZPerson
-(void)receiveNotifaction:(NSNotification *)notification
{
    NSLog(@"通知的名称%@",notification.name);
    Company *company = notification.object;
    NSLog(@"通知发布者%@",company.name);
    NSLog(@"通知内容%@",notification.userInfo);
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
