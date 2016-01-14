//
//  CZHomeCell.m
//  网易新闻-01
//
//  Created by 何建新 on 16/1/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZHomeCell.h"
#import "CZNewsController.h"
@interface CZHomeCell()
@property(nonatomic, strong)CZNewsController *vc;
@end
@implementation CZHomeCell
-(void)setUrlStr:(NSString *)urlStr
{
    self.vc.urlStr = urlStr;
}
//加载一个sb
-(void)awakeFromNib
{
    //加载另一个sb的CZNewsController
    //找到sb
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.vc = [sb instantiateInitialViewController];
//
    [self addSubview:self.vc.view];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.vc.view.frame = self.bounds;
}
@end
