//
//  CZNewsCell.h
//  网易新闻
//
//  Created by 何建新 on 16/1/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZNews;
@interface CZNewsCell : UITableViewCell
@property(nonatomic, strong)CZNews *news;
+(NSString *)getReuseId:(CZNews *)news;
+(CGFloat)getRowHeight:(CZNews *)news;
@end
