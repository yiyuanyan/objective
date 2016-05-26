//
//  SchoolTableViewCell.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/5/9.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "SchoolTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface SchoolTableViewCell()


@end
@implementation SchoolTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDic:(NSDictionary *)dic
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    imageView.image = nil;
    
    if(dic[@"images"] != nil){
        [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"images"]]];
    }
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, kScreenWidth-50-10, 20)];
    titleLabel.text = nil;
    titleLabel.text = dic[@"name"];
    titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(55, 25, 80, 10)];
    num.text = nil;
    num.text = @"123帖";
    num.font = [UIFont fontWithName:@"Arial" size:10];
    num.textColor = [UIColor grayColor];
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:num];
    
}
@end
