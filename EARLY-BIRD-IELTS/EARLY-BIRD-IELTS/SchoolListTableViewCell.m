//
//  SchoolListTableViewCell.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/5/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "SchoolListTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#define kFont [UIFont fontWithName:@"Arial" size:14]
@implementation SchoolListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setInfoDic:(NSMutableDictionary *)infoDic
{

    //头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    //headImageView.image = [UIImage];
    if(infoDic[@"uimage"] != nil){
        [headImageView sd_setImageWithURL:[NSURL URLWithString:infoDic[@"uimage"]]];
    }
    //名称Size
    CGSize nameSize = [self stringSize:infoDic[@"uname"]];
    //名称
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, nameSize.width, 20)];
    nameLabel.font = kFont;
    nameLabel.text = infoDic[@"uname"];
    nameLabel.textColor = [UIColor blueColor];
    //大学
    CGSize schoolNameSize = [self stringSize:infoDic[@"school_name"]];
    UILabel *schoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, schoolNameSize.width, 20)];
    schoolLabel.font = kFont;
    schoolLabel.text = infoDic[@"school_name"];
    //发帖时间
    CGSize createTimeSize = [self stringSize:infoDic[@"create_time_geshi"]];
    UILabel *createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - createTimeSize.width - 10, 20, createTimeSize.width, createTimeSize.height)];
    createTimeLabel.font = kFont;
    createTimeLabel.textColor = [UIColor grayColor];
    createTimeLabel.text = infoDic[@"create_time_geshi"];
    //帖子内容
    CGSize contentSize = [self stringSize:infoDic[@"content"]];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, headImageView.frame.size.height + headImageView.frame.origin.y + 5, [UIScreen mainScreen].bounds.size.width - 10, contentSize.height)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = kFont;
    contentLabel.text = infoDic[@"content"];
    
    CGFloat imgAllViewHeight = 0.0;
    UIView *imageAllView = [[UIView alloc] init];
    if([infoDic[@"images"] count] > 1 && [infoDic[@"images"] count] < 3){
        for(int i = 0; i<[infoDic[@"images"] count]; i++){
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*100 + i*5 + 5, 0, 100, 100)];
            [imgView sd_setImageWithURL:infoDic[@"images"][i][@"middle_image"]];
            [imageAllView addSubview:imgView];
        }
        imgAllViewHeight = 100;
    }else if([infoDic[@"images"] count] > 3){
        for(int i = 0; i<3; i++){
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*100 + i*5 + 5, 0, 100, 100)];
            [imgView sd_setImageWithURL:infoDic[@"images"][i][@"middle_image"]];
            [imageAllView addSubview:imgView];
        }
        int a = 0;
        for(int j = 3; j<6; j++){
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(a*100 + a*5 + 5, 105, 100, 100)];
            [imgView sd_setImageWithURL:infoDic[@"images"][j-1][@"middle_image"]];
            [imageAllView addSubview:imgView];
            a++;
        }
        imgAllViewHeight = 205;
    }
    
    [imageAllView setFrame:CGRectMake(0, contentLabel.frame.origin.y+contentLabel.frame.size.height+10, [UIScreen mainScreen].bounds.size.width, imgAllViewHeight)];
    //栏目、点赞、回帖按钮view
    UIView *favorView = [[UIView alloc] initWithFrame:CGRectMake(0, imageAllView.frame.origin.y+imageAllView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, 20)];
    favorView.backgroundColor = [UIColor redColor];
    
    
    [self.contentView addSubview:imageAllView];
    
    [self.contentView addSubview:contentLabel];
    [self.contentView addSubview:createTimeLabel];
    [self.contentView addSubview:schoolLabel];
    [self.contentView addSubview:nameLabel];
    [self.contentView addSubview:headImageView];
    [self.contentView addSubview:favorView];

}

// 计算文字内容高度
-(CGSize)stringSize:(NSString *)string{
    
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont} context:nil].size;
    return strSize;
}
@end
