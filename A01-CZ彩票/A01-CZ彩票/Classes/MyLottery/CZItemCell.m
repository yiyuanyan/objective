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
        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }else if([item isKindOfClass:[CZItemSwitch class]]){
        //不允许CELL选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = [[UISwitch alloc] init];
    }else if ([item isKindOfClass:[CZItemLabel class]]){
        UILabel *label = [[UILabel alloc]init];
        label.text = item.time;
        label.textColor = [UIColor grayColor];
        [label sizeToFit];
        self.accessoryView = label;
    } else{
        
        self.accessoryView = nil;
    }
}
@end
