//
//  IWLoadMoreView.m
//  weibo 16
//
//  Created by 何建新 on 16/1/26.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWLoadMoreView.h"

@implementation IWLoadMoreView

+(instancetype)loadMoreView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"IWLoadMoreView" owner:nil options:nil] lastObject];
}

@end
