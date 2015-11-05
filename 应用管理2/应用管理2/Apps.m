//
//  Apps.m
//  应用管理2
//
//  Created by 何建新 on 15/11/5.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "Apps.h"

@implementation Apps
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)appsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)apps
{
    //获取plist文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"apps_full" ofType:@"plist"];
    //文件读入数组
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray * arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        Apps *apps = [Apps appsWithDict:dict];
        [arrayM addObject:apps];
    }
    return arrayM;
}
@end
