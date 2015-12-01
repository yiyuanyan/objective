//
//  CZTabBar.h
//  彩票test
//
//  Created by 何建新 on 15/11/30.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZTabBar;
@protocol CZTabBarDelegate <NSObject>
//可选代理协议
@optional
-(void)tabBar:(CZTabBar *)tabBar didClickedButton:(NSInteger)index;


@end
@interface CZTabBar : UIView
//代理属性
@property(nonatomic, weak)id<CZTabBarDelegate> delegate;
//添加按钮
-(void)addTabBarItem:(NSString *)name;
@end
