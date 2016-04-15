//
//  StudyTableViewCell.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/15.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "StudyTableViewCell.h"

@implementation StudyTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
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
