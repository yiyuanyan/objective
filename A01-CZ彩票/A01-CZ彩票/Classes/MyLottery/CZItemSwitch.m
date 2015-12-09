//
//  CZItemSwitch.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/3.
//  Copyright © 2015年 何建新. All rights reserved.
//  带开关的CELL

#import "CZItemSwitch.h"

@implementation CZItemSwitch
+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    CZItemSwitch *item = [self itemWithTitle:title];
    item.subTitle = subTitle;
    
    return item;
}
@end
