//
//  CZMicroBlogCell.m
//  02-新浪微博
//
//  Created by 何建新 on 15/10/27.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMicroBlogCell.h"

//类扩展属性
@interface CZMicroBlogCell()
//头像
@property(nonatomic,weak)UIImageView *iconView;
//昵称
@property(nonatomic, weak)UILabel *nameLabel;
//vip视图
@property(nonatomic,weak)UIImageView *vipView;
//文本
@property(nonatomic, weak)UILabel *textView;
//图片
@property(nonatomic, weak)UIImageView *pictureView;
@end
@implementation CZMicroBlogCell

+(instancetype)microBlogCellWithTableView:(UITableView *)tableView
{
    //1.定义重用表示
    NSString *reuseId = @"ID";
    //2.检查缓存池
    CZMicroBlogCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}
//重写cell的初始化方法，完成自定义cell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.创建子控件
        //初始化一个UIImageView
        UIImageView *iconView = [[UIImageView alloc]init];
        //self为cell，contentView为cell的子视图，将iconView加入到cell的子视图中
        //创建一个cell的子视图，类型为UIImageView
        [self.contentView addSubview:iconView];
        //给新创建的UIImageView视图赋值
        //给属性赋值
        self.iconView = iconView;
        
        
        //名称
        UILabel *nameLabel= [[UILabel alloc]init];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        
        //vip视图
        UIImageView *vipView = [[UIImageView alloc]init];
        [self.contentView addSubview:vipView];
        self.vipView = vipView;
        
        
        //文本
        UILabel *textView = [[UILabel alloc]init];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        
        //图片
        UIImageView *pictureView = [[UIImageView alloc]init];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        //2.只需要执行一次的代码
        self.vipView.image = [UIImage imageNamed:@"vip"];
        //设置文本支持换行
        self.textView.numberOfLines = 0;
        self.nameLabel.font = nameFont;
        self.textView.font = textFont;
    }
    return self;
}
//重写数据模型的setter方法
-(void)setMicroBlogFrame:(CZMicroBlogFrame *)microBlogFrame
{
    _microBlogFrame = microBlogFrame;
    [self setDataForSubviews];
    
    //3.计算子控件的frame
    [self setFrameForSubviews];
}

-(void)setDataForSubviews
{
    CZMicroBlog *microBlog = self.microBlogFrame.microBlog;
    self.iconView.image = [UIImage imageNamed:microBlog.icon];
    self.nameLabel.text = microBlog.name;
    //不是VIP就隐藏
    self.vipView.hidden = !microBlog.isVip;
    self.textView.text = microBlog.text;
    if (microBlog.picture) {
        self.pictureView.image = [UIImage imageNamed:microBlog.picture];
        self.pictureView.hidden = NO;
    }else{
        self.pictureView.hidden = YES;
    }
}
-(void)setFrameForSubviews
{
    self.iconView.frame = self.microBlogFrame.iconF;
    self.nameLabel.frame = self.microBlogFrame.nameF;
    self.vipView.frame = self.microBlogFrame.vipF;
    self.textView.frame = self.microBlogFrame.textF;
    self.pictureView.frame = self.microBlogFrame.pictureF;
//    //计算子控件的frame
//    //计算iconView的frame
//    CGFloat margin = 10; //间距
//    CGFloat iconX = margin;
//    CGFloat iconY = margin;
//    CGFloat iconW = 30;
//    CGFloat iconH = 30;
//    
//    CGRect iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
//    self.iconView.frame = iconFrame;
//    //计算名称的frame
//    CGFloat nameX = CGRectGetMaxX(iconFrame) + margin;
//    //计算文本的尺寸
//    //不支持换行，只能计算一行的尺寸
//    CGSize nameSize = [self.microBlog.name sizeWithAttributes:@{NSFontAttributeName:self.nameLabel.font}];
//    CGFloat nameY = margin + (iconH - nameSize.height) / 2;
//    CGRect nameFrame = (CGRect){nameX,nameY,nameSize};
//    self.nameLabel.frame = nameFrame;
//    //计算vip的位置
//    if (self.microBlog.isVip) {
//        CGFloat vipX = CGRectGetMaxX(nameFrame) + margin;
//        CGFloat vipW = 14;
//        CGFloat vipH = 14;
//        CGFloat vipY = margin + (iconH - vipH) / 2;
//        self.vipView.frame = CGRectMake(vipX, vipY, vipW, vipH);
//    }
//    //计算文本的frame
//    CGFloat textX = iconH;
//    CGFloat textY = CGRectGetMaxY(iconFrame) + margin;
//    //计算文本的尺寸，支持换行
//    //CGSize:文字被绘制的区域大小
//    //options:NSStringDrawingUsesFontLeading  //支持换行
//    CGFloat screenW =  [UIScreen mainScreen].bounds.size.width;
//    CGFloat maxTextW = screenW - margin * 2;
//    CGSize maxSize = CGSizeMake(maxTextW, CGFLOAT_MAX);
//    //根据文本字体计算文本大小
//    NSDictionary *attr = @{NSFontAttributeName:self.textView.font};
//    CGSize textSize = [self.microBlog.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
//    CGRect textFrame = (CGRect){textX,textY,textSize};
//    self.textView.frame = textFrame;
//    CGFloat rowHeight = CGRectGetMaxY(textFrame) + margin;
//    //计算pictureView的frame
//    if (self.microBlog.picture) {
//        CGFloat pictureX = iconX;
//        CGFloat pictureY = CGRectGetMaxY(textFrame) + margin;
//        CGFloat pictureW = 100;
//        CGFloat pictureH = 100;
//        CGRect pictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
//        self.pictureView.frame = pictureFrame;
//        rowHeight = CGRectGetMaxY(pictureFrame) + margin;
//        
//    }
}
@end
