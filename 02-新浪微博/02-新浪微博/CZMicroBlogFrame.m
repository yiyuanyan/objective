//
//  CZMicroBlogFrame.m
//  02-新浪微博
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMicroBlogFrame.h"

@implementation CZMicroBlogFrame
/**
 *  重写数据模型的setter方法，计算frame
 */
-(void)setMicroBlog:(CZMicroBlog *)microBlog
{
    //1.给自己的成员变量赋值
    _microBlog = microBlog;
    //2.计算frame和行高
    //计算子控件的frame
    //计算iconView的frame
    CGFloat margin = 10; //间距
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);

    //计算名称的frame
    CGFloat nameX = CGRectGetMaxX(self.iconF) + margin;
    //计算文本的尺寸
    //不支持换行，只能计算一行的尺寸
    
    CGSize nameSize = [self.microBlog.name sizeWithAttributes:@{NSFontAttributeName:nameFont}];
    CGFloat nameY = margin + (iconH - nameSize.height) / 2;
    CGRect nameFrame = (CGRect){nameX,nameY,nameSize};
    _nameF = nameFrame;
    //计算vip的位置
    if (self.microBlog.isVip) {
        CGFloat vipX = CGRectGetMaxX(nameFrame) + margin;
        CGFloat vipW = 14;
        CGFloat vipH = 14;
        CGFloat vipY = margin + (iconH - vipH) / 2;
        _vipF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    //计算文本的frame
    CGFloat textX = iconH;
    CGFloat textY = CGRectGetMaxY(self.iconF) + margin;
    //计算文本的尺寸，支持换行
    //CGSize:文字被绘制的区域大小
    //options:NSStringDrawingUsesFontLeading  //支持换行
    CGFloat screenW =  [UIScreen mainScreen].bounds.size.width;
    CGFloat maxTextW = screenW - margin * 2;
    CGSize maxSize = CGSizeMake(maxTextW, CGFLOAT_MAX);
    //根据文本字体计算文本大小
    NSDictionary *attr = @{NSFontAttributeName:textFont};
    CGSize textSize = [self.microBlog.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    CGRect textFrame = (CGRect){textX,textY,textSize};
    _textF = textFrame;
    _rowHeight = CGRectGetMaxY(textFrame) + margin;
    //计算pictureView的frame
    if (self.microBlog.picture) {
        CGFloat pictureX = iconX;
        CGFloat pictureY = CGRectGetMaxY(textFrame) + margin;
        CGFloat pictureW = 100;
        CGFloat pictureH = 100;
        _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        
        _rowHeight = CGRectGetMaxY(self.pictureF) + margin;
        
    }
}
@end
