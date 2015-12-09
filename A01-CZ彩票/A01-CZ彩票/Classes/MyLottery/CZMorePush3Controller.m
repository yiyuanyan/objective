//
//  CZMorePush3Controller.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMorePush3Controller.h"

@interface CZMorePush3Controller ()

@end

@implementation CZMorePush3Controller

-(void)setData{
    CZItem *item = [CZItemSwitch itemWithTitle:@"中奖动画"];
    CZGroup *group = [CZGroup groupWithFooter:@"开启后，当有新中奖订单，打开应用时会显示动画提醒界面。为避免显示过于频繁，高频彩不会提醒" items:@[item]];
    self.groups = @[group];
}

@end
