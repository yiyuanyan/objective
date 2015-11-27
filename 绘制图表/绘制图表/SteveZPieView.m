//
//  SteveZPieView.m
//  绘制图表
//
//  Created by 何建新 on 15/11/26.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "SteveZPieView.h"

@implementation SteveZPieView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //1.获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.创建一个路径对象
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    //关闭路径
    //[path closePath];
    //3.把路径添加到上下文中
    CGContextAddPath(ctx, path.CGPath);
    //4.执行渲染
    CGContextDrawPath(ctx, kCGPathFill);
}


@end
