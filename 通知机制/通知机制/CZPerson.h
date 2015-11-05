//
//  CZPerson.h
//  通知机制
//
//  Created by 何建新 on 15/11/2.
//  Copyright © 2015年 何建新. All rights reserved.
//
//接收通知的对象
#import <Foundation/Foundation.h>

@interface CZPerson : NSObject
@property(nonatomic, copy)NSString *name;
//监听通知的方法
-(void)receiveNotifaction:(NSNotification *)notification;
@end
