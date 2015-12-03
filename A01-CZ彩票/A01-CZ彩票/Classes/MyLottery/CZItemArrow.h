//
//  CZItemArrow.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/3.
//  Copyright © 2015年 何建新. All rights reserved.
// 带箭头的CELL

#import "CZItem.h"

@interface CZItemArrow : CZItem

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon desController:(Class)desController;
+(instancetype)itemWithTitle:(NSString *)title desController:(Class)desController;
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon option:(CZItemOption)option;
@end
