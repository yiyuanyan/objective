//
//  Province.m
//  03-城市的选择
//
//  Created by 何建新 on 15/11/11.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "Province.h"

@implementation Province
+(instancetype)proinceWithDict:(NSDictionary *)dict
{
    Province *pro = [[Province alloc]init];
    [pro setValuesForKeysWithDictionary:dict];
    return pro;
}
@end
