//
//  CZGroupHeaderView.m
//  03-QQ好友
//
//  Created by 何建新 on 15/11/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZGroupHeaderView.h"
@interface CZGroupHeaderView()
@property(nonatomic, weak)UIButton *nameBtn;
@property(nonatomic, weak)UILabel *onlineLabel;

@end
@implementation CZGroupHeaderView

+(instancetype)groupHeaderViewWithTableView:(UITableView *)tableView
{
    //定义重用标识
    NSString *reuseId = @"ID";
    //检查有没有可重用的分组
    CZGroupHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:reuseId];
    }
    
    return headerView;
}
//重写init方法
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        //穿件子控件
        UIButton *nameBtn = [[UIButton alloc]init];
        [self addSubview:nameBtn];
        self.nameBtn = nameBtn;
        
        UILabel *onlineLabel = [[UILabel alloc]init];
        [self addSubview:onlineLabel];
        self.onlineLabel = onlineLabel;
        
        //设置只需要设置一次的属性
        [nameBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        //设置按钮内容水平方向的对其方式
        nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置按钮往哪个方向挤多少个像素
        self.nameBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        //设置按钮图片的内容模式
        self.nameBtn.imageView.contentMode = UIViewContentModeCenter;
        //不要剪切图片
        self.nameBtn.imageView.clipsToBounds = NO;
        //设置文字颜色
        [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置标题内容往哪个方向挤多少个像素
        self.nameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        //设置onlineLabel右对其
        self.onlineLabel.textAlignment = NSTextAlignmentRight;
        
        
        //设置监听按钮的点击
        [nameBtn addTarget:self action:@selector(headerTouched) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    
    return self;
}
-(void)headerTouched
{
    //每点击一次，将friendGroup.open属性取反
    self.friendGroup.open = !self.friendGroup.isOpen;
    //通知代理
    if ([self.delegate respondsToSelector:@selector(groupHeadViewDidTouched:)]) {
        [self.delegate groupHeadViewDidTouched:self];
    }
    
    
    
}
//系统用来布局控件的方法，在这个方法中可以拿到各种控件的大小和位置。
-(void)layoutSubviews
{
#warning 一定要记住首先要调用[super layoutSubviews]
    [super layoutSubviews];
    //让按钮填充整个头部空间
    self.nameBtn.frame = self.bounds;
    //设置onlineLabel的frame
    CGFloat onlineW = 150;
    CGFloat onlineH = self.bounds.size.height;
    CGFloat onlineY = 0;
    CGFloat onlineX = self.bounds.size.width - onlineW - 20;
    self.onlineLabel.frame = CGRectMake(onlineX, onlineY, onlineW, onlineH);
    
}
-(void)setFriendGroup:(CZFriendGroup *)friendGroup
{
    //1.给自己的成员变量
    _friendGroup = friendGroup;
    //设置名称
    [self.nameBtn setTitle:friendGroup.name forState:UIControlStateNormal];
    //设置在线人数
    self.onlineLabel.text = [NSString stringWithFormat:@"%zd/%zd",friendGroup.online,friendGroup.friends.count];
    
    //根据状态旋转图片
    if (self.friendGroup.isOpen) {
        self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);
        
    }
    
    
}
@end
