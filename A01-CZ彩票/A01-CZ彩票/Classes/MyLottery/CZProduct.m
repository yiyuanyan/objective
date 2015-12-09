//
//  CZProduct.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/8.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZProduct.h"

@implementation CZProduct
+(instancetype)productWithDic:(NSDictionary *)dic{
    CZProduct *pro = [[CZProduct alloc]init];
    [pro setValuesForKeysWithDictionary:dic];
    return  pro;
}
@end
