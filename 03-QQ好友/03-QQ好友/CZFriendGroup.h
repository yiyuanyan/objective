//
//  CZFriendGroup.h
//  03-QQ好友
//
//  Created by 何建新 on 15/11/3.
//  Copyright © 2015年 何建新. All rights reserved.
//
//循环plist外层
#import <Foundation/Foundation.h>

@interface CZFriendGroup : NSObject
//分组名称
@property(nonatomic, copy)NSString *name;
//在线人数
@property(nonatomic, assign) int online;
//好友列表
@property(nonatomic, strong)NSArray *friends;
//开关属性
@property(nonatomic, assign, getter=isOpen)BOOL open;
/**
 *  字典转模型
 */
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)friendGroupWithDict:(NSDictionary *)dict;
+(NSArray *)friendGroups;
@end
