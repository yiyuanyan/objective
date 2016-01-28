//
//  IWStatusFrame.h
//  weibo 16
//
//  Created by 何建新 on 16/1/27.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWStatus;
//原创微博的昵称的字体
#define NAME_LABEL_SIZE 14
//微博内容字体
#define CONTENT_LABEL_SIZE 12

#define CREATE_TIME_SIZE 10
@interface IWStatusFrame : NSObject
@property(nonatomic, assign)CGRect headImageF;
@property(nonatomic, assign) CGRect nameLabelF;
@property(nonatomic, assign) CGRect contentLabelF;
@property(nonatomic, strong)IWStatus *status;

@property(nonatomic, assign)CGFloat cellHeight;
@property(nonatomic, assign)CGRect createLabelF;
@property(nonatomic, assign)CGRect sourceLabelF;
@property(nonatomic, assign) CGRect photoViewF;
//底部工具条
@property(nonatomic, assign) CGRect statusToolBarF;

@end
