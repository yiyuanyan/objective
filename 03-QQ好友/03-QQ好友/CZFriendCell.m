//
//  CZFriendCell.m
//  03-QQ好友
//
//  Created by 何建新 on 15/11/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZFriendCell.h"

@implementation CZFriendCell

+(instancetype)friendCellWithTableView:(UITableView *)tableView
{
    NSString *reuseId = @"ID";
    CZFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[CZFriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}

-(void)setFriend:(CZFriend *)friend
{
    //给自己对应的成员变量赋值
    _friend = friend;

    self.imageView.image = [UIImage imageNamed:friend.icon];
    self.textLabel.text = friend.name;
    self.detailTextLabel.text = friend.intro;
    if (friend.isVip) {
        self.textLabel.textColor = [UIColor redColor];
    }else{
        self.textLabel.textColor = [UIColor blackColor];
    }
}
@end
