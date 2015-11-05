//
//  CZMessageCell.m
//  QQ聊天
//
//  Created by 何建新 on 15/10/29.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMessageCell.h"
#import "UIImage+Extentions.h"
@interface CZMessageCell()
@property(nonatomic, weak)UILabel *timeLabel;
@property(nonatomic, weak)UIImageView *iconView;
@property(nonatomic, weak)UIButton *textBtn;
@end
@implementation CZMessageCell

+(instancetype)messageCellWithTableView:(UITableView *)tableView
{
    //定义重用标识
    NSString *reuseId = @"ID";
    //检测缓存池是否有可重用cell
    CZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    //判断cell是否为空
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}
//重写属性的初始化方法，创建子控件
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建子控件
        UILabel *timeLabel = [[UILabel alloc]init];
        //将子控件添加到self的contentView子视图中
        [self.contentView addSubview:timeLabel];
        //给属性赋值
        self.timeLabel = timeLabel;
        
        //创建头像
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //创建文本按钮
        UIButton *textBtn = [[UIButton alloc]init];
        [self.contentView addSubview:textBtn];
        self.textBtn = textBtn;
        //只需要赋值一次的属性赋值
        //设置时间居中显示
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        //设置按钮的label字体，
        self.textBtn.titleLabel.font = textFont;
        //设置文字颜色
        [self.textBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置支持换行
        self.textBtn.titleLabel.numberOfLines = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/**
 *  重写frame模型的setter方法
 */
-(void)setMessageFrame:(CZMessageFrame *)messageFrame
{
    //给自己对应的成员变量赋值
    _messageFrame = messageFrame;
    //取出数据模型
    CZMessage *message = messageFrame.message;
    //给子控件设置数据
    self.timeLabel.text = message.time;
    if (message.type == CZMessageTypeMe) {
        self.iconView.image = [UIImage imageNamed:@"me"];
    }else{
        self.iconView.image = [UIImage imageNamed:@"other"];
    }
    [self.textBtn setTitle:message.text forState:UIControlStateNormal];
    //设置对话框背景图片
    
    if (message.type == CZMessageTypeMe) {
        UIImage *normalImage = [UIImage resizableImageWithName:@"chat_send_nor"];
        [self.textBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
        
        
        
        [self.textBtn setBackgroundImage:[UIImage resizableImageWithName:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
    }else{

        [self.textBtn setBackgroundImage:[UIImage resizableImageWithName:@"chat_recive_nor"] forState:UIControlStateNormal];
        
        
        
        [self.textBtn setBackgroundImage:[UIImage resizableImageWithName:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
    }
    //图片局部拉伸  返回一张可拉伸的图片     被保护的宽度                被保护的高度
    //[normalImage stretchableImageWithLeftCapWidth:<#(NSInteger)#> topCapHeight:<#(NSInteger)#>];
    
    
    
    //             可变尺寸的大小
    //normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(capTop, capLeft, capBottom, capRight)];
    
    
    //把文字挤到中间
    self.textBtn.contentEdgeInsets = UIEdgeInsetsMake(textPading, textPading, textPading, textPading);
    //给子控件设置frame
    self.timeLabel.frame = messageFrame.timeF;
    self.iconView.frame = messageFrame.iconF;
    self.textBtn.frame = messageFrame.textF;
}
@end
