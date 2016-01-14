//
//  CZNewsCell.m
//  网易新闻
//
//  Created by 何建新 on 16/1/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZNewsCell.h"
#import "CZNews.h"
#import <UIImageView+AFNetworking.h>
@interface CZNewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *digestView;
@property (weak, nonatomic) IBOutlet UILabel *replyCountView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImagesView;

@end
@implementation CZNewsCell

-(void)setNews:(CZNews *)news
{
    _news = news;
    
    [self.iconView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
    self.titleView.text = news.title;
    self.digestView.text = news.digest;
    self.replyCountView.text = [NSString stringWithFormat:@"%@跟帖",news.replyCount];
    
    if (news.imgextra) {
        [news.imgextra enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *imgsrc = dic[@"imgsrc"];
            UIImageView *imgView = self.extraImagesView[idx];
            [imgView setImageWithURL:[NSURL URLWithString:imgsrc]];
        }];
    }
}
//根据模型数据返回可用CELL的ID
+(NSString *)getReuseId:(CZNews *)news{
    if (news.imgextra) {
        NSLog(@"news1");
        return @"news1";
    }
    NSLog(@"news");
    return @"news";
}
//根据模型数据获取高度
+(CGFloat)getRowHeight:(CZNews *)news{
    if (news.imgextra) {
        return 130;
    }
    return 100;
}
@end
