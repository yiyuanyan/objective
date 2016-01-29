//
//  IWStatusPhoto.m
//  weibo 16
//
//  Created by 何建新 on 16/1/28.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWStatusPhoto.h"
#import "UIImageView+WebCache.h"
#import "IWPhoto.h"
@interface IWStatusPhoto()
@property(nonatomic, weak)UIImageView *gifImage;
@end
@implementation IWStatusPhoto

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        UIImageView *gifImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timline_image_gif"]];
        [self addSubview:gifImage];
        self.gifImage = gifImage;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifImage.x = self.width - self.gifImage.width;
    self.gifImage.y = self.height - self.gifImage.height;
}
-(void)setPhoto:(IWPhoto *)photo
{
    _photo = photo;
//    if ([photo.thumbnail_pic hasSuffix:@".gif"]) {
//        self.gifImage.hidden = NO;
//    }else{
//        self.gifImage.hidden = YES;
//    }
    self.gifImage.hidden = ![photo.thumbnail_pic hasSuffix:@".gif"];
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}
@end
