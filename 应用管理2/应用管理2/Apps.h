//
//  Apps.h
//  应用管理2
//
//  Created by 何建新 on 15/11/5.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apps : NSObject
//定义模型属性,与plist文件字典同名
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *download;
@property(nonatomic, copy)NSString *size;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)appsWithDict:(NSDictionary *)dict;

+(NSArray *)apps;
@end
