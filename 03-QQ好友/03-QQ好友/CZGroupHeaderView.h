//
//  CZGroupHeaderView.h
//  03-QQ好友
//
//  Created by 何建新 on 15/11/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZFriendGroup.h"
//为了告诉控制器头部被点击，需要给头部视图定义一个代理
//1.定义代理协议
@class CZGroupHeaderView;

@protocol CZGroupHeaderViewDelegate <NSObject>
@optional
- (void)groupHeadViewDidTouched:(CZGroupHeaderView *)headerView;

@end
@interface CZGroupHeaderView : UITableViewHeaderFooterView
//2.定义一个代理属性
@property(nonatomic,weak)id<CZGroupHeaderViewDelegate> delegate;
//支持重用创建CZGroupHeaderView的方法
+(instancetype)groupHeaderViewWithTableView:(UITableView *)tableView;
@property(nonatomic, strong)CZFriendGroup *friendGroup;
@end
