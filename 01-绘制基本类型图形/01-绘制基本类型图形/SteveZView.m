//
//  SteveZView.m
//  01-绘制基本类型图形
//
//  Created by 何建新 on 15/11/23.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "SteveZView.h"

@implementation SteveZView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//在自定义的view中进行绘图，必须在下面这个方法中编写绘图代码
//
- (void)drawRect:(CGRect)rect {
    /*
    //1。获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.添加图形路径,创建路径同时把路径添加到图形上下文中
    //设置一个起点
    CGContextMoveToPoint(ctx, 30, 30);
    //添加一条线段，到一个终点
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 100, 200);
    CGContextAddLineToPoint(ctx, 200, 200);
    CGContextAddLineToPoint(ctx, 200, 100);
    CGContextAddLineToPoint(ctx, 100, 100);
    //3.渲染图形.stroke描边
    CGContextStrokePath(ctx);
     */
    
    
    //通过UIBezierPath路径对象来绘制图形
    //1获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //创建路径对象
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    //向路径对象中添加路径
    [path moveToPoint:CGPointMake(30, 30)];
    //添加一条线
    [path addLineToPoint:CGPointMake(100, 30)];
    [path addLineToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(30, 150)];
    [path addLineToPoint:CGPointMake(30, 30)];
    
    //把路径对象添加到图形上下文中 path是UIxxx类型。通过.CGPath转换为CGxxx类型
    CGContextAddPath(ctx, path.CGPath);
    
    //渲染
    CGContextDrawPath(ctx, kCGPathStroke);
}


@end
