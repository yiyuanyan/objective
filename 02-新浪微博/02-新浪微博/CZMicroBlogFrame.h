//
//  CZMicroBlogFrame.h
//  02-新浪微博
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZMicroBlog.h"
#define nameFont [UIFont systemFontOfSize:20]
#define textFont [UIFont systemFontOfSize:15]
@interface CZMicroBlogFrame : NSObject
@property(nonatomic, assign,readonly)CGRect iconF;
@property(nonatomic, assign,readonly)CGRect nameF;
@property(nonatomic, assign,readonly)CGRect vipF;
@property(nonatomic, assign,readonly)CGRect textF;
@property(nonatomic, assign,readonly)CGRect pictureF;
@property(nonatomic, assign,readonly)CGFloat rowHeight;

/**
 *  由于计算frame需要数据模型，所以在frame模型中需要一个数据模型
 */
@property(nonatomic, strong)CZMicroBlog *microBlog;
@end
