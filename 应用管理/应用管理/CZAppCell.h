//
//  CZAppCell.h
//  应用管理
//
//  Created by 何建新 on 15/11/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZApp.h"
//定义代理协议
@class CZAppCell;
@protocol CZAppCellDelegate <NSObject>

@optional
-(void)appCellDownLoad:(CZAppCell *)appCell downloadAppBtn:(UIButton *)button;

@end


@interface CZAppCell : UITableViewCell


@property(nonatomic, strong)CZApp *app;
//代理属性
@property(nonatomic,weak)id<CZAppCellDelegate>delegate;
@end
