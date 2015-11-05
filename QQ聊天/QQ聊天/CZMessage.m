//
//  CZMessage.m
//  QQ聊天
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMessage.h"

@implementation CZMessage
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
+(NSArray *)messages
{
    //获取plist文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"messages" ofType:@"plist"];
    //将文件读入数组
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CZMessage *message = [CZMessage messageWithDict:dict];
        [arrayM addObject:message];
    }
    return arrayM;
}

@end
