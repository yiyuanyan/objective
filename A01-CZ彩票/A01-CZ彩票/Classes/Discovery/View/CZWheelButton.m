//
//  CZWheelButton.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZWheelButton.h"

@implementation CZWheelButton
-(void)setHighlighted:(BOOL)highlighted
{

}
//快速创建自定义button的对象，并且传递按钮中的imageView的大小
+(instancetype)wheelButton:(CGFloat)imgW imgH:(CGFloat)imgH
{
    CZWheelButton *btn = [[CZWheelButton alloc]init];
    btn.imgH = imgH;
    btn.imgW = imgW;
    return btn;
}
//设置imageView的大小和位置
//返回按钮中imageView的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x  =(contentRect.size.width - self.imgW) * 0.5;
    CGFloat y = 20;
    return CGRectMake(x, y, self.imgW, self.imgH);
}
//返回按钮中titleLabel的frame
//-(CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//
//}

@end
