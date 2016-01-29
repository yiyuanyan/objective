//
//  IWStatusPhotos.m
//  weibo 16
//
//  Created by 何建新 on 16/1/28.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWStatusPhotos.h"
#import "IWStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "IWPhoto.h"
#import "IWStatusPhoto.h"
//子控件的宽高
#define CHILE_WH 70
@implementation IWStatusPhotos

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (int i = 0; i < 9; i++) {
            IWStatusPhoto *imageView = [[IWStatusPhoto alloc] init];
            
            [self addSubview:imageView];
            
            
        }
    }
    return self;
}
-(void)setPic_url:(NSArray *)pic_url
{
    _pic_url = pic_url;
    
    //向数组里面所有的元素发送hidden
    [self.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:@(YES)];
    
    
    
    
    for (int i = 0; i < pic_url.count; i++) {
        IWStatusPhoto *imageView = self.subviews[i];
        //取出照片
        IWPhoto *photo = pic_url[i];
        imageView.hidden = NO;
        imageView.photo = photo;
//        [imageView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.pic_url.count;
    CGFloat childWidth = CHILE_WH;
    NSInteger maxCR = count==4?2:3;
    for (int i = 0; i < count; i++) {
        NSInteger col = i % maxCR;
        NSInteger row = i / maxCR;
        UIView *childView = self.subviews[i];
        childView.size = CGSizeMake(childWidth, childWidth);
        childView.x = col * (childWidth + MARGIN);
        //计算y
        childView.y = row * (childWidth + MARGIN);
    }
}
+(CGSize)sizeWithCount:(NSInteger)count
{
    NSInteger maxCR = count==4?2:3;
    NSInteger col = count<maxCR?count:maxCR;
    NSInteger row = (count + (maxCR-1)) / maxCR;
    CGFloat childWidth = CHILE_WH;
    CGSize photoViewSize = CGSizeMake(col * childWidth + (col-1) * MARGIN, row * childWidth + (row-1) * MARGIN);
    
    return photoViewSize;
}
@end
