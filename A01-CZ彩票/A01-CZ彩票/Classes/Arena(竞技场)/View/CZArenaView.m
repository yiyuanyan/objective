//
//  CZArenaView.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/27.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZArenaView.h"

@implementation CZArenaView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //加载背景图
    UIImage *img = [UIImage imageNamed:@"NLArenaBackground"];
    //参数rect就是背景图片的大小
    [img drawAsPatternInRect:rect];
}


@end
