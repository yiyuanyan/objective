//
//  CZFriend.m
//  03-QQ好友
//
//  Created by 何建新 on 15/11/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZFriend.h"

@implementation CZFriend
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)friendWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
+(NSArray *)friendsWithDictArray:(NSArray *)dictArray
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        CZFriend *friend = [self friendWithDict:dict];
        [arrayM addObject:friend];
    }
    return arrayM;
}
@end
