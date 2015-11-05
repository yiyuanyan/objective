//
//  CZMessageCell.h
//  QQ聊天
//
//  Created by 何建新 on 15/10/29.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZMessageFrame.h"
@interface CZMessageCell : UITableViewCell
//frame模型
@property(nonatomic, strong)CZMessageFrame *messageFrame;
//重用cell的创建cell方法
+(instancetype)messageCellWithTableView:(UITableView *)tableView;
@end
