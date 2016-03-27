//
//  PartOneTableViewCell.m
//  Login
//
//  Created by 何建新 on 16/3/8.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartOneTableViewCell.h"
#define FONT_NAME @"Century Gothic"
@implementation PartOneTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化标题大小
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 52)];
        //初始化标题字体
        //self.nameLabel.font = [UIFont fontWithName:FONT_NAME size:12];
        //设置标题居中
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        
        //设置标题颜色
        [self.contentView addSubview:self.nameLabel];
    }
    
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
