//
//  CZQuestion.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/9.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZQuestion.h"

@implementation CZQuestion
+(instancetype)questionWithDic:(NSDictionary *)dic
{
    CZQuestion *question = [[CZQuestion alloc]init];
    [question setValuesForKeysWithDictionary:dic];
    return question;
}
@end
