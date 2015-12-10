//
//  CZItemCell.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZItemCell.h"
#import "CZItem.h"
#import "CZItemArrow.h"
#import "CZItemSwitch.h"
#import "CZItemLabel.h"

@interface CZItemCell()
@property(nonatomic, strong)UIImageView *iconView;
@property(nonatomic, strong)UISwitch *switchView;
@property(nonatomic, strong)UILabel *timeView;
@end
@implementation CZItemCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    return [self cellWithTableView:tableView style:UITableViewCellStyleDefault];
}
+(instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style
{
    NSString *reuseId = @"item";
    CZItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:reuseId];
    }
    return cell;
}
-(UIImageView *)iconView
{
    if (_iconView == nil) {
        
        _iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    
    return _iconView;
}
-(UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc]init];
        //加载开关的创造
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [_switchView setOn:[userDefaults boolForKey:self.item.title]];
        [_switchView addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _switchView;
}
//点击开关存储开关状态
-(void)valueChange:(UISwitch *)sender
{
    //创建用户默认模式
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //默认模式存储BOOL类型，setBool为值  forkey为键
    [userDefaults setBool:sender.isOn forKey:self.item.title];
    //立即保存
    [userDefaults synchronize];
}
-(UILabel *)timeView
{
    if (_timeView ==nil) {
        _timeView = [[UILabel alloc]init];
        _timeView.textColor = [UIColor grayColor];
    }
    return _timeView;
}
-(void)setItem:(CZItem *)item
{
    _item = item;
    self.textLabel.text = item.title;
    if (item.icon) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    if (item.subTitle) {
        self.detailTextLabel.text = item.subTitle;
    }
    
    
    
    //判断是箭头还是开关
    if ([item isKindOfClass:[CZItemArrow class]]) {
        self.accessoryView = self.iconView;
    }else if([item isKindOfClass:[CZItemSwitch class]]){
        //不允许CELL选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = self.switchView;
    }else if ([item isKindOfClass:[CZItemLabel class]]){
        
        self.timeView.text = item.time;
        
        [self.timeView sizeToFit];
        self.accessoryView = self.timeView;
    } else{
        
        self.accessoryView = nil;
    }
}
@end
