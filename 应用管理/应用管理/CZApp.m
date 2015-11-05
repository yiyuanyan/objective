//
//  CZApp.m
//  应用管理
//
//  Created by 何建新 on 15/11/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZApp.h"

@implementation CZApp
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)appWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

+(NSArray *)apps
{
    //获取plist文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"apps_full" ofType:@"plist"];
    //将文件读入数组
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    //定义临时可变数组
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CZApp *app = [self appWithDict:dict];
        [arrayM addObject:app];
    }
    return arrayM;
}
@end
