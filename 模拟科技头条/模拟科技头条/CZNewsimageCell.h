//
//  CZNewsimageCell.h
//  模拟科技头条
//
//  Created by 何建新 on 15/12/22.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZNews;
@interface CZNewsimageCell : UITableViewCell
@property(nonatomic, strong)CZNews *news;
+(NSString *)getReuseId:(CZNews *)news;
@end
