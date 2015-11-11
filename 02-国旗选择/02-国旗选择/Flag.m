//
//  Flag.m
//  02-国旗选择
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "Flag.h"

@implementation Flag

+(instancetype)flagWithDict:(NSDictionary *)dict
{
    Flag *flag = [[Flag alloc]init];
    [flag setValuesForKeysWithDictionary:dict];
    return flag;
}
@end
