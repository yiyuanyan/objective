//
//  CZLoopImageCell.m
//  网易新闻
//
//  Created by 何建新 on 16/1/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZLoopImageCell.h"
#import "CZLoopImage.h"
#import <UIImageView+AFNetworking.h>
@interface CZLoopImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
@implementation CZLoopImageCell
-(void)setLoopImage:(CZLoopImage *)loopImage
{
    _loopImage = loopImage;
    //给子空间赋值
    [self.imgView setImageWithURL:[NSURL URLWithString:loopImage.imgsrc]];
    self.titleView.text = loopImage.title;
    
    self.pageControl.currentPage = self.tag;
    
}
@end
