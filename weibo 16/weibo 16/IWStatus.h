//
//  IWStatues.h
//  weibo 16
//
//  Created by 何建新 on 16/1/25.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWUser;
@interface IWStatus : NSObject
//微博正文的内容
@property(nonatomic, copy)NSString *text;
//微博ID
@property(nonatomic, assign)long long id;
//用户所有的信息
@property(nonatomic, strong)IWUser *user;
//创建时间
@property(nonatomic, copy)NSString *created_at;
//来源
@property(nonatomic, copy)NSString *source;

@property(nonatomic, copy)NSString *thumbnail_pic;
@property(nonatomic, strong)NSArray *pic_urls;
@property(nonatomic, assign) NSInteger reposts_count;
@property(nonatomic, assign) NSInteger comments_count;
@property(nonatomic, assign) NSInteger attitudes_count;

@property(nonatomic, strong) IWStatus *retweeted_status;

@end
