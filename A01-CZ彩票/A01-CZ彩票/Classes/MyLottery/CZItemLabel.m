//
//  CZItemLabel.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZItemLabel.h"

@implementation CZItemLabel
+(instancetype)itemWithTitle:(NSString *)title time:(NSString *)time
{
    CZItemLabel *item = [CZItemLabel itemWithTitle:title];
    item.time = time;
    return item;
}
@end
