//
//  CZGroup.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZGroup.h"

@implementation CZGroup
+(instancetype)groupWithItems:(NSArray *)items
{
    CZGroup *group = [[CZGroup alloc]init];
    group.items = items;
    return group;
}
@end
