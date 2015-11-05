//
//  CZFriendCell.h
//  03-QQ好友
//
//  Created by 何建新 on 15/11/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZFriend.h"
@interface CZFriendCell : UITableViewCell

@property(nonatomic, strong)CZFriend *friend;

+(instancetype)friendCellWithTableView:(UITableView *)tableView;
@end
