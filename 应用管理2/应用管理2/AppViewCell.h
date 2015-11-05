//
//  AppViewCell.h
//  应用管理2
//
//  Created by 何建新 on 15/11/5.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Apps.h"
@interface AppViewCell : UITableViewCell
//图标
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
//APP名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//下载量
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;
//下载按钮
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
//下载按钮方法
- (IBAction)download:(UIButton *)sender;


//定义一个属性，用来设置cell的各个元素
@property(nonatomic, strong)Apps *apps;
@end
