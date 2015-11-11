//
//  Flag.h
//  02-国旗选择
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flag : NSObject
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *icon;
+(instancetype)flagWithDict:(NSDictionary *)dict;
//-(instancetype)initWithDict:(NSDictionary *)dict;

//+(NSArray *)flags;
@end
