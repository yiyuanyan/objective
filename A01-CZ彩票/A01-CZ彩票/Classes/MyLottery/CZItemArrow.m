//
//  CZItemArrow.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/3.
//  Copyright © 2015年 何建新. All rights reserved.
// 带箭头的CELL

#import "CZItemArrow.h"

@implementation CZItemArrow
//初始化
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon desController:(Class)desController
{
    //调用父类的初始化方法，初始化title和icon
    CZItemArrow *item = [self itemWithTitle:title icon:icon];
    item.desController = desController;
    return item;
}
+(instancetype)itemWithTitle:(NSString *)title desController:(Class)desController
{
    //调用父类的初始化方法，初始化title和icon
    CZItemArrow *item = [self itemWithTitle:title icon:nil];
    item.desController = desController;
    return item;
}
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon option:(CZItemOption)option
{
    //调用父类的初始化方法，初始化title和icon
    CZItemArrow *item = [self itemWithTitle:title icon:icon];
    item.option = option;
    return item;
}
@end
