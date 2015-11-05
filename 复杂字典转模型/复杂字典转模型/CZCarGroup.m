//
//  CZCarGroup.m
//  复杂字典转模型
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZCarGroup.h"
#import "CZCars.h"
@implementation CZCarGroup
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.title = dict[@"title"];
        NSArray *dictArray = dict[@"cars"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            CZCars *car = [CZCars carsWithDict:dict];
            [arrayM addObject:car];
        }
        _cars = arrayM;
        
    }
    return self;
}
+(instancetype)carGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
+(NSArray *)carGroups
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"cars_total" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [[NSMutableArray alloc]initWithCapacity:array.count];
    //便利数组，字典转模型
    for (NSDictionary *dict in array) {
        CZCarGroup *carGroup = [self carGroupWithDict:dict];
        [arrayM addObject:carGroup];
    }
    return arrayM;
}
@end
