//
//  IWTabBar.m
//  weibo 16
//
//  Created by 何建新 on 16/1/19.
//  Copyright © 2016年 何建新. All rights reserved.
//  底部中间按钮

#import "IWTabBar.h"
@interface IWTabBar()
@property(nonatomic, weak)UIButton *plusBtn;
@end
@implementation IWTabBar
@dynamic delegate;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加加号按钮
        UIButton *plusBtn = [[UIButton alloc] init];
        //设置button不同状态的背景图片
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateNormal];
        //设置button不同状态的image
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        //设置button的大小
        CGRect frame = plusBtn.frame;
        //获取按钮背景图片的大小
        frame.size = plusBtn.currentBackgroundImage.size;
        
        plusBtn.frame = frame;
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        //给自定义按钮添加一个点击事件
        [plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加btn到视图中
        [self addSubview:plusBtn];
        //赋值给属性
        self.plusBtn = plusBtn;
    }
    return self;
}
//调整btn的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    //调整加号按钮位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    //调整uitabbarButton的大小和位置
    CGFloat tabbarBtnW = self.width * 0.2;
    NSInteger index = 0;
    for (int i=0; i<self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.width = tabbarBtnW;
            view.x = index * tabbarBtnW;
            if (index == 1) {
                index++;
            }
            index++;
            
        }
    }
}
-(void)plusBtnClick:(UIButton *)btn{
    //判断是否有代理方法
    if ([self.delegate respondsToSelector:@selector(tabBar:plusBtnDidClicked:)]) {
        //有代理方法把相关参数传递过去
        [self.delegate tabBar:self plusBtnDidClicked:btn];
    }
}
@end
