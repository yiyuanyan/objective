//
//  CZMorePush2Controller.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMorePush2Controller.h"
#import "CZItemLabel.h"
#import "CZKeyboard.h"

@interface CZMorePush2Controller ()<CZKeyboardDeletage>
@property(nonatomic, weak)UIDatePicker *datePick;
@property(nonatomic, strong)NSIndexPath *indexPath;
@end

@implementation CZMorePush2Controller

-(void)setData
{
    CZItem *item = [CZItemSwitch itemWithTitle:@"推送我关注的比赛"];
    CZGroup *group = [CZGroup groupWithFooter:@"开启后，当有新中奖订单，打开应用时会显示动画提醒界面。为避免显示过于频繁，高频彩不会提醒" items:@[item]];
    
    
    //第二组
    CZItem *item2 = [CZItemLabel itemWithTitle:@"起始时间" time:@"00:00"];
    CZGroup *group2 = [CZGroup groupWithHeader:@"时期事件" items:@[item2]];
    CZItem *item3 = [CZItemLabel itemWithTitle:@"结束时间" time:@"00:00"];
    CZGroup *group3 = [CZGroup groupWithItems:@[item3]];
    
    self.groups = @[group, group2, group3];
}
//1点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    //获取当前点击的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //文本框,为了点击cell能弹出键盘
    //并且让文本框成为第一响应者
    UITextField *text = [[UITextField alloc]init];
    [cell addSubview:text];
    //设置键盘上面的工具栏
    CZKeyboard *tool = [CZKeyboard keyboardTool];
    tool.delegate = self;
    text.inputAccessoryView = tool;
    //将键盘转换成datePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.backgroundColor = [UIColor lightGrayColor];
    text.inputView = datePicker;
    
    self.datePick = datePicker;
    
    [text becomeFirstResponder];
    
    
}
-(void)keyboardDidClickedCancel:(CZKeyboard *)kb
{
    [self.view endEditing:YES];
}
-(void)keyboardDidClickedSure:(CZKeyboard *)kb
{
    NSDateFormatter *ndf = [[NSDateFormatter alloc]init];
    ndf.dateFormat = @"HH:mm";
    NSString *time = [ndf stringFromDate:self.datePick.date];
    CZGroup *group = self.groups[self.indexPath.section];
    CZItemLabel *item = group.items[self.indexPath.row];
    item.time = time;
    //
    [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
