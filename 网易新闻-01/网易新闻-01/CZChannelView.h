//
//  CZChannelView.h
//  网易新闻-01
//
//  Created by 朱艳 on 16/1/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZChannelView : UILabel
+(instancetype)channelViewWithTName:(NSString *)tname;
@property(nonatomic, assign)CGFloat scale;
@end
