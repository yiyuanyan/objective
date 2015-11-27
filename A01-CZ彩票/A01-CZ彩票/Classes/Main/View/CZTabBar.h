//
//  CZTabBar.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/26.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
//1代理协议
@class CZTabBar;
@protocol CZTabBarDelegate <NSObject>
@optional  //可选代理协议
-(void)tabBar:(CZTabBar *)tabBar didClickedButton:(NSInteger)index;


@end

@interface CZTabBar : UIView
//2定义代理属性

@property(nonatomic, weak) id<CZTabBarDelegate> delegate;
-(void)addTabBarItem:(NSString *)name;
@end
