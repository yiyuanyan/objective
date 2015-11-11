//
//  Flags.m
//  国旗练习
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "Flags.h"

@implementation Flags
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)flagWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
+(NSArray *)flags
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"flags" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        Flags *flags = [self flagWithDict:dict];
        [arrayM addObject:flags];
    }
    return arrayM;
}
@end
