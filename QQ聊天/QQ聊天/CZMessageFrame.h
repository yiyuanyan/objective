//
//  CZMessageFrame.h
//  QQ聊天
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//
//用来记录cell中所有子控件的frame和行高
#import <UIKit/UIKit.h>
#import "CZMessage.h"
#define textFont [UIFont systemFontOfSize:16]
#define textPading 20
@interface CZMessageFrame : NSObject
//时间
@property(nonatomic, assign, readonly)CGRect timeF;
//头像
@property(nonatomic, assign, readonly)CGRect iconF;
//文本
@property(nonatomic, assign, readonly)CGRect textF;
//行高
@property(nonatomic, assign, readonly)CGFloat rowHeight;
//数据模型
@property(nonatomic, strong)CZMessage *message;
@end
