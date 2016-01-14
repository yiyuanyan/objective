//
//  CZNewsimageCell.m
//  模拟科技头条
//
//  Created by 何建新 on 15/12/22.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZNewsimageCell.h"
#import "CZNews.h"
#import "UIImageView+WebCache.h"
@interface CZNewsimageCell()
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *summaryView;
@property (weak, nonatomic) IBOutlet UILabel *sitenameView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *addtimeView;

@end
@implementation CZNewsimageCell
-(void)setNews:(CZNews *)news
{
    _news = news;
    self.titleView.text = news.title;
    self.summaryView.text = news.summary;
    self.sitenameView.text = news.sitename;
    self.addtimeView.text = news.time;
    if (news.img) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:news.img]];
    }
    
    //[self.imageView sd_setImageWithURL:[NSURL URLWithString:news.img]];
    
}
+(NSString *)getReuseId:(CZNews *)news{
    if (news.img.length > 0) {
        return @"news";
    }else{
        return @"news1";
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //判断title的长度超过2行则隐藏summary
    CGSize size = [self.news.title sizeWithAttributes:@{NSFontAttributeName:self.titleView.font}];
    if (size.width > self.titleView.frame.size.width) {
        self.summaryView.hidden = YES;
    }else{
        self.summaryView.hidden = NO;
    }
}
@end
