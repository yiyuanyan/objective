//
//  CZFriendGroup.m
//  03-QQ好友
//
//  Created by 何建新 on 15/11/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZFriendGroup.h"
#import "CZFriend.h"
@implementation CZFriendGroup
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        //将第二层的字典转为模型
        _friends = [CZFriend friendsWithDictArray:self.friends];
    }
    return self;
}
+(instancetype)friendGroupWithDict:(NSDictionary *)dict
{
   return [[self alloc]initWithDict:dict];
}
+(NSArray *)friendGroups
{
    //获取plist文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"friends" ofType:@"plist"];
    //文件读入数组
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    //定义可变数组
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CZFriendGroup *friendGroup = [self friendGroupWithDict:dict];
        [arrayM addObject:friendGroup];
    }
    return arrayM;
}
@end
