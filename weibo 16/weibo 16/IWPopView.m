//
//  IWPopView.m
//  weibo 16
//
//  Created by 何建新 on 16/1/21.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWPopView.h"

@implementation IWPopView

-(instancetype)initWithCustomsView:(UIView *)customView showView:(UIView *)showView
{
    self = [super init];
    if (self) {
        self.width = SCREENW;
        self.height = SCREENH;
        [self addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //初始化灰色框
        UIImageView *contentView = [[UIImageView alloc] init];
        contentView.image = [UIImage imageNamed:@"popover_background"];
        //允许用户操作,这样点击红框就不会消失
        contentView.userInteractionEnabled = YES;
        //传入的customView的大小决定灰框的大小
        contentView.width = customView.width + 10;
        contentView.height = customView.height + 20;
        //设置customView的x,y值
        customView.x = 5;
        customView.y = 12;
        
        [self addSubview:contentView];
        //传入的customView添加到灰框中
        [contentView addSubview:customView];
        
        //计算contentView的显示位置
        CGRect rect = [showView.superview convertRect:showView.frame toView:[UIApplication sharedApplication].keyWindow];
        contentView.centerX = CGRectGetMidX(rect);
        contentView.y = CGRectGetMaxY(rect);
        contentView.y = CGRectGetMaxY(showView.frame)+20;
        
    }
    return self;
}
//点击后控件消失
-(void)coverBtnClick:(UIButton *)btn{
    [self removeFromSuperview];
}
@end
