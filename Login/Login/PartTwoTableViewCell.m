//
//  PartTwoTableViewCell.m
//  Login
//
//  Created by 何建新 on 16/4/8.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoTableViewCell.h"

@implementation PartTwoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    
    
    return self;
}

-(void)setEnView:(UIView *)enView{

    [self.contentView addSubview:enView];
}
-(void)setChView:(UIView *)chView{
    [self.contentView addSubview:chView];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
