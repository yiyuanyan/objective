//
//  CZMessageFrame.m
//  QQ聊天
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMessageFrame.h"
#import "NSString+Extension.h"
@implementation CZMessageFrame


-(void)setMessage:(CZMessage *)message
{
    //1.给自己的成员变量赋值
    _message = message;
    //2.计算个个子控件的frame
#warning todo  还没有UI设计图
    //控件之间的间距
    CGFloat margin = 10;
    //取出屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //1.时间标签的frmae
    if (!message.hideTime) {
        CGFloat timeY = margin;
        CGFloat timeX = 0;
        CGFloat timeW = screenW;
        CGFloat timeH = 21;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    //2.计算头像的frame
    CGFloat iconY = CGRectGetMaxY(_timeF) + margin;
    CGFloat iconW = 45;
    CGFloat iconH = 45;
    CGFloat iconX = -1;
    //确定X坐标
    if (message.type == CZMessageTypeMe) {
        iconX = screenW - margin - iconW;
    }else{
        iconX = margin;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    //3.计算文本button的frame
    //先计算文本所占的大小，支持换行
    CGFloat maxTextW = screenW - iconW - margin * 3 - textPading * 2; //计算空白区域
    CGSize maxSize = CGSizeMake(maxTextW, CGFLOAT_MAX);
    //字体
    CGSize textSize = [message.text sizeWithMaxSize:maxSize andFont:textFont];
    
    
    
    CGFloat textY = iconY;
    CGFloat textX = -1;
    CGFloat textBtnW = textSize.width + 2 * textPading;
    CGFloat textBtnH = textSize.height + 2 * textPading;
    
    if (message.type == CZMessageTypeMe) {
        textX = iconY - margin - textBtnW + 280;
    }else{
        textX = CGRectGetMaxX(_iconF) + margin;
    }
    _textF = CGRectMake(textX, textY, textBtnW, textBtnH);
    
    //计算头像最大y
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    _rowHeight = iconMaxY > textMaxY ? iconMaxY : textMaxY;
    _rowHeight += margin;
    //_rowHeight = 100;
}
@end
