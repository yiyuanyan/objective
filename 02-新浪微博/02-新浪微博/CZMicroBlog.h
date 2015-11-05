//
//  CZMicroBlog.h
//  02-新浪微博
//
//  Created by 何建新 on 15/10/26.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZMicroBlog : NSObject
//文本
@property(nonatomic, copy)NSString *text;
//头像
@property(nonatomic, copy)NSString *icon;
//图片
@property(nonatomic, copy)NSString *picture;
//名称
@property(nonatomic, copy)NSString *name;
//是否VIP
@property(nonatomic, assign, getter=isVip)BOOL vip;

/**
 *  字典转模型
 */
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)microBlogWithDict:(NSDictionary *)dict;
+(NSArray *)microBlogs;
@end
