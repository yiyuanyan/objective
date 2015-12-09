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
+(instancetype)groupWithHeader:(NSString *)header items:(NSArray *)items{
    CZGroup *group = [CZGroup groupWithItems:items];
    group.header = header;
    return group;
    
}

+(instancetype)groupWithFooter:(NSString *)footer items:(NSArray *)items{
    CZGroup *group = [CZGroup groupWithItems:items];
    group.footer = footer;
    return group;
}

+(instancetype)groupWithHeader:(NSString *)header footer:(NSString *)footer items:(NSArray *)items
{
    CZGroup *group = [CZGroup groupWithHeader:header items:items];
    group.footer = footer;
    return group;
}
@end
