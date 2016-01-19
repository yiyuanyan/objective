//
//  IWTabBar.h
//  weibo 16
//
//  Created by 何建新 on 16/1/19.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWTabBar;
#warning 自定义的空间，如果是继承于系统的控件的话而且有代理，自定义协议一定要继承父类的协议
@protocol IWTabBarDelegate <NSObject,UITabBarDelegate>
-(void)tabBar:(IWTabBar *)tabbar plusBtnDidClicked:(UIButton *)btn;
@end
@interface IWTabBar : UITabBar
@property(nonatomic, weak)id<IWTabBarDelegate>delegate;
@end
