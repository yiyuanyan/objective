//
//  CZChannelView.m
//  网易新闻-01
//
//  Created by 朱艳 on 16/1/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZChannelView.h"

@implementation CZChannelView
+(instancetype)channelViewWithTName:(NSString *)tname
{
    CZChannelView *channelView = [[CZChannelView alloc]init];
    channelView.text = tname;
    channelView.textAlignment = NSTextAlignmentCenter;
    channelView.font = [UIFont systemFontOfSize:18];
    [channelView sizeToFit];
    channelView.font = [UIFont systemFontOfSize:14];
    
    return channelView;
}
-(void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    //最大能变多少
    CGFloat maxScale = 18 / 14.0 - 1;
    self.transform = CGAffineTransformMakeScale(maxScale*scale+1, maxScale*scale+1);
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
}
@end
