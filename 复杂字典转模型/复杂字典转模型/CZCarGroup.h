//
//  CZCarGroup.h
//  复杂字典转模型
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZCarGroup : NSObject
@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong)NSArray *cars;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)carGroupWithDict:(NSDictionary *)dict;
+(NSArray *)carGroups;
@end
