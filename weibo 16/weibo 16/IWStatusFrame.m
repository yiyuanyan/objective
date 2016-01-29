//
//  IWStatusFrame.m
//  weibo 16
//
//  Created by 何建新 on 16/1/27.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWStatusFrame.h"
#import "IWStatus.h"
#import "IWUser.h"
#import "IWStatusPhotos.h"
#define MARGIN 10
@implementation IWStatusFrame
-(void)setStatus:(IWStatus *)status{
    _status = status;
    //给IWStatusFrame所有的子控件Frame赋值
    //计算头像大小
    CGFloat headImageX = MARGIN;
    CGFloat headImageY = MARGIN * 2;
    CGFloat headImageWH = 30;
    self.headImageF = CGRectMake(headImageX, headImageY, headImageWH, headImageWH);
    //昵称
    CGFloat nameLabelX = CGRectGetMaxX(self.headImageF) + MARGIN;
    CGFloat nameLabelY = headImageY;
    CGSize nameLabelSize = [status.user.screen_name sizeWithFont:SYS_FONT(NAME_LABEL_SIZE)];
    self.nameLabelF = (CGRect){{nameLabelX, nameLabelY},nameLabelSize};
    
    //创建时间
    CGFloat createLabelX = nameLabelX;
    CGFloat createLabelY = CGRectGetMaxY(self.nameLabelF)+MARGIN * 0.5;
    CGSize createLabelSize = [status.created_at sizeWithFont:SYS_FONT(CREATE_TIME_SIZE)];
    self.createLabelF = (CGRect){{createLabelX, createLabelY},createLabelSize};
    
    //来源
    CGFloat sourceLabelX = CGRectGetMaxX(self.createLabelF) + MARGIN;
    CGFloat sourceLabelY = createLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:SYS_FONT(CREATE_TIME_SIZE)];
    self.sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY},sourceLabelSize};
    
    
    //正文
    CGFloat contentLabelX = headImageX;
    CGFloat contentLabelY = CGRectGetMaxY(self.headImageF) + MARGIN;
    CGSize contentLabelSize = [status.text sizeWithFont:SYS_FONT(CONTENT_LABEL_SIZE) constrainedToSize:CGSizeMake(SCREENW - 2 * MARGIN, MAXFLOAT)];
    
    
    self.contentLabelF = (CGRect){{contentLabelX, contentLabelY},contentLabelSize};
    
    
    CGFloat statusToolBarY = CGRectGetMaxY(self.contentLabelF) + MARGIN;
    if (status.pic_urls.count) {
        //计算imageView的大小
        CGFloat photoViewX = headImageX;
        CGFloat photoViewY = CGRectGetMaxY(self.contentLabelF) + MARGIN;
        CGSize photoViewSize = [IWStatusPhotos sizeWithCount:self.status.pic_urls.count];
        self.photoViewF = (CGRect){{photoViewX, photoViewY},photoViewSize};
        statusToolBarY = CGRectGetMaxY(self.photoViewF) + MARGIN;
    }
    //计算原创微博的整体view的大小
    CGFloat originalViewX = 0;
    CGFloat originalViewY = MARGIN;
    CGSize originalViewSize = CGSizeMake(SCREENW, statusToolBarY);
    self.originalViewF = (CGRect){{originalViewX, originalViewY},originalViewSize};
    if (status.retweeted_status) {
        //计算整个转发微博的大小
        //1.计算转发微博正文
        CGFloat retweetContentLabelX =MARGIN;
        CGFloat retweetContentLabelY = MARGIN;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@:%@",status.retweeted_status.user.screen_name,status.retweeted_status.text];
        
        
        CGSize retweetContentLabelSize = [retweetContent sizeWithFont:SYS_FONT(CONTENT_LABEL_SIZE) constrainedToSize:CGSizeMake(SCREENW - 2 * MARGIN, MAXFLOAT)];
        self.retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY},retweetContentLabelSize};
        //2.计算转发微博配图的大小
        CGFloat retweetViewH = CGRectGetMaxY(self.retweetContentLabelF) + MARGIN;
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retweetPhotoX = MARGIN;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + MARGIN;
            CGSize retweetPhotoSize = [IWStatusPhotos sizeWithCount:status.retweeted_status.pic_urls.count];
            self.retweetPhotoF = (CGRect){{retweetPhotoX, retweetPhotoY},retweetPhotoSize};
            retweetViewH = CGRectGetMaxY(self.retweetPhotoF) + MARGIN;
        }
        
        
        
        //
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.contentLabelF) + MARGIN;
        
        CGSize retweetViewSize = CGSizeMake(SCREENW,  retweetViewH);
        self.retweetViewF = (CGRect){{retweetViewX, retweetViewY},retweetViewSize};
        //如果有转发微博，这个statustoolbar的y就是相对于转发微博最大的y值
        statusToolBarY = CGRectGetMaxY(self.retweetViewF);
    }
    
    
    
    CGFloat statusToolBarX = 0;
    CGSize statusToolBarSize = CGSizeMake(SCREENW, 35);
    self.statusToolBarF = (CGRect){{statusToolBarX, statusToolBarY},statusToolBarSize};
    
    self.cellHeight = CGRectGetMaxY(self.statusToolBarF);
}
@end
