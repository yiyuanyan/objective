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
@implementation CZItemCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *reuseId = @"item";
    CZItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
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
    
    
    
    //判断是箭头还是开关
    if ([item isKindOfClass:[CZItemArrow class]]) {
        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }else if([item isKindOfClass:[CZItemSwitch class]]){
        //不允许CELL选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = [[UISwitch alloc] init];
    }else{
        
        self.accessoryView = nil;
    }
}
@end
