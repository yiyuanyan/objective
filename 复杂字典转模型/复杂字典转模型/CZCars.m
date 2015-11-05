//
//  CZCars.m
//  复杂字典转模型
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZCars.h"

@implementation CZCars
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)carsWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
