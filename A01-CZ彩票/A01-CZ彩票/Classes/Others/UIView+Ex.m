//
//  UIView+Ex.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/26.
//  Copyright © 2015年 何建新. All rights reserved.
//
//本扩展类为了设置tabBar上按钮的坐标，get\set x y width height
#import "UIView+Ex.h"

@implementation UIView (Ex)
-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
@end
