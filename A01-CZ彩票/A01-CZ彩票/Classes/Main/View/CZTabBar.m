//
//  CZTabBar.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/26.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZTabBar.h"
#import "UIView+Ex.h"

//关闭按钮点击后高亮状态,必须重写setHighlighted:方法。所以重新定义一个类，继承UIButton
#import "CZTabBarButton.h"

@interface CZTabBar()
//记录上一次点击的按钮
@property(nonatomic, weak)UIButton *preButton;
@end
@implementation CZTabBar
//添加一个按钮，对应tabBarController中得一个子控制器
-(void)addTabBarItem:(NSString *)name{
    //使用重新定义的类创建一个btn。类里面重新写了setHighlighted:方法
    CZTabBarButton *btn = [CZTabBarButton buttonWithType:UIButtonTypeCustom];
    //self就是底部导航栏。将btn按钮加入
    [self addSubview:btn];  //self.subviews是个数组
    //设置每个按钮的tag的值
    btn.tag = self.subviews.count - 1;
    //设置图片按钮
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%@_new",name]] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%@_selected_new",name]] forState:UIControlStateSelected];
    //让按钮的大小和图片的大小一致
    [btn sizeToFit];
    //点击按钮。设置选中状态
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //[self addSubview:btn]后self.subviews是个数组。
    if (self.subviews.count == 1) {
        //第一个按钮调用btnClick:方法。将自己传过去。设置为第一个按钮选中状态
        [self btnClick:btn];
    }
    //关闭按钮点击后高亮状态,必须重写setHighlighted:方法
    
}
-(void)btnClick:(UIButton *)sender{
    //把上一个按钮设为NO
    self.preButton.selected = NO;
    //把点击的按钮设置为YES
    sender.selected = YES;
    //记录这次点击的按钮
    self.preButton = sender;
    
    //代理第三步：向代理对象发送消息
    //判断这个方法是否可实现
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickedButton:)]) {
        //向代理发送了消息。然后由CZTabBarController来接收消息
        [self.delegate tabBar:self didClickedButton:sender.tag];
    }
    
    
}
//调整每一个btn的位置
-(void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn  = self.subviews[i];
        //使用控件的x width属性的时候要先导入UIView+Ex
        btn.x = i * btn.width;
    }
}
@end
