//
//  CZItem.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZItem.h"

@implementation CZItem
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    CZItem *item = [self itemWithTitle:title];
    item.icon = icon;
    return item;
}
+(instancetype)itemWithTitle:(NSString *)title
{
    CZItem *item = [[self alloc]init];
    item.title = title;
    return item;
}

@end
