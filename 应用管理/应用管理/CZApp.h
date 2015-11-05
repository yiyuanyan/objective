//
//  CZApp.h
//  应用管理
//
//  Created by 何建新 on 15/11/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZApp : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *download;
@property(nonatomic,copy)NSString *size;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)appWithDict:(NSDictionary *)dict;

+(NSArray *)apps;
@end
