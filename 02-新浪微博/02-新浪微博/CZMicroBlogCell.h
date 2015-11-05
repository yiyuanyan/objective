//
//  CZMicroBlogCell.h
//  02-新浪微博
//
//  Created by 何建新 on 15/10/27.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZMicroBlogFrame.h"
@interface CZMicroBlogCell : UITableViewCell
+(instancetype)microBlogCellWithTableView:(UITableView *)tableView;
@property(nonatomic, strong)CZMicroBlogFrame *microBlogFrame;
@end
