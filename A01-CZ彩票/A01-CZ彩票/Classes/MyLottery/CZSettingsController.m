//
//  CZSettingsController.m
//  A01-CZ彩票
//
//  Created by apple on 15-6-14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CZSettingsController.h"

//使用兑换码的控制器
#import "CZRedeemCodeController.h"
//推送和提醒
#import "CZMorePushController.h"

#import "CZProductsController.h"
@interface CZSettingsController ()
@end

@implementation CZSettingsController



//填数据
- (void)setData{
    //第一组
    CZItem *item11 = [CZItemArrow  itemWithTitle:@"使用兑换码" icon:@"RedeemCode" desController:[CZRedeemCodeController class]];
    CZGroup *group1 = [CZGroup groupWithItems:@[item11]];
    //
    
    //第二组
    //箭头
    CZItem *item21 = [CZItemArrow itemWithTitle:@"推送和提醒" icon:@"MorePush" desController:[CZMorePushController class]];
    
    //开关
    CZItem *item22 = [CZItemSwitch itemWithTitle:@"摇一摇机选" icon:@"handShake"];
    CZItem *item23 = [CZItemSwitch itemWithTitle:@"声音效果" icon:@"sound_Effect"];
    CZItem *item24 = [CZItemSwitch itemWithTitle:@"购彩小助手" icon:@"More_LotteryRecommend"];
    CZItem *item25 = [CZItemSwitch itemWithTitle:@"圈子仅Wifi加载图片" icon:@"More_QuanZi_NetFlowSwitchImage"];
    CZGroup *group2 = [CZGroup groupWithItems:@[item21,item22,item23,item24,item25]];
    
    
    
    //第三组
    CZItem *item31 = [CZItemArrow itemWithTitle:@"检查新版本" icon:@"MoreUpdate" option:^{
        NSLog(@"检查新版本");
    }];
    
    
    CZItem *item32 = [CZItem itemWithTitle:@"推荐给朋友" icon:@"MoreShare"];
    CZItem *item33 = [CZItemArrow itemWithTitle:@"产品推荐" icon:@"MoreNetease"  desController:[CZProductsController class]];
    CZItem *item34 = [CZItem itemWithTitle:@"关于" icon:@"MoreAbout"];
    CZGroup *group3 = [CZGroup groupWithItems:@[item31,item32,item33,item34]];
    self.groups = @[group1,group2,group3];

}



@end
