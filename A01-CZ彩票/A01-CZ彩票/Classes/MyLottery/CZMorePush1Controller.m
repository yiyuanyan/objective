//
//  CZMorePush1Controller.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMorePush1Controller.h"

@interface CZMorePush1Controller ()

@end

@implementation CZMorePush1Controller

-(void)setData
{
    //一组
    CZItem *item11 = [CZItemSwitch itemWithTitle:@"开奖推送" subTitle:@"每周二、四、日开奖"];
    CZItem *item12 = [CZItemSwitch itemWithTitle:@"比分直播推送"  subTitle:@"每周一、三、六开奖"];
    CZItem *item13 = [CZItemSwitch itemWithTitle:@"中奖动画"  subTitle:@"每周开奖 包括试机号提醒"];
    CZItem *item14 = [CZItemSwitch itemWithTitle:@"购彩提醒"  subTitle:@"每周一、三、五开奖"];
    CZItem *item15 = [CZItemSwitch itemWithTitle:@"圈子推送"  subTitle:@"每周二、五、日开奖"];
    CZItem *item16 = [CZItemSwitch itemWithTitle:@"排列三"  subTitle:@"每天开奖"];
    CZItem *item17 = [CZItemSwitch itemWithTitle:@"排列五"  subTitle:@"每天开奖"];
    
    
    CZGroup *group1 = [CZGroup groupWithItems:@[item11,item12,item13,item14,item15,item16,item17]];
    self.groups = @[group1];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CZItemCell *cell = [CZItemCell cellWithTableView:tableView style:UITableViewCellStyleSubtitle];
    CZGroup *group = self.groups[indexPath.section];
    CZItem *item = group.items[indexPath.row];
    cell.item = item;
    return cell;
}



@end
