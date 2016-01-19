//
//  IWHomeTitleButton.m
//  weibo 16
//
//  Created by 何建新 on 16/1/19.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWHomeTitleButton.h"

@implementation IWHomeTitleButton

-(void)layoutSubviews{
    [super layoutSubviews];
    //调整title的位置
    self.titleLabel.x = 0;
    //再根据titleLabel的位置去设置imageView的x
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+5;
    //根据imageView的位置去设置自己的宽度
    self.width = CGRectGetMaxX(self.imageView.frame);
    //按钮的中心点是父视图的中心点
    self.centerX = self.superview.centerX;
    
}

@end
