//
//  CZMorePushController.m
//  A01-CZ彩票
//
//  Created by apple on 15-6-16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CZMorePushController.h"
#import "CZMorePush1Controller.h"
#import "CZMorePush2Controller.h"
#import "CZMorePush3Controller.h"

@interface CZMorePushController ()
//2、获取数据  groups
@end

@implementation CZMorePushController

//1、设置分组
//2、获取数据  groups
//3、数据源方法
//4、实现跳转的功能


//设置数据
- (void)setData{
    //第一组
    CZItem *item11 = [CZItemArrow itemWithTitle:@"开奖推送" desController:[CZMorePush1Controller class]];
    
    CZItem *item12 = [CZItemArrow itemWithTitle:@"比分直播推送" desController:[CZMorePush2Controller class]];
    CZItem *item13 = [CZItemArrow itemWithTitle:@"中奖动画" desController:[CZMorePush3Controller class]];
    CZItem *item14 = [CZItemArrow itemWithTitle:@"购彩提醒" desController:nil];
    
    CZItem *item15 = [CZItemArrow itemWithTitle:@"圈子推送" desController:nil];
    
    CZGroup *group = [CZGroup groupWithItems:@[item11,item12,item13,item14,item15]];
    
    self.groups = @[group];
}





@end
