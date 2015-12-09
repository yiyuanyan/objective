//
//  CZBaseSettingController.h
//  A01-CZ彩票
//
//  Created by apple on 15-6-16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZGroup.h"
#import "CZItem.h"
#import "CZItemArrow.h"
#import "CZItemSwitch.h"

#import "CZItemCell.h"
@interface CZBaseSettingController : UITableViewController
//存储分组数据
@property (nonatomic, strong) NSArray *groups;
- (void)setData;
@end
