//
//  AppViewCell.m
//  应用管理2
//
//  Created by 何建新 on 15/11/5.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "AppViewCell.h"

@implementation AppViewCell

//重写set方法
-(void)setApps:(Apps *)apps
{
    _apps = apps;
    self.iconView.image = [UIImage imageNamed:apps.icon];
    self.nameLabel.text = apps.name;
    self.downloadLabel.text = [NSString stringWithFormat:@"%@ | %@",apps.size,apps.download];
    self.downloadLabel.textColor = [UIColor lightGrayColor];
}

- (IBAction)download:(UIButton *)sender {
}
@end
