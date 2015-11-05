//
//  CZFriend.h
//  03-QQ好友
//
//  Created by 何建新 on 15/11/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZFriend : NSObject
//头像
@property(nonatomic, copy)NSString *icon;
//描述
@property(nonatomic, copy)NSString *intro;
//名称
@property(nonatomic, copy)NSString *name;
//是否为VIP
@property(nonatomic, assign,getter=isVip)BOOL vip;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)friendWithDict:(NSDictionary *)dict;
+(NSArray *)friendsWithDictArray:(NSArray *)dictArray;
@end
