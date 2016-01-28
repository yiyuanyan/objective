//
//  IWStatusCell.h
//  weibo 16
//
//  Created by 何建新 on 16/1/27.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#define identifier @"IWStatusCell"
@class IWStatusFrame;
@interface IWStatusCell : UITableViewCell
@property(nonatomic, strong)IWStatusFrame *statusFrame;


//通过tableView初始化一个Cell(让tableVIew去缓存查)
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
