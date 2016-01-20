//
//  UIView+Inspectable.m
//  weibo 16
//
//  Created by 何建新 on 16/1/20.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "UIView+Inspectable.h"

@implementation UIView (Inspectable)
-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius>0;
}
-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}
-(void)setBordercolor:(UIColor *)bordercolor
{
    self.layer.borderColor = bordercolor.CGColor;
}
-(UIColor *)bordercolor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}
-(CGFloat)borderWidth
{
    return self.layer.borderWidth;
}
@end
