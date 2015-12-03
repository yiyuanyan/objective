//
//  CZItemCell.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZItem;
@interface CZItemCell : UITableViewCell
@property(nonatomic, strong)CZItem *item;
//创建一个可重用的cell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
