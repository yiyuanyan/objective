//
//  IWStatusToolBar.m
//  weibo 16
//
//  Created by 何建新 on 16/1/28.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWStatusToolBar.h"
@interface IWStatusToolBar()
//保存3个按钮
@property(nonatomic, strong) NSMutableArray *childBUttons;
@property(nonatomic, strong) NSMutableArray *childSplites;
@end
@implementation IWStatusToolBar
-(NSMutableArray *)childBUttons{
    if (!_childBUttons) {
        _childBUttons = [NSMutableArray array];
    }
    
    return _childBUttons;
}
-(NSMutableArray *)childSplites{
    if (!_childSplites) {
        _childSplites = [NSMutableArray array];
    }
    
    return _childSplites;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildBtnWithImageName:@"timeline_icon_retweet" title:@"转发"];
        [self addChildBtnWithImageName:@"timeline_icon_comment" title:@"评论"];
        [self addChildBtnWithImageName:@"timeline_icon_unlike" title:@"赞"];
        
        
        [self addSpliteView];
        [self addSpliteView];
    }
    return self;
}
-(void)addSpliteView{
    UIImageView *splite = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
    [self addSubview:splite];
    [self.childSplites addObject:splite];
}
//添加子控件
-(void)addChildBtnWithImageName:(NSString *)imageName title:(NSString *)title{
    UIButton *button = [[UIButton alloc] init];
    //设置左边的图片
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //设置不同的状态的背景图片
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:SYS_FONT(15)];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self addSubview:button];
    [self.childBUttons addObject:button];
}
//调整子控件位置
-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.childBUttons.count;
    CGFloat childW = self.width/count;

    
    
    for (int i = 0; i < count; i++) {
        UIView *childView = self.subviews[i];
        
            childView.x = i * childW;
            childView.height = self.height;
            childView.width = childW;
    }
    for (int j = 0; j < self.childSplites.count; j++) {
        UIImageView *imageView = self.childSplites[j];
        imageView.x = childW * (j + 1) - imageView.width * 0.5;
    }
}
@end
