//
//  contentView.m
//  Login
//
//  Created by 何建新 on 16/3/21.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "contentView.h"

@implementation contentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)stringView:(NSString *)string stringFont:(UIFont *)stringFont{
    //通过字符串和字符串字体获取文字Size
    //CGSize strSize = [string sizeWithAttributes:@{NSFontAttributeName:stringFont}];

    CGSize strSize = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:stringFont} context:nil].size;
    //创建Label装载文字
    UILabel *strLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, strSize.height)];
    strLabel.textAlignment = NSTextAlignmentLeft;
    strLabel.numberOfLines = 0;
    strLabel.text = string;
    strLabel.font = stringFont;
    
    
    //创建view装载两个btn
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, strLabel.frame.size.height+strLabel.frame.origin.y+10, strLabel.frame.size.width, 43)];

    UIButton *luyinBtn = [[UIButton alloc] init];
    [luyinBtn setFrame:CGRectMake(btnView.frame.size.width-86, btnView.frame.size.height-35, 33, 33)];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin_press"] forState:UIControlStateNormal];
    UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnView.frame.size.width-43, btnView.frame.size.height-35, 33, 33)];
    [playBtn setImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:playBtn];
    [btnView addSubview:luyinBtn];
    
    //创建view装载label和btnview
    UIView *allView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, strLabel.frame.size.height+btnView.frame.size.height+30)];
    allView.backgroundColor = [UIColor whiteColor];
    CGFloat borderY = allView.frame.size.height;
    //[allView addSubview:marginLeft];
    [allView addSubview:strLabel];
    
    if (self.hid == NO) {
        [allView addSubview:btnView];
        
    }else{
        borderY = allView.frame.size.height-50;
    }

    UIView *borderBottom = [[UIView alloc] initWithFrame:CGRectMake(0, borderY, [UIScreen mainScreen].bounds.size.width, 1)];
    borderBottom.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    borderBottom.tag = 101;
    [allView addSubview:borderBottom];
    return allView;
}
@end
