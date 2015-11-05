//
//  CZCars.h
//  复杂字典转模型
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZCars : NSObject
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *name;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)carsWithDict:(NSDictionary *)dict;
@end
