//
//  CZTabBar.m
//  彩票test
//
//  Created by 何建新 on 15/11/30.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZTabBar.h"


#import "CZTabBarButton.h"

#import "UIView+Ex.h"
@interface CZTabBar()
//记录上一次点击的按钮
@property(nonatomic, weak)UIButton *preButton;
@end
@implementation CZTabBar
//添加按钮到对应的tabBarController中.CZTabBarController调用，并将name传递过来
-(void)addTabBarItem:(NSString *)name
{
    //首先创建一个CZTabBarButton按钮,并设置按钮状态
    CZTabBarButton *btn = [CZTabBarButton buttonWithType:UIButtonTypeCustom];
    //按钮加入底部导航栏，自身就是底部导航栏所以加入底部
    [self addSubview:btn];
    //设置按钮的tag表示，使用subviews的下表进行标记
    btn.tag = self.subviews.count - 1;
    //设置按钮两个状态的图片
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%@_new",name]] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%@_selected_new",name]] forState:UIControlStateSelected];
    
    //设置按钮的大小就是内容大小
    [btn sizeToFit];
    
    //添加点击按钮事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置默认选中第一个按钮
    if (self.subviews.count == 1) {
        [self btnClick:btn];
    }

}

//按钮点击事件
-(void)btnClick:(UIButton *)sender{
    //设置上一个按钮选择状态为NO
    self.preButton.selected = NO;
    //设置被选择按钮状态YES
    sender.selected = YES;
    //记录被选择的按钮
    self.preButton = sender;
    
    //判断是否可以响应代理方法，如果响应则向代理发放发送参数
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickedButton:)]) {
        [self.delegate tabBar:self didClickedButton:sender.tag];
    }

}

//调整btn的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btn.width;
    }
}
@end
