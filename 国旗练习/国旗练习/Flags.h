//
//  Flags.h
//  国旗练习
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flags : NSObject
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *icon;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)flagWithDict:(NSDictionary *)dict;
+(NSArray *)flags;
@end
