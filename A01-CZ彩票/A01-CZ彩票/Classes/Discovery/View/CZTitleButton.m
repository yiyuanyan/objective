//
//  CZTitleButton.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/30.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZTitleButton.h"
#import "UIView+Ex.h"
@implementation CZTitleButton
-(void)layoutSubviews
{
    [super layoutSubviews];
    //self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}
@end
